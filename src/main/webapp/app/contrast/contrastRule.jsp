<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html>
<head>
    <title>比对规则管理</title>

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
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/contrastRule.css">
</head>

<body>
<div class="tophead">
	<p><span id="backAppli" class="glyphicon glyphicon-circle-arrow-left" style="font-size: 17px;float: left;"></span> 规则管理</p>
</div>
<div class="panel panel-default">
	<div class="panel-body">
		<div id="form1" >
			规则名称：
			<input id="textbox-rulename" name="ruleName" class="nui-textbox"/>
			创建时间：
			<input id="textbox-createTime" name="createTime" class="nui-datepicker"/>
			创建人：
			<input id="textbox-createUserId" name="createUserName" class="nui-textbox"/>
			规则类型：
			<input id="typeCombobox" name="ruleType" class="nui-combobox" style="width:150px;"
				   textField="text" valueField="id" showNullItem="true" allowInput="false" />
			<br/><br/>
			<button id="searchBtn" class="btn btn-primary blue" onclick="search()">查询</button>
			<button id="clearBtn" class="btn btn-primary blue" onclick="resetForm()">重置</button>
		</div>
	</div>
</div>
<div class="panel panel-default">
	<div class="panel-body">
		<p class="p-head"><span></span>结果列表	
			<button id="ruleBtn" class="btn btn-primary" onclick="openRuleGroup()" style="float:right;">规则组管理</button>
			<button id="addBtn" class="btn btn-primary" onclick="add()" style="float:right;" data-toggle="modal" data-target="#newSheet"> 新增</button>
		</p>
		<div class="well">
			<div id="datagrid1" class="nui-datagrid" style="height:500px;"
				 dataField="data"idField="ruleId" allowResize="false" sortMode="client">
				<div property="columns">
					<div type="indexcolumn" ></div>
					<div field="ruleCode"  headerAlign="center" align="center" allowSort="true">规则编号</div>
					<div field="ruleName"  headerAlign="center" align="center" allowSort="true">规则名称</div>
					<div field="ruleType"  headerAlign="center" align="center" allowSort="true">规则类型</div>
					<div field="createUserName"  headerAlign="center" align="center" allowSort="true">创建人</div>
					<div field="createTime"  headerAlign="center" align="center" allowSort="true">创建时间</div>
					<div name="action" width="120" headerAlign="center" align="center"
						 renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="hidebg2"></div>
<div class="dRight2">
	<div class="embed-responsive embed-responsive-16by9">
		<iframe class="embed-responsive-item" src=""></iframe>
	</div>
