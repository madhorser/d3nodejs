<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<link rel="stylesheet" href="../base/css/bootstrap.min.css">
		<script src="../base/js/nui/nui.js" type="text/javascript"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/metadataDetail.css">

	</head>
	<body>


		<div class="left">
			<div class="panel-group" id="accordion" role="tablist"
				aria-multiselectable="true">
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingOne">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion"
								href="#collapseOne" aria-expanded="true"
								aria-controls="collapseOne"> 基本信息 </a>
						</h4>
					</div>
					<div id="collapseOne" class="panel-collapse collapse in"
						role="tabpanel" aria-labelledby="headingOne">
						<div class="panel-body">
							<div id="baseinfo" class="nui-datagrid" style="height: 175px;"
								idField="modeId" sizeList="[30,80,80]" showPageInfo="false"
								showPagerButtonIcon="false" allowAlternating="true" showPager="false"
								showColumns="true" showPageIndex="false" showPageSize="false"
								showReloadButton="false" sortMode="client">
								
								<div property="columns">
									<div type="indexcolumn"></div>
									<div name="info" field="info" align="left" width="100"
										allowSort="true">
										基本信息名称
									</div>
									<div name="value" field="value" align="left" width="100"
										allowSort="true">
										基本信息值
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingTwo">
						<h4 class="panel-title">
							<a class="collapsed" data-toggle="collapse"
								data-parent="#accordion" href="#collapseTwo"
								aria-expanded="false" aria-controls="collapseTwo"> 属性信息 </a>
						</h4>
					</div>
					<div id="collapseTwo" class="panel-collapse collapse"
						role="tabpanel" aria-labelledby="headingTwo">
						<div class="panel-body">
							<div id="datagrid" class="nui-datagrid" style="height: 200px;"
								idField="modeId" allowResize="false" sizeList="[30,80,80]"
								showPager="false" howReloadButton="false" sortMode="client">


								<div property="columns">
									<div type="indexcolumn"></div>
									<div name="featureName" field="featureName" align="left"
										 allowSort="true">
										属性名称
									</div>
									<div name="featureValue" field="featureValue" align="left"
										 allowSort="true">
										属性值
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="right">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						关联关系
					</h4>
				</div>
				<div class="panel-body">
						<div class="embed-responsive embed-responsive-16by9">
								<iframe class="embed-responsive-item"
									id="relation"></iframe>
							</div>
					</div>
					
				
			</div>
			
		</div>
		<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
		<script src="../base/js/jquery.min.js"></script>

		<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
		<script src="../base/js/bootstrap.min.js"></script>
		<script type="text/javascript">
    nui.parse(); 
    var grid1 = nui.get("baseinfo");
    var instanceId = <%=request.getParameter("id")%>;
    document.getElementById("relation").src = "relation.jsp?instanceId="+instanceId;
