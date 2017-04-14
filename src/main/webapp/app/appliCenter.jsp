<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Bootstrap Template</title>
    <link rel="stylesheet" href="base/css/bootstrap.min.css">
    <style>

        html, body {
            height: 100%;
        }
        html {
            overflow: hidden;
        }
        body {
            font-family:"微软雅黑";
            overflow: auto;
            width: calc(100vw + 20px);
        }
        body{
            background-color:rgb(246,246,246)
        }
        .sbar{
            float:left;
            height:20px;
            border:2px solid #467bff;
            /*margin-left:-16px;*/
        }
        .part1, .part2{
            margin-top:20px;
            margin-left:20px;
            margin-right:10px;
        }
        .part1>p, .part2>p{
            margin-left:30px;
            font-weight:bold;
        }
        .part1 .panel, .part2 .panel{
            margin:10px 15px;
            height:92px;
            background-color:#eff3f6;
            border-color:#e6e9ee;
        }
        .well img{
            width:50px;
        }
        .part1 .block:nth-child(1) .well:hover{
            border-color:#00d6c9;
            box-shadow: 0 0 5px rgba(0, 214, 201, 1)
            /*box-shadow: 10px 10px 5px #00d6c9;*/
        }
        .part1 .block:nth-child(2) .well:hover{
            border-color:#2497fd;
            box-shadow: 0 0 5px rgba(36, 151, 253, 1);
            /*box-shadow: 10px 10px 5px #2497fd;*/
        }
        .part1 .block:nth-child(3) .well:hover{
            border-color:#ffa921;
            box-shadow: 0 0 5px rgba(255, 169, 33, 1)
            /*box-shadow: 10px 10px 5px #ffa921;*/
        }
        .well-top, .well-bottom{

            display:inline-block;
            width:290px;
            background-color:white;
            margin-left:20px;
            padding:14px;
            height:120px;
            overflow:hidden;
            -webkit-box-shadow:  3px 3px 5px rgb(223,223,223);
            -moz-box-shadow:  3px 3px 5px rgb(223,223,223);
            box-shadow:  3px 3px 5px rgb(223,223,223);
        }
        .part2>div{
            color: rgb(190,210,230);

        }
        .well-inner{
            margin-left: 70px;
            display: inline-block;
            margin-top: -45px;
        }
        .well-inner>p{
            margin-top:10px;
            color:rgb(180,180,180);
        }
    </style>
</head>
<head>
<%@ include file="/common/packages.jsp"%>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Bootstrap Template</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
<% 
	String roleIds="";
   if(request.getSession().getAttribute(UserProfile.KEY)==null){ //获取失败，session过期处理 
        HttpServletResponse rep = (HttpServletResponse) response;
        //rep.sendRedirect("../login.do");
   }else{
		UserProfile u = (UserProfile)request.getSession().getAttribute(UserProfile.KEY);
   
  		String[] roleStrArray = u.getRoleIds();
   		StringBuilder roleStrTemp=new StringBuilder();
  	 	for(int i = 0 ; i < roleStrArray.length ; i++)
  		{
     		roleStrTemp.append(roleStrArray[i]);
     		roleStrTemp.append("&");
   		}   		
   		if(roleStrTemp.length()>0)
     		roleIds = roleStrTemp.substring(0,roleStrTemp.length()-1);
   }
   
 %>

</head>
<body>
<div class="part2">
	<div class="block">
        <p><strong>系统开发管控</strong></p>
        <div class="well well-top">
            <a ><img src="base/images/icons/apply01_xqgl_bid.svg"></a>
            <div class="well-inner">
                <strong>需求管理</strong>
                <p>可定制元数据系统需求开发并管理系统需求更新</p>
            </div>

        </div>
        <div class="well well-top">
            <a ><img src="base/images/icons/apply01_mxgl_bid.svg"></a>
            <div class="well-inner">
                <strong>模型管理</strong>
                <p>符合企业数据仓库环境的各类元数据管理模型</p>
            </div>
        </div>
        <div class="well well-top">
            <a ><img src="base/images/icons/apply01_kfsxzdh_bid.svg"></a>
            <div class="well-inner">
                <strong>开发上线自动化</strong>
                <p>企业元数据管理系统的快速部署与企业咸阳认证系统的无缝集成</p>
            </div>
        </div>
    </div>
    
