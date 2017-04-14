/**
 * 树型下拉框。使用例子:
 * <pre>
 * var cf = new Ext.form.ComboTree({applyTo: 'local-states2',
		fieldLabel: 'Test ComboTree',
		name: 'name1',
		typeAhead: true,
		triggerAction: 'all',
		selectOnFocus: true, forceSelection:true,
		emptyText: '--please select treenode--',
		loader:new Ext.tree.TreeLoader({
        	dataUrl:'http://localhost:8080/mdms/mtree.do?invoke=authMenu&roleCode=NODE_R',
        	listeners:{beforeload:function(treeLoader, node) {
        		var code = node.id;
        		if (node.id.substr(0,5)=='ynode') code='MM_BIZ';
        		treeLoader.baseParams['parentMenuCode'] = code;
    		}}
        })
	});
 * </pre>
 */
Ext.form.ComboTree = function(options) {
    Ext.form.ComboTree.superclass.constructor.call(this, options);
};

Ext.extend(Ext.form.ComboTree, Ext.form.TriggerField, {
    triggerClass : 'x-form-arrow-trigger',
    shadow : 'sides',
    lazyInit : true,
    initComponent : function() {
        Ext.form.ComboTree.superclass.initComponent.call(this);
    },

    onRender : function(ct, position) {
        Ext.form.ComboBox.superclass.onRender.call(this, ct, position);
        var hiddenName = this.name;

        this.hiddenField = this.el.insertSibling({
            tag : 'input',
            type : 'hidden',
            name : hiddenName
        }, 'before', true);

        this.hiddenField.value = this.value !== undefined ? this.value : 0;

        this.el.dom.removeAttribute('name');
        this.id = this.name;

        if (!this.lazyInit) {
            this.initList();
        } else {
            this.on('focus', this.initList, this, {
                single : true
            });
        }
    },

    initList : function() {
        if (this.list) {
            return;
        }
        this.list = new Ext.Layer({
            shadow : this.shadow,
            cls : 'x-combo-list',
            constrain : false
        });

        this.root = new Ext.tree.AsyncTreeNode({expanded :true});
        this.list.setWidth(Math.max(this.wrap.getWidth(), 70));
        tree = new Ext.tree.TreePanel({
            autoScroll : true,
            height : 200,
            border : false,
            root : this.root,
            loader : this.loader
        });

        delete this.loader;

        tree.on('click', this.onClick, this);
        tree.render(this.list);

        this.el.dom.setAttribute('readOnly', true);
        this.el.addClass('x-combo-noedit');
    },

    expandNode : function(n, v){
        var cs = n.childNodes;
        for(var i = 0, len = cs.length; i < len; i++) {
            if(cs[i].id == v){
                return true;
            }
            if(expandNode(cs[i], v)){
                cs[i].expand();
                return true;
            }
        }
        return false;
    },


    validateValue : function(value) {
        return true;
    },

    validateBlur : function() {
        return !this.list || !this.list.isVisible();
    },

    onDestroy : function() {
        if (this.wrap) {
            this.wrap.remove();
        }
        if (this.list) {
            this.list.destroy();
        }
        Ext.form.ComboTree.superclass.onDestroy.call(this);
    },

    isExpanded : function() {
        return this.list && this.list.isVisible();
    },

    collapse : function() {
        if (this.isExpanded()) {
            this.list.hide();
        }
    },

    onClick : function(node) {
        this.setValue(node);
        this.collapse();
    },


    setValue : function(v) {
        var val = v;
        if(typeof v === 'object'){
            this.hiddenField.value = ((this.root && v.id == this.root.id) ? 0 : v.id);
            val = v.text;
        }
        Ext.form.ComboTree.superclass.setValue.call(this, val);
    },

    initEvents : function() {
        Ext.form.ComboTree.superclass.initEvents.call(this);
        this.el.on('mousedown', this.onTriggerClick, this);
    },

    onTriggerClick : function() {
        if (this.disabled) {
            return;
        }

        if (this.isExpanded()) {
            this.collapse();
            this.el.focus();
        } else {
            this.onFocus({});
            this.list.alignTo(this.wrap, 'tl-bl?');
            this.list.show();
        }
    }

});
Ext.reg('combotree', Ext.form.ComboTree);