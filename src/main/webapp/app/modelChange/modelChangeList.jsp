<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html>
<head>
    <title>模型变更管理</title>

	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery-ui.js"></script>
    <script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery.tmpl.js"></script>

    <%
		String contextPath=request.getContextPath();
    
	    String roleIds="";
	    if(request.getSession().getAttribute(UserProfile.KEY)==null){ //获取失败，session过期处理 
	         HttpServletResponse rep = (HttpServletResponse) response;
	    }else{
	 		UserProfile u = (UserProfile)request.getSession().getAttribute(UserProfile.KEY);
	    
	   		String[] roleStrArray = u.getRoleIds();
	    		StringBuilder roleStrTemp=new StringBuilder();
	   	 	for(int i = 0 ; i < roleStrArray.length ; i++)
	   		{
	      		roleStrTemp.append(roleStrArray[i]);
	      		roleStrTemp.append("&");
	    		}   		
	    		if(roleStrTemp.length()>0)
	      		roleIds = roleStrTemp.substring(0,roleStrTemp.length()-1);
	    }
	%>
	<script>
    $(document).ready(function(){
    	//引用jquery-ui.js&jquery.tmpl.js实现拖动 
        $("#addChange-drag").draggable();//为模态对话框添加拖拽
        $("#addChange").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动
    })
</script>
	<script>
		nui.context='<%=contextPath %>';
	</script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/modelChangeList.css">
</head>

<body>
<div class="tophead">
    <p><span id="backAppli" class="glyphicon glyphicon-circle-arrow-left" style="font-size: 17px;float: left;"></span>综合应用 / 模型变更管理</p>
