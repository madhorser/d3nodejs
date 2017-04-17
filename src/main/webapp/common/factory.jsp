<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<fmt:setBundle basename="resource.main_page" />
<HTML>
<HEAD>
<TITLE></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/menu.css" />
</HEAD>
<BODY>
<div id="MainPanel" style="width:100%;height:100%;">
    <iframe src="<%=request.getAttribute("forwardUrl")%>" frameborder="0" width="100%" height="100%"></iframe>
</div>
</BODY>

</HTML>