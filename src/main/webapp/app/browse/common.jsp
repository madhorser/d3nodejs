<%
	String contextPath=request.getContextPath();

%>

<script type="text/javascript" src="<%=request.getContextPath() %>/app/base/js/nui/nui.js"></script>
<script>
	nui.context='<%=contextPath %>';
</script>
