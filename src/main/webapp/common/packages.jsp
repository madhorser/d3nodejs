<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page errorPage="/common/errorpage.jsp"%>
<%@ page import="java.util.*,java.io.*,java.text.*,java.net.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.primeton.dgs.workspace.system.common.*"%>
<%@ page import="com.primeton.dgs.kernel.core.common.*"%>
<%@ page import="com.primeton.dgs.kernel.core.util.*"%>
<%@ page import="com.primeton.dgs.kernel.core.app.bo.*"%>
<%@ page import="com.primeton.dgs.workspace.metadata.bo.*"%>
<%@ page import="com.primeton.dgs.workspace.system.bo.*"%>
<%@page import="com.primeton.dgs.workspace.system.web.init.system.*"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
UserProfile currentUser = (UserProfile) session.getAttribute(UserProfile.KEY);
Logger log = Logger.getLogger(this.getClass());
%>
<!--指定区域语言-->
<fmt:setLocale value="zh_CN" />           
<fmt:bundle basename="resource.common_page">

<style type= "text/css" >
.x-selectable, .x-selectable * {
	-moz-user-select: text! important ;
	-khtml-user-select: text! important ;
}
</style>

</fmt:bundle>

<%
String username = null;
if(null!=currentUser){
	//覆盖ext生成的cookie代码
	username = "s%3A"+currentUser.getUserId();
	Cookie cookie = new Cookie("ys-username", username); 
	//十天有效期 
	cookie.setMaxAge(60*60*24*10);
	cookie.setPath("/");  
	response.addCookie(cookie); 
}
%>