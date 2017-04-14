/**
 * 更换表格的列头
 * Ext.grid.ToggleHeader
 * @auther huanglp
 */
Ext.grid.ToggleHeader = function(config){
    Ext.apply(this, config);
    Ext.grid.ToggleHeader.superclass.constructor.call(this);
};

Ext.extend(Ext.grid.ToggleHeader, Ext.util.Observable, {
    
    /**
     * @cfg {String} text
     * The text displayed for the "Count:" menu item
     */
    text: 'Toggle Heaher',
    /**
     * @cfg {String} iconCls
     * CSS class that specifies a background image that will be used as the icon for menu item
     */
    iconCls: 'ico_column_head',
    
    
    init: function(grid){
        if(grid instanceof Ext.grid.GridPanel){
          this.grid  = grid;
          this.store = this.grid.getStore();
          grid.on("render", this.onRender, this);
        }
    },
    
    /** private **/
    onRender: function(){
        var hmenu = this.grid.getView().hmenu;
        
        this.sep  = hmenu.addSeparator();
        this.menu = hmenu.add(new Ext.menu.Item({
                text: this.text, iconCls: this.iconCls,
                handler: this.toggleHeader.createDelegate(this)
        }));
        hmenu.on('beforeshow', this.onMenu, this);
    },
    
    /** private **/
    onMenu: function(filterMenu) {
        
    },
    
    /** 
     * private
     * 获取列的配置参数
     */
    getCtxMenuColumnConfig: function() {
        var view = this.grid.getView();
        if(!view || view.hdCtxIndex === undefined) {
            return null;
        }
        
        return view.cm.config[view.hdCtxIndex];
    },
    
    /** 
     * private
     * 获取Ext.grid.ColumnModel
     */
    getColumnModel: function() {
        return this.grid.getColumnModel();
    }, 
    
    /** 
     * private
     * 获取列索引值
     */
    getColumnIndex: function() {
        var view = this.grid.getView();
        return view.hdCtxIndex;
    },
    
    /**
     * private
     * 更换列头
     */
    toggleHeader: function(menuItem, event) {
        var cm = this.getColumnModel();
        var col = this.getCtxMenuColumnConfig();
        if (col.oldHeader == null) {
            col.oldHeader = col.name;
        }
        var tmp = col.oldHeader;
        col.oldHeader = col.header;
        cm.setColumnHeader(this.getColumnIndex(), tmp);
    }
});