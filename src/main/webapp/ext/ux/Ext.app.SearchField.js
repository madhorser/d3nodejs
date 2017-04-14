/**
 * from ext-2.2/docs/resources/docs.js
 * @class Ext.app.SearchField
 * @extends Ext.form.TwinTriggerField
 * @author lphuang
 */
Ext.app.SearchField = Ext.extend(Ext.form.TwinTriggerField, {
	
    validateClass: Ext.form.TextField,
    validationEvent: false,
    validateOnBlur: false,
    trigger1Class: 'x-form-clear-trigger',
    trigger2Class: 'x-form-search-trigger',
    hideTrigger1: true,
    width: 180,
    paramName : 'query',
    pageSize: null,
    
    // private
    initComponent : function(){
        if(this.store && !this.store.baseParams){
            this.store.baseParams = {};
        }
        Ext.app.SearchField.superclass.initComponent.call(this);
        this.on('specialkey', function(f, e){
            if(e.getKey() == e.ENTER){
                this.onTrigger2Click();
            }
        }, this);
        
        this.addEvents(
            /**
             * @event beforesearch
             * This event fires if the filter button click or the filter keys Enter. Return false to calcel search.
             * @param {Ext.app.SearchField} this
             * @param {String} value, this.value
             */
            'beforesearch',
            /**
             * @event search
             * This event fires after search.
             * @param {Ext.app.SearchField} this
             * @param {String} value, this.value
             */
            'search'
        );
    },
    
    // private
    onRender : function(ct, position){
        Ext.app.SearchField.superclass.onRender.call(this, ct, position);
        //create a hidden input field for saving value
        if (this.hiddenName) {
            this.hiddenField = this.el.insertSibling({
                tag:'input', type:'hidden',
                name: this.hiddenName, id: (this.hiddenId||this.hiddenName)
            }, 'before', true);
            this.el.dom.removeAttribute('name'); // prevent input submission
        }
        if (Ext.type(this.title)=='string' && !Ext.isEmpty(this.title)) {
            this.el.dom.title = this.title;
        }
        if (this.hideTrigger1 || this.disabled) {
        	this.triggers[0].hide();
        }
        if (this.disabled) {
            this.triggers[1].hide();
        }
    },

    onTrigger1Click : function(){
        if(this.store){
            this.store.baseParams[this.paramName] = '';
            //this.store.removeAll();
            this.clearValue();
            this.triggers[0].hide();
            this.focus();
        }
    },

    onTrigger2Click : function(){
        var v = this.getValue();
        if (false === this.fireEvent('beforesearch', this, v)) {
            return false;
        }
        if (this.store) {
        	this.store.baseParams[this.paramName] = v;
            var o = {start: 0};
            if (this.pageSize != null) {
            	o.limit = this.pageSize;
            }
            this.store.reload({params:o});
        }
        this.fireEvent('search', this, v);
    }
    
    
    
    /**
     * @method initValue
     * @hide
     */
    ,initValue : function(){
    	if (this.value == null || typeof(this.value) == 'undefined') {
            return;
        }
        this.setValue(this.value);
    }
    /**
     * @method getValue
     * @hide
     */
    ,getValue : function(){
    	if(!this.rendered) {
            return this.value;
        }
        if (this.hiddenField) {
            return this.hiddenField.value;
        }
        return this.getRawValue();
    }
    /**
     * @method getRawValue
     * @hide
     */
    ,getRawValue : function(){
        return Ext.app.SearchField.superclass.getRawValue.call(this);
    }
    /**
     * @method setValue
     * @hide
     */
    ,setValue : function(v){
        Ext.app.SearchField.superclass.setValue.call(this, v);
        if (this.hiddenField){
        	this.hiddenField.value = v;
        }
        this.value = v;
    }
    /**
     * @method setRawValue
     * @hide
     */
    ,setRawValue : function(v){
        Ext.app.SearchField.superclass.setRawValue.call(this, v);
        this.toggleTrigger1();
    }
    
    /**
     * Clears any text/value currently set in the field
     */
    ,clearValue : function(){
        if (this.hiddenField){
        	this.hiddenField.value = '';
        }
        this.setRawValue('');
        this.value = '';
        this.toggleTrigger1();
    }
    
    ,validateValue : function(value){
    	var b = Ext.app.SearchField.superclass.validateValue.call(this, value);
    	if (b===true && this.validateClass) {
    		b = this.validateClass.prototype.validateValue.call(this, value);
    	}
    	this.toggleTrigger1();
        return b
    }
    
    ,validateBlur: function(){
    	this.toggleTrigger1();
        return this.validateClass.prototype.validate.call(this);
    }
    
    ,toggleTrigger1: function() {
    	if (this.hideTrigger1 === true) {
    		return false;
    	}
    	if (this.getRawValue() != '') {
    		this.triggers[0].show();
    	} else {
    		this.triggers[0].hide();
    	}
    }
    
});
Ext.reg('appsearchfield', Ext.app.SearchField);
