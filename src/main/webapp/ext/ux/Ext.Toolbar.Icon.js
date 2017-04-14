/**
 * 工具栏图标，不作为按钮，纯粹是显示。
 * @author huanglp 黄龙平
 * @class Ext.Toolbar.Icon
 * @extends Ext.Toolbar.Item
 * A simple class that adds a vertical icon between toolbar items.  Example usage:
 * <pre><code>
new Ext.Panel({
    tbar : [
        'Item 1',
        {xtype: 'tbicon'},
        'Item 2'
    ]
});
</code></pre>
 * @constructor
 * Creates a new Icon
 * @param {Object} a config object containing a <tt>iconCls</tt> property
 */
Ext.Toolbar.Icon = function(config){
	Ext.apply(this, config);
    var s = document.createElement("span");
    s.className = "icon-bar " + config.iconCls;
    Ext.Toolbar.Icon.superclass.constructor.call(this, s);
};
Ext.extend(Ext.Toolbar.Icon, Ext.Toolbar.Item, {
    enable:Ext.emptyFn,
    disable:Ext.emptyFn,
    focus:Ext.emptyFn,
    
    // private 
    render : function(td){
    	Ext.Toolbar.Icon.superclass.render.call(this, td);
    	if (Ext.type(this.tooltip)=='string' && this.tooltip != '') {
    		new Ext.ToolTip({
                target: td,
                html: this.tooltip,
                title: this.title,
                autoHide: false,
                closable: true,
                draggable:true
            });
    	}
    }
    
});
Ext.reg('tbicon', Ext.Toolbar.Icon);

Ext.Toolbar.IconSep = new Ext.Toolbar.Icon({iconCls: 'icon-sep'});
Ext.Toolbar.IconDot1 = new Ext.Toolbar.Icon({iconCls: 'icon-dot1'});
Ext.Toolbar.IconDot2 = new Ext.Toolbar.Icon({iconCls: 'icon-dot1'});
Ext.Toolbar.IconInfo = new Ext.Toolbar.Icon({iconCls: 'icon-info'});