</div>	
<div class="part1">    
     <!-- ---------------------------------------------------------------------------------- -->
    <div class="block">
        <p><strong>系统运维管理</strong></p>
        <div class="well well-top" id="contrast">
            <a href="contrast/contrastTask.jsp"><img src="base/images/icons/apply02_hjyzxxj.svg"></a>
            <div class="well-inner">
                <strong>环境一致性巡检</strong>
                <p>根据定制的巡检规则通过巡检任务获取系统巡检报告</p>
            </div>

        </div>
        <div class="well well-top" id="modelchange">
            <a href="modelChange/modelChangeList.jsp"><img src="base/images/icons/apply02_mxbggl.svg"></a>
            <div class="well-inner">
                <strong>模型变更管理</strong>
                <p>元数据模型变更管理和模型变更分析管理</p>
            </div>
        </div>
        <div class="well well-top" id="sysversion">
            <a href="version/version.jsp"><img src="base/images/icons/apply02_xtbbwh.svg"></a>
            <div class="well-inner">
                <strong>系统版本维护</strong>
                <p>系统版本控制，支持系统发布、系统发布等常见系统管理</p>
            </div>
        </div>
        <!-- 
        <div class="well well-top">
            <a href="versionMaintenance.html"><img src="base/images/icons/apply4.png"></a>
            <div class="well-inner">
                <strong>系统版本维护</strong>
                <p>描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述</p>
            </div>
        </div>
    </div>
    <!-- ---------------------------------------------------------------------------------- -->
	</div>
</div>
<div class="part2">
	<div class="block">
        <p><strong>业务元数据管理</strong></p>
        <div class="well well-top">
            <a ><img src="base/images/icons/apply03_ywysjwh_bid.svg"></a>
            <div class="well-inner">
                <strong>业务元数据维护</strong>
                <p>提供多种需求的图形化方式元数据维护和分析报告</p>
            </div>

        </div>
        <div class="well well-top">
            <a ><img src="base/images/icons/apply03_ywysjll_bid.svg"></a>
            <div class="well-inner">
                <strong>业务元数据浏览</strong>
                <p>支持元数据批量导出及分析结果导出</p>
            </div>
        </div>
    </div>

</div>	
<!-- 
<div class="part2">
    <span class="sbar"></span><p>我的应用</p>
    <div class="panel panel-info">
        <img src="base/images/icons/apply1_unnor.jpg">
        <div class="well well-bottom">
            <img src="base/images/icons/apply1nor-1-2.png"><span>需求管理</span>
        </div>
        <div class="well well-bottom">
            <img src="base/images/icons/apply1nor-2-2.png"><span>模型管理</span>
        </div>
        <div class="well well-bottom">
            <img src="base/images/icons/apply1nor-3-2.png"><span>开发上线自动化</span>
        </div>
    </div>
    <div class="panel panel-info">
        <img src="base/images/icons/apply2_unnor.jpg">

        <div class="well well-bottom">
            <img src="base/images/icons/apply2un-3-2.png"><span>数据问题定位</span>
        </div>

    </div>
    <div class="panel panel-info">
        <img src="base/images/icons/apply3_unnor.jpg">
        <div class="well well-bottom">
            <img src="base/images/icons/apply3un-1-2.png"><span>业务元数据维护</span>
        </div>
        <div class="well well-bottom">
            <img src="base/images/icons/apply3un-2-2.png"><span>业务元数据浏览</span>
        </div>

    </div>
</div>
-- -->


<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="base/js/jquery.min.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="base/js/bootstrap.min.js"></script>

</body>
	<script type="text/javascript">
	
		var roleIds='<%=roleIds%>';
		
		$(document).ready(function(){
			if(roleIds==""){
				//top.location.href = "../login.do";//parent.location.href
			}else{
				hiddenDIV();
			}	   	                                                  
   		});
   		
	   function hiddenDIV(){
	   		//默认全部不显示
		    document.getElementById("contrast").style.display="none";
		    document.getElementById("modelchange").style.display="none";
		    document.getElementById("sysversion").style.display="none";
		    //var roleIds='<%=roleIds%>';
		    //alert(document.getElementById("div").style.display)
		    var url = "<%=request.getContextPath()%>/statistics.do?invoke=menuRole";
			var jsonObject = {
				"roleIds" : roleIds,
			};
			$.ajax({
				url : url,
				dataType : 'json',
				type : 'post',
				async : true,
				data : jsonObject,

				success : function(data) {
					//alert("ok.data"+data.data);
			        var dataObj=eval(data.data); 
			        //alert(dataObj);    
        			for(var i=0;i<dataObj.length;i++){      
            			//依次判断菜单是否配置显示权限
						if(dataObj[i]=="MM_APP_CENTER_CONTRAST"){
							document.getElementById("contrast").style.display="";
						}else if(dataObj[i]=="MM_APP_CENTER_MODELCHANGE"){
							document.getElementById("modelchange").style.display="";
						}else if(dataObj[i]=="MM_APP_CENTER_VERSION"){
							document.getElementById("sysversion").style.display="";
						}    
        			}          			
				}

			});
	   }
	   
	   
	</script>
</html>