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
      <div id="tab_interface">
            <div class="panel panel-default">
                <div class="panel-body">
                    <span class="sbar"></span><p id="systitle">查询设置</p>
                    <div class="row-list" id="div_interfaceSysCla">
                        <label>系统分类</label>
                        <span id="interfaceSysCla"></span>
                    </div>
                    <div class="row-list" id="div_interfaceSys">
                        <label>系&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统</label>
                        <span id="interfaceSys"></span>
                    </div>
                    <div class="row-list" id="div_fileDir">
                        <label>文件目录</label>
                        <span id="fileDir"></span>
                    </div>
                    <div class="row-list">
                        <form class="form-inline">
                            <label>接口名称</label>
                                <input type="text" class="form-control" id="interfaceName" placeholder="查找元数据">
                                <button class="btn btn-primary" type="button" onclick="interfaceSearch(1)">
                                  	 查询
                                </button>
	                            <button type="button" class="btn btn-primary" onclick="interfaceReset()">
	                            	          重置
	                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <span class="sbar"></span><p id="interfacetitle">结果列表</p>
                     <div style="overflow:auto;">
                        <div style="overflow:auto;">
	                    <div class="lg-well">
	                        <div class="well">
	                            <p class="w-head" id="interface-1-top"></p>
	                            <p class="w-body" id="interface-1-medium"></p>
	                            <p class="w-tail" id="interface-1-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="inter-1-btn">
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
	                            <p class="w-head" id="interface-2-top"></p>
	                            <p class="w-body" id="interface-2-medium"></p>
	                            <p class="w-tail" id="interface-2-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="inter-2-btn">
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
	                            <p class="w-head" id="interface-3-top"></p>
	                            <p class="w-body" id="interface-3-medium"></p>
	                            <p class="w-tail" id="interface-3-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="inter-3-btn">
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
	                            <p class="w-head" id="interface-4-top"></p>
	                            <p class="w-body" id="interface-4-medium"></p>
	                            <p class="w-tail" id="interface-4-down"></p>
	                            <ul class="nav nav-pills" role="tablist"  id="inter-4-btn">
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
                        <ul class="pagination" id="interface-page" onclick="interfacePage()" onmouseover="interfacePage()">
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
	      //按钮值缓存
   		interfaceButton1 = "";
	    interfaceButton2 = "";
	    interfaceButton3 = "";
	    var pathRoot = "";
	    function init(){
	    	 getWebRoot();//获取上下文路径
	    	 $("#interfaceSysCla,#interfaceSys,#fileDir").empty();
	        queryButtomAction("browserSysClassify", "interfaceSysCla",1);
	        queryButtomAction("browserSys", "interfaceSys",2);
	        queryButtomAction("browserInteFileDir", "fileDir",3);
	        interfaceSearch(interfaceCrtPageNum);
	        browseInterButtonBind();
	    }
	    
	        //系统tab按钮绑定
	    function browseInterButtonBind(){
	    	for(var i = 1; i < 5; i++){
	    		var tag = "#inter-" + i + "-btn";
	    		$(tag).bind("mousedown",function(event){
	    			buildInterfaceCheckSrc(event);
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
    
        interfaceTotalNum = "";  //接口查询总结果数量
    interfaceCrtPageNum = 1; //接口  当前页数
    interfaceObj = []; //接口对象
    function interfaceSearch(index) {
    	if(index == 1){
    		 interfaceTotalNum = ""; 
    		 interfaceCrtPageNum = 1; 
    		 interfaceObj = [];
    	}
        //获取系统分类
        var interfaceSysCla = $('#interfaceSysCla input:radio:checked').val();
        if (interfaceSysCla == undefined) {
            //console.log("查询全部");
        } else {
            interfaceButton1 = interfaceSysCla;
        }
        //获取系统分类
        var interfaceSys = $('#interfaceSys input:radio:checked').val();
        if (interfaceSys == undefined) {
            //console.log("查询全部");
        } else {
            interfaceButton2 = interfaceSys;
        }
        //获取负责人
        var logicModelfileDir = $('#logicModelfileDir input:radio:checked').val();
        if (logicModelfileDir == undefined) {
            //console.log("查询全部");
        } else {
            interfaceButton3 = logicModelfileDir;
        }
        var key = document.getElementById("interfaceName").value;
       // interface_grid.load({instanceName: key,sysClassifyId: interfaceButton1,sysId: interfaceButton2,fileDir: interfaceButton3});
        var pageIndex;
        var pageSize; 
        var totalPage = Math.ceil(interfaceTotalNum/4);
        if(index =="«"){
              if(interfaceCrtPageNum == 2){
                 pageIndex = 0;
                 pageSize = 4;
            }else{
            	pageIndex=interfaceCrtPageNum-1;
            	pageSize = 4;
            }
        }else if(index =="»"){
            pageIndex=(interfaceCrtPageNum-1) +1;
            pageSize = 4;
        }else if(index == 1){
	   	    pageIndex = 0;
	  	    pageSize = 4;
	  	    interfaceCrtPageNum = 1;
        }else if(index == totalPage && index != 1){
            pageIndex=index-1;
            pageSize = 4;
        }else if(interfaceCrtPageNum == 2){
       	    pageIndex = 0;
       	    pageSize = 4;
        }else if(index != null || index != undefined){
            pageIndex=index-1;
            pageSize = 4;
        }else{
        	pageIndex=0;
            pageSize = 4;
        }
        var param = {pageSize:pageSize,pageIndex:pageIndex,instanceName:key,sysClassifyId:interfaceButton1,sysId:interfaceButton2,fileDir:interfaceButton3};
        var url = pathRoot + "/browser.do?invoke=searchBrowserInterface";
    	 $.ajax({
             type: 'post',
             url: url,
             data: param,
             async: false,
             dataType: 'json',
             timeout: 40000,//40秒后超时
             success: function(data, textStatus) {
               buildInterfaceContent(data, index);
             },
             error: function(XMLHttpRequest, textStatus) {
                alert("error");
             }
         });
    }

	//接口文件构造内容
	var currentPagenum;//保存前一次显示位置
     function buildInterfaceContent(data, index){
        if(currentPagenum != 4){//id="system-1-btn"
     		for(var j=currentPagenum;j<4;j++){
     			var pos = j+1;
     			var btn = 'inter-' + pos + '-btn';
     			$("#" + btn).show();
     			//var btnTm = document.getElementById(btn);
     			//btnTm.innerHTML = '';
     		}
     	}
        interfaceTotalNum = data.total;
        var title = document.getElementById("interfacetitle");
        title.innerHTML = "";
      	title.innerHTML += "结果列表&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp总数为：" + interfaceTotalNum;
     	buildInterfacePage(data.total, index);
     	var result = data.data;
     	var page;
     	var totalPage = Math.ceil(interfaceTotalNum/4);
     	if(data.total <= 4){
     	    page = data.total;
     	}else{
     	    if(interfaceCrtPageNum == (totalPage)){//到最后一页
     	       page=interfaceTotalNum%4;
     	    }else{
     	        if(parseInt(index) == totalPage){
     	        	page=interfaceTotalNum%4;
     	        }else{
     	        	 page = 4;
     	        }
     	    }
     	}
     	for(var i = 0; i < 4; i++){
     	    var pos = i+1;
     		var top = 'interface-' + pos + '-top';
     		var medium = 'interface-' + pos + '-medium';
     		var down = 'interface-' + pos + '-down';
     		var topTm = document.getElementById(top);
     		var mediumTm = document.getElementById(medium);
     		var downTm = document.getElementById(down);
     		topTm.innerHTML = '';
     		mediumTm.innerHTML =  '';
     		downTm.innerHTML = '';
     	}
     	for(var i = 0; i < page; i++){
     	    var obj = result[i];
     	   interfaceObj[i] = obj;
     	    var pos = i+1;
     		var top = 'interface-' + pos + '-top';
     		var medium = 'interface-' + pos + '-medium';
     		var down = 'interface-' + pos + '-down';
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
     		topTm.innerHTML = '<small>接口名称：</small>' + obj.sysName+'&nbsp&nbsp&nbsp&nbsp<small>编码格式：</small>' + depart + '&nbsp&nbsp&nbsp&nbsp<small>分隔符：</small>' + person;
     		//topTm.innerHTML = '<small>系统名称：</small>' + obj.sysName+'&nbsp&nbsp&nbsp&nbsp<small>管理部门：</small>' + obj.mngDepart + '&nbsp&nbsp&nbsp&nbsp<small>负责人：</small>' + obj.chargePerson;
     		mediumTm.innerHTML =  '描述:' + describe+'&nbsp&nbsp&nbsp&nbsp存储路径：' + depart;
     		downTm.innerHTML = '上下文路径:' + obj.sysPath;
     	}
     	currentPagenum = page;//赋值当前页数
     	if(page != 4){//id="system-1-btn"
     		for(var j=page;j<4;j++){
     			var pos = j+1;
     			var btn = 'inter-' + pos + '-btn';
     			$("#" + btn).hide();
     			//var btnTm = document.getElementById(btn);
     			//btnTm.innerHTML = '';
     		}
     	}
     }
    
    //etl分页构建
     function buildInterfacePage(size, index){
    	 var totalPage = Math.ceil(size/4);
    	 if("»" == index || index =="«"){
             //var totalPage = Math.ceil(size/4);
             $("#interface-page").empty();
             if(index =="«"){
             	if(parseInt(interfaceCrtPageNum) == 2){
		         	  for(var i=parseInt(interfaceCrtPageNum)-1; i<parseInt(interfaceCrtPageNum)+1; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#interface-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#interface-page").append(temp);
					  --interfaceCrtPageNum;
             	}else{
             		  var temp = '<li><a href="#">&laquo;</a></li>';
					  $("#interface-page").append(temp);
		         	  for(var i=parseInt(interfaceCrtPageNum)-1; i<parseInt(interfaceCrtPageNum)+1; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#interface-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#interface-page").append(temp);
					   --interfaceCrtPageNum;
             	}
             }else if("»" == index){
             	if((parseInt(interfaceCrtPageNum)+2) == totalPage){
             		  var temp = '<li><a href="#">&laquo;</a></li>';
					  $("#interface-page").append(temp);
		         	  for(var i=totalPage-1; i<totalPage+1; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#interface-page").append(temp);
				      }
				      ++interfaceCrtPageNum;
             	}else{
             		  var temp = '<li><a href="#">&laquo;</a></li>';
					  $("#interface-page").append(temp);
		         	  for(var i=parseInt(interfaceCrtPageNum)+1; i<parseInt(interfaceCrtPageNum)+3; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#interface-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#interface-page").append(temp);
					  ++interfaceCrtPageNum;
             	}
             }
             $("#interface-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--interface
        }else{
        	if(size <= 4){//小于4，不需要分页
        	    $("#interface-page").empty();
        	    $("#interface-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
  	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--interface
	      	    return;
	      	}else if(size <= 8){
	      	    $("#interface-page").empty();
	      	    if(index ==1 || index ==2){
		      		for(var i=1; i<3; i++){//小于8条，不加》
						var temp = '<li><a href="#">'+i +'</a></li>';
						$("#interface-page").append(temp);
					}
	      	    }
	      	  $("#interface-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
	      			  +totalPage+"&nbsp;&nbsp;页</div>");//--interface
	      	}else{
	      		var toltalPage = Math.ceil(size/4);
	      		if(index == 1){
	      			$("#interface-page").empty();
	      			for(var i=interfaceCrtPageNum; i<interfaceCrtPageNum+2; i++){
			     		temp = '<li><a href="#">'+i +'</a></li>';
					    $("#interface-page").append(temp);
				      }
				      temp = '<li><a href="#">&raquo;</a></li>';
					  $("#interface-page").append(temp);
	      		}else if( index == 2){
	      			return;
	      		}else{
	      			if(index == interfaceCrtPageNum){
		      			return;
			      	}else if(index = toltalPage){
		      			return;
			      	}else{
			      		 $("#interface-page").empty();
			         	  for(var i=interfaceCrtPageNum; i<interfaceCrtPageNum+2; i++){
				     		temp = '<li><a href="#">'+i +'</a></li>';
						    $("#interface-page").append(temp);
					      }
					      temp = '<li><a href="#">&raquo;</a></li>';
						  $("#interface-page").append(temp);
			      	}
	      		}
	      		$("#interface-page").append("<div style='float:right;line-height:28px;padding-right:5px'>&nbsp;&nbsp;共&nbsp;&nbsp;"
		      			  +totalPage+"&nbsp;&nbsp;页</div>");//--interface
	      	}
        }
    }

    //指标按钮绑定事件
	function interfacePage(){
        	var obj_lis = document.getElementById("interface-page").getElementsByTagName("li");
			for (var i = 0; i < obj_lis.length; i++) {
				obj_lis[i].onclick = function() {
					var s = this.innerHTML;
					var temp = s.replace("<a href=\"#\">","").replace("</a>","");
					interfaceSearch(temp);
				}
			}
     }

    function interfaceReset() {
    	radioReset("interfaceSysCla");
    	radioReset("interfaceSys");
    	radioReset("fileDir");
        document.getElementById("interfaceName").value = "";
        interfaceTotalNum = "";
        interfaceCrtPageNum = 1;
        interfaceObj = [];
        interfaceSearch(1);
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
		
		//接口浏览设置src url
	    function buildInterfaceCheckSrc(e){
	    	setButtonVal(e, interfaceObj);
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
