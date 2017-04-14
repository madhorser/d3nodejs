<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>

<!DOCTYPE html />
<html>
<head>
<title>新增规则</title>
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
<%
if(request.getSession().getAttribute(UserProfile.KEY)==null){ //获取失败，session过期处理 
    HttpServletResponse rep = (HttpServletResponse) response;
    //rep.sendRedirect("../login.do");
}else{
	UserProfile usen = (UserProfile)request.getSession().getAttribute(UserProfile.KEY);
	usen.getUserName();
}
%>
<body>
	<div class="panel panel-info">
		<div class="panel-body">
			<div id="form1" >

				&nbsp;&nbsp;&nbsp;规则编号
				<input id="ruleCodeTextBox"  name="ruleCode" class="nui-textbox" required="true" style="width:150px;"
					   value=""
					   allowInput="false"
				/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				规则名称
				<input id="ruleNameTextBox"  name="ruleName" class="nui-textbox" style="width:150px;" required="true" />
				<br/>
				<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;创建人
				<input id="createUserIdTextBox"  name="createUserId" class="nui-textbox"  required="true" style="width:150px;"
					   value="<%=currentUser.getUserName()%>"
				allowInput="false"
				/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				创建时间
				<input id="createTimeTextBox"  name="createTime" class="nui-textbox" style="width:150px;" required="true"
					   value= ""
					   allowInput="false"
				/>
				<br/>
				<br/>
				&nbsp;&nbsp;&nbsp;规则类型
				<input id="typeCombobox" name="ruleType" class="nui-combobox" style="width:150px;" textField="text" valueField="id" value="0"
					   allowInput="false"
				/>
				&nbsp;&nbsp;&nbsp;从其他规则复制
				<input id="ruleCombox" class="nui-combobox" style="width:150px;" textField="ruleName" valueField="ruleId"
					   allowInput="false" showNullItem="true"
				/>
			</div>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-body">
			<p class="p-head"><span></span>结果列表
				<button id="searchBtn" class="btn btn-primary" onclick="submitForm()">保存</button>
				&nbsp;&nbsp;&nbsp;
				<button id="deleteBtn" class="btn btn-primary" onclick="onDelete()">删除</button>
				&nbsp;&nbsp;&nbsp;

				<button id="copyBtn" class="btn btn-primary" onclick="onCopy()">复制一行</button>
				&nbsp;&nbsp;&nbsp;
				<button id="addBtn" class="btn btn-primary" onclick="newRow()">新增</button>

			</p>
			<div class="well">
                <div id="datagrid1" name="grid" class="nui-datagrid" style="width:800px;height:280px;" allowResize="true"
                     allowCellEdit="true" allowCellSelect="true" editNextRowCell="true"  multiSelect="true" showReloadButton="false">
                    <div property="columns">
                        <div type="checkcolumn" ></div>
                        <div type="indexcolumn" ></div>
                        <div field="attrName" name="attrName" width="120" align="center" headerAlign="center">属性名称
                            <input property="editor" class="nui-textbox" style="width:100%;"/>
                        </div>
                        <div field="attrCode" name="attrCode" width="120" align="center" headerAlign="center">属性代码
                            <input property="editor" class="nui-textbox" style="width:100%;"/>
                        </div>
                    </div>
                </div>
			</div>
		</div>
	</div>

    

