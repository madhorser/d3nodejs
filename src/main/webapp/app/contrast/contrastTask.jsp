<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html>
<head>
    <title>任务管理</title>

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
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/contrastTask.css">
</head>

<body>
<div class="tophead">
    <p><span id="backAppli" class="glyphicon glyphicon-circle-arrow-left" style="font-size: 17px;float: left;"></span>综合应用 / 环境一致性巡检</p>
</div>
<div class="main">
    <div class="panel panel-default">
        <div class="panel-body">
            <p class="p-head"><span></span>查询设置</p>
            <div id="form1" >
                                                 任务名称：
                <input id="textbox-name" name="taskName" class="nui-textbox"/>
                                                 源库：
                <input id="textbox-source" name="sourcePath" class="nui-textbox"/>
                                                 目标库：
                <input id="textbox-dest" name="targetPath" class="nui-textbox"/>
               	 开始时间：
                <input id="textbox-startTime" name="startTime" class="nui-datepicker"/>
               	 结束时间：
                <input id="textbox-endTime" name="endTime" class="nui-datepicker"/>
				 任务状态：
				<input id="status-box" name="taskStatus" class="nui-combobox" 
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
                <button class="btn btn-primary" id="ruleBtn" onclick="openRule()"><img src="<%=request.getContextPath() %>/app/base/images/icons/add.png">&nbsp规则管理</button>
                <button class="btn btn-primary" id="addBtn" onclick="add()" data-toggle="modal" data-target="#compare"><img src="<%=request.getContextPath() %>/app/base/images/icons/add.png">&nbsp新增任务</button>
            </p>
            <div class="well">
                <div id="datagrid1" class="nui-datagrid" style="height:430px;"
                     dataField="data" idField="taskId" allowResize="false" sortMode="client">
                    <div property="columns">
                        <div type="indexcolumn" width="20px"></div>
                        <div field="taskName"   width="90px" headerAlign="center" allowSort="true">任务名称</div>
                        <div field="startTime" headerAlign="center" align="center" allowSort="true">开始时间</div>
                        <div field="endTime" headerAlign="center" align="center" allowSort="true">结束时间</div>
                        <div field="createTime"  headerAlign="center" align="center" allowSort="true">创建时间</div>
                        <div field="sourcePath"  width="80px" headerAlign="center" allowSort="true">源端元数据路径</div>
                        <div field="targetPath"  width="80px" headerAlign="center" allowSort="true">目标端元数据路径</div>
                        <div field="taskStatus"  headerAlign="center" align="center" allowSort="true">任务状态</div>
						<!-- 修改action宽度过小导致伸缩浏览器时看不到后面的按钮 -->
                        <div name="action" width="190px" headerAlign="center" align="center"
                             renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="compare" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="compare-drag" role="document">
        <div class="modal-content"  style="height:690px;width:700px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">新增任务</h5>
            </div>
            <div class="modal-body" id="ifrbody" >
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src=""></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="modal fade" id="ruleManage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">规则管理</h5>
            </div>
            <div class="modal-body">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src=""></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="modal fade" id="selectRuleMod" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="selectRuleMod-drag" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">选择规则</h5>
            </div>
            <div class="modal-body" style="height:600px">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src="" style="height:560px"></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="hidebg"></div>
<div class="dRight">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe class="embed-responsive-item" src=""></iframe>
    </div>
