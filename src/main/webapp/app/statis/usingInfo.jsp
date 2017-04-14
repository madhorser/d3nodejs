<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ECharts</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
</head>

<body>

	<div id="main" style="height:400px"></div>
	<script src="<%=request.getContextPath()%>/app/base/statis/echarts.js"></script>

	<script type="text/javascript">
	
	   $(document).ready(function(){
	   		//testcall();
	   		  startcall();                                              
	   });
	   result1=[];
	   result2=[];
	   function startcall(){
       var url = "<%=request.getContextPath()%>/statistics.do?invoke=usingInfo";
			var jsonObject = {
			
				};
			$.ajax({
				url : url,
				dataType : 'json',
				type : 'post',
				async : true,
				data : jsonObject,

				success : function(data) {
					var resultlist = data.data;
					$.each(resultlist, function(index, value) {
						var num = value.NUM;
						var name = value.INSTANCE_CODE;
						//alert(name);
						result2[index] = num;
						result1[index] = [ name ];
					});
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
				var worldMapContainer = document.getElementById('main');
				var resizeWorldMapContainer = function() {
					worldMapContainer.style.width = window.innerWidth 
							+ 'px';
					worldMapContainer.style.height = window.innerHeight 
							+ 'px';
				};
				resizeWorldMapContainer();
				var myChart = ec.init(document.getElementById('main'),
						'macarons');

				var option = {

					tooltip : {
						trigger : 'axis'
					},
                    grid:{
					x:45,
					y:20,
					x2:30,
					y2:30
					},
					calculable : true,
					xAxis : [ {
						type : 'category',
						data : result1,
					} ],
					yAxis : [ {
						type : 'value'
					} ],
					series : [ {
						name : '使用次数',
						type : 'bar',
						barCategoryGap : '70%',
						itemStyle : {
							normal : {
								color : '#6495ED'
							}
						},
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
						markLine : {
							data : [ {
								type : 'average',
								name : '平均值'
							} ]

						}
					},

					]
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
