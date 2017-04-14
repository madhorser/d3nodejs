/*
 * 黄龙平。
 * 超级输入控件，可在后面增加显示任意其他控件，最后还可以增加一个Label。
 * Copyright(c) 2009-2015, primedata, Xiamen.
 * huanglp
 */

/**
 * @class Ext.form.SuperField
 * @extends Ext.form.Field
 * @constructor
 * Creates a new super field
 * @param {Object} config Configuration options
 */
Ext.form.SuperField = Ext.extend(Ext.form.Field, {
	/**
	 * config object of the default field
	 * @type 
	 */
	field: null
	
	/**
     * display at the end of field
     * @type String
     */
    ,endLabel: null
    
    /**
     * the input items config to display at the middle, only one field config object is allowed too.
     * @type Array/object 
     */
    ,items: []
    
    // private
    ,groupCls: 'x-form-check-group'
	
    //private
    ,initComponent : function(){
    	Ext.form.SuperField.superclass.initComponent.call(this);
    	this.fieldLabel = this.fieldLabel || (this.field ? this.field.fieldLabel : '');
    	this.panelCfg = {border: false, cls:'x-form-check-group'};
    	this.fields = this.items;
    	delete this.items;
    	
    	//extends Ext.Container and init items
    	this.items = new Ext.util.MixedCollection(false, Ext.Container.prototype.getComponentId);
    	this.itemCn = new Ext.Container();
    	this.itemCn.items = this.items;
    }
    
    // private
    ,onRender : function(ct, position){
    	if(!this.el){
    		// make a table
            ct.addClass('x-table-layout-ct');
            var table = ct.createChild({tag:'table', border:'0', 
                cls:'x-table-layout x-form-item', cellspacing: '0', cn:{
                tag:'tbody', cn:{tag:'tr'}
            }}, position);
            this.el = table;
            this.tr = table.child("tr");
            
            // field
            if (this.field) {
            	this.addItem(this.field);
            }
            
            // items
            if (Ext.type(this.fields) == 'object') {
            	this.fields = [this.fields];
            }
            if (Ext.isArray(this.fields)) {
            	for (var i=0; this.fields && i<this.fields.length; i++) {
                   this.addItem(this.fields[i]);
                }
            }
            delete this.fields;
            
            // end Label
            if(this.endLabel){
            	var td = this.nextBlock();
            	Ext.DomHelper.append(td, {
                    tag: 'label',
                    cls: 'x-form-cb-label',
                    html: this.endLabel
                });
            }
            
            this.field = this.items.first();
        }
        Ext.form.SuperField.superclass.onRender.call(this, ct, position);
    }//end onRender
	
    // private
    ,addItem : function (item) {
    	if (item.isFormField || item.render){ // some kind of form field
    		return this.addField(item);
    	}
    	var td = this.nextBlock();
        var p = new Ext.Panel(Ext.apply({
           renderTo: td, items: item
        }, this.panelCfg));
        this.findFields(p);
        return p.items.first();
    }
    
    // private
    ,addField : function(field){
        var td = this.nextBlock();
        field.render(td);
        if (field.isFormField) {
        	this.items.add(field);
        }
        return field;
    }
    
	// private
    ,nextBlock : function(){
        var td = document.createElement("td");
        Ext.get(td).addClass('x-table-layout-cell');
        this.tr.appendChild(td);
        return td;
    }
    
    // private
    ,findFields : function(panel) {
    	var fields = panel.findBy(function(c){
            return c.isFormField;
        }, this);
        this.items.addAll(fields);
    }
    
    // inhert from Field
    ,validate : function(){
    	var valid = true;
    	var ct = this.itemCn;
        this.itemCn.cascade(function(f){
            if(ct != f){
                if(!f.validate()){
                   return (valid = false);
                }
            }
        });
        return valid;
    }
    
    
    // private inhert from Field
    ,initValue : function(){
    	if (this.field) {
    		this.field.initValue();
    	}
    }
    
    // inhert from Field
    ,getValue : function(){
    	if (this.field) {
    		return this.field.getValue();
    	}
    	return null;
    }
    
    // inhert from Field
    ,getRawValue : function(){
    	if (this.field) {
            return this.field.getRawValue();
        }
        return null;
    }
    
    // inhert from Field
    ,setValue : function(v){
        if (this.field) {
            return this.field.setValue(v);
        }
    }
    
    // inhert from Field
    ,setRawValue : function(v){
    	if (this.field) {
            return this.field.setRawValue(v);
        }
    }
    
    // reset
    ,reset: function() {
        this.items.each(function(f){
            f.reset();
        });
    }
    
});
Ext.reg('superfield', Ext.form.SuperField);
