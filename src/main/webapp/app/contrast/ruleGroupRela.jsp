<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<!DOCTYPE html />
<html>
<head>
    <title>分配规则</title>
    <!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/ruleGroupRela.css">
</head>

<body>
<div class="main">
	<div class="left">
		<div class="panel panel-info">
			<div class="panel-heading">
				未分配规则
			</div>
			<div class="panel-body">
				<input id="textbox1" class="nui-textbox"/>
                <button id="searchBtn1" class="btn btn-primary blue" onclick="search1()">查询</button>
				<div class="well">
					<div id="datagrid1" name="grid" class="nui-datagrid" style="height:290px;"
						 showReloadButton="false"
						 idField="ruleId" multiSelect="true" sortMode="client">
						<div property="columns">
							<div type="indexcolumn" ></div>
							<div field="ruleCode" name="ruleCode" align="center" headerAlign="center" allowSort="true">规则代码</div>
							<div field="ruleName" name="ruleName" align="center" headerAlign="center" allowSort="true">规则名称</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="middle">
        <button id="addAllBtn" class="btn btn-primary" onclick="addAll()"><span class="glyphicon glyphicon-forward"></span></button><br/><br/>
        <button id="addBtn" class="btn btn-primary" onclick="add()"><span class="glyphicon glyphicon-chevron-right"></span></button><br/><br/>
        <button id="removeBtn" class="btn btn-primary" onclick="remove1()"><span class="glyphicon glyphicon-chevron-left"></span></button><br/><br/>
        <button id="removeAllBtn" class="btn btn-primary" onclick="removeAll()"><span class="glyphicon glyphicon-backward"></span></button><br/><br/>

	</div>
	<div class="right">
		<div class="panel panel-info">
			<div class="panel-heading">
				已分配规则
			</div>
			<div class="panel-body">
				<input id="textbox2" class="nui-textbox"/>
                <button id="searchBtn2" class="btn btn-primary blue" onclick="search2()">查询</button>
				<div class="well">
					<div id="datagrid2" name="grid" class="nui-datagrid" style="height:290px;"
						 showReloadButton="false"
						 idField="ruleId" multiSelect="true" sortMode="client">
						<div property="columns">
							<div type="indexcolumn" ></div>
							<div field="ruleCode" name="ruleCode" align="center" headerAlign="center" allowSort="true">规则代码</div>
							<div field="ruleName" name="ruleName" align="center" headerAlign="center" allowSort="true">规则名称</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal-button">
    <button id="closeBtn" class="btn btn-primary" onclick="submit()">保存</button>
</div>

	<script type="text/javascript">
		nui.parse();
		// 存储grid1, grid2搜索前的数据
		var grid1Data = [];
		var grid2Data = [];
		
		var grid1 = nui.get("datagrid1");
		var url1 = "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listUngroupedRule";
		grid1.setUrl(url1);

		var grid2 = nui.get("datagrid2");
		var url2 = 
			"<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listGroupedRule" +
			"&ruleGroupId=<%=request.getParameter("ruleGroupId") %>";
		grid2.setUrl(url2);
		
		grid1.load();
		grid2.load();
		
		grid1.on("load",function(e){
			// 数据加载成功时
			grid1Data = nui.clone(grid1.getData());
		});
		grid2.on("load",function(e){
			// 数据加载成功时
			grid2Data = nui.clone(grid2.getData());
		});
		
		function addAll(){
			// 选中所有行，不触发事件
			grid1.selectAll (false);
			var rows = grid1.getSelecteds();
			// 移除grid1中的行，不自动选择
			grid1.removeRows(rows,false);
			// 将行添加到grid2的开头
			grid2.addRows(rows, 0);

			for(var j=0;j<rows.length;j++){
				var row = rows[j];
				for(var i=0;i<grid1Data.length;i++){
					var rowData = grid1Data[i];
					if(rowData.ruleId == row.ruleId){
						grid1Data.splice(i, 1);
						i--;
					}
				}
				grid2Data.push(row);
			}
		}
		
		function add(){
	        var row = grid1.getSelected();
	        
	        if(typeof(row) == "undefined"){
	        	nui.alert("请选择规则");
	        }else{
	        	grid1.removeRow(row, false);
	        	grid2.addRow(row, 0);
	        }
			// 同步数据
			for(var i=0;i<grid1Data.length;i++){
				var rowData = grid1Data[i];
				if(rowData.ruleId == row.ruleId){
					grid1Data.splice(i, 1);
					i--;
				}
			}
			grid2Data.push(row);
		}
		
		function remove1(){
			var row = grid2.getSelected();
	        
	        if(typeof(row) == "undefined"){
	        	nui.alert("请选择规则");
	        }else{
	        	grid2.removeRow(row, false);
	        	grid1.addRow(row, 0);
	        }
			// 同步数据
			for(var i=0;i<grid2Data.length;i++){
				var rowData = grid2Data[i];
				if(rowData.ruleId == row.ruleId){
					grid2Data.splice(i, 1);
					i--;
				}
			}
			grid1Data.push(row);
		}
		
		function removeAll(){
			// 选中所有行，不触发事件
			grid2.selectAll (false);
			var rows = grid2.getSelecteds();
			// 移除grid1中的行，不自动选择
			grid2.removeRows(rows,false);
			// 将行添加到grid2的开头
			grid1.addRows(rows, 0);
			
			for(var j=0;j<rows.length;j++){
				var row = rows[j];
				for(var i=0;i<grid2Data.length;i++){
					var rowData = grid2Data[i];
					if(rowData.ruleId == row.ruleId){
						grid2Data.splice(i, 1);
						i--;
					}
				}
				grid1Data.push(row);
			}
		}
		
		function submit(){
			grid2.setData(nui.clone(grid2Data));
			// 选择所有行，不触发事件
			grid2.selectAll(false);
        	var data = grid2.getSelecteds();     
        	//nui.alert(data.length);
        	var params = "{rules :" + nui.encode(data) + "}";
        	var ruleGroupId = "<%=request.getParameter("ruleGroupId") %>";
        	var url = "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=assignRule";
        	nui.ajax({
	            url : url,
	            type : "post",
	            data:{
	           	 	ruleGroupId : ruleGroupId,
	            	params: params
	            },
	            success: function (text) {
	                nui.alert("保存成功","",function(action){
	                	onclose();
	                });
	            }
        	});
		}
		
		/**
		* 查询规则，前台查询
		* grid1Data为grid1中的数据
		*/
		function search1(){
			// 获取查询关键字
			var keyWord = nui.get("textbox1").value;
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
		
		/**
		* 查询规则，前台查询
		* grid2Data为grid2中的数据
		*/
		function search2(){
			// 获取查询关键字
			var keyWord = nui.get("textbox2").value;
			if(keyWord == ""){
				// 如果关键字为空串，恢复grid2中的数据
				grid2.setData(nui.clone(grid2Data));
			}else{
				// 先恢复再查询结果
				grid2.setData(nui.clone(grid2Data));
				var rules = grid2.getData();
				for(var i=0;i<rules.length;i++){
                	var rule = rules[i];
                	if(rule.ruleName.indexOf(keyWord)>=0);              	
					else{
						// 将不符合查询条件的数据从表中删除
						grid2.removeRow(rule,false);
					}
	            }
			}
		}
		function onclose(){
		    parent.closeModal();
		}
	</script>
</body>
</html>
