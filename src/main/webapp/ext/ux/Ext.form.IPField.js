/**
 * @class Ext.form.IPField
 * @extends Ext.form.Field
 * @auther lphuang 黄龙平
 * IP地址输入框
 * @param {Object} config Configuration options
 */
Ext.form.IPField = Ext.extend(Ext.form.Field, {
    /**
     * @cfg {Boolean} allowBlank False to validate that all fields must input a value.
     * If there is empty text at validation time, {@link @blankText} will be used as the error text.
     */
    allowBlank : true,
    /**
     * @cfg {String} blankText Error text to display if the {@link #allowBlank} validation fails 
     * (defaults to "IP address can not be empty")
     */
    blankText : "IP地址不能为空",
    
    betweenText: "{0}不是一个有效值，请指定一个介于{1}和{2}之间的数值。",
    
    readOnly: false,
    
    /**
     * @cfg {Number} The width of each input field in this component in pixels. 
     * If the value is less then 1, it is used as an anchor width. (defaults to "auto")
     */
    itemWidth: 'auto',
    
    // private
    defaultType : 'numberfield',
    
    // private
    groupCls: 'x-form-check-group',
    
    //private
    itemCount: 4,
    
    // private
	initComponent : function(){
        Ext.form.IPField.superclass.initComponent.call(this);
    },
    
    // private
    onRender : function(ct, position){
        if(!this.el){
            var panelCfg = {
                cls: this.groupCls,
                layout: 'column',
                border: false,
                renderTo: ct
            };
            var colCfg = {
                defaultType: this.defaultType,
                layout: 'form',
                border: false,
                labelWidth: 5,
                defaults: {
                    labelSeparator:'.',
                    anchor: '100%',
                    allowDecimals: false,
                    allowNegative: false,
                    maxValue: 255, minValue: 0,
                    style:'text-align:center;',
                    selectOnFocus: false,
                    readOnly: this.readOnly,
                    allowBlank: this.allowBlank,
                    blankText: this.blankText,
                    enableKeyEvents: true
                }
            }
            
            var cwidths = [];
            if (typeof this.itemWidth == 'string') { // 'auto'
                cwidths = [40,45,45,45];
            } else {
            	var w = isNaN(this.itemWidth)? .25 : this.itemWidth;
            	cwidths = [w,w,w,w];
            }
            
            // Generate the column configs with the correct width setting
            var cols = [];
            for(var i=0; i<this.itemCount; i++){
                var cc = Ext.apply({items:[]}, colCfg);
                cc[cwidths[i] <= 1 ? 'columnWidth' : 'width'] = cwidths[i];
                if(this.defaults){
                    cc.defaults = Ext.apply(cc.defaults || {}, this.defaults)
                }
                cols.push(cc);
            };
            
            // Distribute the original items into the columns
            for(var i=0; i<this.itemCount; i++){
                var itm = {listeners:{
                	keydown: this.onKeyDown.createDelegate(this),
                	keyup: this.onKeyUp.createDelegate(this),
                	change: this.onValueChange.createDelegate(this)
                }};
                if (i == 0) {
                	itm.maxValue = 223;
                	itm.minValue = 1;
                	itm.hideLabel = true;
                }
                cols[i].items.push(itm);
            };
            
            Ext.apply(panelCfg, {
                layoutConfig: {columns: this.itemCount},
                items: cols
            });
            
            this.panel = new Ext.Panel(panelCfg);
            this.el = this.panel.getEl();
            
            if(this.forId && this.itemCls){
                var l = this.el.up(this.itemCls).child('label', true);
                if(l){
                    l.setAttribute('htmlFor', this.forId);
                }
            }
            
            var fields = this.panel.findBy(function(c){
                return c.isFormField;
            }, this);
            
            this.items = new Ext.util.MixedCollection();
            this.items.addAll(fields);
            
            //create a hidden input field for saving ip value
            this.hiddenName = this.hiddenName ? this.hiddenName : this.name;
            this.hiddenField = this.el.insertSibling({tag:'input',type:'hidden',
            	name: this.hiddenName, id: (this.hiddenId||this.hiddenName)}, 'before', true);

            // prevent input submission
            this.items.each(function(f){
	            f.el.dom.removeAttribute('name');
	        }, this);
        }
        Ext.form.IPField.superclass.onRender.call(this, ct, position);
    },
    
    // private
    validateValue : function(value){
        var valided = true;
        this.items.each(function(f){
            valided = f.isValid();
            if (!valided) return false;
        }, this);
        
        return valided;
    },

    // private
    onResize : function(w, h){
        this.panel.setSize(w, h);
        this.panel.doLayout();
    },
    
    // inherit docs from Field
    reset : function(){
        Ext.form.IPField.superclass.reset.call(this);
        this.items.each(function(c){
            if(c.reset){
                c.reset();
            }
        }, this);
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
    	if (this.value == null || this.value == undefined) {
    		this.value = "";
    	}
    	Ext.form.IPField.superclass.initValue.call(this);
    },
    /**
     * @method getValue
     * @hide
     */
    getValue : function(){
    	var v = [];
    	this.items.each(function(c){
            var value = c.getValue();
            if (value!="") v.push(value);
        }, this);
        this.hiddenField.value = v.join(".");
        return this.hiddenField.value;
    },
    /**
     * @method getRawValue
     * @hide
     */
    getRawValue : function(){
    	return this.getValue();
    },
    /**
     * @method setValue
     * @hide
     */
    setValue : function(v){
    	var vs = v.split(".");
    	if (vs.length < this.itemCount) {
    		vs.push("");
    	}
    	var i = 0;
    	this.items.each(function(c){
            c.setValue(vs[i++]);
        }, this);
        this.hiddenField.value = v;
    },
    /**
     * @method setRawValue
     * @hide
     */
    setRawValue : function(v){
    	this.setValue(v);
    },
    
    /**
     * Clears any text/value currently set in the field
     */
    clearValue : function(){
        if(this.hiddenField){
            this.hiddenField.value = '';
        }
        this.setRawValue('');
        this.value = '';
    },
    
    //private
    onKeyDown: function(f, ke) {
		var v = f.getValue();
		var eo = Ext.EventObject;
		var idx = this.items.indexOf(f);
		if (ke.getKey()==eo.ENTER && idx<this.itemCount-1) {
			this.items.itemAt(idx+1).focus();
			ke.stopEvent();
			return;
		}
		if (ke.getKey()==eo.BACKSPACE) {
			if (v=="" && idx>0) {
				this.focusLastText(this.items.itemAt(idx-1));
			}
			return;
		}
		if ((v+"").length == 3) {
			if (idx == this.itemCount-1) {
				ke.stopEvent();
			}
			return;
		}
	},
	
	//private
    onKeyUp: function(f, ke) {
		var v = f.getValue();
		var idx = this.items.indexOf(f);
		if ((v+"").length >= 3 && v > f.maxValue) {
			f.setValue(f.maxValue);
			this.xmsg(String.format(this.betweenText, v, f.minValue, f.maxValue));
			ke.stopEvent();
			return;
		}
		if (idx == 0 && v === 0) {
			f.setValue(f.minValue);
			this.xmsg(String.format(this.betweenText, v, f.minValue, f.maxValue));
			return;
		}
		if ((v+"").length == 3) {
			if (idx < this.itemCount-1) {
				this.items.itemAt(idx+1).focus();
			}
			return;
		}
	},
	
	//private 
	onValueChange: function(f, newValue, oldValue) {
		this.getValue();
	},
	
	focusLastText: function (field) {
	    try{
	    	var o = field.getEl().dom;
			var r = o.createTextRange();
		 	r.moveStart('character', o.value.length);
		 	r.collapse(true);
		 	r.select();
		 } catch(e) {
		 	alert(e.message)
		 }
	},
	
	/**
	 * short hand for Ext.Msg.show
	 * @private
	 * @param {String} title
	 * @param {String} msg
	 * @param {Function} fn
	 */
	xmsg: function(msg, fn){
        Ext.Msg.show({
            title: 'INFO', 
            msg: msg,
            fn: Ext.type(fn)?fn:Ext.emptyFn,
            icon: Ext.Msg.INFO,
            buttons: Ext.Msg.OK
        });
    }
    
});

Ext.reg('ipfield', Ext.form.IPField);
