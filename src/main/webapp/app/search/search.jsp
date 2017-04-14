<%@ page contentType="text/html; charset=UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<head>
<meta charset="utf-8">
<title>Search</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/search.css">
<style>
.btn-primary{
    color: #fff;
    background-color: #99c4e8;
    border-color: #99c4e8;
}
</style>
</head>

<body onload="showvalf()">

	<div class="container">
		<div class="a1">
			<a href="#" data-toggle="modal" data-target="#myModal">高级检索</a>
		</div>
		<div class="search-text">
			<div class="col-md-4 col-md-offset-5">
				<img src="../base/images/logo.jpg">
			</div>
			<div class="col-md-6 col-md-offset-3">
				<div class="input-group input-group-lg">
					<input type="text" class="form-control" id="testvalue" onkeyup="searchenter(event);"> 
					<span class="input-group-btn">
						<button id="submit" class="btn btn-default" type="button"
							style="padding-left: 40px;padding-right: 40px;"
							onclick="search()">检索</button>
					</span>
				</div>
			</div>
		</div>

		<div class="search-menu" id="testmain">
			<div class="col-md-offset-3">
				<ul id="_btnClick" class="nav nav-pills">
					<li><button type="button" class="btn btn-primary"
							onclick="viewSystem()">系统信息</button></li>
					<li><button type="button" class="btn btn-primary"
							onclick="viewReport()">报表信息</button></li>
					<li><button type="button" class="btn btn-primary"
							onclick="dataStandard()">数据标准</button></li>
					<li><button type="button" class="btn btn-primary"
							onclick="branchStaff()">组织机构与人员</button></li>
					<li><button type="button" class="btn btn-primary"
							onclick="viewDatabase()">数据库</button></li>
					<li><button type="button" class="btn btn-primary"
							onclick="physicsMm()">物理模型</button></li>
					<li><button type="button" class="btn btn-primary"
							onclick="moreOthers()">更多>></button></li>
				</ul>
			</div>
		</div>
		
			<div style="color:RoyalBlue;text-align:left;" class="total" id="totals"></div>
			<div style="text-align:left;" class="detail" id="details"></div>
		
		<div id="pagediv" hidden="hidden" class="pagenumbers"
			style="text-align:center;top:300px">
			<ul class="pagination" id="testpage" onmouseover="pageNumber()">
			</ul>
		</div>
	</div>
	<div class="hidebg"></div>
	<div class="topdiv">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header" style="background-color:#4682B4 ">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h5 class="modal-title" id="myModalLabel" style="color: #FFFFFF">
					高级查询
				</h5>
			</div>
			
			<div class="modal-body" style="height:260px;">
			<div class="wrap">
					<div class="row">
							<label  class="col-sm-2 control-label">元数据类型</label>
							<div class="col-sm-8">
								<input id="btnEdit1" class="nui-buttonedit" style="width:100%"
									onbuttonclick="onButtonEdit" />
							</div>
						</div>

                   <div class="row">
						
							<label   class="col-sm-2 control-label">元数据代码</label>
							<div class="col-sm-8">
								<input class="nui-textbox" style="width:100%" type="text" id="code" />
								</div>
							
						</div>
						<div class="row">
							<label class="col-sm-2 control-label">元数据名称</label>
							<div class="col-sm-8">
								<input class="nui-textbox" style="width:100%" type="text" id="name" />
							</div>
						</div>



						<div class="row">
							<label class="col-sm-2 control-label">元数据属性</label>
							<div class="col-sm-8">
								<form role="form">
									<div class="form-group">
										<select class="form-control" id="attrimenu" style="width:100%"
											onmouseover="getattri()">
										</select>
									</div>
								</form>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-offset-4 col-sm-4">
								<button type="button" class="btn btn-success"
									onclick="advancedSearch()" data-dismiss="modal">高级查询</button>
							</div>
						</div>
						</div>
			</div>
		</div>
	</div>
	</div>
	</div>
		    <div class="modal fade" id="summary" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                    <h5 class="modal-title">元数据详情</h5>
                </div>
                <div class="modal-body">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src=""></iframe>
                    </div>
                </div>

            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