<script language="javascript">
	nui.parse();
	// 设置规则类型下拉列表，默认全量比对
	var types = [
	    { "id": "0", "text": "全量比对" },
	    { "id": "1", "text": "只比较基本信息" },
	    { "id": "2", "text": "只比较属性信息" },
	];
	var typeCombobox = nui.get("typeCombobox");
	typeCombobox.setData(types);
	// 设置复制规则选择下拉列表
	var ruleCombox = nui.get("ruleCombox");
	var url = "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listContrastRule";
	ruleCombox.load(url);

	// 获得ruleCode最大值，设置新增规则Code
	var c = ruleCombox.getData();
	var ruleCodeTextBox = nui.get("ruleCodeTextBox");
	if(typeof(c) == "undefined" || c.length == 0){
		ruleCodeTextBox.value = "gz001";
	}else{
		var max = "gz000";
		for(var i=0;i<c.length;i++){
			if(c[i].ruleCode >= max){
				max = c[i].ruleCode;
			}
		}
		var maxNum = "" + (parseInt(max.substr(2,3))+1);
		var text = "gz";
		for(var i=0;i<3-maxNum.length;i++)text += "0";
		ruleCodeTextBox.value = text + maxNum;
	}

	// 设置新增规则生成时间
	var createTimeTextBox = nui.get("createTimeTextBox");
	var currentTime = new Date();
	createTimeTextBox.value = nui.formatDate(currentTime,"yyyy-MM-dd HH:mm:ss");

	var grid = nui.get("datagrid1");

	var attrArray = [];
	var baseArray = [
		{attrName : "元数据代码", attrCode : "instanceCode", isBase : "1"},
		{attrName : "元数据名称", attrCode : "instanceName", isBase : "1"},
		{attrName : "开始时间", attrCode : "startTime", isBase : "1"},
		{attrName : "结束时间", attrCode : "endTime", isBase : "1"}
	];

	// 数据提交前进行校验
	grid.on("cellcommitedit", function(e){

		var rowIndex = e.rowIndex;
		var row = grid.getRow(rowIndex);
		// 键入空值时做恢复用
		var attrName = row.attrName;
		var attrCode = row.attrCode;
		if(e.field == "attrName")row.attrName = e.value;
		if(e.field == "attrCode")row.attrCode = e.value;

		if(typeof(row.attrCode) == "undefined" || typeof(row.attrName) == "undefined")return;
		if(row.attrCode == "" || row.attrName == ""){
			e.cancel = true;
			if(e.field == "attrName")row.attrName = attrName;
			if(e.field == "attrCode")row.attrCode = attrCode;
			nui.alert("不允许键入空值");
			return;
		}else{
			if(e.cancel);
			else {
				var pushFlag = true;
				for(var i=0;i<attrArray.length;i++){
					var attr = attrArray[i];
					if(row._uid == attr._uid ){
						pushFlag = false;
						break;
					}
				}
				if(pushFlag)attrArray.push(row);
			}
		}
	});


	ruleCombox.on("valuechanged", function(e) {
		var ruleId = ruleCombox.getValue();
		if(ruleId == ""){
			grid.setData(attrArray);
		}else{
			var url = "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=listRuleAttr&ruleId=" + ruleId;
			nui.ajax({
	            url: url,
	            type: "post",
	            data:{
	           	 	ruleId : ruleId
	            },
	            success: function (text) {
	            	var data = nui.decode(text).data;
					grid.setData(data.concat(attrArray));
	            }
	        });
        }
	});

	typeCombobox.on("valuechanged", function(e) {
		var type = typeCombobox.getValue();
		switch (type){
		case "1" :
			// 只比较基本信息
			grid.setData(baseArray);
			grid.allowCellEdit = false;
			// 禁用新增及复制一行按钮
			$("#addBtn").attr("disabled", true);
			$("#copyBtn").attr("disabled", true);
			ruleCombox.setValue("");
			ruleCombox.enabled = false;
			break;
		case "0" :
		case "2" :
			// 全量比对或只比较属性信息
			grid.setData(attrArray);
			grid.allowCellEdit = true;
			$("#addBtn").attr("disabled", false);
			$("#copyBtn").attr("disabled", false);
			ruleCombox.enabled = true;
			break;
		};
	});

    function onDelete(){
    	var rows = grid.getSelecteds();
    	if(typeof(rows) == "undefined" || rows.length == 0){
	        	nui.alert("请选择属性记录");
	    }else{
	    	for(var i=0;i<rows.length;i++){
	    		var row = rows[i];
				if(typeof(row.attrCode) == "undefined" || typeof(row.attrName) == "undefined"){
					grid.removeRow(row,false);
				}else{
					var index;
					for(var j=0;j<attrArray.length;j++){
						var attr = attrArray[j];
						if(row.attrCode == attr.attrCode && row.attrName == attr.attrName){

							index = attrArray.indexOf(attr);
							break;
						}
					}
					if (index > -1) {
						attrArray.splice(index, 1);
					}
					grid.removeRow(row,false);
				}
			}
	    }
    }

    function onCopy(){
    	var rows = grid.getSelecteds();
    	if(typeof(rows) == "undefined" || rows.length == 0){
	        nui.alert("请选择属性记录");
	    }else if(rows.length != 1){
	    	nui.alert("请选择单条属性记录");
	    }else{

	    	var row = {};
	    	row.attrCode = rows[0].attrCode;
	    	row.attrName = rows[0].attrName;
	    	row.isBase = rows[0].isBase;
       		grid.addRow(row,0);
       		grid.cancelEdit();
	    }
    }

    function submitForm() {
        //提交表单数据
        var form = new nui.Form("#form1");
        //获取表单多个控件的数据
        var data = form.getData();

        var grid = nui.get("datagrid1");
        //var data2 = grid.getSelecteds();
		var data2 = grid.getData();
		// 去除空行
		for(var i=0;i<data2.length;i++){
			var attr = data2[i];
			if(typeof(attr.attrCode) == "undefined" && typeof(attr.attrName) == "undefined"){
				data2.splice(i, 1);
				i--;
			}
		}
		// 检查未完成行，并标记
		for(var i=0;i<data2.length;i++){
			var attr = data2[i];
			if(typeof(attr.attrCode) == "undefined" || typeof(attr.attrName) == "undefined"){
				nui.alert("第"+(grid.indexOf(attr)+1)+"行未完成");
				grid.addRowCls(grid.getRowByUID(attr._uid), "unfinished");
				return;
			}
		}
        // 检查重复行，并标记
        for(var i=0;i<data2.length;i++){
			for(var j=i+1;j<data2.length;j++){
				if(data2[i].attrCode == data2[j].attrCode && data2[i].attrName== data2[j].attrName){
					nui.alert("第"+(grid.indexOf(data2[i])+1)+"行和第"+(grid.indexOf(data2[j])+1)+"行重复");
					grid.addRowCls(grid.getRowByUID(data2[i]._uid), "repeated");
					grid.addRowCls(grid.getRowByUID(data2[j]._uid), "repeated");
					return;
				}
			}
		}

        var params = "{attrs :" + nui.encode(data2) + "}";

		var ruleCode = data.ruleCode;
      	var ruleName = data.ruleName;
      	if(typeof(ruleName) == "undefined" || ruleName == ""){
      		nui.alert("请输入规则名称");
      		return;
      	}
      	var ruleType = data.ruleType;
      	var createUserId = data.createUserId;
      	var createTime = nui.parseDate(data.createTime).getTime();

        nui.ajax({
            url: "<%=request.getContextPath()%>/contrastTaskCmd.do?invoke=addContrastRule" ,
            type: "post",
            data:{
           	 	ruleCode : ruleCode,
            	ruleName : ruleName,
            	ruleType : ruleType,
            	createTime : createTime,
            	params: params
            },
            success: function (text) {
                nui.alert("保存成功","",function(action){
                	onclose();
                });
            }
        });
        onclose();
    }
	function newRow() {
        var row = {};
        row.isBase = "0";
       	grid.addRow(row, 0);
    }
    function onclose(){
	    parent.closeModal();
	}
</script>
</body>
</html>