</div>

	<script type="text/javascript">
        nui.parse();
		// 设置状态类型下拉框文本
  		var status2 = [
	    { "id": "0", "text": "未执行" },
	    { "id": "2", "text": "已完成" }
		]; 
		var statusbox = nui.get("status-box");
		statusbox.setData(status2); 
		// 设置表格数据
        var grid = nui.get("datagrid1");
        grid.setUrl(nui.context + "/contrastTaskCmd.do?invoke=listContrastTask");
        grid.load();
        // 表格事件，格式化文本
        grid.on("drawcell", function (e) {
			var record = e.record;
		    var field = e.field;
		    var value = e.value;
		    //格式化日期
		    if (field == "createTime") {
		    	value = new Date(value); 
		        if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
		    }
		    if (field == "startTime" && value != null) { 			    	
		   		value = new Date(value); 
		        if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
		    }
		    if (field == "endTime" && value != null) {
		    	value = new Date(value); 
		        if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
		    }
		    // 状态
		    if (field == "taskStatus"){
		    	switch(value){
		    	case "0":
		    		e.cellHtml = "未执行";
		    		break;
		    	case "1":
		    		e.cellHtml = "执行中";
		    		break;
		    	case "2":
		    		e.cellHtml = "已完成";
		    		break;
		    	}
		    }
		});
		/**
		* 定义操作列
		*/
 		function onActionRenderer(e) {
		    var grid = e.sender;
		    var record = e.record;
		    var uid = record._uid;
		    var rowIndex = e.rowIndex;
		    // 设置操作列
		    var s = '  <button class="btn btn-primary blue" data-toggle="modal" data-target="#selectRuleMod" onclick="selectRule(\'' + uid + '\')">选择规则</button>' +
		    		'  <button class="btn btn-primary blue" onclick="execute(\'' + uid + '\')">执行</button>' +
 		    		'  <button class="btn btn-primary blue" onclick="download(\'' + uid + '\')">下载结果</button>' + 
		    		'  <button class="btn btn-primary blue" onclick="onDelete(\'' + uid + '\')">删除</button>' ;
		    return s;
    	}
		/**
		* 新增任务
		*/		
		function add(){
			var url = nui.context + "/forward.do?forward=/app/contrast/addContrastTask.jsp";
			var ifrbody = document.getElementById("ifrbody");
			//ifrbody.style.width="600px";
			ifrbody.style.height="660px";//设置最适宜
            $('#compare iframe').attr('src',url);
	 	}
		/**
		* 下载任务执行结果
		*/	
 		function lookResult(row_uid){
		    var row = grid.getRowByUID(row_uid);
		    var taskStatus = row.taskStatus;
		    if(taskStatus != "2"){
		    	nui.alert("请选择已完成的任务");
		    	return false;
		    }    
		    var taskId = row.taskId;
	 		var url = nui.context + "/contrastTaskCmd.do?invoke=downloadResult&taskId=" + taskId;
			window.open(url);
	 	}
		/**
		* 查询
		*/	 	
	 	function search() {
            var form = new nui.Form("#form1");
	        var data = form.getData();
	 		var taskName = data.taskName;
			var sourcePath = data.sourcePath;
	      	var targetPath = data.targetPath;
			var taskStatus = data.taskStatus;
			// 通过时间查询时，用前后两个时间点为条件查询数据
	      	var date1 = data.startTime;
	      	var startTime = "";
	      	var date2 = data.endTime;
	      	var endTime = "";
	      	if(typeof(date1) != "undefined" && date1 != ""){
	      		startTime = nui.parseDate(date1).getTime();
	      	}     	
	      	if(typeof(date2) != "undefined" && date2 != ""){
	      		endTime = nui.parseDate(date2).getTime() + 86400000;
	      	}
            grid.load({
            	taskName : taskName,
	            sourcePath : sourcePath,
	            targetPath : targetPath,
	            taskStatus : taskStatus,
	            startTime : startTime,
	            endTime : endTime,
            });
        }	
	 	/**
		* 重置查询条件
		*/	 
	 	function resetForm(){
        	var form = new nui.Form("#form1");
	    	form.reset();
            grid.load();
        }
        /**
		* 删除任务
		*/	  		
 		function onDelete(row_uid){
 			var row = grid.getRowByUID(row_uid);
	 		if(row){
	 			if(row.taskStatus != "0"){
	        	nui.alert("该任务已执行，不允许删除");
		        }else{
		        	nui.alert("确定删除该任务？", "确定？",
		                    function (action) {
		                        if (action == "ok") {
		        	var taskId = row.taskId;
		        	var url = nui.context + "/contrastTaskCmd.do?invoke=deleteContrastTask";
					nui.ajax({
					    url: url,
					    data: {
					   		taskId : taskId
						},
						success: function (text) {
				            var data = nui.decode(text);
				            if(data.status == "0"){
				            	grid.reload(); 
				            	nui.alert("删除成功");
				            }else if(data.status == "-1"){
				            	grid.reload(); 
				            	nui.alert("该任务已选择了关联的规则，不允许删除");
				            } 
				        }
					}); 
		        }
		        	});
		        }	
	 		} 
	 	}
        /**
		* 执行任务
		*/			
		function execute(row_uid){
			var row = grid.getRowByUID(row_uid);
		    var taskId = row.taskId;
	 		var url = nui.context + "/contrastTaskCmd.do?invoke=executeTask";
	 		var messageId;
	 		nui.ajax({
			    url: url,
			    data: {
			   		taskId : taskId
				},
				beforeSend: function(){
					messageId = nui.loading("任务执行中","加载提示框");
				},
				success: function (text) {
		            nui.hideMessageBox(messageId);            
			        grid.reload(); 
		        }
			}); 
	 	}
        /**
		* 下载任务执行结果
		*/	
 		function download(row_uid){
		    var row = grid.getRowByUID(row_uid);
		    var taskStatus = row.taskStatus;
		    if(taskStatus != "2"){
		    	nui.alert("请选择已完成的任务");
		    	return false;
		    }    
		    var taskId = row.taskId;
	 		var url = nui.context + "/contrastTaskCmd.do?invoke=downloadResult&taskId=" + taskId;
			/*
			// 此方式调用了后台方法，但未出现下载弹窗
  			nui.ajax({
				url:url
			});  */
			window.open(url);
	 	}
        /**
		* 给任务分配规则
		*/			
	 	function selectRule(row_uid){
	 		var row = grid.getRowByUID(row_uid);
		    var taskId = row.taskId;
		    var url = nui.context + "/app/contrast/taskRuleConfig.jsp?taskId=" + taskId;
		    $('#selectRuleMod iframe').attr('src',url);
	 	}
        /**
		* 打开规则管理页
		*/	
		function openRule(){
			var url = nui.context + "/forward.do?forward=/app/contrast/contrastRule.jsp";
            $('.dRight iframe').attr('src',url);
		}
        /**
		* 关闭模态框
		*/			
		function closeModal(){
			
    		$('.modal').modal('hide');	    		
    		//refreshGrid();
    		grid.load();
		}
		function refreshGrid(){
			debugger;
			grid.load();
		}
        jQuery(function () {
            $('#ruleBtn').click(function(){
                $('.dRight').addClass('menu-right');
                var hideobj=document.getElementsByClassName("hidebg")[0];
                hideobj.style.display="block";
                hideobj.style.height=document.body.clientHeight+"px";

            });
            $('#back').click(function(){
                $('.dRight').removeClass('menu-right');
                document.getElementsByClassName("hidebg")[0].style.display="none";
            });
            $('.hidebg').click(function(){
                $('.dRight').removeClass('menu-right');
                document.getElementsByClassName("hidebg")[0].style.display="none";
            })
            $('#ruleGroup').click(function(){
                $('.dRight2').addClass('menu-right');
                var hideobj=document.getElementsByClassName("hidebg2")[0];
                hideobj.style.display="block";
                hideobj.style.height=document.body.clientHeight+"px";

            });
            $('#backAppli').click(function(){
            	window.history.back();
			});            
            $('.hidebg2').click(function(){
                $('.dRight2').removeClass('menu-right');
                document.getElementsByClassName("hidebg2")[0].style.display="none";
            })
        });
    </script>
    <script>
    $(document).ready(function(){
    	//引用jquery-ui.js&jquery.tmpl.js实现拖动 
        $("#compare-drag").draggable();//为模态对话框添加拖拽
        $("#compare").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动
        //选择规则
        $("#selectRuleMod-drag").draggable();//为模态对话框添加拖拽
        $("#selectRuleMod").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动

    })
</script>
</body>
</html>