</body>
<script type="text/javascript">

var typeid="";
var name1="";
var code1="";
var attribute="";
var view1="";

$("#attrimenu").empty();
nui.parse();
var codetext= nui.get("code");
	codetext.setValue("");
var nametext= nui.get("name");
	nametext.setValue("");
var attri1=$("#attrimenu option:selected");
var thisURL = decodeURI(document.URL);    
var  getval =thisURL.split('?')[1];  

var show1= getval.split("=")[1];  
var showval=show1.split("&")[0];
var show2=getval.split("=")[2];
var type2=show2.split("&")[0];
//alert(val2);
var show3=getval.split("=")[3];
var name2=show3.split("&")[0];
//alert("name"+name2);
var show4=getval.split("=")[4];
var code2=show4.split("&")[0];
//alert("code"+code2);
var attri2=getval.split("=")[5];
function  showvalf(){  

   
   if(type2!=null){
   document.getElementById("testvalue").value=name2;
   typeid=type2;
   //code1=code2;
   codetext.setValue(code2);
   //name1=name2;
   nametext.setValue(name2);
   attribute=attri2;
   advancedSearch();
 
  }else{
   if( document.getElementById("testvalue").value!="undefined"){
   document.getElementById("testvalue").value=showval;
   search();}
   }
} 

function viewSystem(){
	
	view1="[\"'view-system'\"]";
	if(typeid==""){
		name1= document.getElementById("testvalue").value;
		search();
	}else{
		name1 = nametext.getValue();
		advancedSearch();
		}
	
}
function viewReport(){
	
	view1="[\"'view-report'\"]";
	if(typeid==""){
		name1= document.getElementById("testvalue").value;
		search();
	}else{
		name1 = nametext.getValue();
		advancedSearch();
		}
}
function dataStandard(){
	
	view1="[\"'view-data-standard'\"]";
	if(typeid==""){
		name1= document.getElementById("testvalue").value;
		search();
	}else{
		name1 = nametext.getValue();
		advancedSearch();
		}
}
function branchStaff(){
	
	view1="[\"'view-branch-staff'\"]";
	if(typeid==""){
		name1= document.getElementById("testvalue").value;
		search();
	}else{
		name1 = nametext.getValue();
		advancedSearch();
		}
}
function viewDatabase(){
	
	view1="[\"'view-database'\"]";
	if(typeid==""){
		name1= document.getElementById("testvalue").value;
		search();
	}else{
		name1 = nametext.getValue();
		advancedSearch();
		}
}
function physicsMm(){
	
	view1="[\"'view-physics-mm'\"]";
	if(typeid==""){
		name1= document.getElementById("testvalue").value;
		search();
	}else{
		name1 = nametext.getValue();
		advancedSearch();
		}
}
function moreOthers(){
	
	view1="[\"'view-server'\",\"'view-cognos'\",\"'view-etl'\",\"'view-hadoop'\"]";
	if(typeid==""){
		name1= document.getElementById("testvalue").value;
		search();
	}else{
		name1 =nametext.getValue();
		advancedSearch();
		}
}
function searchenter(event) {
        name1= document.getElementById("testvalue").value;
        event = event || window.event;
        if (event.keyCode == 13) {
            if (name1== '') {
                return false;
            }           
           search();
        }
    }
function showCenter() {
	typeid="";
	name1="";
	code1="";
	attribute="";
	view1="";
 
    codetext.setValue("");
   nametext.setValue("");

	
	$("#attrimenu").empty();
	

}

