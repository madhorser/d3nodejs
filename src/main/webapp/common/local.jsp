<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<%@ page import="javax.servlet.jsp.jstl.core.Config, java.util.*" %>
<HTML>
<HEAD>
    <TITLE></TITLE>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<BODY class="x-panel-mc">
<%
    Locale local = request.getLocale();
    System.out.println("@@@@@@@@@@@" + local);
    Object obj = Config.find(pageContext, Config.FMT_LOCALE);
    if (obj != null && obj instanceof Locale) {
        local = (Locale) obj;
    }
%>
<c:if test="${param['locale'] != null}">
    <fmt:setLocale value="${param['locale']}" scope="session"/>
    <fmt:setTimeZone value="${param['locale']}" scope="session"/>
</c:if>
<c:if test="${param['locale'] == null}">
    <fmt:setLocale value="<%=local %>" scope="session"/>
    <fmt:setTimeZone value="<%=local.toString() %>" scope="session"/>
</c:if>
<%
    obj = Config.find(pageContext, Config.FMT_LOCALE);
    if (obj != null && obj instanceof Locale) {
        local = (Locale) obj;
    }
     Locale[] la = MessageHelper.getAvailableFormattingLocales(local);
%>
<FORM method="POST" action="">
    Language Choose:<br />
    <select name="locale">
    <%for (int i = 0; i < la.length; i++) {%>
        <option value="<%=la[i]%>" <%if (la[i].equals(local)) {out.print("selected=\"selected\"");}%>>
        <%= la[i].getDisplayName(local)%></option>
    <%}%>
    </select>
    <br />
    <input type="submit" value="Change"/>
</FORM>
</BODY>
</HTML>