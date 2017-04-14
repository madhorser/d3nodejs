<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<!DOCTYPE html />
<html>
<head>
    <title>规则组管理</title>
	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery-ui.js"></script>
    <script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery.tmpl.js"></script>
    <%
		String contextPath=request.getContextPath();
	%>
	<script>
		nui.context='<%=contextPath %>';
	</script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/contrastRuleGroup.css">
</head>

<body>
<div class="tophead">
	<p><span id="back" class="glyphicon glyphicon-circle-arrow-right" style="font-size: 17px;float: left;"></span> 规则组管理</p>
</div>
<div class="panel panel-info">
	<div class="panel-body">
		<div id="form1" >
			规则组代码：
			<input id="textbox-groupcode" name="ruleGroupCode" class="nui-textbox"/>
			规则组名称：
			<input id="textbox-groupname" name="ruleGroupName" class="nui-textbox"/>
			创建人：
			<input id="textbox-createUserName" name="createUserName" class="nui-textbox"/>
			创建时间：
			<input id="textbox-createTime" name="createTime" class="nui-datepicker"/>
			<br/>
			<br/>
			<button id="searchBtn" class="btn btn-primary blue" onclick="search()">查询</button>
			<button id="clearBtn" class="btn btn-primary blue" onclick="resetForm()">重置</button>
		</div>
	</div>
