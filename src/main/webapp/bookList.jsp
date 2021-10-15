<%--
  Created by IntelliJ IDEA.
  User: 19025
  Date: 2021/2/28
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>书籍管理</title>
    <%--	  禁止浏览器从本地计算机的缓存中访问页面内容--%>
    <meta http-equiv="pragma" content="no-cache">
    <%--    用于控制HTTP缓存--%>
    <meta http-equiv="cache-control" content="no-cache">
    <%--    设置网页缓存到期时间，必须使用GMT的时间格式--%>
    <meta http-equiv="expires" content="0">
    <%--  keywords  description设置关键字，来帮助你的主页被各大搜索引擎登录，提高网站的访问量--%>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!-- 导入 easyui 的资源文件 -->
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <link id="themeLink" rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
</head>
<body>
<table id="bookList"></table>
<%--    工具条：链接按钮--%>
<div id=tb style="padding:5px 0;">
    <a id=addBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a id=editBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
    <a id=deleteBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
    <a id=readBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-read',plain:true">阅读</a>
</div>
<%--    编辑窗口--%>
<div id="win" class="easyui-window" title="书籍信息编辑"  style="width:500px;height:200px;padding:10px;"
     data-options="iconCls:'icon-save',modal:true,closed:true">
    <form id="editForm" method="post">
        <%--             提供id隐藏域--%>
        <input type="hidden" name="id">
        书名：<input type="text" id="bookname"  name="bookname" class="easyui-validatebox" data-options="required:true"/><br/>
        作者：  <input type="text" id="author" name="author" class="easyui-validatebox" data-options="required:true"/><br/>
        出版时间: <input type="text"id="booktime" name="booktime" class="easyui-validatebox" data-options="required:true"/><br/>
        数量: <input type="text"  id="quantity" name="quantity" class="easyui-validatebox" data-options="required:true"/><br/>
        注释: <input type="text" class="inputgri" id="comment" name="comment" /><br/>
        <a id=saveBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
        </p>
    </form>
</div>
<script type="text/javascript">
    // 页面加载函数
    $(function () {
        // 抓取页面地址
        $("#bookList").datagrid({
            // url：后台数据查询的地址
            url:"bookstore/listByPage.do",
            // columns：填充的列数据
            columns:[[
                //field:后台对象的属性（？名称）title列标题、width宽度 checkbox复选框
                {
                    field:"id",
                    title:"书籍编号",
                    width:100,
                    checkbox:true
                },
                {
                    field:"bookname",
                    title:"书名",
                    width:200,
                },
                {
                    field:"author",
                    title:"作者",
                    width:200,
                },
                {
                    field:"booktime",
                    title:"出版时间",
                    width:200,
                },
                {
                    field:"quantity",
                    title:"数量",
                    width:200,
                },
                {
                    field:"comment",
                    title:"注释",
                    width:400,
                }
            ]],
            //显示分页
            pagination:true,
            //工具条
            toolbar:"#tb"
        });
        // 打开编辑窗口
        $("#addBtn").click(function () {
            $("#editForm").form("clear");
            $("#win").window("open");
        });
        //保存数据
        $("#saveBtn").click(function () {
            $("#editForm").form("submit",{
                //提交到后台的地址
                url:"bookstore/save.do",
                //表单提前交的回调函数，返回true就提交表单，返回false就不提交表单
                onSubmit:function () {
                    //判断表单验证是否都通过了
                    return $("#editForm").form("validate");
                },
                //服务器执行完毕后的回调函数  data是服务器返回的数据，数据类型是字符串
                success:function (data) {
                    //把data字符串类型转为对象类型
                    data = eval("("+data+")");
                    if(data.success){
                        //关闭并刷新
                        $("#win").window("close");
                        $("#bookList").datagrid("reload");
                        $.messager.alert("提示","保存成功！","info");
                    }else {
                        $.messager.alert("提示","保存失败！"+data.msg,"error");
                    }
                }
            });
        });
        //修改
        $("#editBtn").click(function () {
            //判断数据只能选择一行（一种书）
            var rows = $("#bookList").datagrid("getSelections");
            if(rows.length!=1){
                $.messager.alert("提示","修改只能选择一行","warning");
                return;
            }
            //表单回显
            $("#editForm").form("load","bookstore/findById.do?id="+rows[0].id);
            $("#win").window("open");
        });
        //删除
        $("#deleteBtn").click(function () {
            var rows = $("#bookList").datagrid("getSelections");
            if(rows.length==0){
                $.messager.alert("提示","删除至少选择一行","warning");
                return;
            }
            $.messager.confirm("提示","确实删除数据吗？",function (value) {
                if(value){
                    //执行删除操作，先遍历数据
                    var idstr="";
                    $(rows).each(function (i) {
                        idstr +=("id="+rows[i].id+"&");
                    });
                    idstr = idstr.substring(0,idstr.length-1);
                    alert(idstr);
                    //传递到后台

                    $.post("bookstore/delete.do",idstr,function (data) {
                        if(data.success){
                            $("#bookList").datagrid("reload");
                            $.messager.alert("提示","删除成功！","info");
                        }else {
                            $.messager.alert("提示","删除失败！"+data.msg,"error");
                        }
                    },"json");
                }
            });
        });
        //阅读
        $("#readBtn").click(function () {
            //判断数据只能选择一行（一种书）
            var rows = $("#bookList").datagrid("getSelections");
            if (rows.length != 1) {
                $.messager.alert("提示", "一次只能选择一本", "warning");
                return;
            }
            $.messager.confirm("提示", "确实阅读这本书吗？", function (value) {
                if (value) {
                    var idstr="";
                    idstr +=("id="+rows[0].id);
                    alert(idstr);
                    $.post("bookstore/read.do", idstr, function (data) {
                        //把data字符串类型转为对象类型
                        // data = eval("(" + data + ")");
                        if (data.success) {
                            $.messager.alert("read", data.msg).window({width: 1000, height: 500});
                            // $(location).attr('href','/_001_war_exploded/read.jsp');
                        } else {
                            $.messager.alert("提示", "打开失败！" + data.msg, "error");
                        }
                    },"json");
                }
            });
        });
    });
</script>

</body>
</html>