<!DOCTYPE html>
<html>
<head>
<%@page pageEncoding="UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>ECharts</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/analyse.css">



</head>
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
<body>
	<div id="analyze">
		<div class="panel panel-default" id="distribution">
			<div class="panel-body" style="height:314px;width:1144px">
				<p class="p-head">
					<span></span>元数据分布图
				</p>				
					<div class="embed-responsive embed-responsive-16by9">
						<iframe class="embed-responsive-item"
							src="<%=request.getContextPath()%>/app/statis/distribution.jsp"></iframe>
					</div>
			</div>
		</div>		
		<div class="panel panel-default" id="changeTrend">
			<div class="panel-body" style="height:314px;width:1144px" >
				<p class="p-head">
					<span></span>元数据变更趋势图
				</p>				
					<div class="embed-responsive embed-responsive-16by9">
						<iframe class="embed-responsive-item"
							src="<%=request.getContextPath()%>/app/statis/changeTrend.jsp"></iframe>
					</div>
			</div>
		</div>

		<div class="panel panel-default" id="sysImportant">
			<div class="panel-body" style="height:314px;width:1144px">
				<p class="p-head">
					<span></span>系统重要性统计图
				</p>				
					<div class="embed-responsive embed-responsive-16by9">
						<iframe class="embed-responsive-item"
							src="<%=request.getContextPath()%>/app/statis/sysImportant.jsp"></iframe>
					</div>
				</div>			
		</div>
			<div class="panel panel-default" id="usingInfo">
			<div class="panel-body" style="height:314px;width:1144px" >
				<p class="p-head">
					<span></span>使用情况统计图
				</p>				
					<div class="embed-responsive embed-responsive-16by9">
						<iframe class="embed-responsive-item"
							src="<%=request.getContextPath()%>/app/statis/usingInfo.jsp"></iframe>
					</div>				
				</div>
		</div>		
			<div class="panel panel-default" id="sysActive">
			<div class="panel-body" style="height:314px;width:1144px">
				<p class="p-head">
					<span></span>人员活跃度统计图
				</p>				
					<div class="embed-responsive embed-responsive-16by9">
						<iframe class="embed-responsive-item"
							src="<%=request.getContextPath()%>/app/statis/sysActive.jsp"></iframe>
					</div>					
				</div>
		</div>
		</div>
<script type="text/javascript">
	var roleIds='<%=roleIds%>';
	$(document).ready(function(){
		if(roleIds==""){
			//top.location.href = "../login.do";//parent.location.href
		}else{
			hiddenDIV();
		}	   	                                                  
    });
   
	var w = $(window).width() - 30;
	$(".menu-li a .panel").width(w / 5);
	$(window).resize(function() {
		var w = $(window).width() - 30;
		$(".menu-li a .panel").width(w / 5);
	});
	
   function hiddenDIV(){
   		//默认全部不显示
	    document.getElementById("distribution").style.display="none";
	    document.getElementById("changeTrend").style.display="none";
	    document.getElementById("sysImportant").style.display="none";
	    document.getElementById("usingInfo").style.display="none";
	    document.getElementById("sysActive").style.display="none";
	   // var roleIds='<%=roleIds%>';
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
					if(dataObj[i]=="MM_MAP_DISTRIBUTION"){
						document.getElementById("distribution").style.display="block";
					}else if(dataObj[i]=="MM_MAP_CHANGETREND"){
						document.getElementById("changeTrend").style.display="block";
					}else if(dataObj[i]=="MM_MAP_IMPORTANT"){
						document.getElementById("sysImportant").style.display="block";
					}else if(dataObj[i]=="MM_MAP_USEINFO"){
						document.getElementById("usingInfo").style.display="block";
					}else if(dataObj[i]=="MM_MAP_SYSACTIVE"){
						document.getElementById("sysActive").style.display="block";
					}	    
    			}          			
			}

		});
   }
</script>
</body>