</div>
<div class="panel panel-default">
	<div class="panel-body">

		<p class="p-head"><span></span>结果列表
			<button id="addBtn" class="btn btn-primary" onclick="add()" data-toggle="modal" data-target="#newSheet"><img src="<%=request.getContextPath() %>/app/base/images/icons/add.png">&nbsp新增</button>
		</p>
		<div class="well">
			<div id="datagrid1" class="nui-datagrid" style="height:500px;"
				 allowCellEdit="true" allowCellSelect="true"
				 dataField="data" idField="groupId" allowResize="false" sortMode="client"> 
				<div property="columns">
					<div type="indexcolumn" ></div>
					<div field="groupCode"  headerAlign="center" align="center" allowSort="true">规则组编号</div>
					<div field="groupName"  headerAlign="center" align="center" allowSort="true">规则组名称
						<input property="editor" class="nui-textbox" style="width:100%;"/>
					</div>
					<div field="createUserName"  headerAlign="center" align="center" allowSort="true">创建人</div>
					<div field="createTime"  headerAlign="center" dateFormat="yyyy-MM-dd" align="center" allowSort="true">
						创建时间
					</div>
					<div field="groupDesc"  headerAlign="center" allowSort="true">备注
						<input property="editor" class="nui-textbox" style="width:100%;"/>
					</div>
					<div name="action" width="120" headerAlign="center" align="center"
						renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="newSheet" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="newSheet-drag" role="document">
        <div class="modal-content" style="height:350px;width:600px;top:90px;left:130px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">新增规则组</h5>
            </div>
            <div class="modal-body" style="height:320px;align:center">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src="" style="height:280px"></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<div class="modal fade" id="assign" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" style="width:700px;" id="assign-drag" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">分配规则</h5>
            </div>
            <div class="modal-body">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src=""></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
	<script type="text/javascript">
        nui.parse();
        var grid = nui.get("datagrid1");
        grid.setUrl(nui.context + "/contrastTaskCmd.do?invoke=listRuleGroup");      
        grid.load();
        grid.on("drawcell", function (e) {
			var record = e.record;
		    var field = e.field;
		    var value = e.value;
		    //格式化日期
		    if (field == "createTime") {
		    	value = new Date(value); 
		        if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
		    }
		});
		
		// 数据编辑提交后更新
		grid.on("cellcommitedit", function(e){
			var rowIndex = e.rowIndex;
			var row = grid.getRow(rowIndex);

        	if(e.field == "groupName")row.groupName = e.value;
			if(e.field == "groupDesc")row.groupDesc = e.value;
        	var url = nui.context + "/contrastTaskCmd.do?invoke=updateContrastRuleGroup";
        	var ruleGroupId = row.groupId;
        	var groupName = row.groupName;
        	var groupDesc = row.groupDesc;
			nui.ajax({
			    url: url,
			    type : "POST",
			    data: {
			   		ruleGroupId : ruleGroupId,
			   		groupName : groupName,
			   		groupDesc : groupDesc
				},
				success: function (text) {
		            grid.reload();
		        }
			});
		});
		
	    function onActionRenderer(e) {
		    var grid = e.sender;
		    var record = e.record;
		    var uid = record._uid;
		    var rowIndex = e.rowIndex;
		    var s =	'  <button class="btn btn-primary blue" onclick="onDelete(\'' + uid + '\')">删除</button>' +
		    		'  <button class="btn btn-primary blue" data-toggle="modal" data-target="#assign" onclick="assignRule(\'' + uid + '\')">分配规则</button>' ;	
		    return s;
	    }
	    
		function add(){
	        // 获得groupCode最大值，作为参数传递
			var c = grid.getData();
			var newCode;
			if(typeof(c) == "undefined" || c.length == 0){
				newCode = "gzz001";
			}else{
				var max = "gzz000";
				for(var i=0;i<c.length;i++){	
					if(c[i].groupCode >= max){
						max = c[i].groupCode;
					}
				}
				var maxNum = "" + (parseInt(max.substr(3,3))+1);
				var text = "gzz";
				for(var i=0;i<3-maxNum.length;i++)text += "0";
				newCode = text + maxNum;
			}
	        
	        var url = nui.context + "/forward.do?forward=/app/contrast/addRuleGroup.jsp&newCode=" + newCode;
            $('#newSheet iframe').attr('src',url);
	 	}
	 	
		function onDelete(uid){
    		var row = grid.getRowByUID(uid);
        	var isEmpty = row.isEmptyGroup;
        	if(isEmpty == "0"){
        		nui.alert("你选择的是非空组，不允许删除");
        	}else{
        		var groupId = row.groupId;
	        	var url = nui.context + "/contrastTaskCmd.do?invoke=deleteRuleGroup";
	        	nui.alert("确定删除该任务？", "确定？",
	                    function (action) {
	                        if (action == "ok") {
	                        	nui.ajax({
	            				    url: url,
	            				    data: {
	            				   		groupId : groupId
	            					},
	            					success: function (text) {
	            			            nui.alert("删除成功");
	            				        grid.reload(); 
	            			        }
	            				}); 
	                        }
	        	}); //
        	}
	 	}
	 	
	 	function search() {
	        var form = new nui.Form("#form1");
	        var data = form.getData();
	 		
			var ruleGroupCode = data.ruleGroupCode;
	      	var ruleGroupName = data.ruleGroupName;
	      	var createUserName = data.createUserName;
	      	var date = data.createTime;
	      	var createTime = "";
	      	var createTime2 = "";
	      	if(typeof(date) != "undefined" && date != ""){
	      		createTime = nui.parseDate(date).getTime();
	      		createTime2 = createTime+86400000;
	      	}
	      //客户端过滤
            grid.filter(function (row) {

                //ruleName
                var r1 = true;
                if (ruleGroupCode) {
                    r1 = String(row.groupCode).toLowerCase().indexOf(ruleGroupCode) != -1;
                }
                //createTime
                var r2 = true;
                if (createTime) {
                    r2 = false;
                    if (row.createTime >= createTime&&row.createTime<=createTime2) r2 = true;
                }

                var r3 = true;
                if (createUserName) {
                    r3 = String(row.createUserName).toLowerCase().indexOf(createUserName) != -1;
                }
                var r4 = true;
                if (ruleGroupName) {
                    r4 = String(row.groupName).toLowerCase().indexOf(ruleGroupName) != -1;
                }

                return r1 && r2 && r3 && r4;
            });
        }
        function resetForm(){
     		var form = new nui.Form("#form1");
	    	form.reset();
            grid.load();
        }
        function assignRule(uid){     	
	        var row = grid.getRowByUID(uid);
        	var ruleGroupId = row.groupId;
        	var url = "forward.do?forward=/app/contrast/ruleGroupRela.jsp&ruleGroupId=" + ruleGroupId;
        	$('#assign iframe').attr('src',url);
	 	}
	 	function closeModal(){
    		$('.modal').modal('hide');
    		grid.reload();
		}
	 	jQuery(function () {
			
			$('#back').click(function(){
				parent.$('.hidebg2').click();
				});

		});
    </script>
    <script>
    $(document).ready(function(){
    	//引用jquery-ui.js&jquery.tmpl.js实现拖动 
        $("#newSheet-drag").draggable();//为模态对话框添加拖拽
        $("#newSheet").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动
        //选择规则
        $("#assign-drag").draggable();//为模态对话框添加拖拽
        $("#assign").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动

    })
</script>
</body>
</html>