</div>
<div class="main">
    <div class="panel panel-default">
        <div class="panel-body">
            <p class="p-head"><span></span>查询设置</p>
            <div id="form1">
                &nbsp;&nbsp;&nbsp;变更单编号：
                <input id="textbox-changeId" name="id" class="nui-textbox"/>
                &nbsp;&nbsp;&nbsp;提出日期：
                <input id="textbox-createTime" name="createTime" class="nui-datepicker"/>
                &nbsp;&nbsp;&nbsp;提出人：
                <input id="textbox-creator" name="userName" class="nui-textbox"/>
                &nbsp;&nbsp;&nbsp;状态：
                <input id="statusCombo" class="nui-combobox" style="width:150px;" textField="status" valueField="id" value="0" /> 
                <br/><br/>
                &nbsp;&nbsp;&nbsp;
                <button id="searchBtn" class="btn btn-primary blue" onclick="search()">查询</button>
                <button id="clearBtn" class="btn btn-primary blue" onclick="clearC()">重置</button>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-body">
            <p class="p-head"><span></span>结果列表
                <button id="exportTemplate" class="btn btn-primary blue" onclick="exportTemplate()">下载模板</button>
                <button id="deleteBtn" class="btn btn-primary blue" onclick="onDelete()">删除</button>
                <button id="submitBtn" class="btn btn-primary blue" onclick="onSubmitC()">提交</button>
                <button id="addBtn" class="btn btn-primary blue" onclick="add()" data-toggle="modal" data-target="#addChange">新增</button>
            </p>
            <div class="well">
                <div id="datagrid1" class="nui-datagrid" style="height:430px;"
                     dataField="data" idField="taskId" allowResize="false" sortMode="client">
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div field="id" width="80" headerAlign="center" align="center" allowSort="true">变更单编号</div>
                        <div field="createTime" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" allowSort="true">提出时间</div>
                        <div field="userName" width="80" headerAlign="center" align="center" allowSort="true">提出人</div>
                        <div field="status" width="80" headerAlign="center" align="center" allowSort="true">状态</div>
                        <div name="action" width="120" headerAlign="center" align="center"
                                 renderer="onActionRenderer" cellStyle="padding:0;">操作
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addChange" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="addChange-drag" role="document">
        <div class="modal-content"  style="height:300px;width:600px;top:90px;left:130px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">新增变更</h5>
            </div>
            <div class="modal-body" id="ifrbody" style="height:240px">
                <div class="embed-responsive embed-responsive-16by9" style="height:240px">
                    <iframe class="embed-responsive-item" src="" style="height:240px"></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="modal fade" id="changeAnalyse" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">变更分析</h5>
            </div>
            <div class="modal-body">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src=""></iframe>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="modal fade" id="changeDetails" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath() %>/app/base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">变更详情</h5>
            </div>
            <div class="modal-body" style="height:550px">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src=""></iframe>
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
	    		{id: "0", status: "请选择..."},
	            { id: "1", status: "未提交" },
	            { id: "2", status: "提交" },
	            { id: "3", status: "生效" }
		]; 
		var statusbox = nui.get("statusCombo");
		statusbox.setData(status2); 
		// 设置表格数据
        var grid = nui.get("datagrid1");
        grid.setUrl(nui.context + "/modelChange.do?invoke=searchModelChange");
        // 表格事件，格式化文本
        grid.on("drawcell", function (e) {
			var record = e.record;
			var column = e.column;
		    var field = e.field;
		    var value = e.value;
		    //格式化日期
		    if (field == "createTime") {
		    	value = new Date(value); 
		        if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
		    }
		    // 状态
		    if (field == "status"){
		    	switch(value){
		    	case "1":
		    		e.cellHtml = "未提交";
		    		break;
		    	case "2":
		    		e.cellHtml = "提交";
		    		break;
		    	case "3":
		    		e.cellHtml = "生效";
		    		break;
		    	}
		    }
		});
        
        var roleIds='<%=roleIds%>';
	    ssNull(roleIds);
        //grid.load();

        function ssNull(roleIds){
	    	if(roleIds==""){
	    		top.location.href = "../../login.do";//parent.location.href
	    		return;
    		}else {
    			grid.load();
    		}
	    }
        /**
		* 查询
		*/
        function search() { 	
	    	var form = new nui.Form("#form1");
	        var data = form.getData();
	        var combo = nui.get("statusCombo");
	    	var status = combo.getValue();	
	    	if(status == "0"){
	    		status = "";
	    	}
	        var id = data.id;
	        var time = data.createTime;
	        var userName = data.userName;
	        var createTime = "";
	        if (typeof(time) != "undefined" && time != "") {
	            createTime = nui.parseDate(time).getTime();
	        }
	        grid.load({
	            id: id,
	            createTime: createTime,
	            userName: userName,
	            status: status
	        });
	    }
        /**
		* 重置
		*/
	    function clearC() {
	        var form = new nui.Form("#form1");
	        form.reset();
	        grid.load();
	    }
        
		/**
		* 定义操作列
		*/	
 		function onActionRenderer(e) {
 	        var grid = e.sender;
 	        var record = e.record;
 	        var rowid = record._uid;
 	        var rowIndex = e.rowIndex;

 	        var s = '  <button class="btn btn-primary blue" onclick="analyse(\'' + rowid + '\')">变更分析</button>' +
 	                '  <button class="btn btn-primary blue" onclick="details(\'' + rowid + '\')">变更详情</button>' +
 	                '  <button class="btn btn-primary blue" onclick="change(\'' + rowid + '\')" >模型变更</button>' +      
 	                '  <button class="btn btn-primary blue" onclick="update(\'' + rowid + '\')" >模型修改</button>';	       

 	        return s;
 	    }
		
		/**
		* 新增变更单
		*/		
		function add(){
			var url = nui.context + "/forward.do?forward=/app/modelChange/addModelChangeList.jsp";
			var ifrbody = document.getElementById("ifrbody");
            $('#addChange iframe').attr('src',url);
	 	}
		
		/**
		*删除变更单
		*/
		function onDelete() {
	        var row = grid.getSelected();
	        if (typeof(row) == "undefined") {
	            nui.alert("请选择一条数据");
	            return;
	        } else {
	            if (row.status == "2" || row.status == "3") {
	                nui.alert("请选择【未提交】的记录进行删除");
	                return;
	            }
	            nui.confirm("确定删除记录？", "确定？",
                    function (action) {            
                        if (action == "ok") {
                        	var id = row.id;
            	            var url = "<%=request.getContextPath()%>/modelChange.do?invoke=deleteInfo&changeId=" + id;
            	            nui.ajax({
            	                url: url,
            	                data: {
            	                    id: id
            	                },
            	                success: function (text) {
            	                    var data = nui.decode(text);
            	                    nui.alert(data.status);
            	                    grid.load();
            	                }
            	            });
                        } else {
                            return;
                        }
                    }
                );
	        }
	    }
		/**
		*提交变更单
		*/
		function onSubmitC() {
	        var row = grid.getSelected();
	        if (typeof(row) == "undefined") {
	            nui.alert("请选择一条数据");
	            return;
	        } else {
	            if (row.status == "2" || row.status == "3") {
	                nui.alert("请选择【未提交】的记录进行提交");
	                return;
	            }
	            var id = row.id;
	            var url = "<%=request.getContextPath()%>/modelChange.do?invoke=submitChanges&changeId=" + id;
	            nui.ajax({
	                url: url,
	                data: {
	                    id: id
	                },
	                success: function (text) {
	                    var data = nui.decode(text);
	                    nui.alert(data.status);
	                    grid.load();
	                }
	            });
	        }
	    }
		/**
	     *下载模板
	     */
	    function exportTemplate() {
	        var url = "<%=request.getContextPath()%>/modelChange.do?invoke=exportTemplate";
	        window.open(url);
	    }
		/**
		*变更操作
		*/
	    function change(row_uid) {
	        var row = grid.getRowByUID(row_uid);
	        var id = row.id;
	        var status = row.status;
	        if (status == 1) {
	            nui.alert("模型变更为未提交状态，无法进行变更!");
	           closeModal();
	            return;
	        }
	        if (status == 3) {
	            nui.alert("变更已生效，无需进行再次操作!");
	            $('.modal').modal('hide');
	            return;
	        }
	        var url = "<%=request.getContextPath()%>/modelChange.do?invoke=changeModel&changeId=" + id;
   			nui.ajax({
	        	url: url,	         
	         	success: function (text) {
			         var data = nui.decode(text);
			         nui.alert(data.msg);
			         grid.load();
         		}
        	}); 
	    }
		
	    /**
		*变更修改
		*/
	    function update(rowid) {
			var row = grid.getRowByUID(rowid);
	        var id = row.id;
	        var status = row.status;
	        if (status != 1) {
	            nui.alert("只能修改未提交状态模型!");
	            return;
	        }
	    	var url = nui.context + "/forward.do?forward=/app/modelChange/modelChangeUpdate.jsp&changeId=" + id;
	    	showRight(url);
	    }
	    /**
		* 变更分析
		*/
	    function analyse(rowid) {	    	
	    	var row = grid.getRowByUID(rowid);
	        var id = row.id;
	        var status = row.status;
	        if (status == 1) {
	            nui.alert("模型变更为未提交状态，无法进行分析!");
	            return;
	        }
	        var url = nui.context + "/modelChange.do?invoke=openChangeAnalyse&changeId=" + id;
	        showRight(url);
	    }
       
		/**
		* 打开变更详情页面
		*/	
		function details(rowid){
			var row = grid.getRowByUID(rowid);
	        var id = row.id;
	    	var url = nui.context + "/forward.do?forward=/app/modelChange/modelChangeDetails.jsp&changeId=" + id;
	    	showRight(url);
		}
		
		function showRight(url){
			$('.dRight iframe').attr('src',url);
	        $('.dRight').addClass('menu-right');
	        var hideobj=document.getElementsByClassName("hidebg")[0];
	        hideobj.style.display="block";
	        hideobj.style.height=document.body.clientHeight+"px";
		}
        
        /**
		* 关闭模态框
		*/			
		function closeModal(){			
    		$('.modal').modal('hide');	    		
    		grid.load();
		}
		function refreshGrid(){
			grid.load();
		}
        jQuery(function () {
            $('#back').click(function(){
                $('.dRight').removeClass('menu-right');
                document.getElementsByClassName("hidebg")[0].style.display="none";
            });
            $('.hidebg').click(function(){
                $('.dRight').removeClass('menu-right');
                document.getElementsByClassName("hidebg")[0].style.display="none";
            });
            $('#backAppli').click(function(){
            	window.history.back();
			});            
        });
    </script>
</body>
</html>
