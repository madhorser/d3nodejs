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
		
    <%
		String contextPath=request.getContextPath();
	%>
	<script>
		nui.context='<%=contextPath %>';
	</script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/version.css">
</head>

<body>
<div class="tophead">
 	<p><span id="backAppli" class="glyphicon glyphicon-circle-arrow-left" style="font-size: 17px;float: left;"></span> 综合应用 / 系统版本维护</p>
</div>
<div class="panel panel-default">
	<div class="panel-body">
	 	<p class="p-head"><span></span>查询设置</p>
		<div id="form1" >
			版本编号：
			<input class="nui-TextBox" id="verNameLike" name="verNameLike" placeholder="">
			定版时间(>=)：
		 	<input class="nui-datepicker" id="startDate" name="startDate"  placeholder="" timeFormat="">
		 	 定版时间(<=)：
		 	<input class="nui-datepicker" id="endDate" name="endDate"  placeholder="" timeFormat="">
			 定版人员：
			 <input class="nui-TextBox" id="userName" name="userName" placeholder="">
			 是否基线版本：
			 <input class="nui-combobox" id="verType" name="verType" allowInput="true" placeholder="">
			<br/><br/>
			<button id="searchBtn" class="btn btn-primary blue" onclick="searchVersion()">查询</button>
			<button id="clearBtn" class="btn btn-primary blue" onclick="reset()">重置</button>
		</div>
	</div> 
	
	        
	
</div>
<div class="panel panel-default">
	<div class="panel-body">
        <p class="p-head"><span></span>结果列表</p>

			
		<div id="p3" class="mini-panel" title="检核任务：" iconCls="icon-tip" style="float:left;width:28%;height:50%;" >
		
		<div id="datagrid2" class="nui-datagrid" style="width:100%;height:100%;" allowResize="false" onshowrowdetail="onShowRowDetail" autoHideRowDetail="false"
        url="<%=request.getContextPath()%>/task.do?invoke=searchTasks&noext=1&needjson=1"  idField="feedId" multiSelect="true" sortMode="client">
        <div property="columns"> 
                   
            <div field="taskName" width="" headerAlign="center" allowSort="true">任务名称</div>    
            <div field="checkSystem" width="" headerAlign="center" allowSort="true">系统</div>
        </div>
        </div>
		    
		</div>
		
		<div id="p4" class="mini-panel" title="重点监控：" iconCls="icon-tip" style="float:right;width:66%;height:50%;margin-right:55px;" >
		   
		<div id="datagrid3" class="nui-datagrid" style="width:100%;height:100%;" allowResize="false" onshowrowdetail="onShowRowDetail" autoHideRowDetail="false"
        url="<%=request.getContextPath()%>/ques.do?invoke=listQues&control=true&noext=1&needjson=1"  idField="feedId" multiSelect="true" sortMode="client">
        <div property="columns"> 
                    
            <div field="methodName" width="" headerAlign="center" allowSort="true">检核方法名称</div>    
            <div field="dataDate" width="" headerAlign="center" allowSort="true">数据日期</div>
            <div field="countNum" width="" headerAlign="center" allowSort="true">问题数</div>
        </div>
        </div>
		    
		</div>
			
		
	</div>
</div>
 <div class="hidebg"></div>
<div class="dRight">
        <div class="embed-responsive embed-responsive-16by9">
            <iframe class="embed-responsive-item" src=""></iframe>
        </div>
