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
      <div id="tab_database">
            <div class="panel panel-default">
                <div class="panel-body">
                    <span class="sbar"></span><p id="systitle">查询设置</p>
                    <div class="row-list" id="div_databaseSysClassify">
                        <label>系统分类</label>
                        
                        <span id="databaseSysClassify"></span>
                    </div>
                    <div class="row-list" id="div_databaseSys">
                        <label>系&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统</label>
                        
                        <span  id="databaseSys"></span>
                    </div>
                    <div class="row-list" id="div_dbSchema">
                        <label>库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <span id="dbSchema"></span>
                    </div>
                    <div class="row-list" id="div_dbDataType">
                        <label>类&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;型</label>
                        <span id="dbDataType"></span>
                    </div>
                    <div class="row-list">
                        <form class="form-inline">
                            <label>库表名称</label>
                                <input type="text" class="form-control" id="DbMdName" placeholder="查找元数据">
                                <button class="btn btn-primary" type="button" onclick="dbSearch(1)">
                                   	查询
                                </button>
	                            <button type="button" class="btn btn-primary" onclick="databaseReset()">
	                            	           重置
	                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <span class="sbar"></span><p id="dbtitle">结果列表</p>
                    <div style="overflow:auto;">
                         <div style="overflow:auto;">                    
	                    <div class="lg-well">
	                        <div class="well">
	                            <p class="w-head" id="database-1-top"></p>
							    <p class="w-body" id="database-1-medium"></p>
								<p class="w-tail" id="database-1-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="db-1-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#">查看</a></li>
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
	                            <p class="w-head" id="database-2-top"></p>
							    <p class="w-body" id="database-2-medium"></p>
								<p class="w-tail" id="database-2-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="db-2-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#">查看</a></li>
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
	                            <p class="w-head" id="database-3-top"></p>
							    <p class="w-body" id="database-3-medium"></p>
								<p class="w-tail" id="database-3-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="db-3-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#">查看</a></li>
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
	                           <p class="w-head" id="database-4-top"></p>
							    <p class="w-body" id="database-4-medium"></p>
								<p class="w-tail" id="database-4-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="db-4-btn">
	                                <li class=""><a data-toggle="modal" data-target="#browse-check" href="#">查看</a></li>
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
                        <ul class="pagination" id="database-page" onclick="databasePage()" onmouseover="databasePage()">
					     </ul>
                    </nav>
                </div>
            </div>
      </div>
      <!-- 弹窗子模块 -->
