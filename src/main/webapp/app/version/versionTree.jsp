<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/versionTree.css">
	</head>
	<body>
	<div class="tophead">
		<p><span id="back" class="glyphicon glyphicon-circle-arrow-right" style="font-size: 17px;float: left;margin-top: 3px;"></span>版本树</p>
	</div>
		<div class="left">
			<div class="panel panel-default">
				<div class="panel-heading">
					<button class="btn btn-primary blue" onclick="exportSelected()">导出</button>
					<button class="btn btn-primary blue" onclick="exportAll()">全部导出</button>	
				</div>
				<div class="panel-body">
					<ul id="tree1" class="nui-tree"
						showTreeIcon="true" idField="instanceId"
						onbeforeload="onBeforeTreeLoad" onnodeselect="onNodeSelect"  
						onnodecheck="onNodeCheck" autoCheckParent="true" checkRecursive="true" showCheckBox="true" >
					</ul>
				</div>
			</div>
		</div>

		<div class="right">
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingOne">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								基本信息
							</a>
						</h4>
					</div>
					<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
						<div class="panel-body">
							<div id="baseinfo" class="nui-datagrid" style="height: 175px;"
								 idField="modeId" sizeList="[30,80,80]" showPageInfo="false"
								 showPagerButtonIcon="false" allowAlternating="true"
								 showColumns="false" showPageIndex="false" showPageSize="false"
								 showReloadButton="false" sortMode="client">


								<div property="columns">
									<div type="indexcolumn"></div>
									<div name="info" field="info" align="left" width="100"
										 allowSort="true">
										基本信息名称
									</div>
									<div name="value" field="value" align="left" width="100"
										 allowSort="true">
										基本信息值
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingTwo">
						<h4 class="panel-title">
							<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
								属性信息
							</a>
						</h4>
					</div>
					<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
						<div class="panel-body">
							<div id="datagrid" class="nui-datagrid" style="height: 200px;"
								 idField="modeId" allowResize="true" sizeList="[30,80,80]"
								 pageSize="5" allowAlternating="true" sortMode="client">


								<div property="columns">
									<div type="indexcolumn"></div>
									<div name="featureName" field="featureName" align="left"
										 width="100" allowSort="true">
										属性名称
									</div>
									<div name="featureValue" field="featureValue" align="left"
										 width="100" allowSort="true">
										属性值
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingThree">
						<h4 class="panel-title">
							<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
								系统
							</a>
						</h4>
					</div>
					<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
						<div class="panel-body">

						</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingfour">
						<h4 class="panel-title">
							<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsefour" aria-expanded="false" aria-controls="collapseThree">
								系统层次
							</a>
						</h4>
					</div>
					<div id="collapsefour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingfour">
						<div class="panel-body">

						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
    nui.parse();
     function onBeforeTreeLoad(e){
        var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var params = e.params;  //参数对象
        if (typeof(node.resource) == "undefined") {
			params.resource = "root";
		    params.instanceId = "";
			params.classifierId = "";
			params.orderBy = "name";
			params.verId="<%=request.getParameter("verId")%>";

		}   
	  else{
	    	params.resource = node.resource;
		    params.parentId = node.instanceId;
			params.classifierId = node.classifierId;
			params.verId="<%=request.getParameter("verId")%>";
	    
	    }	
    }
	var tree1 = nui.get("tree1");		    
    var url = '<%=request.getContextPath()%>/verTreeCmd.do?invoke=newmetadataTree';
    tree1.setUrl(url);
    
    nui.parse();
    var grid1 = nui.get("baseinfo");	
    var grid = nui.get("datagrid");
    
    function onNodeSelect(e){
    	var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var parent = tree.getParentNode(node);
        
        if(node.pid!=node.instanceId){
        	
    		//基本信息赋值
            var url1 = "<%=request.getContextPath()%>/version.do?invoke=showVersionMetadata&verId=<%=request.getParameter("verId")%>&instanceId="+node.instanceId;
            grid1.setUrl(url1);
            //grid1.setData(data);
            grid1.load();

            //属性信息赋值
            var url = '<%=request.getContextPath()%>/version.do?invoke=showVersionAttribute&verId=<%=request.getParameter("verId")%>&instanceId='+node.instanceId;
            grid.setUrl(url);
            grid.load();
        }
        else{
        	grid.clearRows();
        	grid1.clearRows();
        }
		
    } 
    function onNodeCheck(e){
    	var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
    }
    //导出选中树
    function exportSelected(){
      var nodes = new Array();
      nodes = tree1.getCheckedNodes();
      if(nodes.length==0){
    	  nui.alert("请选择一个节点");
    	  return false;
      }
      var instanceId = new Array();
      for(var i = 0;i<nodes.length;i++){
          var parent = tree1.getParentNode(nodes[i]);
          var inid = nodes[i].instanceId;
          if(parent.instanceId==inid){       	  
              var instans = nodes[i].children;
              for(var j = 0;j<instans.length;j++){
            	  instanceId.push(instans[j].instanceId);
              }
          }
          else{
        	  instanceId.push(inid);
          }
          
      }
      var instanceIds = nui.encode(instanceId);
	   	var url = "<%=request.getContextPath()%>/verTreeCmd.do?invoke=downloadVersionTree&verId=<%=request.getParameter("verId")%>&instanceIds="+instanceIds+"&whole=false";
		window.open(url);
     }
	//导出全部树
    function exportAll(){
  	   	var url = "<%=request.getContextPath()%>/verTreeCmd.do?invoke=downloadVersionTree&verId=<%=request.getParameter("verId")%>&whole=true";
		window.open(url);
        
       }
	
	jQuery(function () {
		$('#back').click(function(){
			parent.$('.hidebg').click();
		});
	});
    
</script>
	</body>
</html>