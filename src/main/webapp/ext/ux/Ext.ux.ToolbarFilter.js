/**
 * @class Ext.ux.ToolbarFilter
 * @extends Ext.form.Field
 * @auther lphuang 黄龙平
 * 工具栏过滤框
 * @param {Object} config Configuration options
 */
Ext.ux.ToolbarFilter = Ext.extend(Ext.form.Field, {
    /**
     * @cfg {Boolean} allowBlank False to validate that the value length > 0 (defaults to true).
     * If text is empty at validation time, {@link @blankText} will be used as the error text.
     */
    allowBlank : true,
    
    /**
     * @cfg {Boolean} readOnly True to set filter input readonly.
     */
    readOnly: false,
    
    /**
     * @cfg {String} blankText Error text to display if the allow blank validation fails (defaults to "This field is required")
     */
    blankText : "This field is required",
    
    /**
     * @cfg {String} emptyText The default text to display in the filter field (defaults to "Filter..."). 
     */
    emptyText : "Filter...",
    
    /**
     * @cfg {Number} fieldWidth The width of the filter field (defaults to 150). 
     */
    fieldWidth: 150,
    
    /**
     * @cfg {String} iconCls The icon class to display in the filter button (defaults to "btn_ico_search"). 
     */
    iconCls: 'btn_ico_search',
    
    /**
     * @cfg {String} btnText The text to display in the filter button (defaults to ""). 
     */
    btnText: '',
    
    /**
     * @cfg {String} tooltip The tooltip text to display in the filter button (defaults to "Filter/Search"). 
     */
    tooltip: 'Filter/Search',
    
    inputCfg: null,
    
    inputXType : 'textfield',
    
    
    // private
	initComponent : function(){
        Ext.ux.ToolbarFilter.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @event actionfilter
             * This event fires if the filter button click or the filter keys Enter.
             * @param {Ext.ux.ToolbarFilter} this
             * @param {Object} values, like {name:value}
             */
            'actionfilter'
        );
    },
    
    // private
    onRender : function(ct, position){
        if(!this.el){
        	var inpCfg = Ext.apply({
				xtype: this.inputXType,
				name: this.name, 
				width: this.fieldWidth,
				emptyText: this.emptyText,
				allowBlank: this.allowBlank,
                blankText: this.blankText,
				readOnly: this.readOnly,
				enableKeyEvents: true,
                style: 'border:0;'
			}, this.inputCfg);
            var btnCfg = {
				xtype: 'button', hideParent: true,
				iconCls: this.iconCls,
				tooltip: this.tooltip, text: this.btnText,
				handler: this.doFilterAction.createDelegate(this)
			};
			var panelCfg = {
                layout: 'table', items:[inpCfg, btnCfg],
                border: false, bodyBorder: false,
                header: false, footer: false, 
                cls:'x-panel-mc', style: 'padding:0px;margin:0px;',
                renderTo: ct
            };
			this.panel = new Ext.Panel(panelCfg);
			this.el = this.panel.getEl();
            this.input = this.panel.items.get(0);
            this.filter = this.panel.items.get(1);
            
            this.input.on('specialkey', function(field,e) {
            	if (e.getKey() == e.ENTER) {this.doFilterAction.call(this);}
            }, this);
        }
        Ext.ux.ToolbarFilter.superclass.onRender.call(this, ct, position);
    },
    
    // private
    validateValue : function(value){
        return this.input.isValid();
    },

    // private
    onResize : function(w, h){
        this.panel.setSize(w, h);
        this.panel.doLayout();
    },
    
    // inherit docs from Field
    reset : function(){
        Ext.ux.ToolbarFilter.superclass.reset.call(this);
    },
    
    /**
     * Returns the name attribute of the field if available
     * @return {String} name The field name
     */
    getName: function(){
         return this.name;
    },
    
    /**
     * @method initValue
     * @hide
     */
    initValue : function(){
    	this.input.initValue();
    },
    /**
     * @method getValue
     * @hide
     */
    getValue : function(){
        return this.input.getValue();
    },
    /**
     * @method getRawValue
     * @hide
     */
    getRawValue : function(){
    	return this.input.getRawValue();
    },
    /**
     * @method setValue
     * @hide
     */
    setValue : function(v){
    	this.input.setValue(v);
    },
    /**
     * @method setRawValue
     * @hide
     */
    setRawValue : function(v){
    	this.input.setRawValue(v);
    },
    
    //private
    doFilterAction: function() {
    	if (!this.isValid()) return false;
    	var str = encodeURIComponent(this.name) + '=' + encodeURIComponent(this.getValue());
    	var values = Ext.urlDecode(str);
    	this.fireEvent('actionfilter', this, values);
    }
    
});

Ext.reg('toolbarfilter', Ext.ux.ToolbarFilter);
