<%--
  Created by IntelliJ IDEA.
  User: 19025
  Date: 2021/3/2
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>个人信息管理</title>
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
<table id="userXX"></table>
<%--    工具条：链接按钮--%>
<div id=tb style="padding:5px 0;">
    <a id=editBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
<%--    <a id=deleteBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">注销</a>--%>
</div>
<%--    编辑窗口--%>
<div id="win" class="easyui-window" title="用户信息编辑"  style="width:500px;height:200px;padding:10px;"
     data-options="iconCls:'icon-save',modal:true,closed:true">
    <form id="editForm" method="post">
        <input type="hidden" name="uid">
        <%--        用户ID：<input type="text" id="uid"  name="uid" class="easyui-validatebox" data-options="required:true"/><br/>--%>
        用户名：  <input type="text" id="username" name="username" class="easyui-validatebox" data-options="required:true"/><br/>
        用户密码: <input type="text"id="password" name="password" class="easyui-validatebox" data-options="required:true"/><br/>
        <a id=saveBtn href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
        </p>
    </form>
</div>
<script type="text/javascript">
    // 页面加载函数
    $(function () {
        // 抓取页面地址
        $("#userXX").datagrid({
            // url：后台数据查询的地址
            url:"usersCon/userXXList.do",
            // columns：填充的列数据
            columns:[[
                //field:后台对象的属性（？名称）title列标题、width宽度 checkbox复选框
                {
                    field:"uid",
                    title:"用户UID",
                    width:100,
                },
                {
                    field:"username",
                    title:"用户名",
                    width:200,
                },
                {
                    field:"password",
                    title:"用户密码",
                    width:200,
                },
                {
                    field:"flag",
                    title:"用户权限",
                    width:100,
                    checkbox:true
                }
            ]],
            //显示分页
            pagination:true,
            //工具条
            toolbar:"#tb"
        });
        //保存数据
        $("#saveBtn").click(function () {
            $("#editForm").form("submit",{
                //提交到后台的地址
                url:"usersCon/save.do",
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
                        $("#userXX").datagrid("reload");
                        $.messager.alert("提示","修改成功！请重新登录！","info");
                    }else {
                        $.messager.alert("提示","保存失败！"+data.msg,"error");
                    }
                }
            });
        });
        //修改
        $("#editBtn").click(function () {
            //判断数据只能选择一行（一种书）
            var rows = $("#userXX").datagrid("getSelections");
            if(rows.length!=1){
                $.messager.alert("提示","修改只能选择一行","warning");
                return;
            }
            //表单回显
            $("#editForm").form("load","usersCon/findByUid.do?uid="+rows[0].uid);
            $("#win").window("open");
        });
        //删除
        // $("#deleteBtn").click(function () {
        //     var rows = $("#userXX").datagrid("getSelections");
        //     if(rows.length==0){
        //         $.messager.alert("提示","删除至少选择一行","warning");
        //         return;
        //     }
        //     $.messager.confirm("提示","确实删除数据吗？",function (value) {
        //         if(value){
        //             //执行删除操作，先遍历数据
        //             var idstr="";
        //             $(rows).each(function (i) {
        //                 idstr +=("uid="+rows[i].uid+"&");
        //             });
        //             idstr = idstr.substring(0,idstr.length-1);
        //             alert(idstr);
        //             //传递到后台
        //
        //             $.post("usersCon/deleteUsers.do",idstr,function (data) {
        //                 if(data.success){
        //                     $("#userXX").datagrid("reload");
        //                     $.messager.alert("提示","注销成功！","info");
        //                 }else {
        //                     $.messager.alert("提示","注销失败！"+data.msg,"error");
        //                 }
        //             },"json");
        //         }
        //     });
        // });
    });
</script>

</body>
</html>