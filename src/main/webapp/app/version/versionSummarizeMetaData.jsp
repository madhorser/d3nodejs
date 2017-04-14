<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html>
	<head>

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/noneScroll.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/versionSummarizeMetaData.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	</head>

	<body>
		<div class="tophead">
			<p><span id="back" class="glyphicon glyphicon-circle-arrow-right" style="font-size: 17px;float: left;"></span>版本概要详情</p>
		</div>
		<div id="datagrid" class="nui-datagrid" style="height: 92%;width:95%;"
					idField="modeId"  allowResize="false" 
					pageSize="10" sortMode="client">

					<div property="columns">
						<div type="indexcolumn"></div>
						<div name="classifierId" field="classifierId" align="left" width="100">
						</div>
						<div name="verName" field="verName" align="center" headerAlign="center" width="100"
							allowSort="true">
							版本编号
						</div>

						<div field="classifierName" width="100" align="center" headerAlign="center"
							allowSort="true">
							元数据类型
						</div>
						<div field="instanceCode" width="100" align="center" headerAlign="center"
							allowSort="true">
							元数据代码
						</div>
						<div field="instanceName" width="100" align="center" headerAlign="center"
							allowSort="true">
							元数据名称
						</div>
						<div field="fullPath" width="100" align="center" headerAlign="center"
							allowSort="true">
							上下文路径
						</div>
		</div>
		</div>
			<script type="text/javascript">
	nui.parse();   		
	var grid = nui.get("datagrid");
	var url1 = "<%=request.getContextPath()%>/version.do?invoke=newqueryVersionMetadata&verId=<%=request.getParameter("verId")%>&classifierId=<%=request.getParameter("classifierId")%>";
	grid.setUrl(url1);
	grid.load();
	grid.hideColumn("classifierId");
	grid.on("drawcell", function (e) {
        var record = e.record,
    column = e.column,
    field = e.field,
    value = e.value;
	var classifierId;
        if (field == "verName") {
            e.cellHtml = "<%=request.getParameter("verName")%>"
        }
        if (field == "parents") {
            var str = nui.encode(value);
            var str1 = str.substring(1,str.length-1);
            var str2 = str1.replaceAll("\\\"","\"");
            var json = nui.decode(str2);
            var parent="";
            for(var key in json){
                if(key == "instanceName"){
                	parent=parent+"/"+json[key];
                }
            	
            }
            e.cellHtml = parent;  
        }

	});
	String.prototype.replaceAll = function(s1,s2){ 
		return this.replace(new RegExp(s1,"gm"),s2); 
	};
    
 	jQuery(function () {
		
		$('#back').click(function(){
			parent.$('.hidebg2').click();
			});

	});

	</script>
	</body>
</html>
