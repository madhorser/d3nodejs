<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<%@ page import="com.primeton.dgs.workspace.metamodel.util.ClassifierContext" %>
<%@ page import="com.primeton.dgs.kernel.core.common.SpringContextHelper" %>
<%@ page import="com.primeton.dgs.kernel.core.cache.ICache" %>
<HTML>
<HEAD>
    <TITLE>刷新内存</TITLE>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<BODY>
<%
CodeParamManager.getInstance().refreshCache();
MenuManager.getInstance().refreshCache();
ClassifierContext.getInstance().clear();
ICache cache = (ICache)SpringContextHelper.getBean("cache");
cache.clear();
System.gc();
%>
<div class="x-toolbar" style="height:100%">
<table width="100%" border="0" cellpadding="0" cellspacing="5" class="main-top">
  <tr height="40">
    <td width="60" align="center" class="main-top-txt">
      <img src="<%=request.getContextPath()%>/images/icons/icoInfo.gif" alt="info">
    </td>
    <td align="left" class="main-top-txt">
    &nbsp;参数已经成功刷新！<br/>&nbsp;如果你要查看的数据还没有更新，请重新登录系统。
    </td>
  </tr>
</table>
</div>
</BODY>
<SCRIPT LANGUAGE="JavaScript">
Ext.onReady(function(){
	//Ext.QuickTips.init();
	
});
</SCRIPT>
</HTML>