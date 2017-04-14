<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html>
<head>
    <title>变更修改</title>

	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
		
    <%
		String contextPath=request.getContextPath();
    	String changeId = request.getParameter("changeId");
	%>
	<script>
		nui.context='<%=contextPath %>';
	</script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/modelChangeUpdate.css">
</head>

<body>
<div class="tophead">
	<p><span id="back" class="glyphicon glyphicon-circle-arrow-right" style="font-size: 17px;float: left;"></span>变更修改</p>
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
			<button id="addBtn" class="btn btn-primary" onclick="cancel()" style="float:right;" data-toggle="modal" data-target="#newSheet">取消</button>
			<button id="addBtn" class="btn btn-primary" onclick="update()" style="float:right;" data-toggle="modal" data-target="#newSheet">保存</button>
		</p>
		<div class="well">
			<div id="datagrid" class="nui-datagrid" style="height:435px;" sortMode="client" 
				allowCellEdit="true" allowCellSelect="true" editNextRowCell="true"  multiSelect="true">				 
				 
				<div property="columns"> 
					<div field="alterId" headerAlign="center" align="center" allowSort="true">变更单编号
					</div>
		            <div field="schemaCode" headerAlign="center" align="center" allowSort="true">数据库名
		            </div>
		            <div field="tableCode" headerAlign="center" align="center" allowSort="true">表名
						<input property="editor" class="nui-textbox" style="width:100%;" minWidth="200" />
		            </div>
		            <div field="columnCode" headerAlign="center" align="center" allowSort="true">字段名
						<input property="editor" class="nui-textbox" style="width:100%;" minWidth="200" />
		            </div>
		            <div field="columnType" headerAlign="center" align="center" allowSort="true">字段类型
						<input property="editor" class="nui-textbox" style="width:100%;" minWidth="200" />
		            </div>
		            <div field="columnLength" headerAlign="center" align="center" allowSort="true">长度
						<input property="editor" class="nui-textbox" style="width:100%;" minWidth="200" />
		            </div>
		            <div field="columnPrecision" headerAlign="center" align="center" allowSort="true">精度
						<input property="editor" class="nui-textbox" style="width:100%;" minWidth="200" />
		            </div>
		            <div  field="nullable" headerAlign="center" align="center" allowSort="true">是否为空
						<input property="editor" class="nui-combobox" style="width:100%;" minWidth="200" data="nullableItems" />
		            </div>
		            <div field="changeType" headerAlign="center" align="center" allowSort="true">变更类型
						<input property="editor" class="nui-combobox" style="width:100%;" minWidth="200" data="changeTypeItems" />
		            </div>
				</div>
			</div>
		</div>
	</div>
</div>

	<script type="text/javascript">
	
	 	var nullableItems = [{ id: 1, text: "是" }, { id: 0, text: "否"}];
	 	var changeTypeItems = [{id: 1, text: "新增"},{id: 2, text: "修改"},{id: 3, text: "删除"}];
	 	
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
	    
	    var url = "<%=request.getContextPath()%>/modelChange.do?invoke=queryChangeDetail&changeId=<%=changeId%>";
	    grid.setUrl(url);
	    grid.on("drawcell", function (e) {
	         var record = e.record,
                column = e.column,
                field = e.field,
                value = e.value;
	        if (field == "changeType") {
	            if (trim(value) == "1") e.cellHtml = "新增";
	            if (trim(value) == "2") e.cellHtml = "修改";
	            if (trim(value) == "3") e.cellHtml = "删除";
	        }else  if (field == "nullable") {
	            if (trim(value) == "1") e.cellHtml = "是";
	            if (trim(value) == "0") e.cellHtml = "否";
	        } 
	        
	    });
	    grid.load();
	    
	    function trim(str)
	    { 
	        return str.replace(/(^\s*)|(\s*$)/g, ""); 
		}
		/***************************************************************************/
		
		function closeModal(){
    		$('.modal').modal('hide');
    		grid.reload();
		}
		jQuery(function () {
			$('#back').click(function(){
				parent.$('.hidebg').click();
			});
		});
		
		function cancel(){
			if(!grid.isChanged()){
	            nui.alert("没有数据变动！");
			}else{
                grid.reload();
			}
		};

		function update(){		
			
			if(!grid.isChanged()){
	            nui.alert("没有数据变动!");
				return;
			}else{
	            nui.confirm("保存变动数据？", "确定？",
	                    function (action) {
	                        if (action == "ok") {
	                        	saveUpdate();
	                        } else {
	                           return;
	                        }
	                    }
	                );
			}

		}
		
		function saveUpdate(){
			
			var changeData = grid.getChanges();
			var updateData = [];
			
			for(var i =0; i < changeData.length; i++){
				updateData.push(
						{
							id              :  changeData[i].id,             
							alterId         :  changeData[i].alterId,      
							changeType      :  changeData[i].changeType,    
							hangNodeId      :  changeData[i].hangNodeId,    
							schemaCode      :  changeData[i].schemaCode,     
							tableName       :  changeData[i].tableName,     
							tableCode       :  changeData[i].tableCode,      
							columnName      :  changeData[i].columnName,     
							columnCode      :  changeData[i].columnCode,     
							columnType      :  changeData[i].columnType,     
							columnLength    :  changeData[i].columnLength,   
							columnPrecision :  changeData[i].columnPrecision,
							nullable        :  changeData[i].nullable    
						});
			}

			var json = nui.encode(updateData);
			var changeUrl = "<%=request.getContextPath()%>/modelChange.do?invoke=updateChanges";

		 	grid.loading("保存中，请稍后......");
	        $.ajax({
	                url: changeUrl,
	                data: { changeData: json },
	                type: "post",
	                success: function (text) {
	                    grid.reload();
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);
	                }
	            });
		}
		
    </script>
</body>
</html>