function onButtonEdit(e) {
    var btnEdit = this;
  

    nui.open({
        url:"<%=request.getContextPath()%>/app/search/selectType.jsp",
        showMaxButton: false,
        title: "选择元数据类型",
        width: 350,
        height: 350,
        ondestroy: function (action) {
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.GetData();
                data = nui.clone(data);
                if (data) {
                    btnEdit.setValue(data.id);
                    btnEdit.setText(data.text);
                    //alert(data.id);
                    //alert(btnEdit.value);
                    typeid = btnEdit.value;
                }
                var jsonObject = {
                    "classifierId": typeid
                };
                var url = "<%=request.getContextPath()%>/query.do?invoke=getAttributeList";
                $.ajax({
                    url: url,
                    dataType: 'json',
                    type: 'post',
                    data: jsonObject,
                    async: true,
                    success: function (data) {
                        $("#attrimenu").empty();
                        var resultlist = data.list;
                        $.each(resultlist, function (index, value) {
                            var name1 = value.name;
                            //alert(name1);
                            var temp = " <option>" + name1 + "</option>";
                            $("#attrimenu").append(temp);
                        });
                    }
                });

            }
        }
    });
     
}


function getattri(){
     var attribute=document.getElementById("attrimenu").getElementsByTagName("option");
	for (i = 0; i < attribute.length; i++) {
     attribute[i].onclick = function() {		
     var options=$("#attrimenu option:selected");
 	    }
	}
   }

