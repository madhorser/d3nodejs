<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<!DOCTYPE html>

<html>
<head>
    <title>浏览模块部分页面</title>
    <!--NUI-->
    <script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
    <script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/browseHistory.css">

</head>

<body>
	<div class="panel panel-default">
	    <div class="panel-body">
	        <label for="date1$text">变更时间：</label>
	        <div id="form1">
	            <input id="date1" name="startVersionDay" class="nui-datepicker" required="true"/>&nbsp;--
	            <input id="date2" name="endVersionDay" class="nui-datepicker" required="true"/>
	        </div>
	        <button class="btn btn-primary blue" onclick="historySearch()">查询</button>
	        <button class="btn btn-primary blue" onclick="hsitoryReset()">重置</button>
	    </div>
	</div>

	<div class="panel panel-default">
	    <div class="panel-body">
	        <p class="p-head"><span></span>结果列表
	            <a class="nui-button" iconCls="icon-find" onclick="compareEdtMetadata()">与新版本比对</a>
	            <a class="nui-button" iconCls="icon-find" onclick="compareEdtMetadatas()">互相比对</a>
	        </p>
	        <div class="well">
	            <div id="checkHistoryTab" class="nui-datagrid" style="height:500px;" allowRowSelect="true" 
	            enableHotTrack="false" multiSelect="true" autoHideRowDetail="false" ondrawcell="onGridDraw" sortMode="client">
	                <div property="columns">
	                    <div type="checkcolumn"></div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<button id="open-modal" class="sr-only" data-toggle="modal" data-target="#share-modal"></button>
	<div class="modal fade" id="share-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal"><img src="<%=request.getContextPath()%>/app/base/images/icons/close.png"><span
	                        class="sr-only">Close</span></button>
	                <h5 class="modal-title"></h5>
	            </div>
	            <div class="modal-body">
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

	var instanceId = "<%=request.getParameter("id")%>";
	var classifierId = "Schema";
	
	nui.parse();
	var grid = nui.get("checkHistoryTab");
	// 存储搜索前grid的数据
	var gridData = [];
	// grid加载成功时触发
	grid.on("load",function(e){
		gridData = nui.clone(grid.getData());
	});
	
	nui.ajax({
		url: "<%=request.getContextPath()%>/mhistory.do?invoke=listEditionWin",
        type: "post",
        data:{
          	 instanceId : instanceId,
          	 classifierId : classifierId
        },
        success: function (text) {
        	// 生成表头
			var loadColumns = nui.decode(text).loadColumns;
			for (var i = 0; i < loadColumns.length; i++) {
				var c = loadColumns[i];
				c.field = c.name;
				// 设置居中
				c.headerAlign = "center";
				c.align = "center";
				c.allowSort = "true";
	            if (c.name =='instanceCode'&& (typeof c.header =='undefined' || c.header =="null" || c.header ==null)){
	            	c.header = "元数据代码";
	            }
	            if(c.name =='instanceName'&& (typeof c.header =='undefined' || c.header =="null" || c.header ==null)){
	                c.header = "元数据名称";
	            }
		        if (loadColumns[i].name == 'startTime') {
		        	loadColumns[i].header = '修改时间';
			        loadColumns[i].renderer = "onTimeRenderer";
		        }     
		        // 未设置表头的列，默认不显示
		        if(typeof c.header =='undefined' || c.header == ""){
	            	c.visible = false;
	            }
			}
			// 列的开头添加选择框列
			loadColumns.unshift({
				type : "checkcolumn"
			});
		    grid.setColumns(loadColumns);
			// 加载表格数据
 		    var url = "<%=request.getContextPath()%>/mhistory.do?invoke=listEdition&instanceId="
		    	+instanceId+ "&classifierId="+classifierId;
		    grid.setUrl(url);
		    grid.load();
		}
	});
	
    function compareEdtMetadata() {
        var rows = grid.getSelecteds();
        if(rows.length == 0 || rows.length >= 2){
        	nui.alert("请选择一条记录比对最新元数据！");
        	return false;
        }
		if(rows.length == 1 && (typeof(rows[0].endTime) == "undefined" || rows[0].endTime == "")){
			nui.alert("您选择的元数据为当前最新的元数据。");
        	return false;
		}
		var params = {
            instanceId : instanceId,
            oldStartTime: rows[0].startTime, 
            newStartTime: ""
        };
        var url = "<%=request.getContextPath()%>/forward.do?forward=/app/browse/historyContrast.jsp?params=" 
        	+ nui.encode(params) + "&instanceCode=" + rows[0].instanceCode;
        
        showRight(url);
        
//		$('#open-modal').click();          //打开模态框
//	    $('#share-modal h5').html('历史比对');   //给模态框标题
//	    $('#share-modal iframe').attr('src',url);      //给模态框路径
    }
    
    /**
     * 痕迹比对。两个修改痕迹的元数据间比较。
     */
    function compareEdtMetadatas() {
        var rows = grid.getSelecteds();
        if(rows.length != 2){
        	nui.alert("请选择两条记录互相比对！");
        	return false;
        }
		var r1 = rows[0], r2 = rows[1];
        if (r1.startTime > r2.startTime) {
            var x = r1;
            r1 = r2, r2 = x;
        }
		var params = {
            instanceId : instanceId,
            oldStartTime: r1.startTime, 
            newStartTime: r2.startTime
        };
        var url = "<%=request.getContextPath()%>/forward.do?forward=/app/browse/historyContrast.jsp?params=" 
        	+ nui.encode(params) + "&instanceCode=" + r1.instanceCode;
        
        showRight(url);

 //		$('#open-modal').click();          //打开模态框
//	    $('#share-modal h5').html('历史比对');   //给模态框标题
//	    $('#share-modal iframe').attr('src',url);      //给模态框路径
    }
    
    function onGridDraw (e) {
		var record = e.record;
	    var field = e.field;
	    var value = e.value; 
	    //格式化日期
	    if (field == "startTime") {
	    	value = new Date(value); 
	        if (nui.isDate(value)){
	            if(typeof(record.endTime) == "undefined" || record.endTime == ""){
	            	e.cellHtml = '<b>' + nui.formatDate(value, "yyyy-MM-dd HH:mm:ss") + '</b>';
	            }else{
	            	e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
	            }
	        }
		}
	}

	function historySearch(){
		var form = new nui.Form("#form1");
	    var data = form.getData();
		// 通过时间查询
	    var date1 = data.startVersionDay;
	    var date2 = data.endVersionDay;
	    var startTime1, startTime2;
		if(typeof(date1) != "undefined" && date1 != ""){
	      	startTime1 = nui.parseDate(date1).getTime();
	    }else{
	    	startTime1 = 0;
	    }
	    if(typeof(date2) != "undefined" && date2 != ""){
	    	startTime2 = nui.parseDate(date2).getTime()+86400000;
	    }else{
	    	startTime2 = new Date().getTime();
	    } 
	    // 先恢复数据再执行查询
	    grid.setData(nui.clone(gridData));	
		var rows = grid.getData();
		for(var i=0;i<rows.length;i++){
           	var row = rows[i];
           	if(row.startTime >= startTime1 && row.startTime <= startTime2);              	
			else{
				// 将不符合查询条件的数据从表中删除
				grid.removeRow(row,false);
			}
        }
	}
	
	function hsitoryReset(){
		var form = new nui.Form("#form1");
	    form.reset();
	    grid.setData(nui.clone(gridData));	
	}
	
	function showRight(url){
		$('.dRight iframe').attr('src',url);
        $('.dRight').addClass('menu-right');
        var hideobj=document.getElementsByClassName("hidebg")[0];
        hideobj.style.display="block";
        hideobj.style.height=document.body.clientHeight+"px";
	}
	
    $('.hidebg').click(function(){
        $('.dRight').removeClass('menu-right');
        document.getElementsByClassName("hidebg")[0].style.display="none";
        refreshGrid();
    });

</script>
</body>
</html>