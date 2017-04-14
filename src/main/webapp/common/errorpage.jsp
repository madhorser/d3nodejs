<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page isErrorPage="true"%>
<%@ page import="com.primeton.dgs.kernel.core.util.*"%>
<%@ page import="com.primeton.dgs.kernel.core.common.*"%>
<%
  if (exception == null) {
      exception = (Throwable)request.getAttribute("javax.servlet.jspException");
  }
  String exMessage = "unkown error";
  if (exception == null ) {
      if (request.getAttribute(Constant.LOGIN_MSG) != null) {
          exMessage = (String)request.getAttribute(Constant.LOGIN_MSG);
      } 
  }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<HTML>
<HEAD>
<TITLE>系统异常</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<BODY background="images/bg/08.gif">
<table width="550" height="450" cellspacing="0" cellpadding="0" align="center" border="0">
<tbody>
<tr>
<td valign="top" background="images/bg/ebg.gif">
<table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tbody>
        <tr>
            <td height="350">
            </td>
        </tr>
        <tr>
            <td>
            <table cellspacing="2" cellpadding="0" width="100%" align="center" border="0">
                <tbody>
                    <tr>
                        <td align="center" style="font-size:9pt;font-weight:bold;">
                        <font color="#990000">[<a href="javascript:history.back();" title="返回前一步">返回</a>]</font>&nbsp;|&nbsp;
                        <font color="#990000">[<a href="javascript:window.close();" title="关闭浏览器">关闭</a>]</font>&nbsp;|&nbsp;
                        <font color="#990000">[<a href="login.jsp" target="_top" title="重新登录系统">重新登录</a>]</font>&nbsp;|&nbsp;
                        <font color="#990000">[<a href="javascript:swcCause();" title="显示/隐藏信息">错误信息</a>]</font>&nbsp;|&nbsp;
                        </td>
                    </tr>
                </tbody>
            </table>
            </td>
        </tr>
        <tr>
            <td id="errdiv" style="display:none;"><br>
                <textarea name="textarea" style="color:#FF0000;width:530px;height:200px;"><%=exception != null ? ExUtils.trace(exception) : exMessage%></textarea>
            </td>
        </tr>
    </tbody>
</table>
</td>
</tr>
</tbody>
</table>
</BODY>
<SCRIPT LANGUAGE="JavaScript">
function swcCause() {
    var trCause = document.getElementById("errdiv");
    if (trCause.style.display == "none") {
        trCause.style.display = "";
    } else {
        trCause.style.display = "none";
    }
}
</SCRIPT>
</HTML>