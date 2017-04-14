Ext.Ajax.defaultHeaders = {
    'Request-By': 'Ext'
};

// Add the additional 'advanced' VTypes
Ext.apply(Ext.form.VTypes, {
	/**
	 * 校验日期的开始与结束。如输入了开始日期，则结束日期不能比开始日期在前；反之亦然。
	 * @param {String} val 当前输入值
	 * @param {Ext.form.Field} field 输入域
	 * @return {Boolean} true-校验通过；false-校验失败
	 */
    daterange : function(val, field) {
        var date = field.parseDate(val);

        if(!date){
            return true;
        }
        if (field.startDateField && (!field.dateRangeMax || (date.getTime() != field.dateRangeMax.getTime()))) {
        	var startfd = null;
        	if (field.formName) {
        		startfd = Ext.getCmp(field.formName).getForm().findField(field.startDateField);
        	} else {
        		startfd = Ext.getCmp(field.startDateField);
        	}
            if (startfd == null || startfd == undefined){ return true;}
            startfd.setMaxValue(date);
            if(startfd.menu != null){
                startfd.menu.picker.maxText = String.format(startfd.maxText, startfd.formatDate(startfd.maxValue));
                startfd.menu.picker.setMaxDate(date);
            }
            field.dateRangeMax = date;
            startfd.validate();
        }
        if (field.endDateField && (!field.dateRangeMin || (date.getTime() != field.dateRangeMin.getTime()))) {
            var endfd = null;
            if (field.formName) {
            	endfd = Ext.getCmp(field.formName).getForm().findField(field.endDateField);
            } else {
            	endfd = Ext.getCmp(field.endDateField);
            }
            if (endfd == null || endfd == undefined){ return true;}
            endfd.setMinValue(date);
            if(endfd.menu != null){
                endfd.menu.picker.minText = String.format(endfd.minText, endfd.formatDate(endfd.minValue));
                endfd.menu.picker.setMinDate(date);
            }
            field.dateRangeMin = date;
            endfd.validate();
        }
        /*
         * Always return true since we're only using this vtype to set the
         * min/max allowed values (these are tested for after the vtype test)
         */
        return true;
    },

    /**
     * 校验重复输入的密码与初始密码是否一致
     * @param {String} val 当前输入值
     * @param {Ext.form.Field} field 输入域
     * @return {Boolean} true-密码一致；false-密码不一致
     */
    password : function(val, field) {
        if (field.initialPassField) {
            var pwd = Ext.getCmp(field.initialPassField);
            return (val == pwd.getValue());
        }
        return true;
    },

    passwordText : 'Passwords do not match',
    maxlengthbyteText: "输入值不允许超过 {0} 个字节数",
    notGeneraltext : 'invalidate text',
    
    /**
     * 校验输入域的输入字符串在字节数上是否超出maxLength限制。
     * @param {String} val 当前输入值
     * @param {Ext.form.Field} field 输入域
     * @return {Boolean} true-没有超出，输入正确；false-长度超出，输入错误
     */
    maxlengthbyte : function(val, field) {
    	if (val==null || val=="") return true;
    	var maxlength = field.maxLength;
    	try {
    		if (!maxlength || maxlength=="" || maxlength<=0) return true;
    		if (val.unicodeLength() > maxlength) {
    			field.vtypeText = String.format(Ext.form.VTypes.maxlengthbyteText,maxlength);
    			return false;
    		}
    	} catch (e) {}
    	return true;
    },
    
    /**
     * 检测是否输入的字符串为一般化的字符串，如："[A-Za-z0-9_-]"
     * @param {String} val 当前输入值
     * @param {Ext.form.Field} field 输入域
     * @return {Boolean} true-正确；false-错误
     */
    generaltext : function(val, field) {
    	if (val==null || val=="") return true;
    	var p = new RegExp("[^\\w-]", "g");
    	if (p.test(val)) {
    		field.vtypeText = Ext.form.VTypes.notGeneraltext;
    		return false;
    	}
    	return Ext.form.VTypes.maxlengthbyte(val, field);
    },
    
    unusualcharText: 'invalidate char',
    
    /**
     * 不允许输入特殊字符，如:&/\<>'",:;~?=等
     * @param {String} val 当前输入值
     * @param {Ext.form.Field} field 输入域
     * @return {Boolean} true-正确；false-错误
     */
    unusualchar : function(val, field) {
        if (val==null || val=="") return true;
        var p = />|<|,|\?|\/|=|\'|\\|\"|:|;|\~|\^|\&|`/i;
        if (p.test(val)) {
            return false;
        }
        return Ext.form.VTypes.maxlengthbyte(val, field);
    },
    
    /**
     * 不允许输入空白字符
     * @param {String} val 当前输入值
     * @param {Ext.form.Field} field 输入域
     * @return {Boolean} true-正确；false-错误
     */
    emptyspace: function(val, field) {
    	if (field.allowBlank === false && val.trim().length < 1) {
    		Ext.form.VTypes.emptyspaceText = field.blankText;
    		return false;
    	}
    	return Ext.form.VTypes.maxlengthbyte(val, field);
    },
    
    /**
     * 多种校验组合。需要设置vtypes属性，空格分隔，如：vtypes:'emptyspace unusualchar'
     * @param {String} val 当前输入值
     * @param {Ext.form.Field} field 输入域
     */
    multivalidate: function(val, field) {
    	var vtypes = field.vtypes;
    	if (Ext.type(vtypes) === false) {
    		return true;
    	}
		var vts = vtypes.split(' ');
		for (var i=0; i<vts.length; i++) {
			var vtype = vts[i].trim();
			if(!Ext.form.VTypes[vtype](val, field)){
                field.markInvalid(Ext.form.VTypes[vtype +'Text'] || field.vtypeText);
                return false;
            }
		}
		return true;
    }
    
});


