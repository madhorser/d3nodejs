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
		<title>版本发布</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/versionRelease.css">
	</head>
	<body>

		<div class="left" style="height: 500px;">
			<div class="panel panel-default">
				<div class="panel-heading">
					<button class="btn btn-primary blue" onclick="refresh()">刷新</button>
				</div>
				<div class="panel-body">
					<ul id="tree1" class="nui-tree" style="padding: 5px;"
						showTreeIcon="true" idField="instanceId" pageSize="20"
						onbeforeload="onBeforeTreeLoad"
						pageIndexField="start" showCheckBox="true" checkRecursive="false">
					</ul>
				</div>
			</div>
		</div>

		<div class="right" style="height: 500px;">
			<div class="panel panel-info">
				<div class="panel-heading">
					请填写版本信息
				</div>
				<div class="panel-body" style="height: 500px;">
					<div class="well">
						<p>定版说明</p>
						<p>1、请按照实际项目标准命名版本编号，版本编号全局唯一；</p>
						<p>2、本功能默认对所迭元数据的树形分支进行定版，请选择正确的分支。</p>
					</div>
                    
                    	<br>
                        <label for="verName" style="height: 35px;">版本编号：</label>
                        <input id="verName" name="verName" style="width:50%; height: 35px;" errorMode="none" class="nui-textbox"/>
                        <br>
                        <br>
                 
                        <label for="verType" style="height: 35px;">是否基线：</label>
                        <input id="verType" name="verType" style="height: 35px;" class="nui-combobox"/>
                        <br>
                        <br>
                        <label for="verDesc" style="height: 35px;">版本描述：</label>
                        <input id="verDesc" name="verDesc" class="nui-textarea" style="width:50%;height: 35px;"/>
                        <br>
                        <br>
                        <button class="btn btn-primary blue" style="margin-top:25px" onclick="release()">定版</button>
                    
				</div>
			</div>
		</div>

		<script>
    nui.parse();
    
	//为是否为基线版本的下拉框赋值
	var data = [{'id':'1','text':'是'},{'id':'0','text':'否'}];
	var type = nui.get("verType");
	type.setData(data);
	var tree1 = nui.get("tree1");		    
    var url = '<%=request.getContextPath()%>/dataViewCmd.do?invoke=newtreeDataView';
    tree1.setUrl(url);
    //根据不同情况赋值
    function onBeforeTreeLoad(e){
        var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var params = e.params;  //参数对象
        var url1;
        if(typeof(node.resource) == "undefined"){
        	params.resource = "root";
        	params.privilege = "true";
        	params.orderBy = "name";
            	
        }
        else{
        	params.resource = node.resource;
        	params.privilege = "true";
        	params.orderBy = "name";
        	params.viewId = node.viewId;
        	params.folderId = node.folderId;
        	params.start = node.start;
        	params.instanceId = node.instanceId;
        	params.classifierId = node.classifierId?node.classifierId:"";
        }
        
    } 
    //发布操作 
    function release(){
        var node = tree1.getSelectedNode();
        if(typeof(node)=="undefined"){
            nui.alert("请在元数据树上选择需要定版的分支");
            return;
        }
        if(typeof(node.instanceId)=="undefined"){
            nui.alert("请在元数据树上选择需要定版的分支");
            return false;
        }
        var verName = nui.get("verName").getValue();
    	if(verName == ""){
        	nui.alert("版本编号不能为空！");
        	return false;
    	}
    	var verType = nui.get("verType").getValue();
    	if(verType == ""){
        	nui.alert("请选择基线类型！");
        	return false;
    	}
        nui.alert("请保证需要定版的分支都已正确、完整选择。是否确认提交定版？", "确定？",
                function (action) {
                    if (action == "ok") {
                    	var verName = nui.get("verName").getValue();
                        var verType = nui.get("verType").getValue();
                        var verDesc = nui.get("verDesc").getValue();
                        var url = "<%=request.getContextPath()%>/version.do?invoke=releaseVersion";
                		nui.ajax({
                		    url: url,
                		    data: {
                				instanceId:node.instanceId,
                				verName:encodeURI(verName),
                				verType:encodeURI(verType),
                				verDesc:encodeURI(verDesc)
                			},
                			success: function (text) {
                 				var data = nui.decode(text);
                    			if(data.success){                        			
                    				nui.alert("定版成功","",
                    				function(action){
                    				selfClose();
                    				});
                    				nui.pase();               				
                    			}
                    			else{
                    				nui.alert(data.msg);
                    			}
                	            
                	        }
                	 		
                		});
                    }
                }
            );
        
    }
    //刷新（全部刷新，待优化）
    function refresh(){
        tree1.reload(url);
    }
     function selfClose() {
    	parent.$('.hidebg').click();
    }
    
</script>
	</body>
</html>