</div>

	
<script type="text/javascript">
    nui.parse();
    //为是否为基线版本的下拉框赋值
    var data = [{'id': '1', 'text': '是'}, {'id': '0', 'text': '否'}];
    var type = nui.get("verType");
    type.setData(data);
    //为结果列表赋值
    var grid1 = nui.get("datagrid1");
    var url1 = "<%=request.getContextPath()%>/version.do?invoke=newsearchVersion";
    grid1.setUrl(url1);
    grid1.load();
    grid1.hideColumn("ver_Id");//隐藏版本id列
    grid1.on("drawcell", function (e) {
        var record = e.record,
                column = e.column,
                field = e.field,
                value = e.value;

        //格式化日期
        if (field == "createTime") {
            value = new Date(value);
            if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");

        }

        //是否基线版本
        if (field == "verType") {
            if (value == 0) {
                e.cellHtml = "否";
            }
            else {
                e.cellHtml = "是";
            }
        }
        //操作列为超链接，包括概览和版本树
        if (column.name == "operate") {
            e.cellStyle = "text-align:center";
            //e.cellHtml = '<a href="javascript:versionBrowse(\'' + record.verId + '\',\'' + record.verName + '\')">概览</a>&nbsp; '
             //       + '<a href="javascript:versionTree(\'' + record.verId + '\')">版本树</a>'
            e.cellHtml = '<button class="btn btn-primary blue" onclick="versionBrowse(\'' + record.verId + '\',\'' + record.verName + '\')">概览</button>&nbsp;<button class="btn btn-primary blue" onclick="versionTree(\'' + record.verId + '\')">版本树</button>'
        }
    });
    //重新加载
    function refreshGrid(){
        grid1.load();
    }
    //查询
    function searchVersion() {
        var form = new nui.Form("#form1");
        var data = form.getData();
        var userName = data.userName;
        var verType = data.verType;
        var startDate = data.startDate;
        var endDate = data.endDate;
        var verNameLike = data.verNameLike;
        
      //客户端过滤
        grid1.filter(function (row) {

            var r1 = true;
            if (userName) {
                r1 = String(row.userId).toLowerCase().indexOf(userName.toLowerCase()) != -1;
            }

            //createTime
            var r2 = true;
            if (startDate) {
                r2 = false;
                var startTime = nui.parseDate(startDate).getTime();
                if (row.createTime >= startTime) r2 = true;
            }

            var r3 = true;
            if (verType) {
                r3 = String(row.verType).toLowerCase().indexOf(verType) != -1;
            }
            var r4 = true;
            if (verNameLike) {
                r4 = String(row.verName).toLowerCase().indexOf(verNameLike) != -1;
            }
            var r5 = true;
            if (endDate) {
                r5 = false;
                var endTime = nui.parseDate(endDate).getTime()+86400000;
                if (row.createTime <= endTime) r5 = true;
            }
            return r1 && r2 && r3 && r4 && r5;
        });
    }
    //重置
    function reset() {
        var form = new nui.Form("#form1");
        form.reset();
        grid1.load();

    }
    //概览
    function versionBrowse(verId, verName) {
        var url = "<%=request.getContextPath()%>/app/version/versionSummarize.jsp?verId=" + verId + "&verName=" + verName;
		showRight(url);
        
        /*var url = "<%=request.getContextPath()%>/app/version/versionSummarize.jsp?verId=" + verId + "&verName=" + verName;
        nui.open({
            url: url, width: 650, height: 430
        });*/
    }
    //版本树
    function versionTree(verId) {
        var url = "<%=request.getContextPath()%>/app/version/versionTree.jsp?verId=" + verId;
        /*  $('#versionTree iframe').attr('src',url);
        jQuery.noConflict();
        $('#versionTree').modal('show') */
        
        showRight(url);
        /*var url = "<%=request.getContextPath()%>/app/version/versionTree.jsp?verId=" + verId;
        nui.open({
            url: url, width: 850, height: 500
        });*/
    }
	function showRight(url){
		$('.dRight iframe').attr('src',url);
        $('.dRight').addClass('menu-right');
        var hideobj=document.getElementsByClassName("hidebg")[0];
        hideobj.style.display="block";
        hideobj.style.height=document.body.clientHeight+"px";
	}
</script>
<script>
    $('#newVersion').click(function(){
		$('.dRight iframe').attr('src','versionRelease.jsp');
        $('.dRight').addClass('menu-right');
        var hideobj=document.getElementsByClassName("hidebg")[0];
        hideobj.style.display="block";
        hideobj.style.height=document.body.clientHeight+"px";
    });
    
    $('.hidebg').click(function(){
        $('.dRight').removeClass('menu-right');
        document.getElementsByClassName("hidebg")[0].style.display="none";
        refreshGrid();
    });
    $('#backAppli').click(function(){
    	window.history.back();
	});   
</script>
</body>
</html>
