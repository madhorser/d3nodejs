<!DOCTYPE html>
<html>
<head>
    <%@page pageEncoding="UTF-8"%>
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
   <title>ECharts</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/user.css">
</head>

<body>
<div class="left">
    <ul id="myTab" class="nav nav-pills nav-stacked">
        <li class="active"><a href="#basicInfo" data-toggle="tab"
                                   id="home_tab">基本信息</a></li>
        <li class="tabs"><a href="#password" data-toggle="tab"
                            id="v_tab">修改密码</a></li>
    </ul>
</div>
<div class="right">
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane active" id="basicInfo">

            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <img src="<%=request.getContextPath()%>/app/base/images/head.png">
                </div>
                <div class="form-group">
                    <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <input type="text" class="form-control" id="email"
                               placeholder="">
                </div>
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">用户名</label>
                        <input type="text" class="form-control" id="username">
                </div>
                <div class="form-group">
                    <label for="mobile" class="col-sm-2 control-label">手机号</label>
                        <input type="text" class="form-control" id="mobile">
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-primary " onclick="basic()">
                        保存</button>
                </div>
            </form>
        </div>
        <div class="tab-pane" id="password">
            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="oldpassword" class="col-sm-2 control-label">旧密码</label>
                        <input type="text" class="form-control" id="oldpassword">
                </div>

                <div class="form-group">
                    <label for="newpassword" class="col-sm-2 control-label">新密码</label>
                        <input type="text" class="form-control" id="newpassword">
                </div>
                <div class="form-group">
                    <label for="ensure" class="col-sm-2 control-label">确认新密码</label>
                        <input type="text" class="form-control" id="ensure">
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-primary" onclick="changpw()">保存</button>
                </div>
			</form>
        </div>
    </div>

</div>

</body>
<script type="text/javascript">
document.getElementById("username").value = "";
document.getElementById("email").value = "";
document.getElementById("mobile").value = "";
document.getElementById("oldpassword").value = "";
document.getElementById("newpassword").value = "";
document.getElementById("ensure").value = "";
var userid = getCookie("ys-username");
function basic() {
    var username = document.getElementById("username").value;
    if(username==""){
    	alert("用户名不能为空");
    	return;
    }
    var email = document.getElementById("email").value;
    var mobile = document.getElementById("mobile").value;
//alert(username);
    var url = "<%=request.getContextPath()%>/userInfo.do?invoke=basicInfo";
    var jsonObject = {
        "username": username,
        "email": email,
        "mobile": mobile,
        "userId": userid
    };
    $.ajax({
        url: url,
        dataType: 'json',
        type: 'post',
        async: true,
        data: jsonObject,
        success: function (data) {
        	alert("修改信息成功！");
        }
    });

}

function changpw() {
    var oldpassword = document.getElementById("oldpassword").value;
    var newpassword = document.getElementById("newpassword").value;
    var ensure = document.getElementById("ensure").value;
    var url = "<%=request.getContextPath()%>/userInfo.do?invoke=changePassword";
    if (newpassword != ensure) {
        alert("请重新输入并确认新密码！");
    } else {
        var jsonObject = {
            "oldpassword": oldpassword,
            "newpassword": newpassword,
            "ensure": ensure,
            //"userId" : userid
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
                var result = data.success;
                var msg = data.msg;
                if (result == false) {
                    alert(msg);
                } else {
                    alert("修改密码成功！");
                }
            }
        });

    }
}

function getCookie(cookie_name) {
    var allcookies = document.cookie;
    var cookie_pos = allcookies.indexOf(cookie_name); //索引的长度

    // 如果找到了索引，就代表cookie存在，
    // 反之，就说明不存在。
    if (cookie_pos != -1) {
        // 把cookie_pos放在值的开始，只要给值加1即可。
        cookie_pos += cookie_name.length + 1;
        var cookie_end = allcookies.indexOf(";", cookie_pos);

        if (cookie_end == -1) {
            cookie_end = allcookies.length;
        }

        var value = unescape(allcookies.substring(cookie_pos, cookie_end)); //这里就可以得到你想要的cookie的值了。。。
    }
    return value;
}
</script>
</html>
