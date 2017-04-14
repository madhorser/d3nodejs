/*
 * Ext JS Library 2.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing
 * 
 * http://extjs.com/license
 */


// Very simple plugin for adding a close context menu to tabs

Ext.ux.TabCloseMenu = function(){
    var tabs, menu, ctxItem;
    this.init = function(tp){
        tabs = tp;
        tabs.on('contextmenu', onContextMenu, this);
        tabs.on('render', function(t){
        	t.strip.on('dblclick', onDblclick, this);
        }, this);
    }

    function onContextMenu(ts, item, e){
        if(!menu){ // create context menu on first right click
            menu = new Ext.menu.Menu([{
                id: tabs.id + '-close',
                text: this.closeText,
				iconCls: 'x-menu_close',
                handler : function(){
                    tabs.remove(ctxItem);
                }
            },{
                id: tabs.id + '-close-others',
				iconCls: 'x-menu_close_other',
                text: this.closeOtherText,
                handler : function(){
                    tabs.items.each(function(item){
                        if(item.closable && item != ctxItem){
                            tabs.remove(item);
                        }
                    });
                }
            },{
                id: tabs.id + '-close-all',
                iconCls: 'x-menu_close_all',
                text: this.closeAllText,
                handler : function(){
                    tabs.items.each(function(item){
                        if(item.closable){
                            tabs.remove(item);
                        }
                    });
                }
            }]);
        }
        ctxItem = item;
        var items = menu.items;
        items.get(tabs.id + '-close').setDisabled(!item.closable);
        var disableOthers = true;
        tabs.items.each(function(){
            if(this != item && this.closable){
                disableOthers = false;
                return false;
            }
        });
        items.get(tabs.id + '-close-others').setDisabled(disableOthers);
        items.get(tabs.id + '-close-all').setDisabled(disableOthers && !item.closable);
        menu.showAt(e.getPoint());
    }
    
    // Double click to close
    function onDblclick(e) {
    	e.preventDefault();
        var t = tabs.findTargets(e);
        if(t.item && t.item.closable){
            tabs.remove(t.item);
        }
    }
};

Ext.extend(Ext.ux.TabCloseMenu, {
    closeText : "Close",
    closeOtherText : "Close Others",
    closeAllText : "Close All"
});
