<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<head>
    <title>浏览模块</title>
    <%@ include file="/common/packages.jsp"%>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link href="<%=request.getContextPath() %>/app/base/bootstrap/css/demo.css" rel="stylesheet" type="text/css"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,user-scalable=no, initial-scale=1">
    <link href="<%=request.getContextPath() %>/app/base/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery-3.1.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/app/base/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery.tmpl.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/browse.css">
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
<div class="tophead" style="margin-left:-29px;">
	<div class="menu">
		<div class="min-menu">
		    <ul id="myTab" class="nav nav-pills" role="tablist">
		        <li role="presentation" class="active"><a href="#home" data-toggle="tab" id="home_tab" title="系统"></a></li>
		        <li role="presentation"><a href="#index" data-toggle="tab" title="指标"></a></li>
		        <li role="presentation"><a href="#report" data-toggle="tab" title="报表"></a></li>
		        <li role="presentation"><a href="#database" data-toggle="tab" title="库表"></a></li>
		        <li role="presentation"><a href="#inforItem" data-toggle="tab" title="信息项"></a></li>
		        <li role="presentation"><a href="#code" data-toggle="tab" title="代码"></a></li>
		        <li role="presentation"><a href="#etl" data-toggle="tab" title="ETL作业"></a></li>
		        <li role="presentation"><a href="#interface" data-toggle="tab" title="接口文件"></a></li>
		        <li role="presentation"><a href="#logicModel" data-toggle="tab" title="逻辑模型实体"></a></li>
		    </ul>
		</div>
		<div class="content" style="height:100%">
			<p style="display:none"><button id="view-fullscreen">Fullscreen</button><button id="cancel-fullscreen">Cancel fullscreen</button></p>
            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">1</div>
                <div id="index" class="tab-pane fade">2</div>
                <div id="report" class="tab-pane fade">3</div>
                <div id="database" class="tab-pane fade">4</div>
                <div id="inforItem" class="tab-pane fade">5</div>
                <div id="code" class="tab-pane fade">6</div>
                <div id="etl" class="tab-pane fade">7</div>
                <div id="interface" class="tab-pane fade">8</div>
                <div id="logicModel" class="tab-pane fade">9</div>
            </div>
		</div>
	</div>
</div>

    <textarea id="template" style="display:none">
		<div class="embed-responsive embed-responsive-16by9">
			<iframe class="embed-responsive-item" src="$pageSrc$"></iframe>
		</div>
	</textarea>


<script type="text/javascript">
	var roleIds='<%=roleIds%>';
    $(document).ready(function(){
	   		if(roleIds==""){
				//top.location.href = "../login.do";//parent.location.href
			}else{
				//处理页面加载不同sideBar
				
			//字符串格式化
		    function formateString(str,obj){
			    return str.replace(/\\$\w+\\$/gi, function(matchs) {
			        var returns = obj[matchs.replace(/\\$/g, "")];
			        return (returns + "") == "undefined"? "": returns;
			    });
		    }	
				
	   		var jsonObj={
  					home:[{pageSrc:"browse/systemNav.jsp"}],
  					index:[{pageSrc:"browse/indexNav.jsp"}],
  					report:[{pageSrc:"browse/reportNav.jsp"}],
  					database:[{pageSrc:"browse/databaseNav.jsp"}],
  					inforItem:[{pageSrc:"browse/inforItemNav.jsp"}],
  					code:[{pageSrc:"browse/codeNav.jsp"}],
  					etl:[{pageSrc:"browse/etlNav.jsp"}],
  					interfaces:[{pageSrc:"browse/interfaceNav.jsp"}],
  					logicModel:[{pageSrc:"browse/logicModelNav.jsp"}],
	   		}
	   		
	    	var temp="";
	    	
	   		//默认home
	   		temp=formateString($("#template").val(),jsonObj.home[0]);
			$("#home").html(temp);
	   		$("#myTab").click(function(event){
	   			var tar=event.target;
	   			if(tar.hash=="#home"){
	   				temp=formateString($("#template").val(),jsonObj.home[0]);
	   				$("#home").html(temp);
	   			}else if(tar.hash=="#index"){
	   				temp=formateString($("#template").val(),jsonObj.index[0]);
	   				$("#index").html(temp);
	   			}else if(tar.hash=="#report"){
	   				temp=formateString($("#template").val(),jsonObj.report[0]);
	   				$("#report").html(temp);
	   			}else if(tar.hash=="#database"){
	   				temp=formateString($("#template").val(),jsonObj.database[0]);
	   				$("#database").html(temp);
	   			}else if(tar.hash=="#inforItem"){
	   				temp=formateString($("#template").val(),jsonObj.inforItem[0]);
	   				$("#inforItem").html(temp);
	   			}else if(tar.hash=="#code"){
	   				temp=formateString($("#template").val(),jsonObj.code[0]);
	   				$("#code").html(temp);
	   			}else if(tar.hash=="#etl"){
	   				temp=formateString($("#template").val(),jsonObj.etl[0]);
	   				$("#etl").html(temp);
	   			}else if(tar.hash=="#interface"){
	   				temp=formateString($("#template").val(),jsonObj.interfaces[0]);
	   				$("#interface").html(temp);
	   			}else if(tar.hash=="#logicModel"){
	   				temp=formateString($("#template").val(),jsonObj.logicModel[0]);
	   				$("#logicModel").html(temp);
	   			}
	   		});
			}	   	                          
	   });
</script>
</body>
</html>
