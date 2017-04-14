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
String sysSkin = CodeParamManager.getValue("Main-Page-Option", "system-skin", "default");
request.setAttribute("css_path", CodeParamManager.getValue("Skin-Setting", "skin.setting.path", "ext/resources/css/ext-all.css"));
%>
<!--指定区域语言-->
<fmt:setLocale value="zh_CN" />           
<fmt:bundle basename="resource.common_page">
<c:set var="ext_lang_js"><fmt:message key="ext.lang.js"/></c:set>
<c:set var="extux_lang_js"><fmt:message key="extux.lang.js"/></c:set>
<c:set var="public_lang_js"><fmt:message key="public.lang.js"/></c:set>
<style type= "text/css" >
.x-selectable, .x-selectable * {
	-moz-user-select: text! important ;
	-khtml-user-select: text! important ;
}
</style>
<link rel="stylesheet" type="text/css" href="<c:url value="/${css_path}"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/ext/resources/css/extend.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/ext/resources/css/ext-patch.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/ext/uxresources/Ext.ux.layout.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/ext/uxresources/Ext.ux.upload.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/ext/uxresources/Ext.ux.Spinner.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/ext/uxresources/Ext.ux.basecss.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/public.css"/>" />

<link rel="stylesheet" type="text/css" title="green"   href="<c:url value="/ext/resources/css/xtheme-green.css"/>" />
<link rel="stylesheet" type="text/css" title="gray"    href="<c:url value="/ext/resources/css/xtheme-gray.css"/>" />
<link rel="stylesheet" type="text/css" title="slate"  href="<c:url value="/ext/resources/css/xtheme-slate.css"/>" />
<link rel="stylesheet" type="text/css" title="indigo"  href="<c:url value="/ext/resources/css/xtheme-indigo.css"/>" />
<link rel="stylesheet" type="text/css" title="midnight"    href="<c:url value="/ext/resources/css/xtheme-midnight.css"/>" />
<link rel="stylesheet" type="text/css" title="silverCherry"  href="<c:url value="/ext/resources/css/xtheme-silverCherry.css"/>" />

<script type="text/javascript" src="<c:url value="/ext/ux/SkinWrite.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/js/ext-base.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/js/ext-all.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/js/ExtendExt.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/locale/ext-lang-zh_CN.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.TabCloseMenu.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.grid.TableGrid.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.layout.BorderLayoutOverride.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.layout.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.Spinner.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.form.SpinnerField.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.ToolbarFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.Toolbar.Icon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.Whether.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.StoreStatusBar.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.grid.ToggleHeader.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.ux.TreeCheckNodeUI.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.mm.TreeCombo.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.mm.AppendCombo.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.form.DateTimeFieldUx.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/ux/Ext.form.ComboMultiSelectGridBox.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext/locale/Ext.ux.lang-zh_CN.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/locale/public-all-zh_CN.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/public-all.js"/>"></script>
</fmt:bundle>
<script>
Ext.BLANK_IMAGE_URL = '<c:url value="/ext/resources/images/default/s.gif"/>';
var contPath = "<%=request.getContextPath()%>";
Ext.app.PermissionManager = new Ext.app.Permission({
    ps:<%=currentUser != null ? currentUser.getPermissionJSON(request.getParameter("nodeCode")).toString() : "[]"%>,
    gr:<%=request.getAttribute(Constant.META_GRANTNUM)%>
});
Ext.page.pageSize = <%=Page.getConfigPageSize()%>;
Ext.Ajax.timeout = 10000; //超时时间(ms)

var skinValue = readCookie('metadata-themes-skin');
if(null != skinValue && skinValue != 'default' && skinValue != ''){
	setActiveStyleSheet(skinValue);
}else{
	skinValue = '<%=sysSkin%>';
	setActiveStyleSheet('<%=sysSkin%>');
}
</script>
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