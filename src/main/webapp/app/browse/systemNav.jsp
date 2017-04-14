<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <title>浏览模块子页面</title>
     <%@ include file="/common/packages.jsp"%>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link href="<%=request.getContextPath() %>/app/base/bootstrap/css/demo.css" rel="stylesheet" type="text/css"/>
    <meta name="viewport" content="width=device-width,user-scalable=no, initial-scale=1">
    <!-- Bootstrap -->
    <link href="<%=request.getContextPath() %>/app/base/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery-3.1.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/app/base/js/nui/jquery/jquery-ui.js"></script>
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
    <div id="isFristLoadTag"></div>
      <div id="tab_home">
            <div class="panel panel-default">
                <div class="panel-body">
                    <span class="sbar"></span><p>查询设置</p>
                    <div class="row-list" id="div_sysclassify">
                        <label>系统分类</label>
                        <span class="" id="sysclassify">
                        </span>
                    </div>
                    <div class="row-list" id="div_departclassify">
                        <label>负&nbsp;&nbsp;责&nbsp;&nbsp;人</label>
                        <span id="departclassify">
                        </span>
                    </div>
                    <div class="row-list">
                        <form class="form-inline">
                            <label>系&nbsp;&nbsp;统&nbsp;&nbsp;名</label>
                                <input type="text" class="form-control" id="sysName" placeholder="查找元数据">
	                            <button class="btn btn-primary" type="button" onclick="search(1)">
	                                	查询
	                            </button>
		                        <button type="button" class="btn btn-primary" onclick="sysReset()">
		                           	           重置
		                        </button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <span class="sbar"></span><p id="systitle">结果列表</p>
                    <div style="overflow:auto;">
                        <div style="overflow:auto;">
	                    <div class="lg-well">
	                        <div class="well">
	                            <p class="w-head" id="system-1-top"></p>
							    <p class="w-body" id="system-1-medium"></p>
								<p class="w-tail" id="system-1-down"></p>
	                            <ul class="nav nav-pills" role="tablist" id="system-1-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#" >查看</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse1" href="#browse-analyse1">血统分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse2" href="#">影响分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse3" href="#">全链分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse4" href="#">关系分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-version" href="#">查看版本</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-history" href="#">查看历史</a></li>
	
	                            </ul>
	                        </div>
	                    </div>
	                    <div class="lg-well">
	                        <div class="well">
	                            <p class="w-head" id="system-2-top"></p>
			                    <p class="w-body" id="system-2-medium"></p>
			                    <p class="w-tail" id="system-2-down"></p>
	                            <ul class="nav nav-pills" role="tablist" id="system-2-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#" >查看</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse1" href="#">血统分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse2" href="#">影响分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse3" href="#">全链分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse4" href="#">关系分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-version" href="#">查看版本</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-history" href="#">查看历史</a></li>
	                            </ul>
	                        </div>
	                    </div>
	                    </div>
	                    <div style="overflow:auto;">
	                    <div class="lg-well">
	                        <div class="well">
	                            <p class="w-head" id="system-3-top"></small></p>
			                    <p class="w-body" id="system-3-medium"></p>
			                    <p class="w-tail" id="system-3-down"></p>
	                            <ul class="nav nav-pills" role="tablist" id="system-3-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#" >查看</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse1" href="#">血统分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse2" href="#">影响分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse3" href="#">全链分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse4" href="#">关系分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-version" href="#">查看版本</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-history" href="#">查看历史</a></li>
	                            </ul>
	                        </div>
	                    </div>
	                    <div class="lg-well">
	                        <div class="well">
	                            <p class="w-head" id="system-4-top"></p>
			                    <p class="w-body" id="system-4-medium"></p>
			                    <p class="w-tail" id="system-4-down"></p>
	                            <ul class="nav nav-pills" role="tablist" id="system-4-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#" >查看</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse1" href="#">血统分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse2" href="#">影响分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse3" href="#">全链分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-analyse4" href="#">关系分析</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-version" href="#">查看版本</a></li>
	                                <li><a data-toggle="modal" data-target="#browse-history" href="#">查看历史</a></li>
	                            </ul>
	                        </div>
	                    </div>
	                    </div>
                    </div>
                    <nav>
                         <ul class="pagination" id="system-page" onclick="systemPage()" onmouseover="systemPage()">
					     </ul>
                    </nav>
                </div>
            </div>
      </div>
      
    <div class="hidebg"></div>

            <!-- 弹窗子模块 -->
