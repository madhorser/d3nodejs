<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<!DOCTYPE html>

<html>
<head>
    <title>历史比对结果页面</title>
    <!--NUI-->
    <script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
    <script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>

    <!-- datagrid 中标记行时需要的样式 -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/noneScroll.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/historyContrast.css">

</head>

<body>

	<div class="tophead">
	 	<p><span id="backAppli" class="glyphicon glyphicon-circle-arrow-left" style="font-size: 17px;float: left;"></span>历史比对</p>
	</div>
    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingOne">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        基本信息
                    </a>
                </h4>
            </div>
            <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                <div class="panel-body">
                    <!-- 基本信息表 -->
                    <div id="baseGrid" class="nui-datagrid" showFooter="false" style="height: 220px;" showColumns="false" 
                     showReloadButton="false" showPageInfo="false" showPageSize="false" showPageIndex="false" showPager="false" ondrawcell="onDrawcell">
                        <div property="columns">
                            <div field="info" width="100"></div>
                            <div field="oldValue" width="100"></div>
                            <div field="newValue" width="100"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingTwo">
                <h4 class="panel-title">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" 
                    href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">属性信息
                    </a>
                </h4>
            </div>
            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                <div class="panel-body">
                    <!-- 属性信息表 -->
                    <div id="featureGrid" class="nui-datagrid" showFooter="false" style="height: 250px;"
                         ondrawcell="onDrawcell" emptyText="没有相关的属性信息" sortMode="client">
                        <div property="columns">
                            <div field="featureName" headerAlign="center" align="center" allowSort="true">属性名称
                            </div>
                            <div field="featureValue" headerAlign="center" align="center" allowSort="true">历史值
                            </div>
                            <div field="compareValue" headerAlign="center" align="center" allowSort="true"> 对比值
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<%
  	String params = request.getParameter("params");
	String text = request.getParameter("instanceCode");
%>
<script type="text/javascript">
 	var paramsStr = '<%=params %>';
	var text = '<%=text %>';
	var params = nui.decode(paramsStr);
	
	singleCompareEditionMetadatas(params, text);
	
	// 比对历史元数据
	function singleCompareEditionMetadatas(params, text) {
	    nui.ajax({
			url: "<%=request.getContextPath()%>/mhistory.do?invoke=compareEditionMetadatas",
	        type: "post",
	        data: params,
	        success: function (text) { 
	        	var data = nui.decode(text);
	        	//alert(data.metadata);
	        	//alert(data.fullPath);
	        	//alert(data.attributes);
	        	//alert(data.compositions);
	        	// 设置属性表格数据
	        	var grid2 = nui.get("featureGrid");
	        	grid2.setData(nui.decode(data.attributes));
	        	// 生成基本信息表格行数据，并设置行
	        	var grid1 = nui.get("baseGrid");
	        	var metadata = nui.decode(data.metadata);
	        	var fullPath = nui.decode(data.fullPath);
	        	var row0 = {
	        		info : "元数据代码", oldValue : metadata.instanceCode.oldValue,
					newValue : metadata.instanceCode.newValue,
					different : metadata.instanceCode.different
	        	}
	        	var row1 = {
	        		info : "元数据名称", oldValue : metadata.instanceName.oldValue,
					newValue : metadata.instanceName.newValue,
					different : metadata.instanceName.different
	        	}
	        	var row2 = {
	        		info : "生效时间", oldValue : metadata.startTime.oldValue,
					newValue : metadata.startTime.newValue,
					different : metadata.startTime.different
	        	}
	        	var row3 = {
	        		info : "失效时间", oldValue : metadata.endTime.oldValue,
					newValue : metadata.endTime.newValue,
					different : metadata.endTime.different
	        	}
	        	var row4 = {
	        		info : "元数据类型", oldValue : metadata.classifierName,
					newValue : metadata.classifierName
	        	}
 	        	var row5 = {
	        		info : "上下文路径", oldValue : fullPath.oldValue,
					newValue : fullPath.newValue
	        	} 
	        	grid1.addRow(row0, 0);
	        	grid1.addRow(row1, 1);
	        	grid1.addRow(row2, 2);
	        	grid1.addRow(row3, 3);
	        	grid1.addRow(row4, 4);
	        	grid1.addRow(row5, 5);
	        }
	    });	
    }

    function onDrawcell (e) {
		var record = e.record;
	    var field = e.field;
	    var value = e.value; 
 		    if(record.different == true){
	    	e.rowCls = "myrow";
	    }
	    //格式化日期
		if((record.info == "生效时间" || record.info == "失效时间") && field != "info"){
	    	value = new Date(value); 
	        if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");
	    } 
	    
	    if(record.info == "上下文路径" && field != "info"){
	    	if(value == "")e.cellHtml = '/';
	    }
	}
         
    $('#backAppli').click(function(){
        parent.$('.hidebg').click();
	});   
    
</script>
</body>
</html>