</div>
<div class="modal fade" id="newSheet" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="newSheet-drag" role="document">
        <div class="modal-content" style="height:660px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">新增规则</h5>
            </div>
            <div class="modal-body" id="addBody">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src=""  style="height:560px"></iframe>
                </div>
            </div>
            <!--<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>-->
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<div class="modal fade" id="mod" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="mod-drag" role="document">
        <div class="modal-content" style="height:660px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">修改规则</h5>
            </div>
            <div class="modal-body" id="modBody">
                <div class="embed-responsive embed-responsive-16by9" style="height:620px">
                    <iframe class="embed-responsive-item" src=""  style="height:560px"></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
	
	<script type="text/javascript">
		nui.parse();
		// 设置规则类型文本
		var types = [
	    { "id": "0", "text": "全量比对" },
	    { "id": "1", "text": "只比较基本信息" },
	    { "id": "2", "text": "只比较属性信息" },
		];
		var typeCombobox = nui.get("typeCombobox");
		typeCombobox.setData(types);
		// 设置比对规则表
        var grid = nui.get("datagrid1");
        grid.setUrl(nui.context + "/contrastTaskCmd.do?invoke=listContrastRule");
        grid.load();
        grid.sortBy("ruleName", "desc");
        grid.on("drawcell", function (e) {
			var record = e.record;
		    var field = e.field;
		    var value = e.value;
		    //格式化日期
		    if (field == "createTime") {
		    	value = new Date(value); 
		        if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
		    }
		    // 状态
		    if (field == "ruleType"){
		    	switch(value){
		    	case "0":
		    		e.cellHtml = "全量比对";
		    		break;
		    	case "1":
		    		e.cellHtml = "只比较基本信息";
		    		break;
		    	case "2":
		    		e.cellHtml = "只比较属性信息";
		    		break;
		    	}
		    }
		});
		/***************************************************************************/
		function onActionRenderer(e) {
		    var grid = e.sender;
		    var record = e.record;
		    var uid = record._uid;
		    var rowIndex = e.rowIndex;
		    var s =	'  <button class="btn btn-primary blue" data-toggle="modal" data-target="#mod" onclick="update(\'' + uid + '\')">修改</button>' +
		    		'  <button class="btn btn-primary blue" onclick="onDelete(\'' + uid + '\')">删除</button>' ;
	
		    return s;
    	}
    	
        function add(){
            var url="forward.do?forward=/app/contrast/addRule.jsp";
            var ttbody = document.getElementById("addBody");
            ttbody.style.height="620px";//设置高度
            $('#newSheet iframe').attr('src',url);
 		}
 		function onDelete(row_uid){
	 		var row = grid.getRowByUID(row_uid);
        	var ruleId = row.ruleId;
        	var url = nui.context + "/contrastTaskCmd.do?invoke=deleteContrastRule";
        	nui.alert("确定删除该任务？", "确定？",
                    function (action) {
                        if (action == "ok") {
                        	nui.ajax({
                			    url: url,
                			    data: {
                			   		ruleId : ruleId
                				},
                				success: function (text) {
                		            var data = nui.decode(text);
                		            if(data.status == "0"){
                		            	grid.reload(); 
                		            	nui.alert("删除成功");
                		            }else if(data.status == "-1"){
                		            	grid.reload(); 
                		            	nui.alert("该规则已被任务关联，不允许删除");
                		            }
                			        
                		        }
                			});
                        }        	
    		}); //          
			
	 	}

 		function update(row_uid){
 			var row = grid.getRowByUID(row_uid);
        	var param = nui.encode(row);
        	//encodeURI(param)
			//var url = "<%=request.getContextPath() %>/forward.do?forward=/app/contrast/modRule.jsp?param=" + encodeURI(param);	
			var url = "forward.do?forward=/app/contrast/modRule.jsp?param=" + encodeURI(param);
			var ttbody = document.getElementById("modBody");
            ttbody.style.height="620px";//设置高度
 			$('#mod iframe').attr('src',url);
 		}

        function search() {
            var form = new nui.Form("#form1");
	        var data = form.getData();
	 		
			var ruleName = data.ruleName;
	      	var createUserName = data.createUserName;
	        var ruleType = data.ruleType;
	      	var date = data.createTime;
	      	var createTime = "";
	      	var createTime2 = "";
	      	if(typeof(date) != "undefined" && date != ""){
	      		createTime = nui.parseDate(date).getTime();
	      		createTime2 = createTime + 86400000;
	      	}
	      	//客户端过滤
            grid.filter(function (row) {

                //ruleName
                var r1 = true;
                if (ruleName) {
                    r1 = String(row.ruleName).toLowerCase().indexOf(ruleName) != -1;
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
                if (ruleType) {
                    r4 = String(row.ruleType).toLowerCase().indexOf(ruleType) != -1;
                }

                return r1 && r2 && r3 && r4;
            });
        }	
        
        function resetForm(){
        	var form = new nui.Form("#form1");
	    	form.reset();
            grid.load();
        }
        
        function openRuleGroup(){
			var url = nui.context + "/forward.do?forward=/app/contrast/contrastRuleGroup.jsp";
			$('.dRight2 iframe').attr('src',url);
		}
		function closeModal(){
    		$('.modal').modal('hide');
    		grid.reload();
		}
		jQuery(function () {
			$('#ruleBtn').click(function(){
				$('.dRight2').addClass('menu-right');
				var hideobj=document.getElementsByClassName("hidebg2")[0];
				hideobj.style.display="block";
				hideobj.style.height=document.body.clientHeight+"px";

			});
			$('.hidebg2').click(function(){
				$('.dRight2').removeClass('menu-right');
				document.getElementsByClassName("hidebg2")[0].style.display="none";
			});
			$('#back').click(function(){
					parent.$('.hidebg').click();
				});

		});

    </script>
    <script>
    $(document).ready(function(){
    	//引用jquery-ui.js&jquery.tmpl.js实现拖动 
        $("#newSheet-drag").draggable();//为模态对话框添加拖拽
        $("#newSheet").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动
        //选择规则
        $("#mod-drag").draggable();//为模态对话框添加拖拽
        $("#mod").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动

    })
</script>
</body>
</html>