<div class="modal fade" id="browse-check" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="browse-check-modal" role="document">
        <div class="modal-content" style="height:550px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">查看</h5>
            </div>
            <div class="modal-body" style="padding:0 0 0 0;">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" id="iframeCheck" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal-right fade" id="browse-analyse1" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">血统分析</h5>
            </div>
            <div class="modal-body" style="padding:0 0 0 0;">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" id="lineageAnalyse" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal-right fade" id="browse-analyse2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">影响分析</h5>
            </div>
            <div class="modal-body" style="padding:0 0 0 0;">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" id="impactAnalyse" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal-right fade" id="browse-analyse3" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">全链分析</h5>
            </div>
            <div class="modal-body" style="padding:0 0 0 0;">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" id="wholeChain" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal-right fade" id="browse-analyse4" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">关系分析</h5>
            </div>
            <div class="modal-body" style="padding:0 0 0 0;">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" id="iframeRelaAna" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal-right fade" id="browse-version" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">查看版本</h5>
            </div>
            <div class="modal-body" style="padding:0 0 0 0;">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" id="iframeCheckVersion" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal-right fade" id="browse-history" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                <h5 class="modal-title">查看历史</h5>
            </div>
            <div class="modal-body" style="padding:0 0 0 0;">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" id="iframeCheckHistory" src=""></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
   <script type="text/javascript">
	    var roleIds='<%=roleIds%>';
		$(document).ready(function(){
			if(roleIds==""){
				top.location.href = "../../login.do";//parent.location.href
			}else{
				init();
			}	   	                                                  
	    });
	    
	    //按钮值缓存
   		sysbutton1 = "";
   		sysbutton2 = "";
	    var pathRoot = "";
	    function init(){
	    	 getWebRoot();//获取上下文路径
	    	 queryButtomAction("browserSysClassify", "sysclassify", 1);//databaseSys
	         queryButtomAction("browserSysDepart", "departclassify", 2);//databaseSys
	         search(sysCrtPageNum);
	         browseSysButtonBind();
	    }
	    
	        //系统tab按钮绑定
	    function browseSysButtonBind(){
	    	for(var i = 1; i < 5; i++){
	    		var tag = "#system-" + i + "-btn";
	    		$(tag).bind("mousedown",function(event){
	        		//console.log("sss" + event.target.hash);
	    			buildSysCheckSrc(event);
	        	})
	    	}
	    }
	    
	    function getWebRoot(){
	    	var webroot=document.location.href;   
	    	webroot=webroot.substring(webroot.indexOf('//')+2,webroot.length); 
	    	webroot=webroot.substring(webroot.indexOf('/')+1,webroot.length);   
	    	webroot=webroot.substring(0,webroot.indexOf('/'));   
	    	rootpath="/"+webroot;
	    	var curWwwPath=window.document.location.href;  
	    	var pathName=window.document.location.pathname;  
	        var pos=curWwwPath.indexOf(pathName);  
	        var path=curWwwPath.substring(0,pos);  
	        pathRoot = path  + "/" + webroot;
        }
	    
	     //  查询通用类  生成按钮
	    function queryButtomAction(action, selectorId, tag) {
	        var url = pathRoot + "/browser.do?invoke=" + action;
	        $.ajax({
	            type: 'post',
	            url: url,
	            data: {},
	            async: false,
	            dataType: 'json',
	            timeout: 40000,//40秒后超时
	            success: function (data, textStatus) {
	                buildButtonAction(data.data, selectorId, tag);
	            },
	            error: function (XMLHttpRequest, textStatus) {
	                alert("error");
	            }
	        });
	    }

	    //按钮生成逻辑
	    function buildButtonAction(data, selectorId, tag) {
	    	//debugger;
	    	if(data.length == 0){
	    		var id = "div_"+selectorId;
	    		$("#" +id).empty();
	    	}else{
	    		$.each(data, function (n, value) {
	            	if(value.id != null && value.name != null){
	            		var len = 1;
	                    var inhtml = "";
	                    inhtml = "<span>" + "<input type=\"radio\" name=\"options"+tag+"\" id=\"" + selectorId + "\" value=\"" + value.id + "\">"  + value.name +"&nbsp&nbsp&nbsp&nbsp"+ "</span>";
	                    var selID = "#" + selectorId;
	                    $(selID).append(inhtml);
	            	}
	            });
	    	}
	    }
    
       	//系统分页缓存
		sysTotalNum = "";  //系统查询总结果数量
	    sysCrtPageNum = 1; //系统  当前页数
	    systemObj = []; //系统对象
	    //系统模块查询
	    function search(index) {
	    	if(index == 1){
	    		 sysTotalNum = "";
	    	     sysCrtPageNum = 1;
	    	     systemObj = [];
	     	}
	    	//获取系统分类
	    	var selSystem = $('#sysclassify input:radio:checked').val();
			if(selSystem == undefined){
			}else{
				sysbutton1 = selSystem;
			}
			//获取负责人
			var selDepartment = $('#departclassify input:radio:checked').val();
			if(selDepartment == undefined){
			}else{
				sysbutton2 = selDepartment;
			}
	        var sysName = $("#sysName").val();//parentId
	        var pageIndex;
	        var pageSize; 
	        var totalPage = Math.ceil(sysTotalNum/4);
		      if(index =="«"){
		            if(sysCrtPageNum == 2){
		                 pageIndex = 0;
		                 pageSize = 4;
		            }else{
		            	pageIndex=sysCrtPageNum-1;
		            	pageSize = 4;
		            }
		       }else if(index =="»"){
		            pageIndex=(sysCrtPageNum-1) +1;
		            pageSize = 4;
		       }else if(index == 1){
			   	    pageIndex = 0;
			  	    pageSize = 4;
			  	  sysCrtPageNum = 1;
		      }else if(index == totalPage && index != 1){
		            pageIndex=index-1;
		            pageSize = 4;
		       }else if(sysCrtPageNum == 2){
		       	    pageIndex = 0;
		       	    pageSize = 4;
		       }else if(index != null || index != undefined){
		            pageIndex=index-1;
		            pageSize = 4;
		       }else{
		            pageIndex=0;
		            pageSize = 4;
		       }
	        var param = {pageSize:pageSize,pageIndex:pageIndex,sysName:sysName,parentId:sysbutton1,departName:sysbutton2};
	        var url = pathRoot + "/browser.do?invoke=browserSystem";
	    	 $.ajax({
	             type: 'post',
	             url: url,
	             data: param,
	             async: false,
	             dataType: 'json',
	             timeout: 40000,//40秒后超时
	             success: function(data, textStatus) {
	               buildContent(data, index);
	             },
	             error: function(XMLHttpRequest, textStatus) {
	                alert("error");
	             }
	         });
	    }

		function systemPage(){
	        	var obj_lis = document.getElementById("system-page").getElementsByTagName("li");
				for (var i = 0; i < obj_lis.length; i++) {
					obj_lis[i].onclick = function() {
						var s = this.innerHTML;
						var temp = s.replace("<a href=\"#\">","").replace("</a>","");
						search(temp);
					}
				}
	     }

		 var currentPagenum;//保存前一次显示位置
	     //构建内容列表
	     function buildContent(data, index){
		     if(currentPagenum != 4){//id="system-1-btn"
		     		for(var j=currentPagenum;j<4;j++){
		     			var pos = j+1;
		     			var btn = 'system-' + pos + '-btn';
		     			$("#" + btn).show();
		     			//var btnTm = document.getElementById(btn);
		     			//btnTm.innerHTML = '';
		     		}
		     	}
	         sysTotalNum = data.total;
	         var title = document.getElementById("systitle");
	      	title.innerHTML = "";
	      	title.innerHTML += "结果列表&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp总数为：" + sysTotalNum;
	     	buildPage(data.total, index);
	     	var result = data.data;
	     	var page;
	     	var totalPage = Math.ceil(sysTotalNum/4);
	     	if(data.total <= 4){
	     	    page = data.total;
	     	}else{
	     	    if(sysCrtPageNum == (totalPage)){//到最后一页
	     	       page=sysTotalNum%4;
	     	    }else{
	     	        if(parseInt(index) == totalPage){
	     	        	page=sysTotalNum%4;
	     	        }else{
	     	        	 page = 4;
	     	        }
	     	    }
	     	}
	     	for(var i = 0; i < 4; i++){
	     	    var pos = i+1;
	     		var top = 'system-' + pos + '-top';
	     		var medium = 'system-' + pos + '-medium';
	     		var down = 'system-' + pos + '-down';
	     		var topTm = document.getElementById(top);
	     		var mediumTm = document.getElementById(medium);
	     		var downTm = document.getElementById(down);
	     		topTm.innerHTML = '';
	     		mediumTm.innerHTML =  '';
	     		downTm.innerHTML = '';
	     	}
	     	for(var i = 0; i < page; i++){
	     	    var obj = result[i];
	     	    systemObj[i] = obj;
	     	    var pos = i+1;
	     		var top = 'system-' + pos + '-top';
	     		var medium = 'system-' + pos + '-medium';
	     		var down = 'system-' + pos + '-down';
	     		var topTm = document.getElementById(top);
	     		var mediumTm = document.getElementById(medium);
	     		var downTm = document.getElementById(down);
	     		var depart = "   ";
	     		var person = "   ";
	     		var describe = "";
	     		if(obj.sysDes != null){
	     			describe = obj.sysDes;
	     		}
	     		if(obj.mngDepart != null){
	     			depart = obj.mngDepart;
	     		}
	     		if(obj.chargePerson != null){
	     			person = obj.chargePerson;
	     		}
	     		topTm.innerHTML = '<small>系统名称：</small>' + obj.sysName+'&nbsp&nbsp&nbsp&nbsp<small>管理部门：</small>' + depart + '&nbsp&nbsp&nbsp&nbsp<small>负责人：</small>' + person;
	     		//topTm.innerHTML = '<small>系统名称：</small>' + obj.sysName+'&nbsp&nbsp&nbsp&nbsp<small>管理部门：</small>' + obj.mngDepart + '&nbsp&nbsp&nbsp&nbsp<small>负责人：</small>' + obj.chargePerson;
	     		mediumTm.innerHTML =  '系统描述:' + describe;
	     		downTm.innerHTML = '上下文路径:' + obj.sysPath;
	     	}
	     	currentPagenum = page;//赋值当前页数
	     	if(page != 4){//id="system-1-btn"
	     		for(var j=page;j<4;j++){
	     			var pos = j+1;
	     			var btn = 'system-' + pos + '-btn';
	     			$("#" + btn).hide();
	     			//var btnTm = document.getElementById(btn);
	     			//btnTm.innerHTML = '';
	     		}
	     	}
	     }

	    function buildPage(size, index){
	    	var totalPage = Math.ceil(size/4);
	        if("»" == index || index =="«"){
	             //var totalPage = Math.ceil(size/4);
	             $("#system-page").empty();
	             if(index =="«"){
	             	if(parseInt(sysCrtPageNum) == 2){
			         	  for(var i=parseInt(sysCrtPageNum)-1; i<parseInt(sysCrtPageNum)+1; i++){
				     		temp = '<li><a href="#">'+i +'</a></li>';
						    $("#system-page").append(temp);
					      }
					      temp = '<li><a href="#">&raquo;</a></li>';
						  $("#system-page").append(temp);
						  --sysCrtPageNum;
	             	}else{
	             		  var temp = '<li><a href="#">&laquo;</a></li>';
						  $("#system-page").append(temp);
			         	  for(var i=parseInt(sysCrtPageNum)-1; i<parseInt(sysCrtPageNum)+1; i++){
				     		temp = '<li><a href="#">'+i +'</a></li>';
						    $("#system-page").append(temp);
					      }
					      temp = '<li><a href="#">&raquo;</a></li>';
						  $("#system-page").append(temp);
						   --sysCrtPageNum;
	             	}	             	
	             }else if("»" == index){
	             	if((parseInt(sysCrtPageNum)+2) == totalPage){
	             		  var temp = '<li><a href="#">&laquo;</a></li>';
						  $("#system-page").append(temp);
			         	  for(var i=totalPage-1; i<totalPage+1; i++){
				     		temp = '<li><a href="#">'+i +'</a></li>';
						    $("#system-page").append(temp);
					      }
					      ++sysCrtPageNum;
	             	}else{
	             		  var temp = '<li><a href="#">&laquo;</a></li>';
						  $("#system-page").append(temp);
			         	  for(var i=parseInt(sysCrtPageNum)+1; i<parseInt(sysCrtPageNum)+3; i++){
				     		temp = '<li><a href="#">'+i +'</a></li>';
						    $("#system-page").append(temp);
					      }
					      temp = '<li><a href="#">&raquo;</a></li>';
						  $("#system-page").append(temp);
						  ++sysCrtPageNum;
	             	}
	             }
	           	 //前翻后翻 加总页数
	             $("#system-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	    	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--系统
	        }else{
	        	if(size <= 4){//小于4，不需要分页
	        	    $("#system-page").empty();
	        	  	//前翻后翻 加总页数
	                $("#system-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	    	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--系统
		      	    return;
		      	}else if(size <= 8){
		      	    $("#system-page").empty();
		      	    if(index ==1 || index ==2){
			      		for(var i=1; i<3; i++){//小于8条，不加》
							var temp = '<li><a href="#">'+i +'</a></li>';
							$("#system-page").append(temp);
						}
		      	    }
		      	//前翻后翻 加总页数
	                $("#system-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	    	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--系统
		      	}else{
		      		var toltalPage = Math.ceil(size/4);
		      		if(index == 1){
		      			$("#system-page").empty();
		      			for(var i=sysCrtPageNum; i<sysCrtPageNum+2; i++){
				     		temp = '<li><a href="#">'+i +'</a></li>';
						    $("#system-page").append(temp);
					      }
					      temp = '<li><a href="#">&raquo;</a></li>';
						  $("#system-page").append(temp);
		      		}else if( index == 2){
		      			return;
		      		}else{
		      			if(index == sysCrtPageNum){
			      			return;
				      	}else if(index = toltalPage){
			      			return;
				      	}else{
				      		 $("#system-page").empty();
				         	  for(var i=sysCrtPageNum; i<sysCrtPageNum+2; i++){
					     		temp = '<li><a href="#">'+i +'</a></li>';
							    $("#system-page").append(temp);
						      }
						      temp = '<li><a href="#">&raquo;</a></li>';
							  $("#system-page").append(temp);
				      	}
		      		}
		      	//前翻后翻 加总页数
	                $("#system-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	    	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--系统
		      	}
	        }
	    }

	    function sysReset() {
	    	radioReset("sysclassify");
	        radioReset("departclassify");
	        document.getElementById("sysName").value = "";
	        //分页参数重置
	        sysbutton1 = "";
	        sysbutton2 = "";
	        sysTotalNum = "";
	        sysCrtPageNum = 1;
	        systemObj = [];
	        search(1);
	    }

	    //重置函数
	    function radioReset(selectId){
	        var r = document.all(selectId);
	        //debugger;
	        if(r == undefined){
	        	return;
	        }else{
	        	for(var i=0; i<r.length; i++){
	    	        if(r[i].checked==true){
	    	            r[i].checked = false;
	    	        }
	    	    }
	        }
		}
		
		//系统浏览设置src url    
	    function buildSysCheckSrc(e){
	    	setButtonVal(e, systemObj);
	    }
			
		//按钮设置值
	    function setButtonVal(t, tarObject){
	    	// debugger;
	    	//console.log(t.target.outerHTML);
	    	var id = t.target.hash;
	    	var tag = t.target.outerHTML;
	    	var ctag = t.currentTarget.id;
	    	//alert(ctag.indexOf("1-btn"));
	    	var index;
	    	if(ctag.indexOf("-1-btn") >0){
	    		index = 1;
	    	}else if(ctag.indexOf("-2-btn") > 0){
	    		index = 2;
	    	}else if(ctag.indexOf("-3-btn") > 0){
	    		index = 3;
	    	}else{
	    		index = 4;
	    	}
	        var instanceId =  tarObject[index-1].sysId;
	        $("#isFristLoadTag").attr("isFirst",true);

	        //var url ="browse/metadataDetail.jsp?id='" + instanceId + "'";
	        if(tag.indexOf("#browse-check")>0){
	        	 $("#iframeCheck").attr("src","metadataDetail.jsp?id='" + instanceId +"'");
	        }else if(tag.indexOf("#browse-analyse1") > 0){
	        	$("#lineageAnalyse").attr("src","../analyse/lineageAnalyse.jsp?id=" + instanceId + "");
	        }else if(tag.indexOf("#browse-analyse2")>0){
	        	 $("#impactAnalyse").attr("src","../analyse/impactAnalyse.jsp?id=" + instanceId + "");
	        }else if(tag.indexOf("#browse-analyse3")>0){
	        	 $("#wholeChain").attr("src","../analyse/wholeChain.jsp?id=" + instanceId + "");
	        }else if(tag.indexOf("#browse-analyse4")>0){
	        	$("#iframeRelaAna").attr("src","relation.jsp?instanceId=" + instanceId + "");
	        }else if(tag.indexOf("#browse-version")>0){
	        	$("#iframeCheckVersion").attr("src","../version/versionRecord.jsp?id=" + instanceId + "");
	        }else if(tag.indexOf("#browse-history")){
	        	$("#iframeCheckHistory").attr("src","browseHistory.jsp?id=" + instanceId + "");
	        }
	    }
  </script>
  <script>
//监听模态框‘关闭=隐藏’事件：hidden.bs.modal
	$(function () { $('#browse-analyse1').on('hidden.bs.modal', function () {
			//alert("2");
			parent.$('.min-menu').show();
		})
	});
	//监听模态框‘打开完成后’事件：hidden.bs.modal
	$(function () { $('#browse-analyse1').on('shown.bs.modal', function () {
		//alert("1");
		parent.$('.min-menu').hide();
	})
	});
	//监听模态框‘关闭=隐藏’事件：hidden.bs.modal
  	$(function () { $('#browse-analyse2').on('hidden.bs.modal', function () {
			//alert("2");
			parent.$('.min-menu').show();
		})
  	});
  	//监听模态框‘打开完成后’事件：hidden.bs.modal
  	$(function () { $('#browse-analyse2').on('shown.bs.modal', function () {
		//alert("1");
		parent.$('.min-menu').hide();
	})
	});
  //监听模态框‘关闭=隐藏’事件：hidden.bs.modal
  	$(function () { $('#browse-analyse3').on('hidden.bs.modal', function () {
			//alert("2");
			parent.$('.min-menu').show();
		})
  	});
  	//监听模态框‘打开完成后’事件：hidden.bs.modal
  	$(function () { $('#browse-analyse3').on('shown.bs.modal', function () {
		//alert("1");
		parent.$('.min-menu').hide();
	})
	});
  //监听模态框‘关闭=隐藏’事件：hidden.bs.modal
  	$(function () { $('#browse-analyse4').on('hidden.bs.modal', function () {
			//alert("2");
			parent.$('.min-menu').show();
		})
  	});
  	//监听模态框‘打开完成后’事件：hidden.bs.modal
  	$(function () { $('#browse-analyse4').on('shown.bs.modal', function () {
		//alert("1");
		parent.$('.min-menu').hide();
	})
	});
  </script>
  <script>
    $(document).ready(function(){
    	//引用jquery-ui.js实现拖动
        $("#browse-check-modal").draggable();//为模态对话框添加拖拽
        $("#browse-check").css("overflow", "hidden");//禁止模态对话框的半透明背景滚动

    })
</script>
</body>
</html>
