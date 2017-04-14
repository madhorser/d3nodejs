<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<HTML>
<HEAD>
<TITLE></TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/ext/resources/css/ext-all.css"/>" />
<STYLE type="text/css">
.x-mask-loading-pb{
    position: relative;
    text-align: center;
    width: auto;
}
.x-mask-loading-pb span {
    font-size:12px;
    font-family: tahoma,arial,helvetica,sans-serif;
}
</STYLE>
</HEAD>
<BODY style="border:0;background:#eeeeee" >
<table height="100%" border="0" align="center">
<tr>
<td align="center">
    <!--显示进度条-->
    <div class="ext-el-mask-msg x-mask-loading-pb">
    <table border="0" cellspacing="5" cellpadding="5">
      <tr>
        <td align="center">
          <span id="clock" style="padding-right:2px;"></span>
          <img border="0" src="<c:url value="/images/icons/processbar.gif"/>" align="absmiddle">
        </td>
      </tr>
     <tr>
       <td align="left"><span>操作正在进行中,请稍候...</span></td>
     </tr>
    </table>
    </div>
</td>
</tr>
</table>
</BODY>
<script type="text/javascript">
var timer = null;
function runTimer() {
    var clock = document.getElementById("clock");
    clock.innerHTML = '00:00:00', clock.counter = 0;
    if (timer != null)  window.clearInterval(timer);
    timer = window.setInterval("onTimer()", 1000);
}
function onTimer() {
    var clock = document.getElementById("clock");
    var time = (clock.counter += 1000);
    var s = Math.round(time/1000)%60, m = Math.floor(time/60000)%60, h = Math.floor(time/3600000)%24;
    clock.innerHTML = (h<10 ? "0"+h : h) + ":" + (m<10 ? "0"+m : m) + ":" + (s<10 ? "0"+s : s);
}
runTimer();
</script>
</HTML>