// Add the additional renderer
Ext.apply(Ext.util.Format, {
    rmbMoney : function(value, cell, record, rowIndex, colIndex) {
        var money = Ext.util.Format.usMoney(value);
		money = money.replace(/\$/g,'￥');
		if (!isNaN(value) && value<0) {
			cell.attr = 'style="color:red;"';
		}
        return money;
    }
    ,asMoney : function(value, cell, record, rowIndex, colIndex) {
    	return Ext.util.Format.usMoney(value).replace(/\$/g,'');
    }
    ,formatInt: function(v) {
        var value = String(v);
        var r = /(\d+)(\d{3})/;
        while (r.test(value)) {
            value = value.replace(r, '$1' + ',' + '$2');
        }
        return value;
    }
    ,extQtip : function(value, cell, record, rowIndex, colIndex) {
    	var v = Ext.isEmpty(value) ? "" : Ext.util.Format.htmlEncode(value);
        cell.attr = String.format('ext:qtip="{0}"', v);
    	return v;
    },
    ellipsis : function(value, len, dword){//默认双字节的计算长度为2
        if (dword === false) {
            if(value && value.length > len){
                return value.substr(0, len-2)+"&hellip;";
            }
        }
        else if(value && value.actLength() > len){
            var n = value.actLength() - value.length;
            num = num - parseInt(n/2);
            return value.substr(0, num)+"&hellip;";
        }
        return value;
    }
});

// Fix the TriggerField bug where config hideTrigger:true
Ext.form.TriggerField.override({
    afterRender : function(){
        Ext.form.TriggerField.superclass.afterRender.call(this);
        var y;
        if(Ext.isIE && !this.hideTrigger && this.el.getY() != (y = this.trigger.getY())){
            this.el.position();
            this.el.setY(y);
        }
    }
});

// Add useful method to Ext.MessageBox
Ext.apply(Ext.MessageBox, {
    getProgressBar: function() {
        return Ext.getCmp(Ext.query('div.x-progress-wrap', Ext.MessageBox.getDialog().getId())[0].id);
    }
});

//解决：在ff下会出现Permission denied to access property 'dom' from a non-chrome context的报错
Ext.override(Ext.Element, {
    contains: function() {
        var isXUL = Ext.isGecko ? function(node) {
            return Object.prototype.toString.call(node) == '[object XULElement]';
        } : Ext.emptyFn;

        return function(el) {
            return !this.dom.firstChild || // if this Element has no children, return false immediately
                   !el ||
                   isXUL(el) ? false : Ext.lib.Dom.isAncestor(this.dom, el.dom ? el.dom : el);
        };
    }()
}); //说明：Mozilla guys have fixed this pain in Firefox 3.6 beta,但3.0-3.5依然会需要修复(Ext3.0.2以后有修复)
Ext.lib.Event.resolveTextNode = Ext.isGecko ? function(node){
    if(!node){
        return;
    }
    var s = HTMLElement.prototype.toString.call(node);
    if(s == '[xpconnect wrapped native prototype]' || s == '[object XULElement]'){
        return;
    }
    try {
        return node.nodeType == 3 ? node.parentNode : node;
    } catch(e){}
} : function(node){
    return node && node.nodeType == 3 ? node.parentNode : node;
};