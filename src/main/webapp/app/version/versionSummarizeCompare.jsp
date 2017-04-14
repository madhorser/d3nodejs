<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//String oldVerJson = request.getAttribute("oldVerJson");
%>

<html>
	<head>

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/noneScroll.css">
	</head>

	<body>
		<div id="datagrid" class="nui-datagrid" style="width:95%; height: 98%;"
					idField="modeId" allowResize="true" 
					pageSize="6" sortMode="client">


					<div property="columns">
						<div type="indexcolumn"></div>
						<div name="oldVerName" field="oldVerName" align="center" width="100"
							allowSort="true" headerAlign="center">
							旧版本
						</div>
						<div name="newVerName" field="newVerName" align="center" width="100"
							allowSort="true" headerAlign="center">
							新版本
						</div>

						<div field="classifierName" width="100" headerAlign="center" 
							allowSort="true" align="center">
							元数据类型
						</div>
						<div field="instanceCode" width="100" headerAlign="center"
							allowSort="true" align="center">
							元数据代码
						</div>
						<div field="instanceName" width="100" headerAlign="center"
							allowSort="true" align="center">
							元数据名称
						</div>
						<div field="fullPath" width="100" headerAlign="center"
							allowSort="true" align="center">
							上下文路径
						</div>
		</div>
		</div>
			<script type="text/javascript">
	nui.parse();   		
	var grid = nui.get("datagrid");
	var url1 = "<%=request.getContextPath()%>/verCompareCmd.do?invoke=querySummaryMetadata&newVerId=<%=request.getParameter("newVerId")%>&classifierId=<%=request.getParameter("classifierId")%>"
	+"&alterType=<%=request.getParameter("alterType")%>&oldVerId=<%=request.getParameter("oldVerId")%>&underInstanceId=<%=request.getParameter("underInstanceId")%>&underClassifierId=<%=request.getParameter("underClassifierId")%>"
    + "&underViewId=<%=request.getParameter("underViewId")%>&underFolderId=<%=request.getParameter("underFolderId")%>";
	grid.setUrl(url1);
	grid.load();
	grid.on("drawcell", function (e) {
        var record = e.record,
    column = e.column,
    field = e.field,
    value = e.value;
	var classifierId;
	var alterType = '<%=request.getParameter("alterType")%>';
        if (field == "verName") {
            e.cellHtml = "<%=request.getParameter("verName")%>"
        }
        if(field == "fullPath"){
            var x = value.lastIndexOf("/");
            var full = value.substring(0,x);
            e.cellHtml = full;
            
        }
        if (field == "oldVerName") {
        	if(alterType=="A"){
            	e.cellHtml="";
        	}

    	}
    	//新版本名称赋值
    	if (field == "newVerName") {
        	if(alterType=="D"){
            	e.cellHtml="";
        	}

    	}

	});
	String.prototype.replaceAll = function(s1,s2){ 
		return this.replace(new RegExp(s1,"gm"),s2); 
	}

	</script>
	</body>
</html>
