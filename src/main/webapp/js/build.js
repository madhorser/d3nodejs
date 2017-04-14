//=============================================
//建立日期：2008-06-18
//功能概述：动态创建Ext脚本库对象等
//调用方法：引入ExtJs的core包、base包与adapter包，并引入当前文件：
//<head>
//<script src="{WebPath}/build.js" type="text/javascript" ></script>
//</head>
//=============================================

//===================================
//动态创建Ext-Field
//===================================
function buildExtField(attribute) {
	Ext.apply(attribute, {
		fieldLabel: attribute.fieldLabel||attribute.caption,
        cls: attribute.readOnly?'x-item-disabled':'',
        blankText: attribute.blankText? attribute.blankText:
                (attribute.fieldLabel||attribute.caption)+Ext.AL.fieldIsRequired
	});
	
	if ("Text"==attribute.uiDefine || 'textfield'==attribute.xtype) {
		return createExtField('textfield', attribute);
	}
	if ("Textarea"==attribute.uiDefine || 'textarea'==attribute.xtype) {
		return createExtField('textarea', attribute);
	}
	if ("Number" == attribute.uiDefine || 'numberfield'==attribute.xtype) {
		return createExtField('numberfield', attribute);
	}
	if ("Hidden" == attribute.uiDefine || 'hidden'==attribute.xtype) {
		return createExtField('hidden', attribute);
	}
	if ("ComboBox" == attribute.uiDefine || 'combo'==attribute.xtype) {
		var stor = attribute.store;
        if (attribute.codeTable) {
            attribute.mode = attribute.mode||'remote';
            attribute.typeAhead = attribute.typeAhead||false;
            attribute = getCodeComboOption(attribute); //see module.js for details
        }
		if (attribute.codeString) stor = stor||storeCodeString(attribute.codeString,attribute);
		if (attribute.codeTable) stor = stor||storeCodeTable(attribute.codeTable,attribute); //see public.js
		var id = Ext.id(attribute);
		var combConfig = createExtField('combo', attribute, {id: id,
			typeAhead: Ext.type(attribute.typeAhead) ? attribute.typeAhead:true,
			triggerAction: attribute.readOnly?'none':'all',
			selectOnFocus: true, forceSelection: true,
			displayField: attribute.displayField||'itemValue',
			valueField: attribute.valueField||'itemCode',
			store: stor, mode: attribute.mode||'local',
			minChars: Ext.type(attribute.minChars) ? attribute.minChars : 0,
			emptyText: attribute.emptyText||Ext.AL.comboxEmptyText,
			hiddenName: attribute.hiddenName||attribute.name
        });
        var comb = new Ext.form.ComboBox(combConfig);
        comb.on('beforerender', function(combox){
            combox.on('beforequery', function(eve) {
                if (eve.combo.readOnly){ return !(eve.cancel = true);}
            });
            if (combox.store == null){ return true;}
            if (attribute.initLoad === true){
                combox.store.load({params:attribute.baseParams});
            }
        });
        return comb;
	}
    if ("Password"==attribute.uiDefine || 'password'==attribute.xtype) {
        return createExtField('textfield', attribute, {inputType:'password'});
    }
    if ("Time" == attribute.uiDefine || 'timefield'==attribute.xtype) {
        return createExtField('timefield', attribute, {
            disabled: attribute.readOnly?true:false,
            increment: attribute.increment||60,
            format: attribute.format||getFormatOfDatetime(attribute.uiFormat,'time')
        });
    }
    if ("Date" == attribute.uiDefine || 'datefield'==attribute.xtype) {
        return createExtField('datefield', attribute, {
            width: attribute.width||160,
            hideTrigger: attribute.hideTrigger||attribute.readOnly,
            format: attribute.format||getFormatOfDatetime(attribute.uiFormat,'date')
        });
    }
	return createExtField(attribute.xtype||'textfield', attribute);
}

function createExtField(xtype,attribute,specials) {
	Ext.applyIf(attribute, {'xtype': xtype});
	Ext.apply(attribute, specials||{});
	return attribute;
}

