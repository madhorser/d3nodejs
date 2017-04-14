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
.x-mask-downloading{
    position: relative;
    text-align: center;
    width: auto;
}
.x-mask-downloading div {
    padding:5px 5px 5px 30px;
    background: #fbfbfb url( '<c:url value="/images/icons/loading2.gif"/>' ) no-repeat 0 0;
    line-height: 20px;
    font-size:12px;
}
</STYLE>
</HEAD>
<BODY style="border:0;background:#eeeeee" >
<table border="0" style="height:100%;" align="center">
<tr>
  <td align="center">
    <div class="ext-el-mask-msg x-mask-downloading"><div>文件正在下载，请稍候...</div></div>
  </td>
</tr>
</table>
</BODY>
</HTML>