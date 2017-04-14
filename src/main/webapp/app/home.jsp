<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/packages.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
<title>元数据首页展示</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/home.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
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

<ul class="nav nav-tabs" role="tablist" id="ulTabs">
    <li id="liTab1" role="presentation" class="active"><a href="#tab1" role="tab" data-toggle="tab">数据地图</a></li>
    <li id="liTab2" role="presentation"><a href="#tab2" role="tab" data-toggle="tab">统计分析图</a></li>
</ul>
<div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="tab1">
    	<div class="embed-responsive embed-responsive-16by9" style="height:100%">
	    	<iframe class="embed-responsive-item" id="tab1iframe"  src="homepage/dataMap.jsp"></iframe>
	    </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="tab2"> 
	    <div class="embed-responsive embed-responsive-16by9">
	    	<iframe class="embed-responsive-item" id="tab2iframe" src="statis/statisHome.jsp"></iframe>
	    </div>
    </div>
</div>

<script type="text/javascript">

	var roleIds='<%=roleIds%>';
	var num=0;
	$(document).ready(function(){
		if(roleIds==""){
			//top.location.href = "../login.do";//parent.location.href
		}else{
			hiddenTab();
			$("#ulTabs").click(function(event){//
	 	      var tar= event.target;
	 	      if(tar.hash=="#tab1"){
	 	         //var url ="homepage/dataMap.jsp";
	             //$("#tab1iframe").attr("src",url);
	 	      }else if(tar.hash=="#tab2"){
	 	      	 if(num == 0){
	 	      	 	 var url ="statis/statisHome.jsp";
	                 $("#tab2iframe").attr("src",url);
	                 num = 1;
	 	      	 }
	 	      } 
	 	    });	                     
		}	   	                                                  
    });

   function hiddenTab(){
   		//默认全部不显示
	   	var lis=document.getElementsByTagName("li");
	   	lis[0].style.display="none";//数据地图
	   	lis[1].style.display="none";
	   	//lis[2].style.display="none";//主题地图
	   	var activeStatus = "ACTIVE";
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
		        var dataObj=eval(data.data); 
       			for(var i=0;i<dataObj.length;i++){      
           			//依次判断菜单是否配置显示权限
					if(dataObj[i]=="MM_ENA_DATAMAP"){
						lis[0].style.display="block";
						activeStatus = activeStatus + "_DATAMAP";							
					}else if(dataObj[i]=="MM_ENA_STASTIC"){
						lis[1].style.display="block";//统计分析
						activeStatus = activeStatus + "_STASTIC";
					}
       			}  
       			//开始设置唯一active属性         	
       			var sunNav = document.getElementById('ulTabs');
				var lisc = sunNav.children;
       			if(activeStatus.indexOf("_DATAMAP") > -1){
       				lisc[0].setAttribute( 'class', "active");
       			}else if(activeStatus.indexOf("_STASTIC") > -1){
       				lisc[1].setAttribute( 'class', "active");
       			}else if(activeStatus.indexOf("_TOPICMAP") > -1){
       				lisc[2].setAttribute( 'class', "active");
       			}else{
       				//所有的TAB都没有权限
       				alert("请赋权限");
       			}		        			
			}
		});
   }
   
   function fullScreen(){
       $('.tab-content').height('100%');
   }
   
   function exitFullScreen(){
       $('.tab-content').height($('body').height()-39);
   }
</script>
<script src="base/js/jquery.min.js"></script>
<script src="base/js/bootstrap.min.js"></script>
</body>
</html>