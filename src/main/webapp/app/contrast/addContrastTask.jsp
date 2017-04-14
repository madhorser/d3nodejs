<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    
    <title>比对节点选择</title>

	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/addContrastTask.css">
</head>

<body>
	<div class="main">
	    <div class="left">
	        <div class="panel panel-info" style="height:565px;">
	            <div class="panel-heading">
	                <button type="submit" class="btn btn-danger blue" onclick="refreshTree('tree1')">刷新</button>
                    <label class="sr-only" for="input1">查询</label>
                    <input id="textbox1" class="nui-textbox" style="width:160px;"/>
	                <button type="submit" id="searchBtn1" class="btn btn-default blue" onclick="findNode('tree1')">查询</button>	
	            </div>
	            <div class="panel-body">
					<ul id="tree1" class="nui-tree" style="padding:5px;" showTreeIcon="true"		
						idField="instanceId"
					 	onbeforeload="onBeforeTreeLoad"				 	
					 	pageSize="20" 
					 	pageIndexField="start" >
					</ul>
	            </div>
	        </div>
	
	    </div>
	    <div class="right">
	        <div class="panel panel-info" style="height:565px;">
	            <div class="panel-heading">
	                <button type="submit" class="btn btn-danger blue" onclick="refreshTree('tree2')">刷新</button>
                    <label class="sr-only" for="input2">查询</label>
                    <input id="textbox2" class="nui-textbox" style="width:160px;"/>
	                <button type="submit" id="searchBtn2" class="btn btn-default blue" onclick="findNode('tree2')">查询</button>
	            </div>
	            <div class="panel-body">
					<ul id="tree2" class="nui-tree" style="padding:5px;" showTreeIcon="true"				
						idField="instanceId"
					 	onbeforeload="onBeforeTreeLoad" >
					</ul>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="modal-button">   
	    <button type="submit" class="btn btn-primary" onclick="submit()">确定</button>
	    <button type="reset" class="btn btn-success" data-dismiss="modal" onclick="onclo()">关闭</button>
	</div>

 	<script language="javascript">
 		nui.parse();
		var tree1 = nui.get("tree1");
		var tree2 = nui.get("tree2");		    
	    var url = '<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=metadataTree';
	    tree1.setUrl(url);
	    tree2.setUrl(url);
 		
		function onBeforeTreeLoad(e){
		    var tree = e.sender;    //树控件
		    var node = e.node;      //当前节点
		    var params = e.params;  //参数对象
		    
       		if (typeof(node.resource) == "undefined") {
       			// 向后台传入的自定义参数
  				params.resource = "root";
			    params.instanceId = "";
				params.classifierId = "";
				params.orderBy = "name";
				//params.start = "0";
				//params.limit = "100";
			}   
		    else{
		    	params.resource = node.resource;
			    params.instanceId = node.instanceId;
				params.classifierId = node.classifierId;
				
				//params.start = tree.pageIndex;
				params.orderBy = "name";
				//params.limit = tree.pageSize;
		    
		    }
		}

		function refreshTree(param){
			if(param == "tree1"){
				var tree = nui.get("tree1");
			}else if(param == "tree2"){
				var tree = nui.get("tree2");
			}
			tree.reload();
		}
		function findNode(param){
			if(param == "tree1"){
				var tree = nui.get("tree1");
				var key = nui.get("textbox1").getValue();
			}else if(param == "tree2"){
				var tree = nui.get("tree2");
				var key = nui.get("textbox2").getValue();
			}
			var nodes = tree.findNodes(function(node){
				if(key == ""){
					return false;
				}else{
					key = key.toLowerCase();
					var text = node.text ? node.text.toLowerCase() : ""; 
					if(text.indexOf(key) != -1){
						tree.expandPath(node);
						tree.selectNode(node);
						return true;
					}
				}
			});
			tree.expandNode(nodes);
		}
		
		function submit(){
			var tree1 = nui.get("tree1");
	    	var node1 = tree1.getSelectedNode();
	    	var tree2 = nui.get("tree2");
	    	var node2 = tree2.getSelectedNode();
			
			if (typeof(node1) == "undefined") {
		        nui.alert('请选择左侧要比较的元数据');
		        return false;
		    }
		    if (typeof(node2) == "undefined") {
		        nui.alert('请选择右侧要比较的元数据');
		        return false;
		    }
		    
		    if (node1.resource != 'metadata' || node2.resource != 'metadata') {
		        alert('请选择元数据节点进行比较');
		        return false;
		    }
		    if (node1.classifierId != node2.classifierId) {
		        alert('请比较相同类型的元数据');
		        return false;
		    }
		    // 添加为任务
		    var param = "instanceId1=" + node1.instanceId + "&" + "instanceId2=" + node2.instanceId;
		    var url = "contrastTaskCmd.do?invoke=addTaskInfo&" + param;
		    
		    nui.ajax({
		        url: url
		    });
		    
			onclo();
		}
		
		function onclo(){
	        parent.closeModal();
		}
		
	</script>
</html>
