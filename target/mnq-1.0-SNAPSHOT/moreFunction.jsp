<%--
  Created by IntelliJ IDEA.
  User: 19025
  Date: 2021/3/2
  Time: 20:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>更多功能</title>
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
<!-- 中间编辑区域 -->
<div data-options="region:'center'" style="padding:5px;background:#eee;">
    <div id="tt" class="easyui-tabs" style="width:500px;height:250px;" data-options="fit:true">
        <div title="喵~" style="padding:20px;display:none;">
            更多功能尽请期待~
        </div>
    </div>
</div>
</body>
</html>