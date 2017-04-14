<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ECharts</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
</head>

<body>
	<div class="head-input" style="margin-top: 5px;margin-left: 10px;">

	</div>
	<div id="changeHome" style="height:400px;width:400px"></div>
	<script src="<%=request.getContextPath()%>/app/base/statis/echarts.js"></script>

	<script type="text/javascript">
	    $(document).ready(function(){
	   
	   		//text(); 
	   		startcall();                                                   
	   });
	   
	function text(){
        var x = "center";
        var y = "center";
        var state = "success";
        nui.showTips({
            content: "<b>请选择模型、年份和变更类型</b>",
            state: state,
            x: x,
            y: y,
            timeout: 3000
        }); 
	}
	
	var result1=[];
    var result2=[];
    var result3=[];
    var result4=[];
	
           function startcall(){
        	 var url = "<%=request.getContextPath()%>/statistics.do?invoke=queryAlterationInfo";
			var jsonObject = {
				
				"typeId" : "Table",
				"yearId" : "year",
				
			};
			$.ajax({
				url : url,
				dataType : 'json',
				type : 'post',
				async : true,
				data : jsonObject,

				success : function(data) {
					var result = data.list;
					var index1 = 0;
					for ( var key in result) {
						result1[index1] = [ key ];
						var resultlist = result[key];
						$.each(resultlist, function(index, value) {
							
								result2[index1] = value.ADD_COUNT;
							    result3[index1] = value.DELETE_COUNT;
							    result4[index1] = value.UPDATE_COUNT;
						});
						index1++;
					}
					//alert(result2);
					testcall.call(this, data);
				}

			});
        }     
	
		function testcall() {
			require.config({
				paths : {
					echarts : '<%=request.getContextPath()%>/app/base/statis/echarts',
					'echarts/chart/line': '<%=request.getContextPath()%>/app/base/statis/echarts/line',
					'echarts/chart/bar': '<%=request.getContextPath()%>/app/base/statis/echarts/bar',
						}
					});
			// 使用
			require([ 'echarts', 'echarts/chart/line', 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
			], function(ec) {
				// 基于准备好的dom，初始化echarts图表
				var worldMapContainer = document.getElementById('changeHome');
				var resizeWorldMapContainer = function() {
					worldMapContainer.style.width = window.innerWidth + 'px';
					worldMapContainer.style.height = window.innerHeight * 0.95
							+ 'px';
				};
				resizeWorldMapContainer();
				var myChart = ec.init(document.getElementById('changeHome'),
						'macarons');

				var option = {

					/* title : {
						text : '元数据分布图——变更趋势',

					}, */
					tooltip : {
						trigger : 'axis'
					},
					legend:{
					    data:['新增','删除','修改']
					},
					
					calculable : true,
					grid : {
						x : 35,
						y : 10,
						x2 : 30,
						y2 : 25
					},
					xAxis : [ {
						type : 'category',
						boundaryGap : false,
						data : result1
					} ],
					yAxis : [ {
						type : 'value',
						axisLabel : {
							formatter : '{value} '
						}
					} ],
					series : [ {
						name : '新增',
						type : 'line',
						data : result2,
						markPoint : {
							data : [ {
								type : 'max',
								name : '最大值'
							}, {
								type : 'min',
								name : '最小值'
							} ]
						},

					}, {
						name : '删除',
						type : 'line',
						data : result3,
						markPoint : {
							data : [ {
								type : 'max',
								name : '最大值'
							}, {
								type : 'min',
								name : '最小值'
							} ]
						},

					}, {
						name : '修改',
						type : 'line',
						data : result4,
						markPoint : {
							data : [ {
								type : 'max',
								name : '最大值'
							}, {
								type : 'min',
								name : '最小值'
							} ]
						},

					} ]

				};

				myChart.setOption(option);

				//用于使chart自适应高度和宽度
				window.onresize = function() {
					//重置容器高宽
					resizeWorldMapContainer();
					myChart.resize();
				};
			});
		}
	</script>
</body>
</html>
