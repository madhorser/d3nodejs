<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <title>testEcharts.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <script src="../base/statis/echarts.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
	<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>

  </head>
  
  <body>
   <div id="main" style="height:100%;width:100%"></div>
	<script src="../base/statis/echarts.js"></script>

	<script type="text/javascript">
	var instanceId = '<%=request.getParameter("instanceId")%>';
	var data;
    nui.ajax({
        url:  url= "<%=request.getContextPath()%>/analyseCmd.do?invoke=getWholeChainRemote&displayType=1&instanceId=" + instanceId,
        type: 'POST',
        success: function (text) {
            data = nui.decode(text);
            //nui.alert(nui.encode(data));

        	
			require.config({
				paths : {
					echarts : '../base/statis/echarts',
					'echarts/chart/force': '../base/statis/echarts/force',
						}
					});
			require([ 'echarts', 'echarts/chart/force'
			], function(ec) {
				var myChart = ec.init(document.getElementById('main'));
				option = {
					    tooltip : {
					        trigger: 'item',
					        enterable: true,					        
					        formatter: function(nodes) {
			        			if(typeof(nodes.value2)=="undefined"){  
				               		var value = nodes.value;
				               		var res;
				               		res='名称 : '+value.label+'</br>';
				               		res+='代码 : '+value.instanceCode+'</br>';
				               		res+='元数据类型: '+value.classifier+'</br>';
				               		res+='路径 : /'+value.fullPath+'</br>';
				                	return res;
								}
			        			else{
			        				return "关联关系";
			        			}
							}
					    },
					    
					    series : [
					        {
					            type:'force',
					            name : "人物关系",
					            ribbonType: false,
					            categories : [
					                {
					                    name: '人物'
					                },
					                {
					                    name: '家人'
					                }
					            ],
					            itemStyle: {
					                normal: {
					                    label: {
					                        show: true,
					                        textStyle: {
					                            color: '#333'
					                        }
					                    },
					                    nodeStyle : {
					                        brushType : 'both',
					                        borderColor : 'rgba(255,215,0,0.4)',
					                        borderWidth : 1
					                    },
					                    linkStyle: {
					                        type: 'curve'
					                    }
					                },
					                emphasis: {
					                    label: {
					                        show: false
					                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
					                    },
					                    nodeStyle : {
					                        //r: 30
					                    },
					                    linkStyle : {}
					                }
					            },
					            useWorker: false,
					            minRadius : 15,
					            maxRadius : 25,
					            gravity: 1.1,
					            scaling: 1.1,
					            roam: 'move',
					            linkSymbol: 'arrow',
					            nodes:nui.decode(data.nodes),
					            links :nui.decode(data.links),
					        }
					    ]
					};
                myChart.setOption(option);
                var ecConfig = require('echarts/config');                
			});
            
        }
    });
			

	</script>
  </body>
</html>
