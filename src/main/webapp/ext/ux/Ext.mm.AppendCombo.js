Ext.ns('Ext.mm');
/**
 * 树型下拉框: 元数据树、元模型树。
 * @class Ext.mm.AppendCombo
 * @extends Ext.form.ComboBox
 * @author huanglp 黄龙平
 * @version 1.0 2011-04-26
 */
Ext.mm.AppendCombo=Ext.extend(Ext.form.ComboBox, {
    shadow : 'sides',
    store: new Ext.data.SimpleStore({fields:[], data:[[]]}),
    editable: false,
    resizable: true,
    mode: 'local',
    triggerAction: 'all',
    metadataTreeText: '元数据树',
    classifierTreeText: '元数据类型树',
    cleanerText: '点击清除',
    
    /**
     * @cfg {boolean} 点击树的结点的时候，是否校验结点的有效性。默认为true。
     * 如果修改为false，则需要自己去判断用户选择结点是否您所需要的结点。
     */
    validateEnabled: true,
    
    /**
     * @cfg {Object} 查询参数，用于在初始化的时候赋值到控件里
     */
    baseParams: null,
    
    /**
     * @cfg {boolean} 是否显示清除图标，默认：显示
     */
    showCleaner: true,
    
    /**
     * @type String metadata/classifier, 创建树的类型，默认为metadata
     */
    treeType: 'metadata',
    
    toolTarget : 'header',
    
    // private
    initComponent : function() {
        Ext.mm.AppendCombo.superclass.initComponent.call(this);
        this.pageSize = false;
        this.title = this.isMetadataTree() ? this.metadataTreeText: this.classifierTreeText;
        if (Ext.type(this.hiddenName) === false) {
            this.hiddenName = this.name
        }
        if (Ext.type(this.hiddenId) === false) {
            this.hiddenId = Ext.id();
        }
        this.addEvents(
            /**
             * @event selectnode
             * fire when tree node click
             * @param {Ext.mm.AppendCombo} this
             * @param {Ext.tree.TreeNode} node
             */
            'selectnode'
            /**
             * @event beforeclean
             * fire when before clean the field value
             * @param {Ext.mm.AppendCombo} this
             * @param {String} value
             * @param {String} hideValue
             */
           ,'beforeclean'
           /**
             * @event beforeclean
             * fire when after clean the field value
             * @param {Ext.mm.AppendCombo} this
             */
           ,'clean'
        );
    },
    
    // private
    initEvents : function(){
        if(this.selectOnFocus || this.emptyText){
            this.on("focus", this.preFocus, this);
            this.el.on('mousedown', function(){
                if(!this.hasFocus){
                    this.el.on('mouseup', function(e){
                        e.preventDefault();
                    }, this, {single:true});
                }
            }, this);
            if(this.emptyText){
                this.on('blur', this.postBlur, this);
                this.applyEmptyText();
            }
        }
        this.keyNav = new Ext.KeyNav(this.el, {
            "up" : function(e){
                this.inKeyMode = true;
                this.selectPrev();
            },

            "down" : function(e){
                if(!this.isExpanded()){
                    this.onTriggerClick();
                }else{
                    this.inKeyMode = true;
                    this.selectNext();
                }
            },
            
            "left" : function(e){
                this.inKeyMode = true;
                this.keyCollapseNode();
            },

            "right" : function(e){
                this.inKeyMode = true;
                this.keyExpandNode();
            },
            
            "enter" : function(e){
                this.keyEnterNode();
                this.delayedCheck = true;
                this.unsetDelayCheck.defer(10, this);
            },

            "esc" : function(e){
                this.collapse();
            },

            scope : this,

            doRelay : function(foo, bar, hname){
                if(hname == 'down' || this.scope.isExpanded()){
                   return Ext.KeyNav.prototype.doRelay.apply(this, arguments);
                }
                return true;
            },

            forceKeyDown : true
        });
        if(this.forceSelection){
            this.on('blur', this.doForce, this);
        }
    },
    
    // private
    selectNext : function(){
        var sm = this.tree.getSelectionModel();
        if(sm.getSelectedNode){
            if (sm.getSelectedNode() != null) {
                var node = sm.selectNext();
                this.scrollNodeIntoView(node);
            }
            else {
                var node = this.tree.root.firstChild;
                if (node){
                    sm.select(node);
                    this.scrollNodeIntoView(node);
                }
            }
        }
    },

    // private
    selectPrev : function(){
        var sm = this.tree.getSelectionModel();
        if(sm.getSelectedNode){
            if (sm.getSelectedNode() != null) {
                var node = sm.selectPrevious();
                this.scrollNodeIntoView(node);
                if (node == null) {
                    this.collapse();
                }
            }
            else {
                var node = this.tree.root.lastChild;
                if (node){
                    sm.select(node);
                    this.scrollNodeIntoView(node);
                }
            }
        }
    },
    
    // private
    scrollNodeIntoView: function(node) {
        if (node && this.tree.autoScroll){
            this.tree.body.scrollChildIntoView(node.ui.elNode);
            if (Ext.isIE) {
                node.ui.elNode.scrollIntoView(this.tree.body);
            }
        }
    },
    
    // private
    keyExpandNode : function(){
        var sm = this.tree.getSelectionModel();
        if(sm.getSelectedNode){
            var node = sm.getSelectedNode();
            if (node != null) {
                node.expand(false, this.tree.animate);
            }
        }
    },
    
    // private
    keyCollapseNode : function(){
        var sm = this.tree.getSelectionModel();
        if(sm.getSelectedNode){
            var node = sm.getSelectedNode();
            if (node != null) {
                node.collapse(false, this.tree.animate);
            }
        }
    },
    
    // private
    keyEnterNode : function(){
        var sm = this.tree.getSelectionModel();
        if(sm.getSelectedNode){
            var node = sm.getSelectedNode();
            if (node != null) {
                this.onTreeClick(node);
            }
        }
    },
    
    // private
    onRender : function(ct, position) {
        Ext.mm.AppendCombo.superclass.onRender.call(this, ct, position);
    },

    // private
    initList : function() {
        if (this.list) {
            return;
        }
        
        var cls = 'x-combo-list';
        this.list = new Ext.Layer({
            shadow : this.shadow,
            cls: [cls, this.listClass].join(' '),
            constrain : false
        });

        var lw = this.listWidth || Math.max(this.wrap.getWidth(), this.minListWidth);
        //lw += this.trigger.getWidth();
        this.list.setWidth(lw);
        this.list.swallowEvent('mousewheel');
        
        this.assetHeight = 0;
        if(this.title){
            this.header = this.list.createChild({cls:cls+'-hd', html: this.title});
            this.assetHeight += this.header.getHeight();
        }
        this.tools = this.getBarTools();
        if (this.tools) {
            this.addTool.apply(this, this.tools);
        }
        
        this.innerList = this.list.createChild({cls:cls+'-inner', style:'height:100%;width:100%'});
        this.innerList.setWidth(lw - this.list.getFrameWidth('lr'));
        this.innerList.setHeight(this.maxHeight);
        
        var tree = this.isMetadataTree() ? this.createInstanceTree() : this.createClassifyTree();
        tree.on('click', this.onTreeClick, this);
        tree.render(this.innerList);
        this.tree = tree;
        
        this.el.dom.setAttribute('readOnly', true);
        this.el.addClass('x-combo-noedit');
        
        if(this.resizable){
            this.resizer = new Ext.Resizable(this.list,  {
               pinned:true, handles:'se'
            });
            this.resizer.on('resize', function(r, w, h){
                this.maxHeight = h-this.handleHeight-this.list.getFrameWidth('tb')-this.assetHeight;
                this.listWidth = w;
                this.innerList.setWidth(w - this.list.getFrameWidth('lr'));
                this.restrictHeight();
            }, this);
        }
    },
    
    // private
    restrictHeight: function() {
        this.innerList.dom.style.height = '';
        var inner = this.innerList.dom;
        var pad = this.list.getFrameWidth('tb')+(this.resizable?this.handleHeight:0)+this.assetHeight;
        var h = Math.max(inner.clientHeight, inner.offsetHeight, inner.scrollHeight);
        var ha = this.getPosition()[1]-Ext.getBody().getScroll().top;
        var hb = Ext.lib.Dom.getViewHeight()-ha-this.getSize().height;
        var space = Math.max(ha, hb, this.minHeight || 0)-this.list.shadowOffset-pad-5;
        h = Math.max(Math.min(h, space, this.maxHeight), this.minHeight);

        this.innerList.setHeight(h);
        this.list.beginUpdate();
        this.list.setHeight(h+pad);
        this.list.alignTo(this.wrap, this.listAlign);
        this.list.endUpdate();
    },
    
    expand : function(){
        Ext.mm.AppendCombo.superclass.expand.call(this);
        var xy = this.list.getXY();
        xy = this.list.adjustForConstraints(xy);
        this.list.setXY(xy);
    },
    
    // private
    addTool : function(){
        if(!this[this.toolTarget]) { // no where to render tools!
            return;
        }
        if(!this.toolTemplate){
            // initialize the global tool template on first use
            var tt = new Ext.Template(
                 '<div class="x-tool x-tool-{id}">&#160;</div>'
            );
            tt.disableFormats = true;
            tt.compile();
            this.toolTemplate = tt;
        }
        for(var i = 0, a = arguments, len = a.length; i < len; i++) {
            var tc = a[i], overCls = 'x-tool-'+tc.id+'-over';
            var t = this.toolTemplate.insertFirst((tc.align !== 'left') ? this[this.toolTarget] : this[this.toolTarget].child('span'), tc, true);
            this.tools[tc.id] = t;
            t.enableDisplayMode('block');
            t.on('click', this.createToolHandler(t, tc, overCls, this));
            if(tc.on){
                t.on(tc.on);
            }
            if(tc.hidden){
                t.hide();
            }
            if(tc.qtip){
                if(typeof tc.qtip == 'object'){
                    Ext.QuickTips.register(Ext.apply({
                          target: t.id
                    }, tc.qtip));
                } else {
                    t.dom.qtip = tc.qtip;
                }
            }
            t.addClassOnOver(overCls);
        }
    },
    // private
    createToolHandler : function(t, tc, overCls, panel){
        return function(e){
            t.removeClass(overCls);
            e.stopEvent();
            if(tc.handler){
                tc.handler.call(tc.scope || t, e, t, panel);
            }
        };
    },

    validateValue : function(value) {
        return Ext.mm.AppendCombo.superclass.validateValue.call(this, value);
    },

    onDestroy : function() {
        if (this.wrap) {
            this.wrap.remove();
        }
        if (this.tree) {
            this.tree.destroy();
        }
        if (this.list) {
            this.list.destroy();
        }
        Ext.mm.AppendCombo.superclass.onDestroy.call(this);
    },

    // Implements the default empty TriggerField.onTriggerClick function
    onTriggerClick : function(){
        if(this.disabled){
            return;
        }
        if(this.isExpanded()){
            this.collapse();
            this.el.focus();
        }else {
            this.onFocus({});
            this.expand();
            this.el.focus();
        }
    },
   
    // private
    // click the tree node
    onTreeClick : function(node) {
        if (this.validateSelectNode(node) === false) {
            return;
        }
        
        this.setValue(node);
        this.collapse();
        this.fireEvent('selectnode', this, node);
    },

    initValue: function() {
        Ext.mm.AppendCombo.superclass.initValue.call(this);
        this.originalValue = this.getValue();
    },
    
    /**
     * Returns the currently selected field value or empty string if no value is set.
     * @return {String} value The selected value
     */
    getValue : function(){
        if(this.hiddenField){
            return this.hiddenField.value || this.value || '';
        }else{
            return Ext.mm.AppendCombo.superclass.getValue.call(this);
        }
    },
    
    setValue : function(node) {
        if (this.el && this.emptyClass) {
            this.el.removeClass(this.emptyClass);
        }
        if(Ext.type(node) == 'object'){
            Ext.mm.AppendCombo.superclass.setValue.call(this, node.text);
            var id = node.attributes.resId ? node.attributes.resId : node.attributes.instanceId;
            if(this.hiddenField){this.hiddenField.value = id;}
            this.value = id;
        } else if(Ext.type(node) == 'string'){
            this.setRawValue(node);
        } else {
            this.setRawValue('');
        }
        this.applyEmptyText();
    },
    
    clearValue : function(){
        Ext.mm.AppendCombo.superclass.clearValue.call(this);
        this.collapse();
        this.fireEvent('clean', this);
    },
    
    cleanValue: function(event, toolEl, panel){
        var hiddenValue = this.hiddenField ? this.hiddenField.value : null;
        if(false === this.fireEvent('beforeclean', this, this.value, hiddenValue)) {
            return;
        }
        this.clearValue();
    },

    /**
     * Resets the current field value to the originally-loaded value and clears any validation messages.
     */
    reset : function(){
        if(this.hiddenField){
            Ext.get(this.hiddenField).dom.value = this.originalValue||'';
        }
        Ext.mm.AppendCombo.superclass.reset.call(this);
    },
    
    /**
     * 展开到树结点到toId
     * @param {Ext.tree.TreeNode} n
     * @param {String} toId node-id
     * @return {Boolean} 结点存在并可展开
     */
    expandNode : function(n, toId){
        var cs = n.childNodes;
        for(var i = 0, len = cs.length; i < len; i++) {
            if(cs[i].id == toId){
                return true;
            }
            if(expandNode(cs[i], toId)){
                cs[i].expand();
                return true;
            }
        }
        return false;
    },
    
    /**
     * 是否创建元数据树
     * @return {Boolean}
     */
    isMetadataTree: function() {
        return this.treeType == 'metadata';
    },
    
    /**
     * 1、校验元模型树时，选中的节点是类，而不是包或数据类型；<br>
     * 2、校验元数据树时，选中的节点是元数据，而不是元模型、页码；<br>
     *    当然，若classifierSeleAllowed为true可以选择元模型，若pageSeleAllowed为true可以选择页码；
     * @param {Ext.tree.TreeNode} node
     * @return {Boolean} true-是类，false-不是
     */
    validateSelectNode: function(node) {
        if (this.validateEnabled == false) {
            return true;
        }
        
        var resource = node.attributes.resource;
        // 元数据
        if (this.isMetadataTree()) {
            if (resource == 'class' && this.classifierSeleAllowed !== true) {
                return false;
            }
            if (resource == 'page' && this.pageSeleAllowed !== true) {
                return false;
            }
        }
        // 元模型
        else {
            if (resource == 'package' && this.packageSeleAllowed !== true) {
                return false;
            }
            if (resource == 'datatype' && this.datatypeSeleAllowed !== true) {
                return false;
            }
        }
        return true;
    },
    
    // private
    getBarTools: function() {
        if (this.showCleaner) {
            this.tools = (this.tools||[]).concat([{
                id: 'cleaner', qtip: this.cleanerText,
                handler: this.cleanValue, scope: this
            }]);
        }
        return this.tools;
    },
    
    /**
     * 元数据树
     * @return {Ext.tree.TreePanel}
     */
    createInstanceTree: function() {
        var tree = MetadataTree.Public.createMetadataTree({
            rootVisible: false,
            border: false,
            bodyBorder: false,
            autoScroll: true,
            style: 'height:100%;width:100%'
        });
        tree.getLoader().on('beforeload', this.onBeforeLoadTree, this);
        tree.root.on('load', this.onAfterLoadRoot, this);
        return tree;
    },
    
    /**
     * 元模型树
     * @return {Ext.tree.TreePanel}
     */
    createClassifyTree: function() {
        var tree = AppendTree.createMetamodelTree({
            rootVisible: false,
            border: false,
            bodyBorder: false,
            autoScroll: true,
            style: 'height:100%;width:100%',
            showTextBy: 'name'
        });
        tree.getLoader().on('beforeload', this.onBeforeLoadTree, this);
        tree.root.on('load', this.onAfterLoadRoot, this);
        new Ext.tree.TreeSorter(tree, {
            dir: 'asc',
            caseSensitive: true
        });
        return tree;
    },
    
    /**
     * 结点加载之前，设置默认的参数
     * @param {Ext.tree.TreeLoader} treeLoader
     * @param {Ext.tree.TreeNode} node
     * @param {Function} callback
     */
    onBeforeLoadTree: function(treeLoader, node, callback) {
        Ext.apply(treeLoader.baseParams, this.baseParams || {});
    },
    
    /**
     * 根结点加载后，可能需要提示书否包含子结点信息等
     * @param {Ext.tree.TreeNode} root
     */
    onAfterLoadRoot: function(root) {
        if (!root.hasChildNodes()) {
            this.restrictHeight();
            this.innerList.mask('没有符合的元数据', 'x-mask-pointer-x');
        }
    }

});
Ext.reg('mmappendcombo', Ext.mm.AppendCombo);