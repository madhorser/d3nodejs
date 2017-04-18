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
        <p class="p-head"><span></span>结果列表<button id="newVersion" class="btn btn-primary">版本发布</button></p>

		<div class="well">
<!-- 			<div id="datagrid1" class="nui-datagrid" style="height:500px;"
				 pageSize="2" dataField="data"idField="ruleId" allowResize="true" sortMode="client">
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
			</div> -->
			
<div id="datagrid1" class="nui-datagrid" style="height: 500px;"
                          allowResize="false" sortMode="client" dataField="data" idField="id">
                        <div property="columns">
                            <div type="indexcolumn"></div>
                            <div name="verName" field="verName" align="center" width="100" headerAlign="center"
                                 allowSort="true">
                                版本编号
                            </div>

                            <div field="createTime" width="100" headerAlign="center" align="center"
                                 allowSort="true">
                                定版时间
                            </div>
                            <div field="userId" width="120" headerAlign="center" align="center"
                                 allowSort="true">
                                定版人员
                            </div>
                            <div field="verDesc" width="120" headerAlign="center" align="center"
                                 allowSort="true">
                                版本描述
                            </div>
                            <div field="verType" width="100" align="center" align="center"
                                 headerAlign="center" allowSort="true">
                                是否基线版本
                            </div>
                            <div name="ver_Id" field="verId" width="100" align="center"
                                 headerAlign="center" hidden="true">
                                版本id
                            </div>
                            <div name="operate" field="operate" width="100" align="center"
                                 headerAlign="center">
                                操作
                            </div>
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
