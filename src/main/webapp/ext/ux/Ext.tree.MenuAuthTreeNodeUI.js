/**
 * 菜单权限树树结点UI
 * lphuang 2008-09-23
 */

Ext.tree.MenuAuthTreeNodeUI = function() {
	Ext.tree.MenuAuthTreeNodeUI.superclass.constructor.apply(this, arguments);
	this.node.addEvents("beforeoptionchange", "optionchange");
};

Ext.extend(Ext.tree.MenuAuthTreeNodeUI, Ext.tree.TreeNodeUI, {
	// private
    renderElements : function(n, a, targetNode, bulkRender){
        // add some indent caching, this helps performance when rendering a large tree
        this.indentMarkup = n.parentNode ? n.parentNode.ui.getChildIndent() : '';

        var cb = typeof a.checked == 'boolean';
        var rgt = "R";
        if (n.attributes.params && n.attributes.params.rightDetail)
        	rgt = n.attributes.params.rightDetail;

        var href = a.href ? a.href : Ext.isGecko ? "" : "#";
        var buf = ['<li class="x-tree-node"><div ext:tree-node-id="',n.id,'" class="x-tree-node-el x-tree-node-leaf x-unselectable ', a.cls,'" unselectable="on">',
            '<span class="x-tree-node-indent">',this.indentMarkup,"</span>",
            '<img src="', this.emptyIcon, '" class="x-tree-ec-icon x-tree-elbow" />',
            '<img src="', a.icon || this.emptyIcon, '" class="x-tree-node-icon',(a.icon ? " x-tree-node-inline-icon" : ""),(a.iconCls ? " "+a.iconCls : ""),'" unselectable="on" />',
            cb ? ('<input class="x-tree-node-cb" type="checkbox" ' + (a.checked ? 'checked="checked" />' : '/>')) : '',
            '<a hidefocus="on" class="x-tree-node-anchor" href="',href,'" tabIndex="1" ',
             a.hrefTarget ? ' target="'+a.hrefTarget+'"' : "", '><span unselectable="on">',n.text,'</span></a>',
            '<span>权限:</span><select name="',n.id,'_auth" class="x-combo-list x-tree-node" style="font-size:10px;font-family:宋体;vertical-align:bottom;">',
            '<option value="R" ',(rgt=="R"?'selected':''),'>只读</option>',
            '<option value="W" ',(rgt=="W"?'selected':''),'>可写</option></select>',
            '</div>',
            '<ul class="x-tree-node-ct" style="display:none;"></ul>',
            "</li>"].join('');

        var nel;
        if(bulkRender !== true && n.nextSibling && (nel = n.nextSibling.ui.getEl())){
            this.wrap = Ext.DomHelper.insertHtml("beforeBegin", nel, buf);
        }else{
            this.wrap = Ext.DomHelper.insertHtml("beforeEnd", targetNode, buf);
        }
        
        this.elNode = this.wrap.childNodes[0];
        this.ctNode = this.wrap.childNodes[1];
        var cs = this.elNode.childNodes;
        this.indentNode = cs[0];
        this.ecNode = cs[1];
        this.iconNode = cs[2];
        var index = 3;
        if(cb){
            this.checkbox = cs[3];
			// fix for IE6
			this.checkbox.defaultChecked = this.checkbox.checked;			
            index++;
        }
        this.anchor = cs[index];
        this.textNode = cs[index].firstChild;
        this.optNode = cs[index+2];
        Ext.fly(this.optNode).on("change",this.onChangeOpt.createDelegate(this,arguments));
    },

	getOptEl : function(){
        return this.optNode;
    },
    
    setOptValue : function(val){
    	if (this.optNode.value != val) {
    		this.optNode.value = val;
    		this.onChangeOpt();
    	}
    },
    
    getOptValue: function() {
    	return this.optNode.value;
    },

	// private
	onClick : function(e){
		if(this.dropping){
			e.stopEvent();
			return;
		}
		var selectOpt = e.getTarget('select');
		if (selectOpt) {e.stopEvent();}
		else {
			Ext.tree.MenuAuthTreeNodeUI.superclass.onClick.call(this, e);
		}
	},
	
	onChangeOpt: function(e){
		if(this.fireEvent("beforeoptionchange", this.node, e) == false){
			e.stopEvent();
			return;
		}
		if (!this.node.attributes.params) this.node.attributes.params={};
		this.node.attributes.params.rightDetail = this.optNode.value;
		this.fireEvent("optionchange", this.node, e);
	},

	destroy : function(){
		delete this.optNode;
		Ext.tree.MenuAuthTreeNodeUI.superclass.destroy.call(this);
	}

});