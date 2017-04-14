/**
 * Ext.ux.StoreStatusBar，继承Ext.StatusBar，Store状态栏。<br>
 * @auther huanglp 2009-04-11
 */
Ext.ux.StoreStatusBar = Ext.extend(Ext.StatusBar, {
	 defaultIconCls: 'x-status-anchor'
	,errorIconCls: 'x-status-error'
    ,busyIconCls : 'x-status-busy'
    ,busyText : 'Loading...'
	
	// private
    ,initComponent: function(){
		Ext.ux.StoreStatusBar.superclass.initComponent.call(this);
		if (this.store) {
			this.bind(this.store);
		}
    }
    
    ,onRender:function() {
		Ext.ux.StoreStatusBar.superclass.onRender.apply(this, arguments);
	}
    
    // private
    ,beforeLoad : function(store,options){
        if(!this.rendered){
            return;
        }
        this.showBusy();
    }

    // private
    ,onLoad : function(store, rs, o) {
        if(!this.rendered){
            return;
        }
        var success = true;
        var text = this.defaultText;
        if (store.reader instanceof Ext.data.XmlReader) {
           success = "true" == getValueFromXmlStore(store, "success");
           text = getValueFromXmlStore(store, "msg");
           if (!Ext.type(text)) text = this.defaultText;
        }
        if (store.reader instanceof Ext.data.JsonReader) {
           success = "true" == getValueFromJsonStore(store, "success");
           text = getValueFromJsonStore(store, "msg");
           if (!Ext.type(text)) text = this.defaultText;
        }
        var iconCls = success? this.defaultIconCls : this.errorIconCls;
        this.setStatus({
            text: text, iconCls: iconCls
        });
    }
    
    // private
    ,onLoadError : function(store,options,response,err){
        if(!this.rendered){
            return;
        }
        var text = err ? err.message : response.statusText;
        this.setStatus({
            text: text, iconCls: this.errorIconCls
        });
    }

    /**
     * Unbinds the paging toolbar from the specified {@link Ext.data.Store}
     * @param {Ext.data.Store} store The data store to unbind
     */
    ,unbind : function(store){
        store = Ext.StoreMgr.lookup(store);
        store.un("beforeload", this.beforeLoad, this);
        store.un("load", this.onLoad, this);
        store.un("loadexception", this.onLoadError, this);
        this.store = undefined;
    }

    /**
     * Binds the paging toolbar to the specified {@link Ext.data.Store}
     * @param {Ext.data.Store} store The data store to bind
     */
    ,bind : function(store){
        store = Ext.StoreMgr.lookup(store);
        store.on("beforeload", this.beforeLoad, this);
        store.on("load", this.onLoad, this);
        store.on("loadexception", this.onLoadError, this);
        this.store = store;
    }

});
Ext.reg('storestatusbar', Ext.ux.StoreStatusBar);