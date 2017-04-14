<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ECharts</title>
<!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/app/base/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
</head>

<body>
	<div class="head-input" style="margin-top: 5px;margin-left: 10px;">
		<input id="type" class="nui-buttonedit" onbuttonclick="onButtonEdit"
			emptyText="表" /> <input id="year" name="ruleType"
			class="nui-combobox" style="width:150px;" textField="text"
			valueField="id" emptyText="近一周" allowInput="false" /> <input
			id="change" name="ruleType" class="nui-combobox" style="width:150px;"
			textField="text" valueField="id" emptyText="新增" allowInput="false" />

		<button type="button" class="btn btn-primary btn-sm" onclick="query()">搜索</button>
	</div>
	<div id="main" style="width:600px;height:600px"></div>
	<script src="<%=request.getContextPath()%>/app/base/statis/echarts.js"></script>

	<script type="text/javascript">
	    $(document).ready(function(){
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
	var typeid="Table";
	var yearid="week";
	var typename="新增";
	var changeid="0";
	nui.parse();

	var years=[
	    {"id": "day", "text": "近一天"},
	    {"id": "week", "text": "近一周"},
	    {"id": "month", "text": "近一月"}, 
	    {"id": "year", "text": "近一年"}, 
	   
	];
	var year= nui.get("year");
	year.setData(years);
	
	var changes = [
	    { "id": "0", "text": "新增" },
	    { "id": "1", "text": "删除" },
	    {"id": "2", "text": "修改" }, 
	   
	];
	var change= nui.get("change");
	change.setData(changes);
	result1=[];
	result2=[];

        function onButtonEdit(e) {
            var btnEdit = this;
            nui.open({
                url:"<%=request.getContextPath()%>/app/search/selectType.jsp",
                showMaxButton: false,
                title: "选择模型",
                width: 350,
                height: 350,
                ondestroy: function (action) {                    
                    if (action == "ok") {
                        var iframe = this.getIFrameEl();
                        var data = iframe.contentWindow.GetData();
                        data = nui.clone(data);
                        if (data) {
                            btnEdit.setValue(data.id);
                            btnEdit.setText(data.text);
                             typeid=btnEdit.value;
                             typename=data.text;
                        }
                    }
                }
            });            
             
        }     
        function startcall(){
        	 var url = "<%=request.getContextPath()%>/statistics.do?invoke=queryAlterationInfo";
			var jsonObject = {
				/* "start" : 0,
				"limit" : 10, */
				"typeId" : "Table",
				"yearId" : "week",
				"alterationType" : "0"
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
							
						});
						index1++;
					}
					
					testcall.call(this, data);
				}

			});
        }
	function query(){
	result1=[];
	result2=[];

	
	 var obj1 = nui.get("year");
	 yearid=obj1.getValue();
	  var obj2 = nui.get("change");
	 changeid=obj2.getValue();

	 var url = "<%=request.getContextPath()%>/statistics.do?invoke=queryAlterationInfo";
			var jsonObject = {
				
				"typeId" : typeid,
				"yearId" : yearid,
				"alterationType" : changeid
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
							if (changeid == "0") {
								result2[index1] = value.ADD_COUNT;
							} else {
								if (changeid == "1") {
									result2[index1] = value.DELETE_COUNT;
								} else {
									if (changeid == "2") {
										result2[index1] = value.UPDATE_COUNT;
									}
								}
							}
						});
						index1++;
					}
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
					worldMapContainer.style.width = window.innerWidth + 'px';
					worldMapContainer.style.height = window.innerHeight * 0.8
							+ 'px';
				};
				resizeWorldMapContainer();
				var myChart = ec.init(document.getElementById('main'),
						'macarons');

				var option = {

					tooltip : {
						trigger : 'axis'
					},
					grid : {
						x : 35,
						y : 10,
						x2 : 30,
						y2 : 25
					},

					calculable : true,
					xAxis : [ {
						type : 'category',
						boundaryGap : false,
						data : result1,
					} ],
					yAxis : [ {
						type : 'value',
						axisLabel : {
							formatter : '{value} '
						}
					} ],
					series : [ {
						name : typename,
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

					}]

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
