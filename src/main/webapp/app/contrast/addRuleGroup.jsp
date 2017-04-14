<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>

<html>
<head>
<title>新增规则组</title>
	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="app/base/css/addRule.css">
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


<div class="panel panel-info">
	<div class="panel-body"style="height:200px">
    <div id="form1" >
	<br>
    &nbsp;&nbsp;&nbsp;规则组编号:
    	<input id="groupCodeTextBox"  name="groupCode" class="nui-textbox" required="true" 
    		value="" allowInput="false"
    	/>
    	&nbsp;&nbsp;&nbsp;规则组名称:
    	<input id="groupNameTextBox"  name="groupName" class="nui-textbox" required="true" />
    	<br/>
    	<br>
    	&nbsp;&nbsp;&nbsp;创建人:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	<input id="createUserIdTextBox"  name="createUserId" class="nui-textbox"  required="true" 
    		value="<%=currentUser.getUserName()%>" allowInput="false"
    	/>
    	&nbsp;&nbsp;&nbsp;创建时间:&nbsp;&nbsp;&nbsp;
    	<input id="createTimeTextBox"  name="createTime" class="nui-textbox" required="true" 
    		value= "" allowInput="false"
    	/>
		<br/>
        <br>&nbsp;&nbsp;&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:&nbsp;&nbsp;&nbsp;
    	<input id="groupDescTextBox"  name="groupDesc" class="nui-textbox" /><br/><br/>
		
		<br/>

    </div>
</div>	
</div>
<div style="margin-top:30px">
			<button id="searchBtn" class="btn btn-primary blue" style="margin-left:280px"  onclick="submitForm()" >保存</button>
		</div>
<script language="javascript">
	nui.parse();
	// 设置创建时间
	var createTimeTextBox = nui.get("createTimeTextBox");
	var currentTime = new Date();
	createTimeTextBox.value = nui.formatDate(currentTime,"yyyy-MM-dd HH:mm:ss");
	// 设置新增规则组编号
	var newGroupCode = "<%=request.getParameter("newCode") %>";
	var groupCodeTextBox = nui.get("groupCodeTextBox");
	groupCodeTextBox.value = newGroupCode;
	/**********************************************************************************/
    function submitForm() {	
		//获取表单多个控件的数据
        var form = new nui.Form("#form1");
        var data = form.getData();
 		
		var groupCode = data.groupCode;
      	var groupName = data.groupName;
      	var createUserId = data.createUserId;
      	var createTime = nui.parseDate(data.createTime).getTime();
 		var groupDesc = data.groupDesc;
 		if(groupName==null || groupName == ""){
 	 		nui.alert("请输入规则组名称！");
 	 		return false;
 		}
        nui.ajax({
            url: "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=addRuleGroup" ,
            type: "post",
            data:{
           	 	groupCode : groupCode,
            	groupName : groupName,
            	createUserId  : createUserId,
            	createTime : createTime,
            	groupDesc : groupDesc
            },
            success: function (text) {
                nui.alert("保存成功","",function(action){
                	onclose();
                });
            }
        });
    }
    
    function onclose(){
	    parent.closeModal();
	}
</script>
</body>
</html>