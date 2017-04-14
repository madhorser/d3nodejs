/**
 * 菜单下拉框。使用例子:
 */
Ext.form.MenuPulldown = function(options) {
    Ext.form.MenuPulldown.superclass.constructor.call(this, options);
};

Ext.extend(Ext.form.MenuPulldown, Ext.form.ComboBox, {
    mode : 'remote',
    pageSize : 20,
    typeAhead: true,
    forceSelection: true,
	triggerAction: 'all', minChars:0,
	displayField: 'menuName',
	valueField: 'menuCode',
    
    // private
    initComponent : function(){
    	this.hiddenName = this.name;
    	this.store = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
				url: "urm.do?invoke=queryMenu"
		    }),
		    baseParams:{menuCode:'', menuName:''},
			reader: new Ext.data.XmlReader({
				record: 'row',
				totalRecords: 'TotalResults'
			}, [{name:'menuCode'}, {name:'menuName'}])
		});
		Ext.form.ComboBox.superclass.initComponent.call(this);
		this.store.on('beforeload', this.onStoreBeforeLoad, this);
		this.store.on('load', this.onStoreLoaded, this);
		this.on('beforerender', this.onBeforeRender, this);
    },
    
    //private
    onStoreLoaded : function(){
    	if (!this.renderValueOnPage) {
    		if (this.value) this.setValue(this.value);
    		this.renderValueOnPage = true;
    	}
    },
    
    // private
    onStoreBeforeLoad : function(){
    	var val = this.getRawValue();
    	if (val.length == 0) {
    		Ext.apply(this.store.baseParams, {menuName:'', menuCode:''});
    	} else {
	    	if (this.containsChinese(val)) {
	    		Ext.apply(this.store.baseParams, {menuName:val, menuCode:''});
	    	} else {
	    		Ext.apply(this.store.baseParams, {menuName:'', menuCode:val});
	    	}
    	}
    },
    
    //private
    onBeforeRender : function(){
    	var val = this.value;
    	if (val && val.length>0)
    		this.store.baseParams['menuCode'] = val;
    	this.store.load();
    },
    
    // private
    containsChinese : function(val) {
    	return /[^\x00-\xff]/.test(val);
    },
    
    getValue : function(){
        return Ext.form.MenuPulldown.superclass.getValue.call(this);
    }

});
Ext.reg('menupulldown', Ext.form.MenuPulldown);