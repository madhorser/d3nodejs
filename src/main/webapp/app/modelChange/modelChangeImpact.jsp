<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html>
<head>
    <title>变更分析</title>

	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
		
    <%
		String contextPath=request.getContextPath();
    	String changeId = request.getParameter("changeId");
    	String name =(String) session.getAttribute("name");
    	String time =(String) session.getAttribute("time");
	%>
	<script>
		nui.context='<%=contextPath %>';
	</script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/modelChangeDetails.css">
</head>

<body>
<div class="tophead">
	<p><span id="back" class="glyphicon glyphicon-circle-arrow-right" style="font-size: 17px;float: left;"></span>变更分析</p>
</div>
<div class="panel panel-default">
	<div class="panel-body" style="height:165px;">
		<p class="p-head"><span></span>基本信息	
		</p>
		<div class="well">
			<div id="datagrid_base" class="nui-datagrid" style="height:65px;"
				 dataField="data" allowResize="false" sortMode="client" showPager="false">
				<div property="columns"> 
					<div field="userName" width="80" headerAlign="center" align="center" allowSort="true">提出人</div>
					<div field="id" width="80" headerAlign="center" align="center" allowSort="true">变更单编号</div>
                    <div field="createTime" width="80" headerAlign="center" align="center" allowSort="true">提出时间</div>					
				</div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<p class="p-head"><span></span>结果列表	
		</p>
		<div class="well">
			<div id="datagrid" class="nui-datagrid" style="height:435px;"
				 dataField="data" idField="analyseId" allowResize="false" sortMode="client">
				<div property="columns"> 
					<div field="alterId"  headerAlign="center" align="center" allowSort="true">变更单编号</div>
					<div field="sysCode"  headerAlign="center" align="center" allowSort="true">影响系统</div>
			        <div field="department"  headerAlign="center" align="center" allowSort="true">所属部门</div>
			        <div field="userName"  headerAlign="center" align="center" allowSort="true">负责人</div>
			        <div field="status"  headerAlign="center" align="center" allowSort="true">状态</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	nui.parse();   
	var grid = nui.get("datagrid");
	var gridBase = nui.get("datagrid_base");
	var urlBase = "<%=request.getContextPath()%>/modelChange.do?invoke=queryChangeBaseInfo&changeId=<%=changeId%>";
	gridBase.setUrl(urlBase);
	gridBase.on("drawcell", function (e) {
		var record = e.record,
	        column = e.column,
	        field = e.field,
	        value = e.value;  
       	if (field == "createTime") {
	    	var value1 = new Date(value); 
	        if (nui.isDate(value1)) e.cellHtml = nui.formatDate(value1, "yyyy-MM-dd HH:mm:ss");
	   	}
	});
	gridBase.load();
	
	var url = "<%=request.getContextPath()%>/modelChange.do?invoke=analyseSystem&changeId=<%=changeId%>";
	grid.setUrl(url);
	grid.on("drawcell", function (e) {
       var record = e.record,
           column = e.column,
           field = e.field,
           value = e.value;     
         if (field == "status") {
	        if (value =="1") e.cellHtml  = "未读";
	        if (value =="2") e.cellHtml  = "已读";
	    }
	});
	grid.load();
	
	function closeModal(){
		$('.modal').modal('hide');
		grid.reload();
	}
	jQuery(function () {
		$('#back').click(function(){
			parent.$('.hidebg').click();
		});
	});
</script>
</body>
</html>