function advancedSearch(pageStart1){
     console.log(typeid);
     code1 = codetext.getValue();
	 console.log(code1);
	 name1 = nametext.getValue();
	 console.log(name1);
	 
	 attribute=attri1.text();
	 console.log(attribute);
	// document.getElementById("testvalue").value=name1;
	 document.getElementById("pagediv").removeAttribute("hidden");
		var pagestart;
		if (pageStart1 == undefined) {
			pagestart = 0;
		} else {
			pagestart = pageStart1;

		}
		if(typeid==""){
		alert("请选择要查询的元数据类型！");
		codetext.setValue("");
        nametext.setValue("");
		return;
	}
		//    var val = '"'+v+'"';
		var jsonObject = {
			"start" : pagestart,
			"limit" : 10,
			"instanceName" : name1,
			"searchType" : "off",
			"viewIds" : view1,
			"searchMode" : 2,
			"count" : 0,
			"classifierId":typeid,
			"instanceCode":code1,
			"features":"[]"
		};
		var url = "<%=request.getContextPath()%>/query.do?invoke=search";
		$.ajax({
			url : url,
			dataType : 'json',
			type : 'post',
			data : jsonObject,
			async : true,
			success : function(data) {
				$("#totals").empty();
				$("#details").empty();
				var resultlist = data.list;
				var totalcount1 = data.totalCount;
				if(totalcount1==0){
				var pagenum=0;}else{
				pagenum = parseInt(data.totalCount /10 )+ 1;}
				var spend1 = data.spend;
				$("#totals").append(
						"<h>耗费时间" + spend1 + "秒</h>" + "&nbsp;" + "<h>为您找到相关结果"
								+ totalcount1 + "个</h>" + "&nbsp;"+"<h>共"+pagenum+"页</h>").append("</br>");

				$.each(resultlist, function(index, value) {
				    var instanceId=value.instanceId;
					var classifiername1 = value.classifierName;
					var instanceCode1 = value.instanceCode;
					var instancename1 = value.instanceName;
					
                    var namespace=value.parents;
                    

					$("#details").append("<div>").append(
							"<h>" + classifiername1 + "</h>").append(
							"&nbsp;&nbsp;&nbsp;&nbsp;").append(
							"<a href=\"javascript:show1('"+instanceId+"')\">" + instanceCode1
									+ "</a>")
							.append("&nbsp;&nbsp;&nbsp;&nbsp;").append(
									"<h>" + instancename1 + "</h>").append(
									"&nbsp;&nbsp;&nbsp;&nbsp;");
					 $.each(namespace,function(index,value1){
                      var parent=value1.instanceCode;
                      var parentId=value1.instanceId;
						$("#details").append("/").append("<a href=\"javascript:show('"+parentId+"')\">" + parent
									+ "</a>");
                    });
                    $("#details").append("</br>").append("</br>").append("</div>");

				});
				
				
				var i = pagestart / 10 + 1;
				if (i == 1) {
					//alert(i);
					$("#testpage").empty();
					for (var j = 1; j < 6; j++) {
                        if (j > pagenum) {

							break;
						}
						var temp = " <li><a href=\"#\">" + j + "</a></li>";
						$("#testpage").append(temp);
						
						if (j > 6) {
							break;
						}
					}
				
				} else if (i < 5) {
					//alert(i);
					$("#testpage").empty();
					/* var tem = "<li><a href=\"#\">上一页</a></li>";
					$("#testpage").append(tem); */
					for (var j = 1; j < 6; j++) {
                        if (j > pagenum) {

							break;
						}
						var temp = " <li><a href=\"#\">" + j + "</a></li>";
						$("#testpage").append(temp);
						
						if (j > 6) {
							break;
						}
					}
					/* var tem1 = "<li><a href=\"#\">下一页</a></li>";
					$("#testpage").append(tem1); */
				} else if (4 < i && i < (pagenum - 1)) {
					//alert(9);
					$("#testpage").empty();
					var tem = "<li><a href=\"#\">上一页</a></li>";
					$("#testpage").append(tem);
					for (var j = 0; j < 5; j++) {

						var temp = " <li><a href=\"#\">" + (i - 2)
								+ "</a></li>";
						$("#testpage").append(temp);
						i++;
						if ((i - 2) > pagenum) {
							break;
						}
					}
					var tem1 = "<li><a href=\"#\">下一页</a></li>";
					$("#testpage").append(tem1);
				} else {
                    //alert(a);
					$("#testpage").empty();
					var tem = "<li><a href=\"#\">上一页</a></li>";
					$("#testpage").append(tem);
					for (var j = 0; j < 5; j++) {

						var temp = " <li><a href=\"#\">" + (i - 2)
								+ "</a></li>";
						$("#testpage").append(temp);
						i++;
						if ((i - 2) > pagenum) {
							break;
						}
					}

				}

			}
				
		
		});
	

	
}

	function pageNumber() {
		var obj_lis = document.getElementById("testpage").getElementsByTagName(
				"li");
        
		for (var i = 0; i < obj_lis.length; i++) {
			obj_lis[i].onclick = function() {
				console.log(this.innerHTML);
				var s = this.innerHTML;
				//alert(s);
			    var w = s.replace("<a href=\"#\">","").replace("</a>","");
			   
				if(w=="上一页")
				{
			    start = start-10;
			    //alert(start);
				if(typeid==""){
				
					name1= document.getElementById("testvalue").value;
					search(start);
				}else{
					name1 = nametext.getValue();
					advancedSearch(start);
					}
				}else if(w=="下一页"){
				
				start = start+10;
				if(typeid==""){
					name1= document.getElementById("testvalue").value;
					search(start);
				}else{
					name1 = nametext.getValue();
					advancedSearch(start);
					}
				}
				else{
				
				start =10* (w - 1) ;
				if(typeid==""){
					name1= document.getElementById("testvalue").value;
					search(start);
				}else{
					name1 = nametext.getValue();
					advancedSearch(start);
					}

			}
			}
		}
	}
	
	
	
	function search(pageStart1) {
        name1="";
        typeid="";
        name1= document.getElementById("testvalue").value;
        if(name1==""||name1==" "||name1=="  "||name1=="   "||name1=="    "||name1=="     "){
        //alert("请输入检索条件！");
        return;
        }
		document.getElementById("pagediv").removeAttribute("hidden");
		var pagestart;
		if (pageStart1 == undefined) {
			pagestart = 0;
		} else {
			pagestart = pageStart1;

		}
		//    var val = '"'+v+'"';
		var jsonObject = {
			"start" : pagestart,
			"limit" : 10,
			"instanceName" : name1,
			"searchType" : "off",
			"viewIds" : view1,
			"searchMode" : 1,
			"count" : 0,
			
		};
		var url = "<%=request.getContextPath()%>/query.do?invoke=search";
		$.ajax({
			url : url,
			dataType : 'json',
			type : 'post',
			data : jsonObject,
			async : true,
			success : function(data) {
				//var pageSize = $("#paginations").attr("pageSize");
				$("#totals").empty();
				$("#details").empty();
				var resultlist = data.list;
				var totalcount1 = data.totalCount;
				if(totalcount1==0){
				var pagenum=0;}else{
				pagenum = parseInt(data.totalCount /10 )+ 1;}
				var spend1 = data.spend;
				$("#totals").append(
						"<h>耗费时间" + spend1 + "秒</h>" + "&nbsp;" + "<h>为您找到相关结果"
								+ totalcount1 + "个</h>" + "&nbsp;"+"<h>共"+pagenum+"页</h>");

				$.each(resultlist, function(index, value) {
				    var instanceId1=value.instanceId;
					var classifiername1 = value.classifierName;
					var instanceCode1 = value.instanceCode;
					var instancename1 = value.instanceName;
					
					var namespace = value.parents;
					
					$("#details").append("<div>").append(
							"<h>" + classifiername1 + "</h>").append(
							"&nbsp;&nbsp;&nbsp;&nbsp;").append(
							"<a href=\"javascript:show('"+instanceId1+"')\">" + instanceCode1
									+ "</a>")
							.append("&nbsp;&nbsp;&nbsp;&nbsp;").append(
									"<h>" + instancename1 + "</h>").append(
									"&nbsp;&nbsp;&nbsp;&nbsp;");
									
									
							
                  $.each(namespace, function(index, value1) {
						var parent = value1.instanceCode;
						var parentId=value1.instanceId;
						$("#details").append("/").append("<a href=\"javascript:show('"+parentId+"')\">" + parent
									+ "</a>");
						
					});
				$("#details").append("</br>").append("</br>").append("</div>");
				});
			
				var i = pagestart / 10 + 1;
				if (i == 1) {
					//alert(i);
					$("#testpage").empty();
					for (var j = 1; j < 6; j++) {
                        if (j > pagenum) {

							break;
						}
						var temp = " <li><a href=\"#\">" + j + "</a></li>";
						$("#testpage").append(temp);
						
						if (j > 6) {
							break;
						}
					}
				
				} else if (i < 5) {
					//alert(i);
					$("#testpage").empty();
				
					for (var j = 1; j < 6; j++) {
                        if (j > pagenum) {

							break;
						}
						var temp = " <li><a href=\"#\">" + j + "</a></li>";
						$("#testpage").append(temp);
						
						if (j > 6) {
							break;
						}
					}
					
					
				} else if (4 < i && i < (pagenum - 1)) {
					//alert(9);
					$("#testpage").empty();
					var tem = "<li><a href=\"#\">上一页</a></li>";
					$("#testpage").append(tem);
					for (var j = 0; j < 5; j++) {

						var temp = " <li><a href=\"#\">" + (i - 2)
								+ "</a></li>";
						$("#testpage").append(temp);
						i++;
						if ((i - 2) > pagenum) {
							break;
						}
					}
					var tem1 = "<li><a href=\"#\">下一页</a></li>";
					$("#testpage").append(tem1);
				} else {
                    //alert(a);
					$("#testpage").empty();
					var tem = "<li><a href=\"#\">上一页</a></li>";
					$("#testpage").append(tem);
					for (var j = 0; j < 5; j++) {

						var temp = " <li><a href=\"#\">" + (i - 2)
								+ "</a></li>";
						$("#testpage").append(temp);
						i++;
						if ((i - 2) > pagenum) {
							break;
						}
					}

				}

			}
		});

	}
	
	function show(instanceId1){
	//alert("a");
	
	 var url = "../browse/metadataDetail.jsp?id='"+instanceId1+"'";
        $('#summary iframe').attr('src',url);
        jQuery.noConflict();
        $('#summary').modal('show');}
       function show1(instanceId){
	//alert("a");
	
	 var url = "../browse/metadataDetail.jsp?id='"+instanceId+"'";
        $('#summary iframe').attr('src',url);
        jQuery.noConflict();
        $('#summary').modal('show');}
</script>

</html>
