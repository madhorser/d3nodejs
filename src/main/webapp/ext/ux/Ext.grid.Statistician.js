/*
 * Ext JS Library 2.2
 * Ext.grid.Statistician
 * @auther lphuang
 */

Ext.grid.Statistician = function(config){
	Ext.apply(this, config);
	Ext.grid.Statistician.superclass.constructor.call(this);
};

Ext.extend(Ext.grid.Statistician, Ext.util.Observable, {
	
	/**
	 * @cfg {Boolean} showMenu
	 * True to show the filter menus
	 */
	showMenu: true,
	/**
     * @cfg {String} text
     * The text displayed for the "Count:" menu item
     */
	text: 'Count: ',
	/**
     * @cfg {String} iconCls
     * CSS class that specifies a background image that will be used as the icon for the "Count:" menu item
     */
	iconCls: 'btn_ico_calcu',
	/**
     * @cfg {Array} columns
     * An array of columns to auto create Count menu, and count sum of the cached records's number value
     */
	columns: [],
	
	init: function(grid){
		if(grid instanceof Ext.grid.GridPanel){
		  this.grid  = grid;
		  this.store = this.grid.getStore();
		  grid.on("render", this.onRender, this);
		}
	},
	
	/** private **/
	onRender: function(){
		var hmenu;
		
		if(this.showMenu) {
			hmenu = this.grid.getView().hmenu;
			
			this.sep  = hmenu.addSeparator();
			this.menu = hmenu.add(new Ext.menu.Item({
					text: this.text, iconCls: this.iconCls
			}));
			hmenu.on('beforeshow', this.onMenu, this);
		}
	},
	
	/** private **/
	onMenu: function(filterMenu) {
		var loaded = this.store.getCount() > 0;
		var specified = false;
		
		var dataIndex = this.getCtxMenuDataIndex();
		Ext.each(this.columns, function(col){
			if (col == dataIndex) return !(specified=true);
		});
		if (specified) {
			this.menu.setText(this.text + this.sum(dataIndex));
		}
		this.menu.setVisible(loaded && specified);
		this.sep.setVisible(loaded && specified);
	},
	
	/** private **/
	getCtxMenuDataIndex: function() {
		var config = this.getCtxMenuDataConfig();
		if (config == null) return null;
		return config.dataIndex;
	},
	
	/** private **/
	getCtxMenuDataConfig: function() {
		var view = this.grid.getView();
		if(!view || view.hdCtxIndex === undefined) {
			return null;
    	}
		
		return view.cm.config[view.hdCtxIndex];
	},
	
	/** private **/
	getColumnModel: function() {
		return this.grid.getColumnModel();
	}, 
	
	/** private **/
	sum: function(dataIndex) {
		var view = this.grid.getView();
		var render = this.getColumnModel().getRenderer(view.hdCtxIndex);
		return render.call(this, [this.store.sum(dataIndex)]);
	},
	/** private **/
	avg: function(dataIndex) {
		var view = this.grid.getView();
		var render = this.getColumnModel().getRenderer(view.hdCtxIndex);
		var avgValue = this.store.sum(dataIndex)/this.store.getCount();
		return render.call(this, [avgValue]);
	}
});