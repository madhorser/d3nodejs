<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/packages.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>新增变更单</title>
	<!--NUI-->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
	<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
	<script src="<%= path%>/app/base/js/jquery-form.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/addModelChangeList.css">
	
	<!-- datagrid 中校验时需要的样式 -->
	<style type="text/css">
	    .unfinished
	    {
	        color:blue;
	    }
	    .repeated
	    {
	        color:red;
	    } 
    </style>
</head>
<body>
	<form id="form1" enctype="multipart/form-data" method="post" id="fileForm" name="fileForm">
		<div class="panel panel-info" style="margin-top:10px">
			<div class="panel-body" style="height:150px">
				<br>
				&nbsp;&nbsp;系统环境&nbsp;&nbsp;
				<input id="combobox1" class="nui-combobox" style="width:150px;" textField="instanceName" 
							valueField="instanceId" allowInput="false" onvaluechanged="getCatalogList"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;创建人
				<input id="createUserIdTextBox"  name="createUserId" class="nui-textbox"  required="true" style="width:150px;"
					   value=<%=currentUser.getUserId()%> allowInput="false"/>
				<br/>
				<br/>
				&nbsp;&nbsp;上传附件&nbsp;&nbsp;
				<input type="file" name="filename" size="100"/>
			</div>
		</div>
		<div style="margin-top:30px">
			<input id="btnsubmit" class="btn btn-primary blue" style="margin-left:150px" type="button"  onclick="saveBtn();" value="保存">
			<input id="btnsubmit" class="btn btn-primary blue" style="margin-left:50px" type="button"  onclick="subimtBtn();" value="提交">
			<input id="btnsubmit" class="btn btn-primary blue" style="margin-left:50px" type="button"  onclick="cancelBtn();" value="取消">
		</div>
</form>
</body>

<script type="text/javascript">
	nui.parse();   		
    var combo = nui.get("combobox1");
	var url = "<%=request.getContextPath()%>/modelChange.do?invoke=getCatalogList";
	combo.load(url);
       function getCatalogList() {
		var catalogId = combo.getValue();		
		var url = "<%=request.getContextPath()%>/modelChange.do?invoke=getCatalogList";
		nui.ajax({
            url: url,
            type: "post",
          
            success: function (text) {
            	var data = nui.decode(text).data;
				
				increasable = true;
            }
        });
        
    }

   function submitC(callback){
   	   var combo = nui.get("combobox1");
   	   var catalogId = combo.getValue();		
       var f=document.getElementById("form1");
       f.action="<%=request.getContextPath()%>/modelChange.do?invoke=importFile&catalogId="+catalogId;  
   	   document.getElementById("form1").submit();
   }
       
    function saveBtn() {
    	showMask();
    	var combo = nui.get("combobox1");
 	   	var catalogId = combo.getValue();		
        var form = $("form[name=fileForm]");
  		var url="<%=request.getContextPath()%>/modelChange.do?invoke=importFile&catalogId="+catalogId; 
        var options  = {
             url:url,    
             type:'post',    
             success:function(data)    
             {    
                 var jsondata = eval("("+data+")");  
                 if(jsondata.error == "0"){  
                    var msg = jsondata.msg;  
                    nui.showMessageBox({
                         title: "提示",
                         iconCls: "nui-messagebox-question",
                         buttons: ["ok"],
                         message: msg,
                         callback: function (action) {
                        	 onclose();
                        	 hideMask();
                         }
                    });
                    return;
                 }else{  
                     var msg = jsondata.msg;  
                     nui.showMessageBox({
                         title: "提示",
                         iconCls: "nui-messagebox-question",
                         buttons: ["ok"],
                         message: msg,
                         callback: function (action) {
                        	 onclose();
                        	 hideMask();
                         }
                     });
                 }
             }    
         };    
         form.ajaxSubmit(options);   
     }
       
     function onclose(){
  		parent.closeModal();
     }
       
     function subimtBtn(){
    	 showMask();
    	var combo = nui.get("combobox1");
  	   	var catalogId = combo.getValue();		
        var form = $("form[name=fileForm]");  
   		var url="<%=request.getContextPath()%>/modelChange.do?invoke=importAndSubmitChanges&catalogId="+catalogId; 
        var options  = {
            url:url,    
            type:'post',    
            success:function(data)    
            {
                var jsondata = eval("("+data+")");  
                if(jsondata.error == "0"){  
                	 //调用提交请求方法
					var msg = jsondata.msg;  
                    nui.showMessageBox({
                         title: "提示",
                         iconCls: "nui-messagebox-question",
                         buttons: ["ok"],
                         message: msg,
                         callback: function (action) {
                        	 onclose();
                        	 hideMask();
                         }
                    });
					return;
                }else{  
                    var msg = jsondata.msg;  
                    nui.showMessageBox({
                    	width: 80,
                    	title: "提示",
                        iconCls: "nui-messagebox-question",
                        buttons: ["ok"],
                        message: msg,
                        callback: function (action) {
                       	 	onclose();
                       	 	hideMask();
                        }
                    });
                }  
            }    
          };    
          form.ajaxSubmit(options);  
     }
     //显示遮罩层
     function showMask(){     
         $("#addChange").css("height",$(document).height());     
         $("#addChange").css("width",$(document).width());     
         $("#addChange").show();     
     }  
     //隐藏遮罩层  
     function hideMask(){
     	 $("#addChange").hide();     
     }  
     
     function cancelBtn(){
  	   onclose();
     }
</script>
</html>
