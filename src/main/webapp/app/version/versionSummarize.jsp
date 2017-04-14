<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html>
	<head>

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/noneScroll.css">
		<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
		<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
		<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/versionSummarize.css">
		
	</head>

	<body>
	    
		<div class="tophead">
			<p><span id="back" class="glyphicon glyphicon-circle-arrow-right" style="font-size: 17px;float: left;margin-top: 3px;"></span>版本概要</p>
		</div>
	    
		<div id="datagrid" class="nui-datagrid" style="height: 92%;width : 95%;"
					idField="modeId" allowResize="false" 
					pageSize="10" sortMode="client">


					<div property="columns">
						<div type="indexcolumn" ></div>

						<div name="classifierName" field="classifierName" align="left" width="80"
							allowSort="true">
							元数据类型
						</div>

						<div field="count" width="60" headerAlign="center"
							allowSort="true">
							数量(点击查看)
						</div>
						
						<div width="100">
						</div>
		</div>
		</div>
		
<div class="hidebg2"></div>
<div class="dRight2">
	<div class="embed-responsive embed-responsive-16by9" style="height: 100%;">
		<iframe class="embed-responsive-item" src=""></iframe>
	</div>
</div>
		
		<div class="modal fade" id="summary" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	        <div class="modal-dialog modal-lg">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
	                    <h5 class="modal-title">版本概要详情</h5>
	                </div>
	                <div class="modal-body">
	                    <div class="embed-responsive embed-responsive-16by9">
	                        <iframe class="embed-responsive-item" src=""></iframe>
	                    </div>
	                </div>
	            </div>
	            <!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
			<script type="text/javascript">
	nui.parse();   		
	var grid = nui.get("datagrid");
	var url1 = "<%=request.getContextPath()%>/version.do?invoke=newsummarizeVersion&verId=<%=request.getParameter("verId")%>";
	grid.setUrl(url1);
	grid.load();
	grid.hideColumn("classifierId");
	grid.on("drawcell", function (e) {
        var record = e.record,
    column = e.column,
    field = e.field,
    value = e.value;
	var classifierId;
      //count列，超连接操作按钮
        if (field == "count") {
            e.cellStyle = "text-align:center";
            e.cellHtml = '<a href="javascript:show()">'+value+'</a>&nbsp; '
        }

	});


    function show() {
    	nui.parse();
		var row = grid.getSelected();
        var url = "<%=request.getContextPath()%>/app/version/versionSummarizeMetaData.jsp?classifierId="+row.classifierId+"&verId=<%=request.getParameter("verId")%>&verName=<%=request.getParameter("verName")%>";
/*         $('#summary iframe').attr('src',url);
        jQuery.noConflict();
        $('#summary').modal('show')
		var url = nui.context + "/forward.do?forward=/app/contrast/contrastRuleGroup.jsp";
 */
			$('.dRight2 iframe').attr('src',url);
		
        
			$('.dRight2').addClass('menu-right');
			var hideobj=document.getElementsByClassName("hidebg2")[0];
			hideobj.style.display="block";
			hideobj.style.height=document.body.clientHeight+"px";
			
    }
    
	jQuery(function () {
	
		$('.hidebg2').click(function(){
			$('.dRight2').removeClass('menu-right');
			document.getElementsByClassName("hidebg2")[0].style.display="none";
		});

		$('#back').click(function(){
			parent.$('.hidebg').click();
		});

	});
    


	</script>
	</body>
</html>
