<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<title>Bootstrap Template</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>

	</head>
	<body>
		<div id="treegrid1" class="nui-treegrid"
			style="width: 100%; height: 100%;" treeColumn="metacubeTree"
			onbeforeexpand="onBeforeExpanded" showTreeIcon="true"
			idField="instanceId" parentField="pid" resultAsTree="false">
			<div property="columns">
				<div name="metacubeTree" field="text" width="160">
					元数据树
				</div>
				<div field="oldVerId" width="80">
					旧版本
				</div>
				<div field="newVerId" width="60">
					新版本
				</div>
				<div field="alterType" width="80">
					变更类型
				</div>
				<div field="fullPath" width="80">
					上下文路径
				</div>
			</div>
		</div>
		<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
		<script src="../base/js/jquery.min.js"></script>

		<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
		<script src="../base/js/bootstrap.min.js"></script>
		<script type="text/javascript">
    nui.parse();
    var newVerId="<%=request.getParameter("newVerId")%>";
	var oldVerId="<%=request.getParameter("oldVerId")%>";
	var underInstanceId="<%=request.getParameter("underInstanceId")%>";
	
		var treegrid = nui.get("treegrid1");		    
	    var url = "<%=request.getContextPath()%>/verTreeCmd.do?invoke=metadataCompareParameter&instanceId="+underInstanceId+"&newVerId="+newVerId+"&oldVerId="+oldVerId;
		treegrid.load(url);
		console.log("---------------------------");
		console.log(treegrid);
		console.log(treegrid._rowsViewEl);
		treegrid._rowsViewEl.style.height="100%";
        var data;
    	var metadata;
    	//ajax请求获取根节点的属性。
		nui.ajax({
	    url: url,
	    async: false,
		success: function (text) {
			data = nui.decode(text);
			metadata = nui.decode(data.metadata);
			            
        	}
		});
		var test = treegrid.getRootNode();
		var nodes = treegrid.findNodes(function(node){
		    if(node.instanceId == underInstanceId) return true;
		});
		
		var a={};
		treegrid.addNode(data,"add",nodes[0]);
	function onBeforeExpanded(e){
		var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var resource = node.resource;
        var parentId=node.instanceId;
        var classifierId = node.classifierId;
        //var text = node.instanceId;
        var nodes = treegrid.getChildNodes(node);
        var newVerId="<%=request.getParameter("newVerId")%>";
    	var oldVerId="<%=request.getParameter("oldVerId")%>";
        treegrid.removeNodes(nodes);   

        var url1 = "<%=request.getContextPath()%>/verTreeCmd.do?invoke=metadataCompareTree&resource="
            +resource+"&parentId="+parentId+"&classifierId="+classifierId+"&newVerId="+newVerId+"&oldVerId="
            +oldVerId+"&orderBy=name&loadAllCols=false";
        var data1;
        nui.ajax({
    	    url: url1,
    	    async: false,
    		success: function (text) {
    			if(text!="[]"){
    				data1 = nui.decode(text);
    				for(var i = 0;i<data1.length;i++){
    					treegrid.addNode(data1[i],"add",node);
    					var nodes1 = treegrid.findNodes(function(n){
        				    if(n.instanceId == data1[i].instanceId&&n.classifierId == data1[i].classifierId) return true;
        				});
        				var node2={};
        				for(var j = 0;j<nodes1.length;j++){
        					treegrid.addNode(node2,"add",nodes1[j]); 
        				}
        				
    				} 	 
    			} 			            
            	}
    		});		  
	}

    treegrid.on("drawcell", function (e) {
    	var newVerName="<%=request.getParameter("newVerName")%>";
    	var oldVerName="<%=request.getParameter("oldVerName")%>";
        var record = e.record,
                column = e.column,
                field = e.field,
                value = e.value,
        		rowIndex = e.rowIndex;
		debugger;
        //旧版本名称赋值
       		if (field == "oldVerId"&&rowIndex!=0&&record.pid!=record.instanceId) {
            	if(record.alterType=="A"){
                	e.cellHtml="";
            	}
            	else{
            		e.cellHtml=oldVerName;
            	}

        	}
        	//新版本名称赋值
        	if (field == "newVerId"&&rowIndex!=0&&record.pid!=record.instanceId) {
            	if(record.alterType=="D"){
                	e.cellHtml="";
            	}
            	else{
            		e.cellHtml=newVerName;
            	}

        	}

        //更改状态
       		if (field == "alterType"&&rowIndex!=0&&record.pid!=record.instanceId) {
            	if (value == "A") {
                	e.cellHtml = "新增";
            	}
            	else if (value == "D"){
                	e.cellHtml = "删除";
            	}
            	else if (value == "M"){
                	e.cellHtml = "修改";
            	}
            	else if (value == "C"){
                	e.cellHtml = "变化";
            	}
            	else if (value == ""||value==null){
                	e.cellHtml = "无变化";
                //nui.alert(value);
            	}
            
        	}
        	//上下文路径
        	if (field == "fullPath"&&record.pid!=record.instanceId) {
            	if(rowIndex==0){
            		e.cellHtml="";
            	}
            	else{
            	if(value!=null&&value!=""){
            		var x = value.lastIndexOf("/");
    				e.cellHtml="/"+(value.substring(0,x));
            	}
            	}				
        	}
    });	

</script>
	</body>
</html>