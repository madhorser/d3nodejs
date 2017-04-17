<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<%@page import="com.primeton.dgs.web.command.util.StringUtil"%>

<HTML>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>元数据管理系统</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="app/base/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/newmain.css">

</head>
<script type="text/javascript" src="<%=request.getContextPath()%>/md5.js"></script>
<script src="app/base/js/jquery.min.js"></script>
<script src="app/base/js/bootstrap.min.js"></script>

<body>
	<div id="index">
		<div class="head">
			<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
				<div class="container-fluid">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<a class="navbar-brand" href="#"><img src="app/base/images/icons/top.jpg"></a>
					</div>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#" id="change"><span class="glyphicon glyphicon-search"></span></a></li>
						<li><a href="#" data-toggle="modal" data-target="#news" id="newsnews" onclick="newsaction()">消息</a></li>
						<li><a href="#" data-toggle="modal" data-target="#user"><span class="glyphicon glyphicon-user"></span><span style="font-size:12px;">用户</span></a></li>
						<li><a href="#" onclick="helper()"><span class="glyphicon glyphicon-question-sign"></span><span style="font-size:12px;">帮助</span></a></li>
						<li><a href="#" onclick="backManager()"><span class="glyphicon glyphicon-cog" style="font-size:16px;"></span></a></li>
						<li><a href="#" onclick="logout()"><span class="glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div>
			</nav>
		</div>
		<div class="main">
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="part1">
					<div class="menu">
						<div class="min-menu">
							<ul id="sideBar" class="nav nav-pills nav-stacked" role="tablist">
								<li class="menu-li active" role="presentation"><a href="#home" data-toggle="tab"></a></li>
								<li class="menu-li" role="presentation"><a href="#browse" data-toggle="tab"></a></li>
								<li class="menu-li" role="presentation"><a href="#analyse" data-toggle="tab"></a></li>
								<li class="menu-li" role="presentation"><a href="#appliCenter" data-toggle="tab"></a></li>
								<li class="menu-li" role="presentation"><a href="#search" data-toggle="tab"></a></li>
								<li class="menu-li" role="presentation"><a href="#ontology" data-toggle="tab"></a></li>
							</ul>
						</div>
					</div>
					<div class="content">
						<p style="display:none"><button id="view-fullscreen">Fullscreen</button><button id="cancel-fullscreen">Cancel fullscreen</button></p>
                        <div class="tab-content">
                            <div id="home" class="tab-pane fade in active">1</div>
                            <div id="browse" class="tab-pane fade">2</div>
                            <div id="analyse" class="tab-pane fade">3</div>
                            <div id="appliCenter" class="tab-pane fade" role="tabpanel">4</div>
                            <div id="search" class="tab-pane fade" role="tabpanel">5</div>
                            <div id="ontology" class="tab-pane fade" role="tabpanel">6</div>
                        </div>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane fade" id="part2">
					<div class="panel panel-info">
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-8 col-lg-offset-2">
									<div class="input-group input-group-lg">
										<input type="text" class="form-control"  id="firstvalue" placeholder="搜索">
										<span class="input-group-btn">
											<button class="btn btn-default" type="button" id="searchJump" onclick="searchTo()"><span class="glyphicon glyphicon-search"></span></button>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 消息模态框 -->
		<div class="modal fade" id="news" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">消息</h4>
					</div>
					<div id="msg_info" class="modal-body"></div>
					<div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">关闭</button></div>
				</div>
			</div>
		</div>
		
		<!-- 个人信息设置模态框 -->
		<div class="modal fade" id="user" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
			<div class="modal-dialog" style="height:350px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
						<h5 class="modal-title">个人信息</h5>
					</div>
					<div class="modal-body" id="user_info"></div>
				</div>
			</div>
		</div>
	</div>
	
	<form id="frmLogin" method="post" action="<%=request.getContextPath()%>/showlogin.do?invoke=relogin">
		<input type="hidden" name="userId" id="un" value='' class="form-control""> 
		<input type="hidden" name="ndlogin" id="ndlogin" value="no">
		<input type="hidden" name="hpwd" id="hpwd" value="manage"> 
		<input type="hidden" name="md5RandomKey" id="md5RandomKey" value="">
	</form>
	
	<textarea id="template" style="display:none">
		<div class="embed-responsive embed-responsive-16by9">
			<iframe class="embed-responsive-item" src="$pageSrc$"></iframe>
		</div>
	</textarea>
	
	<textarea id="msg_template" style="display:none">
		<div class="embed-responsive embed-responsive-16by9">
			<iframe class="embed-responsive-item" src="$pageSrc$"></iframe>
		</div>
	</textarea>
	
	<textarea id="user_template" style="display:none">
		<div class="embed-responsive embed-responsive-16by9" style="height:100%;">
			<iframe id="msgbody" class="embed-responsive-item" src="$pageSrc$"></iframe>
		</div>
	</textarea>
	
	<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
	<script type="text/javascript" defer="defer">
	
	//获取系统消息
	function getMsgInfo(){
		var info={pageSrc:"<%=request.getContextPath()%>/app/message/msg.jsp"};
		var temp=formateString($("#msg_template").val(),info);
		$("#msg_info").html(temp);
		
	}
	
	$('#news').on('show.bs.modal', function (e) {
		getMsgInfo();
    });
	
	function getUserInfo(){
		var info={pageSrc:"<%=request.getContextPath()%>/app/user/user.jsp"};
		var temp=formateString($("#user_template").val(),info);
		$("#user_info").html(temp);
	}
	
	$('#user').on('show.bs.modal', function (e) {
		getUserInfo(); 
    });
	
	document.getElementById("firstvalue").value = "";

	function searchTo(){ 
		var getval = document.getElementById("firstvalue").value;
		$('#part1').addClass("in active");
		$('#part2').removeClass("active").removeClass("in");
		$('.menu-li:nth-child(5) a').click();
		var url="app/search/search.jsp?firstvalue=" + getval;
		$('#search iframe').attr("src",encodeURI(url));
	}
	
    //进入后台管理
  	function backManager(url,userId,sessionId){
		var form = document.getElementById("frmLogin");
		form.submit();
	}
    
    function helper(){
    	window.open('<%=request.getContextPath()%>/app/base/help/10.html');
    }
    
	//注销登录信息
	function logout() {
		location.href = "showlogout.do?invoke=logout";
	}
	
	function newsaction(){
		$("#newsnum").empty(); 
	}
	
	//获取系统消息总数	    
	var url = "<%=request.getContextPath()%>/message.do?invoke=queryMsgNum";
	$.ajax({
		url : url,
		dataType : 'json',
		type : 'post',
		async : true,
		success : function(data) {
			var num = data.allNum;
			if (num != 0) {
				$("#newsnews").append("<span id=\"newsnum\" class=\"badge\">" + num + "</span>");
			}
		}
	});

	</script>
	
	<script type="text/javascript">
		
        var homeHeight=$(window).height()-76;
        $(document).ready(function(){
            $('#home').height(homeHeight);

        });

		$('.menu-li a').click(function() {
        	var h = $(this).attr('href');
          	var h2 = h.substring(1);
          	console.log(h2);
          	$('#'+h2+" iframe").attr('src', $('#'+h2+" iframe").attr('src'));
     	})
     	
		var a = false;
		$('#change').click(function() {
			if ($('#part1').hasClass('in active')) {
				$('#part1').removeClass("active").removeClass("in");
				$('#part2').addClass("in active");
			} else {
				$('#part1').addClass("in active");
				$('#part2').removeClass("active").removeClass("in");
			}
		});
		
		var b = false;
		$('#img').click(function() {
			b = !b;
			if (b) {
				$('#img').attr("src", "images/index3.png");
			} else {
				$('#img').attr("src", "images/index2.png");
			}
		});
		
		//字符串格式化
	    function formateString(str,obj){
		    return str.replace(/\\$\w+\\$/gi, function(matchs) {
		        var returns = obj[matchs.replace(/\\$/g, "")];
		        return (returns + "") == "undefined"? "": returns;
		    });
	    }
		
	    $(document).ready(function(){
	   		
	    	//hiddenDIV();//控制隐藏权限	 
	   		
	   		//处理页面加载不同sideBar
	   		var jsonObj={
  					home:[{pageSrc:"app/home.jsp"}],
  					browse:[{pageSrc:"app/browse.jsp"}],
  					analyse:[{pageSrc:"app/analyse.jsp"}],
  					appliCenter:[{pageSrc:"app/appliCenter.jsp"}],
  					search:[{pageSrc:"app/mainSearch.jsp"}],
  					ontology:[{pageSrc:"app/ontology.jsp"}]
	   		}
	   		
	    	var temp="";
	    	
	   		//默认home
	   		temp=formateString($("#template").val(),jsonObj.home[0]);
			$("#home").html(temp);
	   		$("#sideBar").click(function(event){
	   			var tar=event.target;
	   			if(tar.hash=="#home"){
	   				temp=formateString($("#template").val(),jsonObj.home[0]);
	   				$("#home").html(temp);
	   				$('#home .embed-responsive.embed-responsive-16by9').height('100%');
	   			}else if(tar.hash=="#browse"){
	   				temp=formateString($("#template").val(),jsonObj.browse[0]);
	   				$("#browse").html(temp);
	   				$('#browse .embed-responsive.embed-responsive-16by9').height('100%');
	   			}else if(tar.hash=="#analyse"){
	   				temp=formateString($("#template").val(),jsonObj.analyse[0]);
	   				$("#analyse").html(temp);
	   				$('#analyse .embed-responsive.embed-responsive-16by9').height($(window).height()-80);
	   			}else if(tar.hash=="#appliCenter"){
	   				temp=formateString($("#template").val(),jsonObj.appliCenter[0]);
	   				$("#appliCenter").html(temp);
	   				$('#appliCenter .embed-responsive.embed-responsive-16by9').height($(window).height()-80);
	   			}else if(tar.hash=="#search"){
	   				temp=formateString($("#template").val(),jsonObj.search[0]);
	   				$("#search").html(temp);
	   				$('#search .embed-responsive.embed-responsive-16by9').height($(window).height()-80);
	   			}else if(tar.hash=="#ontology"){
	   				temp=formateString($("#template").val(),jsonObj.ontology[0]);
	   				$("#ontology").html(temp);
	   				$('#ontology .embed-responsive.embed-responsive-16by9').height('100%');
	   			}
	   		});
	   });
	    
	   function hiddenDIV(){
		   
	   		//默认全部不显示
	   		var lis=document.getElementsByTagName("li");
	   		document.getElementById("browse").style.display="none";//浏览
		   	document.getElementById("analyse").style.display="none";//统计分析
		   	document.getElementById("appliCenter").style.display="none";//综合应用 
		    var roleIds='';
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
						if(dataObj[i]=="MM_MAIN_BROWERS"){
							document.getElementById("browse").style.display="";
						}else if(dataObj[i]=="MM_MAIN_STASTIC"){
							document.getElementById("analyse").style.display="";
						}else if(dataObj[i]=="MM_MAIN_COMPLEX"){
							document.getElementById("appliCenter").style.display="";
						}	    
	       			}          			
				}
			});
	   }
	   $(document).ready(function(){
			$('.embed-responsive.embed-responsive-16by9').height('100%');
			/* $(window).resize(function() {
			    $('.embed-responsive.embed-responsive-16by9').height($(window).height()-80);
			}); */
		});
	   function fullScreen(){
		   $('.main .menu').hide(500);
		   $('.head').hide(500);
		   $('.main .content').animate({
			   margin:0
		   });
		   $('#index').height('100%');
           $('#home').height('100%');
           $('.main').height('100%');    
           $('.tab-content').height('100%');
           $('#browse').height('100%');
           $('#browse .embed-responsive.embed-responsive-16by9').height('100%');
		   $('#view-fullscreen').click();
	   }
	   
	   function exitFullScreen(){
		   $('.main .menu').show(1000);
		   $('.head').show(1000);
		   $('.main .content').animate({
			   'margin-top':'78px',
			   'margin-left':'110px'
		   });
		   $('#cancel-fullscreen').click();
           $('#home').height('100%');
	   }
	   
	   (function () {
			var viewFullScreen = document.getElementById("view-fullscreen");
			if (viewFullScreen) {
			    viewFullScreen.addEventListener("click", function () {
			        var docElm = document.documentElement;
			        if (docElm.requestFullscreen) {
			            docElm.requestFullscreen();
			        }
			        else if (docElm.msRequestFullscreen) {
			            docElm.msRequestFullscreen();
			        }
			        else if (docElm.mozRequestFullScreen) {
			            docElm.mozRequestFullScreen();
			        }
			        else if (docElm.webkitRequestFullScreen) {
			            docElm.webkitRequestFullScreen();
			        }
			    }, false);
			}
			
			var cancelFullScreen = document.getElementById("cancel-fullscreen");
			if (cancelFullScreen) {
			    cancelFullScreen.addEventListener("click", function () {
			        if (document.exitFullscreen) {
			            document.exitFullscreen();
			        }
			        else if (document.msExitFullscreen) {
			            document.msExitFullscreen();
			        }
			        else if (document.mozCancelFullScreen) {
			            document.mozCancelFullScreen();
			        }
			        else if (document.webkitCancelFullScreen) {
			            document.webkitCancelFullScreen();
			        }
			    }, false);
			}
		})();
	</script>

</body>
</HTML>
