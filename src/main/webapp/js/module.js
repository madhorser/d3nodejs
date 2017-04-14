//=============================================
//建立日期：2009-04-07
//功能概述：系统模块的公共代码库
//调用方法：
//<head>
//<script src="{WebPath}/module.js" type="text/javascript" ></script>
//</head>
//=============================================

/**
 * 结合build.js的buildExtField的下拉框使用。若用户需要增加新的内容可以修改该方法。
 * @param {Object} options
 * @return {Object}
 */
function getCodeComboOption(options) {
    var displayField = options.displayField;
    var valueField = options.valueField;
    var requestUrl = '';
    
    if ('UserGroup' == options.codeTable) {
    	valueField = valueField || 'groupId';
        displayField = displayField || 'groupName';
    } else if ('composition' == options.codeTable) {//组合的元模型类
    	valueField = 'id';
    	displayField = 'name';
    } else if ('Datasource' == options.codeTable) {//数据源的下拉框
    	valueField = 'datasourceId';
        displayField = 'datasourceName';  
    } else if ('QuoteDiffDatasource' == options.codeTable) {//引用异常数据源的下拉框
    	valueField = 'datasourceId';
        displayField = 'datasourceName';  
    } else if ('Adapter' == options.codeTable) {//适配器的下拉框
    	valueField = 'adapterId';
        displayField = 'adapterName';
    }
    
    Ext.apply(options, {displayField:displayField, valueField:valueField, requestUrl: requestUrl});
    return options;
}



/**
 * 给所有的按钮、菜单按钮加上侦听事件，检查权限。<br/>
 * (1)使用funcCode指定权限功能代码的方式：
 * <pre> {
        text:'管理角色', tooltip:'管理角色',
        iconCls:'btn_ico_vcard', funcCodes:['MM_ROLE_MGR:2','MM_ROLE_MGR:3','MM_ROLE_MGR:4'],
        menu:[{
            text:'新增', funcCode:'MM_ROLE_MGR:2',
            iconCls:'btn_ico_vcard_add'
        },'-',{
            text:'<fmt:message key="edit.button.text" />', funcCode:'MM_ROLE_MGR:3',
            iconCls:'btn_ico_vcard_edit'
        },'-',{
            text:'<fmt:message key="dele.button.text" />', funcCode:'MM_ROLE_MGR:4',
            iconCls:'btn_ico_vcard_dele'
        }]
   }
   </pre>
   (2)使用grantNum指定授权数值的方式：
   <pre> {text:'新增', iconCls:'btn_ico_vcard_add', grantNum:1}
   </pre>
 * 
 */
Ext.app.Permission = function(cfg){
    Ext.apply(this, cfg);
    
    Ext.app.Permission.ps = this.ps || [];
    Ext.app.Permission.gr = this.gr || 0;
    
    this.hasPermission = function (item) {
        if (!Ext.isEmpty(item.funcCode)) {
        	if (Ext.app.Permission.ps.indexOf(item.funcCode) < 0) {
                return false;
        	}
        }
        if (Ext.isArray(item.funcCodes)) {
            var b = false;
            Ext.each(item.funcCodes, function(fc) {
                if (Ext.app.Permission.ps.indexOf(fc) >= 0) {
                    return !(b = true);
                }
            });
            return b;
        }
        if (!Ext.isEmpty(item.grantNum)) {
        	var gn = Ext.num(item.grantNum,0)
        	if (gn !== (Ext.app.Permission.gr & gn)) {
                return false;
            }
        }
        if (Ext.isArray(item.grantNums)) {
            var b = false;
            Ext.each(item.grantNums, function(gn) {
            	gn = Ext.num(gn,0)
                if (gn == (Ext.app.Permission.gr & gn)) {
                    return !(b = true);
                }
            });
            return b;
        }
        return true;
    };
    
    Ext.Button.prototype.afterButtonRender = Ext.Button.prototype.afterRender;
    Ext.menu.BaseItem.prototype.onMenuRender = Ext.menu.BaseItem.prototype.onRender;
    Ext.Toolbar.prototype.afterButtonRender = Ext.Toolbar.prototype.afterRender;
    
    Ext.Button.prototype.hasPermission = this.hasPermission;
    Ext.menu.BaseItem.prototype.hasPermission = this.hasPermission;
    Ext.Toolbar.prototype.hasPermission = this.hasPermission;

    Ext.Button.override({
        afterRender : function(){
            this.afterButtonRender(); //call original function body
            if (!this.hasPermission(this)) {
            	this.forbidden = this.disabled = true;
            }
        }
    });
    
    Ext.menu.BaseItem.override({
        onRender : function(container, position){
            this.onMenuRender(container, position); //call original function body
            if (!this.hasPermission(this)) {
                this.forbidden = this.disabled = true;
            }
        }
    });
    
    Ext.Toolbar.override({
    	afterRender : function(){
            this.afterButtonRender(); //call original function body
            for (var i=0; i<this.items.getCount(); i++) {
            	var item = this.items.get(i);
            	if (!this.hasPermission(item)) {
            		item.hide();
            		this.hideSeparator(i+1);
            	}
            }
        }
        
        ,hideSeparator: function(index) {
        	if (index < 0) {return false;}
        	var item = this.items.get(index);
        	if (item instanceof Ext.Toolbar.Separator) {
        		item.hide();
        	}
        }
        
    });
    
};

Ext.extend(Ext.app.Permission, Ext.util.Observable, {
    /**
     * 是否对指定的功能代码FuncCode有访问权限
     * @param {String} funcCode 功能代码
     */
	accessible: function(funcCode) {
        if (!Ext.isArray(this.ps)) {return false;}
        return this.ps.indexOf(funcCode) >= 0;
    }
	
});


/**
 * 在嵌套的Frame中逐层往上查找系统的main页面(支持在open的窗口中调用)。<br>
 * 检测是否存在main.js中的方法addTopTab。
 * @return {window} parent
 */
function getMainParent() {
	var p = window;
	while(true) {
		if (p.document.getElementById('centerZone') != null) {
			return p;
		}
        if (p.opener == null && p == p.top) {
            p = null;
            break;
        }
		p = p.opener != null ? p.opener : p.parent;
	}
	return p;
}

/**
 * 在嵌套的Frame中逐层往上查找系统的factory页面(支持在open的窗口中调用)。<br>
 * 检测是否存在main.js中的方法addBottomTab。
 * @return {window} parent
 */
function getFactoryParent() {
    var p = window;
    while(true) {
        if (p.document.getElementById('TabFactory') != null) {
            return p;
        }
        if (p.opener == null && p == p.top) {
            p = null;
            break;
        }
        p = p.opener != null ? p.opener : p.parent;
    }
    return p;
}


/**
 * 清理浏览器缓存，使用如：在TabPanel中定义listeners:{'beforeremove':cleanupTabCache}。
 * 关于tab与iframe混用时会发生Memory leak:
 * TabPanelItem在关闭时并不会对自定义到tab中的元素做特殊处理，这部分工作必须在控件外来完成。
 * 另一方面，相关资料称IE在iframe元素的回收方面存在着bug，在通常情况下应该将该元素的src属性值修改为"abort:blank"，
 * 并手工将其从DOM树上移除，然后把脚本中引用它的变量置空并调用CollectGarbage()就可以避免iframe不能正常回收所造成的内存泄露。
 */
function cleanupTabCache(tab,panel) {
    var iframes = Ext.query("IFRAME",panel.body.dom);
    Ext.each(iframes, function(iframe){
        iframe.src = 'about:blank';
        Ext.removeNode(iframe);
    });
}