<div class="modal fade" id="browse-check" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
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
<div class="modal modal-right fade" id="browse-analyse4" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
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
	    
	    dbbutton1 = "";
	    dbbutton2 = "";
	    dbbutton3 = "";
	    dbbutton4 = "";
	    var pathRoot = "";
	    function init(){
	    	 getWebRoot();//获取上下文路径
	    	 $("#databaseSysClassify,#databaseSys,#dbSchema,#dbDataType").empty();
	    	 queryButtomAction("browserSysClassify", "databaseSysClassify", 1);//databaseSys
	         queryButtomAction("browserSys", "databaseSys", 2);
	         queryButtomAction("browserSchema", "dbSchema", 3);//dbDataType
	         queryButtomAction("browserSchemaClassify", "dbDataType", 4);//dbDataType
	         dbSearch(dbCrtPageNum);
	         browseDbButtonBind();
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
	                alert("查询数据信息异常！");
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
	    
    function browseDbButtonBind(){
   // debugger;
	    	for(var i = 1; i < 5; i++){
	    		var tag = "#db-" + i + "-btn";
	    		$(tag).bind("mousedown",function(event){
	        		//console.log("sss" + event.target.hash);
	    			buildDbCheckSrc(event);
	        	})
	    	}
    }
    
    //数据库分页缓存
	dbTotalNum = "";  //库表查询总结果数量
    dbCrtPageNum = 1; //库表当前页数，默认其实第一页
    dbObj = []; //库表对象
    //库表
    function dbSearch(index) {
    	if(index == 1){
    		 dbTotalNum = ""; 
    	     dbCrtPageNum = 1;
    	     dbObj = [];
    	}
       //获取数据库分类
       	var selSysClassify = $('#databaseSysClassify input:radio:checked').val();
   		if(selSysClassify == undefined){
   			//console.log("查询全部");
   		}else{
   			dbbutton1 = selSysClassify;
   		}
   		//获取系统
   		var selSys = $('#databaseSys input:radio:checked').val();
   		if(selSys == undefined){
   		}else{
   			dbbutton2 = selSys;
   		}
   		//获取库信息
   		var dbSchema = $('#dbSchema input:radio:checked').val();
   		if(dbSchema == undefined){
   		}else{
   			dbbutton3 = dbSchema;
   		}
   		//获取类型
   		var dbDataType = $('#dbDataType input:radio:checked').val();
   		if(dbDataType == undefined){
   		}else{
   			dbbutton4 = dbDataType;
   		}
        var key = document.getElementById("DbMdName").value;
       var totalPage = Math.ceil(dbTotalNum/4);
       var pageIndex;
       var pageSize; 
       //console.log('dbCrtPageNum' + dbCrtPageNum);
       if(index =="«"){
            if(dbCrtPageNum == 2){
                 pageIndex = 0;
                 pageSize = 4;
            }else{
            	pageIndex=dbCrtPageNum-1;
            	pageSize = 4;
            }
       }else if(index =="»"){
            pageIndex=(dbCrtPageNum-1) +1;
            pageSize = 4;
       }else if(index == 1){
    	    pageIndex = 0;
      	    pageSize = 4;
      	  dbCrtPageNum = 1;
      }else if(index == totalPage && index != 1){
            pageIndex=index-1;
            pageSize = 4;
       }else if(dbCrtPageNum == 10){
       	    pageIndex = 0;
       	    pageSize = 4;
       }else if(index != null || index != undefined){
    	   //alert(index);
            pageIndex=index-1;
            pageSize = 4;
       }else{
    	   pageIndex=0;
           pageSize = 4;
       }
        var param = {pageSize:pageSize,pageIndex:pageIndex,sysClassifyId:dbbutton1,sysId:dbbutton2,schemaId:dbbutton3,classiFierId:dbbutton4,instanceName:key};
        var url = pathRoot + "/browser.do?invoke=searchBrowserSchema";
    	 $.ajax({
             type: 'post',
             url: url,
             data: param,
             async: false,
             dataType: 'json',
             timeout: 40000,//40秒后超时
             success: function(data, textStatus) {
               buildDbContent(data, index);
             },
             error: function(XMLHttpRequest, textStatus) {
                alert("error");
             }
         });
    }

    //<a href="#">上一页</a>
	function databasePage(){
        	var obj_lis = document.getElementById("database-page").getElementsByTagName("li");
			for (var i = 0; i < obj_lis.length; i++) {
				obj_lis[i].onclick = function() {
					var s = this.innerHTML;
					var temp = s.replace("<a href=\"#\">","").replace("</a>","");
					dbSearch(temp.replace("\"",""));
				}
			}
     }

	 var currentPagenum;//保存前一次显示位置
     //构建内容列表
     function buildDbContent(data, index){
    // debugger;
	     if(currentPagenum != 4){//id="system-1-btn"
	     		for(var j=currentPagenum;j<4;j++){
	     			var pos = j+1;
	     			var btn = 'db-' + pos + '-btn';
	     			//var btnTm = document.getElementById(btn);
	     			//btnTm.innerHTML = '';
	     			$("#" + btn).show();
	     		}
	     	}
        dbTotalNum = data.total;
     	buildDbPage(data.total, index);//分页
     	var result = data.data;
     	var title = document.getElementById("dbtitle");
     	title.innerHTML = "";
     	title.innerHTML += "结果列表&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp总数为：" + dbTotalNum;
     	var page;
     	var totalPage = Math.ceil(dbTotalNum/4);
     	if(data.total <= 4){
     	    page = data.total;
     	}else{
     	    if(dbCrtPageNum == (totalPage)){//到最后一页
     	     
     	       page=dbTotalNum%4;
     	    }else{
     	         if(parseInt(index) == totalPage){
     	        	page=dbTotalNum%4;
     	        	if(page==0){
     	        		page=4;
     	        	}
     	        }else{
     	        	 page = 4;
     	        }
     	    }
     	}
     	for(var i = 0; i < 4; i++){
     	    var pos = i+1;
     		var top = 'database-' + pos + '-top';
     		var medium = 'database-' + pos + '-medium';
     		var down = 'database-' + pos + '-down';
     		var topTm = document.getElementById(top);
     		var mediumTm = document.getElementById(medium);
     		var downTm = document.getElementById(down);
     		topTm.innerHTML = '';
     		mediumTm.innerHTML =  '';
     		downTm.innerHTML = '';
     	}
     	for(var i = 0; i < page; i++){
     	    var obj = result[i];
     	    dbObj[i] = obj;
     	    var pos = i+1;
     	     
     		var top = 'database-' + pos + '-top';
     		var medium = 'database-' + pos + '-medium';
     		var down = 'database-' + pos + '-down';
     		var topTm = document.getElementById(top);
     		var mediumTm = document.getElementById(medium);
     		var downTm = document.getElementById(down);
     		var depart = "   ";
     		var person = "   ";
     		var describe = "";
     		if(obj.sysDes != null){
     			describe = obj.sysDes;
     		}
     		topTm.innerHTML = '<small>库表名称：</small>' + obj.sysName;
     		//topTm.innerHTML = '<small>元数据名称：</small>' + obj.sysCode+'&nbsp&nbsp&nbsp&nbsp<small>管理部门：</small>' + obj.mngDepart + '&nbsp&nbsp&nbsp&nbsp<small>负责人：</small>' + obj.chargePerson;
     		mediumTm.innerHTML =  '系统描述:' + describe;
     		downTm.innerHTML = '上下文路径:' + obj.sysPath;
     	}
     	currentPagenum = page;//赋值当前页数
     	if(page != 4){//id="system-1-btn"
     		for(var j=page;j<4;j++){
     			var pos = j+1;
     			var btn = 'db-' + pos + '-btn';
     			//var btnTm = document.getElementById(btn);
     			//btnTm.innerHTML = '';
     			$("#" + btn).hide();
     		}
     	}
     }

     function buildDbPage(size, index){//size 总数, index 当前点击          福
    	// debugger;
    	 var totalPage = Math.ceil(size/4);
    	 if("»" == index || index =="«"){
             //var totalPage = Math.ceil(size/4);
             $("#database-page").empty();
             if(index =="«"){
             	if(parseInt(dbCrtPageNum) == 2){
		         	  for(var i=parseInt(dbCrtPageNum)-1; i<parseInt(dbCrtPageNum)+9; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#database-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#database-page").append(temp);
					  --dbCrtPageNum;
             	}else{
             		  var temp = '<li><a href="#">&laquo;</a></li>';
					  $("#database-page").append(temp);
		         	  for(var i=parseInt(dbCrtPageNum)-1; i<parseInt(dbCrtPageNum)+9; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#database-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#database-page").append(temp);
					   --dbCrtPageNum;
             	}
             }else if("»" == index){
             	if((parseInt(dbCrtPageNum)+10) == totalPage){
             		  var temp = '<li><a href="#">&laquo;</a></li>';
					  $("#database-page").append(temp);
		         	  for(var i=totalPage-1; i<totalPage+9; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#database-page").append(temp);
				      }
				      ++dbCrtPageNum;
             	}else{
             		  var temp = '<li><a href="#">&laquo;</a></li>';
					  $("#database-page").append(temp);
		         	  for(var i=parseInt(dbCrtPageNum)+1; i<parseInt(dbCrtPageNum)+11; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#database-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#database-page").append(temp);
					  ++dbCrtPageNum;
             	}
             }
             $("#database-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--数据库
        }else{
        	//debugger;
        	if(size <= 4){//小于4，不需要分页
        	    $("#database-page").empty();
        	    $("#database-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
   	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--数据库
	      	    return;
	      	}else if(size <= 40){
	      	    $("#database-page").empty();
	      	    if(parseInt(index) < 11){
	      	        if((size%4)==0){
	      	        	for(var j=1; j<(parseInt(size/4)+1); j++){//小于8条，不加》
							var temp = '<li><a href="#">'+j +'</a></li>';
							$("#database-page").append(temp);
						}
	      	        }else{
		      	        for(var j=1; j<(parseInt(size/4)+2); j++){//小于8条，不加》
							var temp = '<li><a href="#">'+j +'</a></li>';
							$("#database-page").append(temp);
						}
	      	        }
	      	    }
	      	  $("#database-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
 	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--数据库
	      	}else{
	      		var toltalPage = Math.ceil(size/4);
	      		if(index == 1){
	      			$("#database-page").empty();
	      			for(var i=dbCrtPageNum; i<dbCrtPageNum+10; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#database-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#database-page").append(temp);
	      		}else if( index == 2){
	      			return;
	      		}else{
	      			if(index == dbCrtPageNum){
		      			return;
			      	}else if(index = toltalPage){
		      			return;
			      	}else{
			      		 $("#database-page").empty();
			         	  for(var i=dbCrtPageNum; i<dbCrtPageNum+10; i++){
				     		temp = '<li><a href="#">'+i +'</a></li>';
						    $("#database-page").append(temp);
					      }
					      temp = '<li><a href="#">&raquo;</a></li>';
						  $("#database-page").append(temp);
			      	}
	      		}
	      		$("#database-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	 	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--数据库
	      	}
        }
    }

    function databaseReset() {
    	radioReset("databaseSysClassify");
    	radioReset("databaseSys");
    	radioReset("dbSchema");
    	radioReset("dbDataType");//
        document.getElementById("DbMdName").value = "";
        dbbutton1 = "";
        dbbutton2 = "";
        dbbutton3 = "";
        dbbutton4 = "";
        dbTotalNum = "";
        dbCrtPageNum = 1;
        dbObj = [];
        dbSearch(1);
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
	
	//库表统浏览设置src url
    function buildDbCheckSrc(e){
    	setButtonVal(e, dbObj);
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