//==================================================
//动态创建多个Ext-Field，参数为attribute-list
//==================================================
function buildExtFields(list) {
	var fields = new Array();
	for (var i=0; i<list.length; i++) {
		fields.push(buildExtField(list[i]));
	}
	return fields;
}

//===================================
//创建Ext.data.Store
//===================================
function createXmlStore(url, params, dataColumns, options) {
	options = options || {};
	var store = new Ext.data.Store(Ext.apply({
		proxy: new Ext.data.HttpProxy({
			url: url, timeout: 90000, headers: {'Response-By':'XML'}
	    }),
	    baseParams:params||{},
		reader: new Ext.data.XmlReader({
			record: 'row',
			id: 'id', success:'success',
			totalRecords: 'totalCount'
		}, dataColumns )
	}, options));
	store.on('loadexception', function(thiz,options,response,err) {
		var reason = err ? err.message : response.statusText;
		if (response && response.status==Ext.AL.ABORT_REQUEST_CODE){
			reason=Ext.AL.abortRequestText;
		}
		if (response && response.status==Ext.AL.FAIL_REQUEST_CODE){
            reason=Ext.AL.failRequestText;
        }
		extWarn(Ext.AL.storeFailText + reason);
	});
	store.on('load', function(thiz,records,options){
		if (records && records.length > 0) return;
		try {
			var doc = thiz.reader.xmlData;
			var result = thiz.reader.readRecords(doc);
			if (result && result.success === false) {
				var root = doc.documentElement || doc;
				var msg = Ext.DomQuery.selectValue("msg", root, null);
				if (msg) {extErr(Ext.AL.storeFailText + msg);}
			}
		}catch(e){}
	});
	return store;
}

//===================================
//创建Ext.data.Store
//===================================
function createJsonStore(url, params, dataColumns, options) {
    options = options || {};
    var store = new Ext.data.JsonStore(Ext.apply({
        url: url, timeout: 90000,
        baseParams: params||{},
        root: 'list', successProperty:'success', totalProperty:'totalCount',
        fields: dataColumns||[] //get from server side
    }, options));
    store.on('loadexception', function(thiz,options,response,err) {
        var reason = err ? err.message : response.statusText;
        if (response && response.status==Ext.AL.ABORT_REQUEST_CODE){
            reason=Ext.AL.abortRequestText;
        }
        if (response && response.status==Ext.AL.FAIL_REQUEST_CODE){
            reason=Ext.AL.failRequestText;
        }
        extWarn(Ext.AL.storeFailText + reason);
    });
    store.on('load', function(thiz,records,options){
        if (records && records.length > 0) return;
        try {
            var json = thiz.reader.jsonData;
            var success = thiz.reader.getSuccess(json);
            if (success === false || success=='false') {
                var msg = json["msg"];
                if (msg) {extErr(Ext.AL.storeFailText + msg);}
            }
        }catch(e){}
    });
    return store;
}

//===================================
//创建Data Reader/Store列表的列
//===================================
function buildStoreColumn(attribute) {
	var rec = {name: attribute.name};
	if (attribute.type) {
		rec.type = attribute.type; //e.g:'date'
	}
	if (attribute.dateFormat) {
		rec.dateFormat = attribute.dateFormat; //e.g:'n/j h:ia'
	}
	return rec;
}

//==================================================
//创建Data Reader/Store列表的所有列，参数为attribute-list
//==================================================
function buildStoreColumns(list) {
	var cols = new Array();
	for (var i=0; i<list.length; i++) {
		cols.push(buildStoreColumn(list[i]));
	}
	return cols;
}

//===================================
//创建Data Grid列表的ColumnModel列
//===================================
function buildGridColumn(attribute) {
	var col = Ext.apply({}, {
		header: attribute.header||attribute.fieldLabel||attribute.caption,
		dataIndex: attribute.dataIndex||attribute.name,
        sortable: attribute.sortable===false ? false : true
	}, attribute);
	return col;
}

