/*
 * 三态树控件
 * 
 * 三态包括：none、part、all，意义： none:不选中任何节点 part:仅当前节点 all：代表当前节点以及下级节点
 * 
 * 
 */
Ext.ux.TreeCheckNodeUI = function() {
	this.checkModel = 'multiple';
	this.onlyLeafCheckable = false;
	this.imagepath = 'images/icons/';
	Ext.ux.TreeCheckNodeUI.superclass.constructor.apply(this, arguments);
};

Ext.extend(Ext.ux.TreeCheckNodeUI, Ext.tree.TreeNodeUI, {
	renderElements : function(n, a, targetNode, bulkRender) {
		var tree = n.getOwnerTree();
		this.checkModel = tree.checkModel || this.checkModel;
		this.onlyLeafCheckable = tree.onlyLeafCheckable || false;
		// add some indent caching, this helps performance when
		// rendering a large tree
		this.indentMarkup = n.parentNode
				? n.parentNode.ui.getChildIndent()
				: '';
		// var cb = typeof a.checked == 'boolean';
		var cb = (!this.onlyLeafCheckable || a.leaf) && (typeof a.checked == 'string');
		var href = a.href ? a.href : Ext.isGecko ? "" : "#";
		var buf = [
				'<li class="x-tree-node"><div ext:tree-node-id="',
				n.id,
				'" class="x-tree-node-el x-tree-node-leaf x-unselectable ',
				a.cls,
				'" unselectable="on">',
				'<span class="x-tree-node-indent">',
				this.indentMarkup,
				"</span>",
				'<img src="', this.emptyIcon, '" class="x-tree-ec-icon x-tree-elbow" />',
                '<img src="', a.icon || this.emptyIcon, '" class="x-tree-node-icon',
                     (a.icon ? " x-tree-node-inline-icon" : ""), (a.iconCls ? " "+a.iconCls : ""), '" unselectable="on" />',
				cb ? ('<img class="x-tree-node-cb" src="' + this.imagepath + n.attributes.checked + '.gif">') : '',
				'<a hidefocus="on" class="x-tree-node-anchor" href="', href,
				'" tabIndex="1" ',
				a.hrefTarget ? ' target="' + a.hrefTarget + '"' : "",
				'><span unselectable="on">', n.text, "</span></a></div>",
				'<ul class="x-tree-node-ct" style="display:none;"></ul>',
				"</li>"].join('');
		var nel;
		if (bulkRender !== true && n.nextSibling
				&& (nel = n.nextSibling.ui.getEl())) {
			this.wrap = Ext.DomHelper.insertHtml("beforeBegin", nel, buf);
		} else {
			this.wrap = Ext.DomHelper.insertHtml("beforeEnd", targetNode, buf);
		}
		this.elNode = this.wrap.childNodes[0];
		this.ctNode = this.wrap.childNodes[1];
		var cs = this.elNode.childNodes;
		this.indentNode = cs[0];
		this.ecNode = cs[1];
		this.iconNode = cs[2];
        var index = 3;
		if (cb) {
			this.checkbox = cs[3];
			Ext.fly(this.checkbox).on('click',
					this.onCheck.createDelegate(this, [null]));
			index++;
		}
		this.anchor = cs[index];
		this.textNode = cs[index].firstChild;
	},
	// private
	onCheck : function() {
		if (this.node.isLeaf() && this.node.attributes.checked == 'part') {
			this.node.attributes.checked = 'all';
		}
		this.check(this.node.attributes.checked, this
				.toggleCheck(this.node.attributes.checked));
	},
	check : function(origchecked, checked) {
		var n = this.node;
		// 当前节点
		if (n.isLeaf() && checked == 'all') {
			checked = 'part';
		}
		if (!n.isLeaf() && checked == 'part') {
			var childAll = 0;
			Ext.each(n.childNodes, function(child) {
				if (child.attributes.checked == 'all'
						|| (child.attributes.checked == 'part' && child
								.isLeaf())) {
					childAll++;
				}
			});
			if (childAll == n.childNodes.length) {
				checked = 'all';
			}
		}
		n.attributes.checked = checked;
		this.setNodeIcon(n);
		// 影响到子节点
		this.childCheck(n, n.attributes.checked);
		// 影响到父节点
		if (n.parentNode != null) {
			this.parentCheck(n, n.attributes.checked);
		}
	},
	parentCheck : function(node, checked) {
		var currentNode = node;
		if (!currentNode.getUI().checkbox) {
			return;
		}
		if(currentNode.parentNode==null){
			return;
		}
		var parentChecked = currentNode.parentNode.attributes.checked;
		// 看点击节点的所有兄弟节点是否全为none
		var allCount = 0;
		// 当前节点的 父节点是part
		if (currentNode.parentNode.attributes.checked == 'part') {
			// 当前节点的所有兄弟节点是否全none
			Ext.each(currentNode.parentNode.childNodes, function(child) {
				if (child.attributes.checked == 'all'
						|| (child.attributes.checked == 'part' && child
								.isLeaf())) {
					allCount++;
				}
			});
			if (allCount == currentNode.parentNode.childNodes.length) {
				parentChecked = 'all';
			}
		}
		// 当前节点的 父节点是all
		else if (currentNode.parentNode.attributes.checked == 'all') {
			// 子节点任意变化
			parentChecked = 'part';
		}
		currentNode.parentNode.attributes.checked = parentChecked;
		this.setNodeIcon(currentNode.parentNode);
		// 递归调用
		var parentNode = node.parentNode;
		if (parentNode !== null) {
			this.parentCheck(parentNode, checked);
		}
	},
	setNodeIcon : function(n) {
		if (n.getUI() && n.getUI().checkbox)
			n.getUI().checkbox.src = this.imagepath + n.attributes.checked
					+ '.gif';
	},
	// private
	childCheck : function(node, checked) {
		// node.expand(true,true);
		if (node.childNodes)
			Ext.each(node.childNodes, function(child) {
				// 判断子是否叶子节点
				var childchecked = child.attributes.checked;
				if (checked == 'all') {
					if (child.isLeaf()) {
						childchecked = 'part';
					} else {
						childchecked = 'all';
					}
				}
				if (checked == 'none') {
					childchecked = 'none';
				}
				child.attributes.checked = childchecked;
				this.setNodeIcon(child);
				// 递归子的子
				this.childCheck(child, checked);
			}, this);
	},
	// 三状态流转
	toggleCheck : function(value) {
		var nv;
		if (value == 'none') {
			nv = 'part';
		} else if (value == 'part') {
			nv = 'all';
		} else {
			nv = 'none';
		}
		return nv;
	}
});
