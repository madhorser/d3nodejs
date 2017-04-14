var Chart={
	init:function(){
		require.config({
				paths:{
					echarts:"js/echarts/echarts",
					'echarts/chart/bar' : 'js/echarts/echarts',
					'echarts/chart/line': 'js/echarts/echarts'
				}
			});
	},
	OptionTemplates:{
		initBar:function(xArray,series){
			var legendData=[];
			for(var i=0;i<series.length;i++){
				legendData.push(series[i].name);
			}
			var option={
				tooltip : {
					trigger: 'axis'
				},
				legend: {
					data:legendData
				},
				dataZoom : { 
					show : true, 
					reltime: false, 
					start: 0, 
					end: 100
				}, 
				toolbox: {
					show : true,
					feature : {
						restore : {show: true}
					}
				},
				calculable : true,
				xAxis : [
					{
						type : 'category',
						data : xArray,
						axisLabel:{
							rotate:0
						}
					}
				],
				yAxis : [
					{
						type : 'value',
						splitArea : {show : true}
					}
				],
				series :series 
			};
			return option;
		}
	},
	render:function(container,option){
		require([
				"echarts",
				'echarts/chart/bar',
				'echarts/chart/line'
			],
			function(ec){
				var myChart=ec.init(container);	
				myChart.setOption(option);
			});
	}
}