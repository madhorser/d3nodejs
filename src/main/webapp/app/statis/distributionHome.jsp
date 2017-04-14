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
<div class="head-input" style="margin-top: 5px;margin-left: 10px;">

</div>
	

	<div id="disHome" style="height:400px;width:400px"></div>
	<script src="<%=request.getContextPath()%>/app/base/statis/echarts.js"></script>

	<script type="text/javascript">
	
	   $(document).ready(function(){
	   		
	   		//text();  
	   		startcall();                                                  
	   });
	   result1=[];
	   result2=[];
	function text(){
        var x = "center";
        var y = "center";
        var state = "success";
        nui.showTips({
            content: "<b>请选择模型和年份</b>",
            state: state,
            x: x,
            y: y,
            timeout: 3000
        }); 
	}
	
	
	var typeid;
	var typename;
	//近十年
	/* var date1=new Date;
	var crtyear=date1.getFullYear();
	var years=[];
	for(var i=0;i<10;i++){
	y=crtyear-i;
	years[i]={"id":y,"text":y};
	}
	console.log(years); */
	  nui.parse();
		/* var models = [
	    { "id": "Schema", "text": "库" },
	    { "id": "Table", "text": "表" },
	    {"id": "Column", "text": "字段" }, 
	    {"id": "Procedure", "text": "存储过程" },
	    {"id": "View", "text": "视图" },
	]; */
	/* var model = nui.get("model");
	model.setData(models);
	 */
	/* var year= nui.get("year");
	year.setData(years); */
	function startcall(){
	 var url = "<%=request.getContextPath()%>/statistics.do?invoke=queryDistributionInfo";
			var jsonObject = {
				"typeId" : "Table"				};
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
						var name = value.SYSNAME;
						result2[index] = num;
						result1[index] = [ name ];
					});
					testcall.call(this, data);
				}

			});
			}
	function query(){
	 var obj = nui.get("model");
	 typeid=obj.getValue();
	  typename=obj.getText();
	/*  var obj1 = nui.get("year");
	 yearid=obj1.getValue(); */

	 //alert(typeid);
	 //alert(yearid);
	 var url = "<%=request.getContextPath()%>/statistics.do?invoke=queryDistributionInfo";
			var jsonObject = {
				"typeId" : typeid,
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
						var name = value.SYSNAME;
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
					echarts :'<%=request.getContextPath()%>/app/base/statis/echarts',
					'echarts/chart/line': '<%=request.getContextPath()%>/app/base/statis/echarts/line',
					'echarts/chart/bar': '<%=request.getContextPath()%>/app/base/statis/echarts/bar',
						}
					});
			// 使用
			require([ 'echarts', 'echarts/chart/line', 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
			], function(ec) {
				// 基于准备好的dom，初始化echarts图表
				var worldMapContainer = document.getElementById('disHome');
				var resizeWorldMapContainer = function() {
					worldMapContainer.style.width = window.innerWidth
							+ 'px';
					worldMapContainer.style.height = window.innerHeight*0.95
							+ 'px';
				};
				resizeWorldMapContainer();
				var myChart = ec.init(document.getElementById('disHome'),
						'macarons');

				var option = {

					tooltip : {
						trigger : 'axis'
					},

					calculable : true,
					grid:{
					x:35,
					y:10,
					x2:30,
					y2:25
					},
					xAxis : [ {
						type : 'category',
						data : result1,
					} ],
					yAxis : [ {
						type : 'value'
					} ],
					series : [ {
						name : typename,
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