//======================================================
//创建Data Grid列表的所有ColumnModel列，参数为attribute-list
//sm: Shorthand for selModel.
//======================================================
function buildGridColumns(list, sm) {
	var cols = new Array();
	if (sm) cols.push(sm);
	for (var i=0; i<list.length; i++) {
		cols.push(buildGridColumn(list[i]));
	}
	return cols;
}

/**
 * 创建Data Grid列表的所有ColumnModel列,从Store的列中找出即可。
 * @param {array} loadcols - Ext.data.Store加载的列表名称
 * @param {array} gridcols - Ext.grid.GridPanel要显示的列的名称
 * @param {selModel} sm - Shorthand for selModel.
 * @return {array} gridcols
 */
function buildFromLoadedCols(loadcols, gridcols, sm) {
	var cols = new Array();
	if (sm) cols.push(sm);
	for (var i=0; i<gridcols.length; i++) {
		var name = gridcols[i];
		for (var j=0; j<loadcols.length; j++) {
			if (name == loadcols[j].name) {
				cols.push(buildGridColumn(loadcols[j]));
			}
		}
	}
	return cols;
}

/**
 * 创建分页工具栏
 * @param {Ext.data.Store} store
 * @param {Numnber} pageSize
 * @param {Boolean} displayInfo
 * @return {Ext.PagingToolbar}
 */
function buildPagingToolbar(store,pageSize, displayInfo) {
	return new Ext.PagingToolbar({
      store: store,
      pageSize: pageSize || Ext.page.pageSize,
      displayInfo: (Ext.type(displayInfo)=='boolean' ? displayInfo : true)
    });
}

/**
 * 创建不显示总记录数的分页工具栏
 * @param {Ext.data.Store} store
 * @param {Numnber} pageSize
 * @param {Boolean} displayInfo
 * @return {Ext.PagingToolbar}
 */
function buildNostatPagingToolbar(store,pageSize, displayInfo) {
    return new Ext.ux.NostatPagingToolbar({
      store: store,
      pageSize: pageSize || Ext.page.pageSize,
      displayInfo: (Ext.type(displayInfo)=='boolean' ? displayInfo : true)
    });
}

//取日期时间的格式，如date对应Y-m-d，time对应H:i:s，也可自定义
function getFormatOfDatetime(format,defaultFmt) {
	if (!Ext.type(format) || ''==format) format=defaultFmt;
	if ('date' == format) return "Y-m-d";
	if ('time' == format) return "H:i:s";
	if ('datetime' == format) return "Y-m-d H:i:s";
	if ('timestamp' == format) return "Y-m-d H:i:s.u";
	if ('shorttime' == format) return "H:i";
	return format;
}

/**
 * 从Store对象(曾加载过Xml)中根据selector/xpath获取值
 * @param {Store} store Store object(曾加载Xml)
 * @param {String} selector The selector/xpath query
 */
function getValueFromXmlStore(store, selector) {
	var value = null;
	try {
		var doc = store.reader.xmlData;
		var root = doc.documentElement || doc;
		value = Ext.DomQuery.selectValue(selector, root, null);
	}catch(e){}
	return value;
}

/**
 * 从Store对象(曾加载过Json data)中根据selector获取值
 * @param {Store} store Store object(曾加载Json data)
 * @param {String} selector 
 */
function getValueFromJsonStore(store, selector) {
	var value = null;
	try {
		var jsonData = store.reader.jsonData;
		var fn = store.reader.getJsonAccessor(selector);
		value = fn(jsonData);
	}catch(e){}
	return value;
}

/**
 * 检查Store中的Record在某个field上的值是否有重复
 * @param {Store} store Store object
 * @param {String} field 被检查属性
 */
function duplicateStore(store, field) {
	var duplicate = false;
	var map = new Ext.util.MixedCollection();
	store.each( function(record) {
		var value = record.data[field];
		if (map.containsKey(value)) {
			duplicate = {value:value};
			return false;
		}
		map.add(value, record.data);
	});
	return duplicate;
}
