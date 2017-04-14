<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>

<!DOCTYPE html />
<html>
<head>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
<title></title>
<link href="<%=request.getContextPath()%>/app/base/bootstrap/css/demo.css"
	rel="stylesheet" type="text/css" />
<!--<style type="text/css">
html,body {
	padding: 0;
	margin: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
</style>-->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/noneScroll.css">
</head>
<body>
	<div class="nui-toolbar" style="text-align:center;line-height:30px;"
		borderStyle="border-left:0;border-top:0;border-right:0;">
		<label>名称：</label> <input id="key" class="nui-textbox"
			style="width:150px;" onenter="onKeyEnter" /> <a class="nui-button"
			style="width:60px;" onclick="searchType()">查询</a>
	</div>
	<div class="nui-fit">

		<ul id="tree1" class="nui-tree" style="width:100%;height:100%;"
			dataField="treeNodes" showTreeIcon="true" textField="text"
			idField="id" parentField="pid" resultAsTree="false"
			expandOnLoad="false" onnodedblclick="onNodeDblClick"
			expandOnDblClick="false" 
			url="<%=request.getContextPath()%>/query.do?invoke=tree">
		</ul>

	</div>
	<div class="nui-toolbar"
		style="text-align:center;padding-top:8px;padding-bottom:8px;"
		borderStyle="border-left:0;border-bottom:0;border-right:0;">
		<a class="nui-button" style="width:60px;" onclick="onSure()">确定</a> <span
			style="display:inline-block;width:25px;"></span> <a
			class="nui-button" style="width:60px;" onclick="onCancel()">取消</a>
	</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();

	var tree = nui.get("tree1");

	//tree.load("../data/listTree.txt");

	function GetData() {
		var node = tree.getSelectedNode();
		return node;
	}
	function searchType() {
		var key = nui.get("key").getValue();
		if (key == "") {
			tree.clearFilter();
		} else {
			key = key.toLowerCase();
			tree.filter(function(node) {
				var text = node.text ? node.text.toLowerCase() : "";
				if (text.indexOf(key) != -1) {
					return true;
				}
			});
		}
	}
	function onKeyEnter(e) {
		search();
	}
	function onNodeDblClick(e) {
		onOk();
	}

	function CloseWindow(action) {
		if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow(action);
		else
			window.close();
	}

	function onSure() {
		var node = tree.getSelectedNode();
		if (node && tree.isLeaf(node) == false) {
			alert("不能选中父节点");
			return;
		}

		CloseWindow("ok");
	}
	function onCancel() {
		CloseWindow("cancel");
	}
</script>