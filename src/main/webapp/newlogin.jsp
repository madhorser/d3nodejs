<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<%@page import="com.primeton.dgs.web.command.util.StringUtil"%>
<fmt:setBundle basename="resource.login_page" />
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<TITLE><fmt:message key="system.name"/></TITLE>
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="app/base/css/login.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/md5.js"></script>

</HEAD>
<%
String md5RandomKey = StringUtil.getRandomNum(10);
request.setAttribute("md5RandomKey",md5RandomKey);
 %>
<BODY>
<div class="content">
    <div class="login-bg"></div>
    <div class="loginPage">
		<FORM id="frmLogin" method="post" action="<%=request.getContextPath()%>/showlogin.do">
			<INPUT type="hidden" name="MetaCude" id="MetaCude"  value ="MetaCude6.0" >
			<img src="app/base/images/skin/loginlogo.png">
            <div class="panel">
                <div class="panel-body">
                    <h4>用户登录</h4><br/>
                    <div class="form-group">
                        <label for="userName" class="sr-only">UserName</label>
                        <input type="text" name="un" id="un" class="form-control" tabindex="1" onblur="fBlurInput(this)" onfocus="fFocusInput(this)"></TD>
                    </div><br/>
                    <div class="form-group">
                        <label for="password" class="sr-only">Password</label>
                        <input type="password" name="tt" id="tt"  value =""  class="form-control">
                    </div>
                    <input type="hidden" name="hpwd" id="hpwd"  value ="" >
                    <input type="hidden" name="md5RandomKey" id="md5RandomKey"  value ="" >
                    <a href="#" onclick="forget();">忘记密码？</a>
                    <tr>
                        <TD height="0" colspan="3"><span id="spanMessage" style="font-size: 12px;"></span></TD>
                    </tr>
                    <br/><br/><br/>
                    <button type="button" class="btn btn-primary btn-block" onClick="login();">登录</button>
					<input type="hidden" name="ndlogin"
					id="ndlogin" value="no">
                </div>

            </div>

    	</FORM>
	</div>
</BODY>
<SCRIPT LANGUAGE="JavaScript" defer="defer">
function hiddenPass(e){
     e = e ? e : window.event; 
     var kcode = e.which ? e.which : e.keyCode;
     var m_pass = document.getElementById("tt");
     var j_pass = document.getElementById("hpwd");
     if(kcode!=8){
	     var keychar=String.fromCharCode(kcode);
	     j_pass.value=j_pass.value+keychar;
	     j_pass.value=j_pass.value.substring(0,m_pass.length);
     }
}

function login(){
    var frm = document.getElementById("frmLogin") ;
    if (validate()){
		 var md5RandomKey='<%=md5RandomKey%>';
         var passWd = MD5(MD5(document.getElementById("tt").value)+md5RandomKey);
    	 document.getElementById("hpwd").value = passWd+md5RandomKey+Ext.get("un").getValue();
    	 document.getElementById("md5RandomKey").value=md5RandomKey;
	     if (parent) { //Session timeout
	           frm.target = "_parent" ;
	     }
	     frm.action="showlogin.do";
	     frm.method= 'POST';  
	     frm.submit();
    }
}

function validate(frm){
    var username = document.getElementById("un");
    var password = document.getElementById("tt");
    if (username.value.isEmpty()) {
        showMessage('<fmt:message key="required.username"/>');
        username.select();
        return false;
    }
    if (password.value.length == 0) {
        showMessage('<fmt:message key="required.password"/>');
        password.select();
        return false;
    }
    return true ;
}

function forget(){
	alert("请联系系统管理员！");//简单处理 
}

function reset() {
    document.getElementById("frmLogin").reset();  
}

Ext.onReady(function(){
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    try {
        showMessage("${LOGIN_MSG}");
    } catch(e) {
        
    }
    Ext.getDoc().addKeyListener(Ext.EventObject.ENTER,
        function(k,e){e.stopEvent(); login();}
    );
    if (Ext.type(Ext.state.Manager.get("un")) !== false) {
        document.getElementById("un").value = Ext.state.Manager.get("un");
    }
    document.getElementById("un").focus();
});

function fBlurInput(input) {
	Ext.fly(input).removeClass('login-input-focus');
}
function fFocusInput(input) {
    Ext.fly(input).addClass('login-input-focus');
}
</SCRIPT>
</HTML>