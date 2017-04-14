/**
 * @class Ext.form.HtmlField
 * @extends Ext.form.Field
 * @auther lphuang 黄龙平
 * HtmlField支持动态增加HTML标签与清空信息，可用于Log日志输出、聊天窗口等
 * @param {Object} config Configuration options
 */
Ext.form.HtmlField = Ext.extend(Ext.form.Field, {
    /**
     * @cfg {Boolean} allowBlank if set to true, when no html input, it will validate fail
     */
    allowBlank : true,
    
    blankText: 'Field {0} is requried',
    
    readOnly: false,
    
    /**
     * @cfg {Boolean} True to strips all script tags, default is true
     */
    stripScripts: true,
    
    /**
     * @cfg {Boolean} True to strips all HTML tags, default is false
     */
    stripTags: false,
    
    /**
     * @cfg {Boolean} True to lock the location of the scrollBar, default is false
     */
    scrollLock: false,
    
    separatorChar: ': ',
    
    // private
	initComponent : function(){
        Ext.form.HtmlField.superclass.initComponent.call(this);
        // short hand
    	this.eo = Ext.EventObject;
    	
    	this.addEvents(
            /**
             * @event keydown
             * Keydown input field event. This event only fires if enableKeyEvents is set to true.
             * @param {Ext.form.TextField} this This text field
             * @param {Ext.EventObject} e
             */
            'keydown',
            /**
             * @event keyup
             * Keyup input field event. This event only fires if enableKeyEvents is set to true.
             * @param {Ext.form.TextField} this This text field
             * @param {Ext.EventObject} e
             */
            'keyup',
            /**
             * @event keypress
             * Keypress input field event. This event only fires if enableKeyEvents is set to true.
             * @param {Ext.form.TextField} this This text field
             * @param {Ext.EventObject} e
             */
            'keypress',
            'focus', 'controlselect', 'click'
            
        );
    },
    
    // private
    onRender : function(ct, position){
    	this.dh = Ext.DomHelper;
        if(!this.el){
        	var panelCfg = {
                cls: this.cls,
                layout: 'fit',
                border: false,
                renderTo: ct
            };
        	this.panel = new Ext.Panel(panelCfg);
        	this.el = this.dh.append(this.panel.body, {
        		tag: "div", cls: "ux_msg_body ux-msg-default",
        		contentEditable: !this.readOnly,
        		style:"width:500px;height:300px;"
        	}, true);
        	
            //create a hidden input field for saving values
            this.hiddenName = this.hiddenName ? this.hiddenName : this.name;
            this.hiddenField = this.el.insertSibling({
            	tag: 'textarea', autocomplete: "off", tabIndex: -1,
            	style: 'display:none; border:0 none;', cls: 'x-hidden',
            	name: this.hiddenName, id: (this.hiddenId||this.hiddenName)}, 'before', true);
            
            // install event handlers
			this.el.on({
				 keyup:{scope:this, fn:this.fKeyUp}
				,keydown:{scope:this, fn:this.fKeyDown}
				,focus:{scope:this, fn:this.fFocusCursor}
				,click:{scope:this, fn:this.fFocusCursor}
				,controlselect:{scope:this, fn:this.fResizeImage}
			});
        }
        this.rCursor = null;
        Ext.form.HtmlField.superclass.onRender.call(this, ct, position);
    },
    
    // private
    validateValue : function(value){
        var valided = true;
        if (this.hiddenField) {
        	var v = this.hiddenField.value;
        	if (!this.allowBlank && v=="") {
        		var lb = this.fieldLabel ? this.fieldLabel : "";
        		this.markInvalid(String.format(this.blankText, lb));
        		return false;
        	}
        }
        return valided;
    },

    // private
    onResize : function(w, h){
        if (w && h) {
        	this.panel.setSize(w, h);
        	this.panel.doLayout();
        }
        Ext.form.HtmlField.superclass.onResize.apply(this, arguments);
    },
    
    // inherit docs from Field
    reset : function(){
        Ext.form.HtmlField.superclass.reset.call(this);
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
    	this.setValue(this.value);
    },
    /**
     * @method getValue
     * @hide
     */
    getValue : function(){
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
        if (v != null && v != undefined) {
        	this.value = this.stripValue(v);
        	this.hiddenField.value = this.value;
	        this.clearAll();
	        this.el.insertHtml('beforeEnd',this.value);
        }
    },
    /**
     * @method setRawValue
     * @hide
     */
    setRawValue : function(v){
    	this.setValue(v);
    },
    
    /**
     * Add value
	 */
	addValue: function(v) {
		if (v != null && v != undefined) {
			this.value = this.value + this.stripValue(v);
        	this.hiddenField.value = this.value;
	        this.el.insertHtml('beforeEnd',v);
		}
	},
	
	/**
	 * strip Scripts or all Tags
	 */
	 stripValue: function(v) {
	 	if (this.stripTags) {
	 		return Ext.util.Format.stripTags(v);
	 	}
	 	if (this.stripScripts) {
	 		return Ext.util.Format.stripScripts(v);
	 	}
	 	return v;
	 },
    
    /**
     * Clears any text/value currently set in the field
     */
    clearValue : function(){
        this.clearAll();
        this.value = "";
        this.hiddenField.value = this.value;
    },
    
    /** 清空信息 */
    clearAll: function() {
    	this.dh.overwrite(this.el,"");
    },
    
    /**
     * 打印消息
     */
    printh: function(msg, time, succ, fail) {
    	var tpl = this.tpl || new Ext.XTemplate('<tpl for="."><div>',
			'<span class="{ux-msg-time}">{time}{separatorChar}</span>',
			'<span class="ux-msg-default {msgCls}">{msg}</span>',
			'</div></tpl>', {scope:this}
		);
		var msgCls = this.getMsgCls(succ, fail);
		var data = {
			separatorChar: this.separatorChar,
			msg: msg, time: time, msgCls: msgCls
		};
		var msgbody = tpl.apply(data);
		this.addValue(msgbody);
		this.scrollText();
	},
	
	// private
	getMsgCls: function(succ, fail) {
		if (fail) {
			return "ux_msg_error";
		}
		if (succ) {
			return "ux_msg_succs";
		}
		return "";
	},
    
    // private
	scrollText: function (scrollTo) {
	    try {
	    	if (this.scrollLock) return false;
	    	scrollTo = scrollTo ? scrollTo : 'scrollbarPageDown';
	    	this.el.dom.doScroll(scrollTo);
		 } catch(e) {
		 	
		 }
	},
	
	// private
	printWord: function(word, e) {
		var textRange = this.createRange();
		textRange.text = word;
		textRange.select();
		if (e) e.stopEvent();
		return false;
	},

	// private
	fKeyDown: function (field, e) {
		this.fireEvent('keydown', this, e);
	},
	
	// private
	onKeyDown: function(field, e) {
		var key = e.getKey();
		if (this.eo.ENTER==key && !e.ctrlKey) { //Enter
			this.printWord("\r\n", e);
		}
		else if (this.eo.TAB==key) { //Tab
			this.printWord("\t\t", e);
		}
	},

	// private
	fKeyUp: function(e) {
		this.fireEvent('keyup', this, e);
	},
	
	// private 
	onKeyUp: function(field, e) {
		//35:End, 36:Home, 37:Left, 38:Up, 39:Right, 40:Down
		var key = e.getKey();
		if(this.eo.END==key || this.eo.HOME==key || this.eo.Left==key
			|| this.eo.Up==key || this.eo.Right==key || this.eo.Down==key) {
			this.fGetCursor(field, e);
		}
	},
	
	// private
	fFocusCursor: function(e) {
		this.fireEvent('focus', this, e);
	},

	// private
	fGetCursor: function (field, e) {
		//window.defaultStatus = (document.selection.type + " " + event.srcElement.tagName);
		if (this.getSelectionType() == "Control") {
			this.clearSelection();
			return false;
		}
		var target = e.getTarget();
		if(this.getSelectionType() == "None" && target && target.tagName!="DIV") {
			return false;
		}
		this.rCursor = this.createRange();
	    this.rCursor.collapse(true);
	},
	
	// private
	fResizeImage: function(e) {
		var target = e.getTarget();
		if (target.tagName == 'IMG')
			target.onresizestart = function(){return false};
	},
	
	// private
	getSelection: function() {
		return document.selection;
	},
	
	// private
	getSelectionType: function() {
		return this.getSelection().type;
	},
	
	// private
	clearSelection: function() {
		this.getSelection().empty();
	},
	
	// private
	createRange: function() {
		return this.getSelection().createRange();
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

Ext.reg('htmlfield', Ext.form.HtmlField);
