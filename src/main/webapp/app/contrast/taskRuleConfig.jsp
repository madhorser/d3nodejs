<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Bootstrap Template</title>
	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/taskRuleConfig.css">
</head>
<body>
<div class="main">
	<div class="left">
	    <div class="panel panel-info">
	        <div class="panel-heading">
	           		 未分配规则
	        </div>
	        <div class="panel-body">
	            <input id="search-box" class="nui-textbox"/>
	            <button class="btn btn-primary blue" onclick="searchRule()">搜索</button>
	           	 规则组：
		        <input id="ruleGroupCombox" class="nui-combobox" style="width:80px;" textField="groupName" valueField="groupId"
						allowInput="false" showNullItem="true" nullItemText="所有规则"/>
	
	            <div class="well">
	                <div id="datagrid1" name="grid" class="nui-datagrid" style="height:290px;"
				        idField="ruleId" sortMode="client" showReloadButton="false">
				        <div property="columns">
				            <div field="ruleName" name="ruleName" align="center" headerAlign="center">规则名称</div>
				            <div field="ruleCode" name="ruleCode" align="center" headerAlign="center">规则编码</div>               
				        </div>
				   	</div> 
	            </div>
	        </div> 
	   </div>
	</div>
	<div class="middle">
		<button class="btn btn-primary blue" onclick="add()"><span class="glyphicon glyphicon-arrow-right"></span></button><br/><br/>
	    <button class="btn btn-primary blue" onclick="remove1()"><span class="glyphicon glyphicon-arrow-left"></span></button>
	</div>
	<div class="right">
	    <div class="panel panel-info">
	        <div class="panel-heading">
	            已分配规则
	        </div>
	        <div class="panel-body">
				<p style="height: 25px;"></p>
	            <div class="well">
	                <div id="datagrid2" name="grid" class="nui-datagrid" idField="ruleId" sortMode="client" style="height:290px;" showReloadButton="false">
				        <div property="columns">
				            <div field="ruleName" name="ruleName" align="center" headerAlign="center" allowSort="true">规则名称</div>
				            <div field="ruleCode" name="ruleCode" align="center" headerAlign="center" allowSort="true">规则编码</div>                
				        </div>
				   	</div> 
	            </div>
	        </div>
	    </div>
	</div>
</div>

<div class="modal-button">   
    <button type="submit" class="btn btn-primary" onclick="submit()">确定</button>
    <button type="reset" class="btn btn-success" data-dismiss="modal" onclick="onclo()">关闭</button>
</div>

	<script type="text/javascript">
		nui.parse();
		// 存储grid1搜索前的数据
		var grid1Data = [];
		var grid1 = nui.get("datagrid1");
		var grid2 = nui.get("datagrid2");
		var url1 = "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listContrastRule";
		grid1.setUrl(url1);
		grid1.load();	
		// grid1数据加载后设置grid2的数据
		grid1.on("load",function(e){
			var taskId = "<%=request.getParameter("taskId") %>";
			nui.ajax({
	            url: "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listRuleIdsByTaskId" ,
	            type: "post",
	            async: false,
	            data:{
	            	taskId : taskId
	            },
	            success: function (text) {
	                // 获得跟任务关联的规则的id
	                var d = nui.decode(text);
	                var values = d.data;
	                for(var i=0;i<values.length;i++){
	                	var ruleId = values[i];
	                	var row = grid1.findRow(function(row){
							if(row.ruleId == ruleId) return true;
						});                	
	                	grid1.removeRow(row, false);
		        		grid2.addRow(row, 0);
	                }
	                grid1Data = nui.clone(grid1.getData());
	            }
	       	});
		});
		
		// 设置规则组选择下拉列表
		var ruleGroupCombox = nui.get("ruleGroupCombox");
		var url2 = "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listRuleGroup";
		ruleGroupCombox.load(url2);
		
		// 下拉框中值发生变化时，更新grid1中的数据
		ruleGroupCombox.on("valuechanged", function(e) {
			var groupId = ruleGroupCombox.getValue();
			if(typeof(groupId)=="undefined" || groupId == ""){
				grid1.reload();
				grid1Data = nui.clone(grid1.getData());
			}
			else{
				var url = "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listGroupedRule";
				nui.ajax({
		            url: url,
		            type: "post",
		            data:{
		           	 	ruleGroupId : groupId
		            },
		            success: function (text) {
		            	var data = nui.decode(text).data;
						grid1.setData(data);
						var taskRules = grid2.getData();
						for(var i=0;i<taskRules.length;i++){
		                	var taskRule = taskRules[i];
		                	var row = grid1.findRow(function(row){
								if(row.ruleId == taskRule.ruleId) return true;
							});                	
		                	grid1.removeRow(row, false);
		                }
		                grid1Data = nui.clone(grid1.getData());
		            }
		        });
			}
		});
		/**
		* 将grid1中选择的记录移到grid2
		*/
		function add(){
	        var row = grid1.getSelected();     
	        if(typeof(row) == "undefined"){
	        	nui.alert("请选择规则");
	        }else{
	        	grid1.removeRow(row, false);
	        	grid2.addRow(row, 0);
	        	grid1Data = nui.clone(grid1.getData());
	        }
		}
		/**
		* 将grid2中选择的记录移到grid1
		*/		
		function remove1(){
			var row = grid2.getSelected();        
	        if(typeof(row) == "undefined"){
	        	nui.alert("请选择规则");
	        }else{
	        	grid2.removeRow(row, false);
	        	var groupId = ruleGroupCombox.getValue();
	        	if(groupId == "" || row.groupId == groupId){
	        		// 当选择的规则组为默认值（空串）或选择记录的groupId与下拉框中groupId一致时，向grid1中添加数据
	        		grid1.addRow(row, 0);
	        		grid1Data = nui.clone(grid1.getData());
	        	}
	        }
		}
		
		function submit(){
        	var data = grid2.getData();
        	var params = "{rules :" + nui.encode(data) + "}";
        	var taskId = "<%=request.getParameter("taskId") %>";
			nui.ajax({
	            url: "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=addTaskRuleRelations",
	            type: "post",
	            data:{
	           	 	params : params,
	            	taskId : taskId
	            },
	            success: function (text) {
	                nui.alert("保存成功","",function(action){
	                	onclo();
	                });
	            }
        	});
		}
		/**
		* 查询规则，前台查询
		* grid1Data为grid1中的数据
		*/
		function searchRule(){
			// 获取查询关键字
			var keyWord = nui.get("search-box").value;
			if(keyWord == ""){
				// 如果关键字为空串，恢复grid1中的数据
				grid1.setData(nui.clone(grid1Data));
			}else{
				// 先恢复再查询结果
				grid1.setData(nui.clone(grid1Data));
				var rules = grid1.getData();
				for(var i=0;i<rules.length;i++){
                	var rule = rules[i];
                	if(rule.ruleName.indexOf(keyWord)>=0);              	
					else{
						// 将不符合查询条件的数据从表中删除
						grid1.removeRow(rule,false);
					}
	            }
			}
		}
		function onclo(){
		    parent.closeModal();
		}
	</script>


</body>
</html>