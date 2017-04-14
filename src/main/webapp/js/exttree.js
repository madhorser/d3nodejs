/**
 * 点击CheckBox树的勾选框事件方法（事件为checkchange），说明如下：<br>
 * 1、勾选结点：
 * (1)遍历并勾选其上级结点，若遍历到某上级结点已经为选中状态则遍历结束；
 * (2)遍历勾选其子孙结点，若遍历到某子孙结点，它的params.ignoreCheckEvent为true，则它不用勾选。
 * 2、勾去结点：
 * (1)对其祖先结点不做任何操作；
 * (2)遍历取消其子孙结点，若遍历到某子孙结点，它的params.ignoreCheckEvent为true，则它不用取消勾选。
 * @param {Ext.tree.TreeNode} node
 * @param {Boolean} checked
 */
function checkTreeNode(node, checked) {
	if (!node.isLeaf() && !node.isLoaded()) {
		node.expand();
	}
    node.getOwnerTree().suspendEvents();
	
	// 若勾选则父亲结点也勾选，若去除勾选则不发生任何事情
	node.bubble(function(parent){
        if (node.id == parent.id) return true;
		if (checked && !parent.getUI().isChecked()) {
            parent.getUI().toggleCheck(true);
        }
	});
	
	node.cascade(function(child){
		if (node.id == child.id) return true;
		if (child.getUI().isChecked() !== checked) {
			var params = child.attributes.params;
			if (params && params.ignoreCheckEvent) {
                return false;
            }
			child.getUI().toggleCheck(checked);
		}
	});
	
	// 修改成可以响应事件的原样
    node.getOwnerTree().resumeEvents();
}

/**
 * 检查node的子结点是否都选中/不选中:checked，返回boolean值
 * @param {Ext.tree.TreeNode} node
 * @param {Boolean} checked
 */
function allChildChecked(node,checked) {
	var same = true;
	node.eachChild(function(child){
		if (child.getUI().isChecked() !== checked) {
			same = false;
			return false;
		}
	});
	return same;
}

/**
 * 显示右键菜单在树结点上。定义tree的contextmenu即可。
 * @param {Ext.tree.TreeNode} node
 * @param {Event} e
 */
function showTreeContextmenu(node, e) {
	node.select();
	var c = node.getOwnerTree().contextMenu;
	c.contextNode = node;
	c.showAt(e.getXY());
}

/**
 * 右键菜单：展开结点
 * @param {Ext.menu.Item} item
 */
function expandNode(item) {
	var n = item.parentMenu.contextNode;
	if (!n.isLeaf() && !n.isExpanded()) n.expand();
}

/**
 * 右键菜单：收缩结点
 * @param {Ext.menu.Item} item
 */
function collapseNode(item) {
	var n = item.parentMenu.contextNode;
	if (!n.isLeaf() && n.isExpanded()) n.collapse(true);
}

/**
 * 右键菜单：全部选择/全不选择
 * @param {Ext.menu.Item} item
 * @param {Boolean} checked true-全选,false-不选
 */
function checkNodeAll(item, checked) {
	var n = item.parentMenu.contextNode;
	if (!n.isLeaf() && !n.isLoaded()) {
		n.expand();
	}
	n.cascade(function(child){
		if (child.getUI().isChecked() !== checked) {
			child.getUI().toggleCheck(checked);
		}
	});
}

/**
 * 右键菜单：刷新结点
 * @param {Ext.menu.Item} item
 */
function refreshNode(item) {
    var n = item.parentMenu.contextNode;
    if (n != null && Ext.type(n.reload) == 'function') {
        n.reload();
    }
}


/**
 * 重新加载树的结点
 * @param {Ext.tree.TreePanel} tree
 * @param {String/Ext.tree.TreeNode} nodeId 结点的ID或者结点
 * @param {Function} callback 加载后的回调方法,参数为thisnode
 */
function reloadNode(tree, nodeId, callback) {
	var node = Ext.type(nodeId)=='string' ? tree.getNodeById(nodeId) : nodeId;
	if (node != null && Ext.type(node.reload) !== false) {
        node.leaf = false;
        node.reload(callback);
    }
}

/**
 * 删除树的一个结点
 * @param {Ext.tree.TreePanel} tree
 * @param {String/Ext.tree.TreeNode} nodeId 结点的ID或者结点
 */
function removeNode(tree, nodeId) {
	var node = Ext.type(nodeId)=='string' ? tree.getNodeById(nodeId) : nodeId;
    if (node != null) {
        node.remove();
    }
}

/**
 * 更新树节点的tooltip
 * @param {Ext.tree.TreeNode} node
 * @param {String} qtip
 * @param {String} qtipTitle
 */
function updateTreeNodeTip(node,qtip,qtipTitle) {
    var ui = node.getUI();
    if(ui.textNode.setAttributeNS){
       ui.textNode.setAttributeNS("ext", "qtip", qtip);
       if(qtipTitle){
           ui.textNode.setAttributeNS("ext", "qtitle", qtipTitle);
       }
    }else{
       ui.textNode.setAttribute("ext:qtip", qtip);
       if(qtipTitle){
           ui.textNode.setAttribute("ext:qtitle", qtipTitle);
       }
    }
}

/**
 * Cascades down the tree from start node, calling the specified function with each node. The scope (<i>this</i>) of
 * function call will be the scope provided or the current node. The arguments to the function
 * will be the args provided or the current node. If the function returns false at any point,
 * the cascade is stopped on that branch.
 * @param {Ext.tree.Node} startNode the start node to be cascaded
 * @param {Function} fn The function to call
 * @param {Object} scope (optional) The scope of the function (defaults to current node)
 * @param {Array} args (optional) The args to call the function with (default to passing the current node)
 */
function cascadeNode(startNode, fn, scope, args){
    if(fn.apply(scope || startNode, args || [startNode]) !== false){
        var cs = startNode.childNodes;
        for(var i = cs.length-1; i >= 0; i--) {
            cascadeNode(cs[i], fn, scope, args);
        }
    }
}


/**
 * 寻找已经被选中的父结点
 * @param {Ext.tree.TreeNode} node
 * @return {Ext.tree.TreeNode} 父结点或者null
 */
function findParentChecked(node) {
    var result = null;
    node.bubble(function(parent){
        if (node.id == parent.id) return true;
        if (parent.getUI().isChecked()) {
            result = parent;
            return false; //终止循环
        }
    });
    return result;
}

/**
 * 寻找已经被选中的子孙结点
 * @param {Ext.tree.TreeNode} node
 * @return {Array} 子孙结点集合
 */
function findChildrenChecked(node) {
    var result = new Array();
    node.cascade(function(child){
        if (node.id == child.id) return true;
        if (child.getUI().isChecked()) {
            result.push(child);
        }
    });
    return result;
}
