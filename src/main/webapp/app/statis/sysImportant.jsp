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


	<div id="main" style="width:600px;height:600px"></div>
	<script src="<%=request.getContextPath()%>/app/base/statis/echarts.js"></script>

	<script type="text/javascript">
	
	   $(document).ready(function(){
	   		//testcall();
	   	    startcall();                                              
	   });
	   result1=[];
	   result2=[];
	   result3=[];
	   function startcall(){
       var url = "<%=request.getContextPath()%>/statistics.do?invoke=sysImportant";
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
						var name = value.SYS_NAME;
						var num = value.NUM;
						//alert(name);
						result2[index] = [name,num];
						result1[index] = [ name ];
						result3[index]={"name":name,"value":num,"xAxis":name,"yAxis":num};
					});
					testcall.call(this, data);
				}

			});
	}

		function testcall() {
			require.config({
				paths : {
				echarts :'<%=request.getContextPath()%>/app/base/statis/echarts',
			    'echarts/chart/scatter': '<%=request.getContextPath()%>/app/base/statis/echarts/scatter',
						}
					});
			// 使用
			require([ 'echarts', 'echarts/chart/scatter', // 使用柱状图就加载bar模块，按需加载
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
						trigger : 'bxis',
						showDelay : 0,
						formatter : function(params) {
						},

					},
                    grid:{
					x:45,
					y:20,
					x2:30,
					y2:30
					},
					xAxis : [ {
						type : 'category',
						scale : true,
						data : result1,
					} ],
					yAxis : [ {
						type : 'value',
						scale : true,
						axisLabel : {
							formatter : '{value} '
						}
					} ],
					series : [ {

						type : 'scatter',
						data : result2,
						markPoint : {
							symbolSize : 15,
							data : result3,
						},

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
