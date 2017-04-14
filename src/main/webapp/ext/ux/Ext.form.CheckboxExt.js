/*
 * 黄龙平。
 * 扩展的checkbox和radio控件，可在后面增加显示任意个其他输入框控件，最后还可以增加一个Label。
 * Copyright(c) 2009-2015, primedata, Xiamen.
 * huanglp
 */
var objectExts = {
    /**
     * display at the end of checkbox field
     * @type String
     */
    boxEndLabel: null
    
    /**
     * the input items config to display at the middle, only one field config object is allowed too.
     * @type Array/object 
     */
    ,items: []
    
    //private
    ,initComponent : function(){
        this.constructor.superclass.initComponent.call(this);
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
            this.tr = table.child("tr");
            
            // hidden el
            var td = this.nextBlock();
            this.innerCt = Ext.get(td);
            this.constructor.superclass.onRender.call(this, this.innerCt);
            
            // items
            if (Ext.type(this.fields) == 'object') {
                this.fields = [this.fields];
            }
            if (Ext.isArray(this.fields)) {
                for (var i=0; i<this.fields.length; i++) {
                	var el = this.fields[i];
                    Ext.applyIf(el, {
                        width:80, height:22
                    });
                    this.addItem(this.fields[i]);
                }
            }
            delete this.fields;
            
            // end Label
            if(this.boxEndLabel){
                var td = this.nextBlock();
                Ext.DomHelper.append(td, {
                    tag: 'label',
                    htmlFor: this.el.id,
                    cls: 'x-form-cb-label',
                    html: this.boxEndLabel
                });
            }
            this.field = this.items.first();
            
            // enable or disable input
            if (this.checked) {
                this.toggleEnable(true);
            } else {
                this.toggleEnable(false);
            }
    	}
    }
    
    // private
    ,addItem : function (item) {
        if (item.isFormField || item.render){ // some kind of form field
            this.addField(item);
            return true;
        }
        var td = this.nextBlock();
        var p = new Ext.Panel(Ext.apply({
           renderTo: td, items: item
        }, this.panelCfg));
        this.findFields(p);
    }
    
    // private
    ,addField : function(field){
        var td = this.nextBlock();
        field.render(td);
        if (field.isFormField) {
            this.items.add(field);
        }
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
    
    // private
    ,onResize : function(w,h){
        this.constructor.superclass.onResize.apply(this, arguments);
    }
    
    // private
    ,onClick : function(e){
        var target = e.getTarget("INPUT");
        if (target != undefined) {
            e.stopEvent();
            return false;
        }
        this.constructor.superclass.onClick.call(this, e);
    }
    
    // private
    ,onFocus: function(e) {
        this.constructor.superclass.onFocus.call(this, e);
        this.inputEl.focus();
    }
    
    // private
    ,toggleEnable: function(enable) {
        var ct = this.itemCn;
        this.itemCn.cascade(function(f){
            if(ct != f){
                f.setDisabled(!enable)
            }
        });
    }
    
    // private
    ,onEnable : function(){
        this.constructor.superclass.onEnable.call(this);
        this.toggleEnable(true);
    }

    // private
    ,onDisable : function(){
        this.constructor.superclass.onDisable.call(this);
        this.toggleEnable(false);
    }

    //public 
    ,getValues : function() {
        var values = {};
        Ext.each(this.items, function(f){
            if (f.isFormField) {
                values[f.getName()] = f.getValue();
            }
        });
        return values;
    }
    
    //public 
    ,setValues : function(values) {
        Ext.each(this.items, function(f){
            if (f.isFormField) {
                if (values[f.getName()] != undefined) {
                    f.setValue(values[f.getName()]);
                }
            }
        });
    }
    
    //public
    ,getItems : function() {
        return this.items.items;
    }
    
    //inherit
    ,setValue : function(v) {
        this.constructor.superclass.setValue.call(this, v);
        if(!this.rendered){ // not rendered
            return;
        }
        if (this.checked) {
            this.toggleEnable(true);
        } else {
            this.toggleEnable(false);
        }
    }

};

/**
 * @class Ext.form.CheckboxExt
 * @extends Ext.form.Checkbox
 * Single checkbox field.  Can be used as a direct replacement for traditional checkbox fields.
 * @constructor
 * Creates a new Checkbox
 * @param {Object} config Configuration options
 */
Ext.form.CheckboxExt = Ext.extend(Ext.form.Checkbox, Ext.apply({
    
}, objectExts));
Ext.reg('checkboxext', Ext.form.CheckboxExt);


/**
 * ⊙ Label1[=fieldA=][=fieldB=]Label2.
 * @class Ext.form.RadioExt
 * @extends Ext.form.Radio
 * Single radio field.  Same as Checkbox, but provided as a convenience for automatically setting the input type.
 * Radio grouping is handled automatically by the browser if you give each radio in a group the same name.
 * @constructor
 * Creates a new Radio
 * @param {Object} config Configuration options
 */
Ext.form.RadioExt = Ext.extend(Ext.form.Radio, Ext.apply({
    
}, objectExts));
Ext.reg('radioext', Ext.form.RadioExt);