/*
    var uri = "<%=request.getContextPath()%>/metadataCmd.do?invoke=getParent&instanceId="+instanceId;   
    nui.ajax({
        url:  url= uri,
        type: 'POST',
        success: function (text) {
        	if(text=="Catalog"){
            	var w = '<div class="panel panel-default">'+
				'<div class="panel-heading" role="tab" id="headingThree">'+
				'<h4 class="panel-title">'+
					'<a class="collapsed" data-toggle="collapse"'+
						'data-parent="#accordion" href="#collapseThree"'+
						'aria-expanded="false" aria-controls="collapseThree"> 系统 </a>'+
				'</h4>'+
			'</div>'+
			'<div id="collapseThree" class="panel-collapse collapse"'+
				'role="tabpanel" aria-labelledby="headingThree">'+
				'<div class="panel-body">'+

				'</div>'+
			'</div>'+
		'</div>'+
		'<div class="panel panel-default">'+
			'<div class="panel-heading" role="tab" id="headingfour">'+
				'<h4 class="panel-title">'+
					'<a class="collapsed" data-toggle="collapse"'+
						'data-parent="#accordion" href="#collapsefour"'+
						'aria-expanded="false" aria-controls="collapseThree"> 系统层次 </a>'+
				'</h4>'+
			'</div>'+
			'<div id="collapsefour" class="panel-collapse collapse"'+
				'role="tabpanel" aria-labelledby="headingfour">'+
				'<div class="panel-body">'+

				'</div>'+
			'</div>'+
		'</div>';
			$('.left .panel-group').append(w);
        	}
        }
    });*/
	//基本信息赋值
    var url1 = "<%=request.getContextPath()%>/metadataCmd.do?invoke=queryBaseInfo&instanceId="+instanceId;
    grid1.setUrl(url1);
    //grid1.setData(data);
    grid1.load();
    	

    //属性信息赋值
	nui.parse();  
	var grid = nui.get("datagrid");
    var url = "<%=request.getContextPath()%>/metadataCmd.do?invoke=queryMetadataFeatures&instanceId="+instanceId;
    grid.setUrl(url);
    grid.load();

    //组合关系赋值
    
    var loadColumns;
    nui.ajax({
        url:  url= "<%=request.getContextPath()%>/bizmetadataCmd.do?invoke=showMetadata&instanceId=" + instanceId,
        type: 'POST',
        success: function (text) {
            var data = nui.decode(text);
            var compositions = nui.decode(data.metadataJson).compositions;
         
         for(var j = 0;j < compositions.length;j++){

             if(compositions[j].isEmpty==false){
                 var id = compositions[j].id;
            	 var w1='<div class="panel panel-default">'+
            	    '<div class="panel-heading" role="tab" id="head-'+id+'">'+
            	    '<h4 class="panel-title">'+
            	    '<a class="collapsed" data-toggle="collapse"'+
							'data-parent="#accordion" href="#coll-'+id+'"'+
							'aria-expanded="true" aria-controls="coll-'+id+'"> '+compositions[j].toClsName+ 
							'</a>'+
            	    
            	    '</h4>'+
            	    '</div>'+
            	    '<div id="coll-'+id+'" class="panel-collapse collapse in" role=tabpanel" aria-labelledby="head-'+id+'">'+
            	    '<div class="panel-body">'+
            	    '<div id="'+id+'" class="nui-datagrid" style="height: 200px;"'+
						'sizeList="[30,80,80]" pageSize="5">'+

						'<div property="columns">'+
						'</div>'+
					'</div>'+
            	    '</div>'+
            	    '</div>'+
            	    '</div>';

            	    $('.left .panel-group').append(w1);

         nui.parse();

			var compogrid = nui.get(id);
			var loadColumns = compositions[j].loadColumns;
			
				for (var i = 0; i < loadColumns.length; i++) {
					var c = loadColumns[i];
					c.field = c.name;
					// 设置居中
					
					//if(c.name == display[j]){
	            		if (c.name =='instanceCode'&& (typeof c.header =='undefined' || c.header =="null" || c.header ==null)){
	            			c.header = "元数据代码";
	            		}
	            		if(c.name =='instanceName'&& (typeof c.header =='undefined' || c.header =="null" || c.header ==null)){
	                		c.header = "元数据名称";
	            		}   
		        		// 未设置表头的列，默认不显示

		        		if(typeof c.header =='undefined' || c.header == ""){			        	
	            			c.visible = false;
	            		}
		        		c.headerAlign = "center";
						c.align = "center";
					}
					// 列的开头添加数字索引列
					loadColumns.unshift({
						type : "indexcolumn"
					});
				    compogrid.setColumns(loadColumns);
					compo = nui.decode(compositions[j]);
				    
				    comurl= "<%=request.getContextPath()%>/metadataCmd.do?invoke=queryComRelationList&fatherInstanceId="+instanceId+"&relationship="+compo.id;
		        	compogrid.setUrl(comurl);
		        	compogrid.load();
				}
				
			}

        }
    });
    
</script>
	</body>
</html>