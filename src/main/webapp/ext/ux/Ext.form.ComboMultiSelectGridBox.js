/**
 * 组合表格的下拉框，允许单选/多选，允许分页，允许是否显示表头，允许拉大缩小: <br>
 * 1、下拉框的层包含一个表格，该表格的行记录第一列为多选框控件，可通过参数multiSelect来指定是否允许多选，默认多选；
 * 2、表格的数据可本地获取，也可通过Ajax方式获取，即设置参数requestUrl和baseParams，或设置store来指定。
 * 使用例子：<pre>
 * var formPanel = new Ext.FormPanel({
 *      labelWidth: 100,
 *      frame:true,
 *      title: 'Please Select',
 *      items: [{
 *          name:'userlist', hiddenName:'userlist', fieldLabel:'UserNames',
 *          xtype: 'combo-grid-box', url: 'user.do?invoke=queryUser', baseParams: {},
 *          responseType: 'xml', multiSelect: true,
 *          records: ['userId','userName'], 
 *          columns: [{
 *              dataIndex:'userId', header:'UserId'
 *          }, {
 *              dataIndex:'userName', header:'UserName'
 *          }],
 *          valueField: 'userId', displayField: 'userName',
 *          resizable: true,
 *          pageSize: 4,
 *          hiddenValue: '[\"lphuang\"]', value: 'Chen-Fubing'
 *      }]
 *  });
 * </pre>
 * @class Ext.form.ComboMultiSelectGridBox
 * @extends Ext.form.TriggerField
 * @author huanglp 黄龙平
 * @version 1.0 2011-02-24
 */
Ext.form.ComboMultiSelectGridBox = Ext.extend(Ext.form.TriggerField, {
    /**@private*/
    defaultAutoCreate : {tag: "input", type: "text", size: "24", autocomplete: "off"},
    
    /**
     * @cfg {Ext.data.Store/Array} store The data source to which this grid is bound (defaults to undefined).  This can be
     * any {@link Ext.data.Store} subclass, a 1-dimensional array (e.g., ['Foo','Bar']) or a 2-dimensional array (e.g.,
     * [['f','Foo'],['b','Bar']]).  Arrays will be converted to a {@link Ext.data.SimpleStore} internally.
     * 1-dimensional arrays will automatically be expanded (each array item will be the combo value and text) and
     * for multi-dimensional arrays, the value in index 0 of each item will be assumed to be the combo value, while
     * the value at index 1 is assumed to be the combo text.
     */
    /**
     * @cfg {String} title If supplied, a header element is created containing this text and added into the top of
     * the dropdown list (defaults to undefined, with no header element)
     */
    /**
     * @cfg {String} hiddenName If specified, a hidden form field with this name is dynamically generated to store the
     * field's data value (defaults to the underlying DOM element's name). Required for the combo's value to automatically
     * post during a form submission.  Note that the hidden field's id will also default to this name if {@link #hiddenId}
     * is not specified.  The combo's id and the hidden field's ids should be different, since no two DOM nodes should
     * share the same id, so if the combo and hidden names are the same, you should specify a unique hiddenId.
     */
    /**
     * @cfg {String} hiddenId If {@link #hiddenName} is specified, hiddenId can also be provided to give the hidden field
     * a unique id (defaults to the hiddenName).  The hiddenId and combo {@link #id} should be different, since no two DOM
     * nodes should share the same id.
     */
    /**
     * @cfg {String} triggerClass An additional CSS class used to style the trigger button.  The trigger will always get the
     * class 'x-form-trigger' and triggerClass will be <b>appended</b> if specified (defaults to 'x-form-arrow-trigger'
     * which displays a downward arrow icon).
     */
    triggerClass : 'x-form-arrow-trigger',
    /**
     * @cfg {String} listClass CSS class to apply to the dropdown list element (defaults to '')
     */
    listClass: '',
    /**
     * @cfg {Boolean/String} shadow True or "sides" for the default effect, "frame" for 4-way shadow, and "drop" for bottom-right
     */
    shadow: 'sides',
    /**
     * @cfg {String} listAlign A valid anchor position value. See {@link Ext.Element#alignTo} for details on supported
     * anchor positions (defaults to 'tl-bl')
     */
    listAlign: 'tl-bl?',
    /**
     * @cfg {Number} listHeight The default height in pixels of the dropdown list before scrollbars are shown (defaults to 150)
     */
    listHeight: 150,
    /**
     * @cfg {Number} maxHeight The maximum height in pixels of the dropdown list before scrollbars are shown (defaults to 300)
     */
    maxHeight: 300,
    /**
     * @cfg {Number} minHeight The minimum height in pixels of the dropdown list when the list is constrained by its
     * distance to the viewport edges (defaults to 90)
     */
    minHeight: 90,
    /**
     * @cfg {Number} listWidth The width in pixels of the dropdown list (defaults to the width of the ComboBox field)
     */
    listWidth: null,
    /**
     * @cfg {Number} minListWidth The minimum width of the dropdown list in pixels (defaults to 70, will be ignored if
     * listWidth has a higher value)
     */
    minListWidth : 70,
    /**
     * @cfg {Number} pageSize If greater than 0, a paging toolbar is displayed in the footer of the dropdown list and the
     * filter queries will execute with page start and limit parameters.  Only applies when mode = 'remote' (defaults to 0)
     */
    pageSize: 0,
    /**
     * @cfg {Boolean} selectOnFocus True to select any existing text in the field immediately on focus.  Only applies
     * when editable = true (defaults to false)
     */
    selectOnFocus:false,
    /**
     * @cfg {Boolean} resizable True to add a resize handle to the bottom of the dropdown list (defaults to false)
     */
    resizable: false,
    /**
     * @cfg {Number} handleHeight The height in pixels of the dropdown list resize handle if resizable = true (defaults to 8)
     */
    handleHeight : 8,
    /**
     * @cfg {Boolean} editable False to prevent the user from typing text directly into the field, just like a
     * traditional select (defaults to false)
     */
    editable: false,
    /**
     * @cfg {String} mode Set to 'local' if the ComboBox loads local data (defaults to 'remote' which loads from the server)
     */
    mode: 'remote',
    /**
     * @cfg {Boolean} lazyInit True to not initialize the list for this combo until the field is focused (defaults to true)
     */
    lazyInit : true,
    /**
     * @cfg {String} requestUrl The url to load data from the server. (defaults to undefined)
     */
    requestUrl: null,
    /**
     * @cfg {String} url Shorthand for {@link #requestUrl}.
     */
    /**
     * @cfg {Object} baseParams The base request params append to request url. (defaults to undefined)
     */
    baseParams: null,
    /**
     * @cfg {String} responseType The data returned from the server may be: xml, json. (defaults to 'xml')
     */
    responseType: 'xml',
    /**
     * @cfg {String} recordEl The DomQuery path to the repeated element which contains record information
     *  when response content is xml. (defaults to 'row')
     */
    recordEl: 'row',
    /**
     * @cfg {String} rootEl name of the property which contains the Array of row objects
     *  when response content is json. (defaults to 'list')
     */
    rootEl: 'list',
    /**
     * @cfg {Boolean} multiSelect True to allow to mutil-select data in the grid, 
     * false to allow selection of only one row at a time . (defaults to true)
     */
    multiSelect: true,
    /**
     * @cfg {Object} cm Shorthand for {@link #colModel}.
     */
    /**
     * @cfg {Object} colModel The {@link Ext.grid.ColumnModel} to use when rendering the grid (required).
     */
    /**
     * @cfg {Array} columns An array of columns to auto create a ColumnModel
     */
    /**
     * @cfg {Array} records For example, [{name:'value1'},{name:'value2', type:'int', mapping:'ItemAttributes > Author'}],
     *  or ['value1','value2','value3']. (defaults is ['value','text']).
     * see {@link Ext.data.Record#create} also.
     */
    records: ['value','text'],
    /**
     * @cfg {Function} displayFn The function to get display text of underlying data from the selected record.
     * This function will be call with arguments (this, Ext.data.Record) when rowselect event happends, and it
     * must return a string value as result. When select multi-records in the grid, each display text return by 
     * this function will contact with the {@link #displaySeparate} as a string to fill into the input field.
     */
    /**
     * @cfg {String} displayField The underlying data field name to bind to this ComboBox (defaults to undefined if
     * mode = 'remote' or 'text' if transforming a select). When select records in the grid, each data mapping by the 
     * displayField will contact with the {@link #displaySeparate} as a string to fill into the input field. Note that:
     * When {@link #displayFn} was specified, the <i>displayField</i> will be ingore. 
     */
    /**
     * @cfg {String} valueField The underlying data value name to bind to this ComboBox (defaults to undefined if
     * mode = 'remote', or 'value' if transforming a select) Note: use of a valueField requires the user to make a selection
     * in order for a value to be mapped. When select records in the grid, each data mapping by the valueField will
     * fill in a array as result.
     */
    /**
     * @cfg {String} valueSeparate The underlying data filled in the hidden field will contact 
     * with valueSeparate as a string. (defaults to ',').
     */
    valueSeparate: ',',
    /**
     * @cfg {String} displaySeparate The underlying data filled in the input field will contact 
     * with displaySeparate as a string. (defaults to ',').
     */
    displaySeparate: ',',
    /**
     * @cfg {Object} loadMask An {@link Ext.LoadMask} config or true to mask the grid while loading (defaults to false).
     */
    loadMask : false,
    /**
     * @cfg {Boolean} hideHeaders True to hide the grid's header (defaults to false).
     */
    hideHeaders: false,
    /**
     * @cfg {Object} gridConfig configs of {@link Ext.grid.GridPanel}.
     */
    gridConfig: null,
    
    okText: 'OK',
    
    /**@private*/
    initComponent : function() {
        Ext.form.ComboMultiSelectGridBox.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @event expand
             * Fires when the dropdown list is expanded
             * @param {Ext.form.ComboMultiSelectGridBox} combo This combo box
             */
            'expand',
            /**
             * @event collapse
             * Fires when the dropdown list is collapsed
             * @param {Ext.form.ComboMultiSelectGridBox} combo This combo box
             */
            'collapse'
        );
        
        if(this.url){
            this.requestUrl = this.url;
            delete this.url;
        }
        
        if(Ext.isArray(this.store)){
            if (Ext.isArray(this.store[0])){
                this.store = new Ext.data.SimpleStore({
                    fields: ['value','text'],
                    data: this.store
                });
                this.valueField = 'value';
            }else{
                this.store = new Ext.data.SimpleStore({
                    fields: ['text'],
                    data: this.store,
                    expandData: true
                });
                this.valueField = 'text';
            }
            this.displayField = 'text';
            this.mode = 'local';
        }
        if (this.store === undefined) {
            if ('xml' == this.responseType) {
                this.store = this.createXmlStore(this.requestUrl,
                    this.baseParams, Ext.data.Record.create(this.records));
            }
            if ('json' == this.responseType) {
                this.store = this.createJsonStore(this.requestUrl,
                    this.baseParams, Ext.data.Record.create(this.records));
            }
        }
        this.bindStore(this.store, true);
        
        this.selModel = (this.multiSelect == true) ? new Ext.grid.CheckboxSelectionModel({}) :
                new Ext.grid.RowSelectionModel({singleSelect: true});
        this.relayEvents(this.selModel, ['beforerowselect', 'rowdeselect', 'rowselect', 'selectionchange']);
        
        if(Ext.isArray(this.columns)){
            if (this.multiSelect == true) {
                this.columns = [this.selModel].concat(this.columns);
            }
            this.colModel = new Ext.grid.ColumnModel(this.columns);
            delete this.columns;
        }
        if(this.cm){
            this.colModel = this.cm;
            delete this.cm;
        }
        this.gridConfig = Ext.applyIf(this.gridConfig||{}, {
            loadMask: this.loadMask,
            hideHeaders: this.hideHeaders
        });
        this.viewConfig = Ext.applyIf(this.viewConfig||{}, {forceFit: true});
    },
    
    /**@private*/
    createXmlStore: function(url, baseParams, records) {
        var store = new Ext.data.Store({
            proxy: new Ext.data.HttpProxy({
                url: url, timeout: 90000, headers: {'Response-By':'XML'}
            }),
            baseParams:baseParams||{},
            reader: new Ext.data.XmlReader({
                record: this.recordEl,
                id: 'id', success:'success',
                totalRecords: 'totalCount'
            }, records )
        });
        return store;
    },
    /**@private*/
    createJsonStore: function(url, baseParams, records) {
        var store = new Ext.data.JsonStore({
            url: url, timeout: 90000,
            baseParams: baseParams||{},
            root: this.rootEl, 
            successProperty:'success', totalProperty:'totalCount',
            fields: records||[] //get from server side
        });
        return store;
    },
    /**@private*/
    onLoadError: function(store,options,response,err) {
        var reason = err ? err.message : response.statusText;
        if (response && response.status == -1){
            reason = 'Request abort';
        }
        if (response && response.status == 0){
            reason = 'Request fail';
        }
        this.collapse();
        this.markInvalid(reason);
    },
    /**@private*/
    doLoad : function(start){
        var o = {};
        if (this.pageSize > 0) {
            o['start'] = start;
            o['limit'] = this.pageSize;
        }
        if (this.mode == 'remote' || this.requestUrl != null) {
            this.store.load({params:o});
        }
    },
    
    /**
     * private
     * @param {Ext.grid.GridView} view
     */
    onRefreshView: function(view) {
        this.selModel.suspendEvents();
        this.store.each(function(record, index){
            var v = this.getRecordValue(record);
            if (this.cachedList.indexOfKey(v) >= 0) {
                this.selModel.selectRow(index);
            }
        }, this);
        this.selModel.resumeEvents();
    },
    
    /**
     * private
     * 选中一行记录，同时维护内存中的cachedList的Array值
     * @param {Ext.grid.RowSelectionModel} sm
     * @param {Number} rowIndex
     * @param {Ext.data.Record} record
     */
    onRowSelect: function(sm, rowIndex, record) {
        var v = this.getRecordValue(record);
        var t = this.getDisplayText(record);
        this.cachedList.removeKey(v);
        this.cachedList.add(v, t);
        if (this.multiSelect == false) {
            this.onSelect.defer(50, this, [record, rowIndex]);
        }
    },
    /**
     * private
     * 取消选中一行记录，同时维护内存中的cachedList的Array值
     * @param {Ext.grid.RowSelectionModel} sm
     * @param {Number} rowIndex
     * @param {Ext.data.Record} record
     */
    onRowDeselect: function(sm, rowIndex, record) {
        var v = this.getRecordValue(record);
        this.cachedList.removeKey(v);
    },
    
    // private
    getRecordValue: function(record) {
        return record.get(this.valueField);
    },
    
    /**
     * private
     * 获取记录用于显示的Text。这些Text最终会在input控件中显示。
     * @param {Ext.data.Record} record
     */
    getDisplayText: function(record) {
        if (this.displayFn != null) {
            return this.displayFn(this, record);
        }
        if (this.displayField) {
            return record.get(this.displayField);
        }
        return this.getRecordValue(record);
    },
    
    /**
     * Allow or prevent the user from directly editing the field text.  If false is passed,
     * the user will only be able to select from the items defined in the dropdown list.  This method
     * is the runtime equivalent of setting the 'editable' config option at config time.
     * @param {Boolean} value True to allow the user to directly edit the field text
     */
    setEditable : function(value){
        if(value == this.editable){
            return;
        }
        this.editable = value;
        if(!value){
            this.el.dom.setAttribute('readOnly', true);
            this.el.on('mousedown', this.onTriggerClick,  this);
            this.el.addClass('x-combo-noedit');
        }else{
            this.el.dom.setAttribute('readOnly', false);
            this.el.un('mousedown', this.onTriggerClick,  this);
            this.el.removeClass('x-combo-noedit');
        }
    },
    /**@private*/
    onEnable: function(){
        Ext.form.ComboMultiSelectGridBox.superclass.onEnable.apply(this, arguments);
        if(this.hiddenField){
            this.hiddenField.disabled = false;
        }
    },
    /**@private*/
    onDisable: function(){
        Ext.form.ComboMultiSelectGridBox.superclass.onDisable.apply(this, arguments);
        if(this.hiddenField){
            this.hiddenField.disabled = true;
        }
    },

    onRender : function(ct, position) {
        Ext.form.ComboMultiSelectGridBox.superclass.onRender.call(this, ct, position);
        if(this.hiddenName){
            this.hiddenField = this.el.insertSibling({
                tag:'input', type:'hidden', name: this.hiddenName,
                id: (this.hiddenId||this.hiddenName)}, 'before', true);
            // prevent input submission
            this.el.dom.removeAttribute('name');
        }
        if(Ext.isGecko){
            this.el.dom.setAttribute('autocomplete', 'off');
        }

        if(!this.lazyInit){
            this.initList();
        }else{
            this.on('focus', this.initList, this, {single: true});
        }

        if(!this.editable){
            this.editable = true;
            this.setEditable(false);
        }
    },

    initList : function() {
        if (this.list) {
            return;
        }
        var cls = 'x-combo-list';
        this.list = new Ext.Layer({
            shadow: this.shadow, constrain: false,
            cls: [cls, this.listClass].join(' ')
        });
        var lw = this.listWidth || Math.max(this.wrap.getWidth(), this.minListWidth);
        this.list.setWidth(lw);
        this.list.swallowEvent('mousewheel');
        this.assetHeight = 0;
        
        if(this.title){
            this.header = this.list.createChild({cls:cls+'-hd', html: this.title});
            this.assetHeight += this.header.getHeight();
        }
        
        this.innerList = this.list.createChild({
            cls: cls+'-inner',
            style: 'height:100%;width:100%;border-bottom:0;'
        });
        this.innerList.setWidth(lw - this.list.getFrameWidth('lr'));
        this.innerList.setHeight(Math.min(this.listHeight, this.maxHeight));

        if (this.multiSelect === true) { // 是多选才生成footer栏，单选则与传统下拉框一致
            var m = ['<table cellspacing="0" style="width:100%">',
                '<tr><td class="x-date-bottom" align="center"></td></tr>', '</table>'
            ];
            this.footer = this.list.createChild({
                cls:cls+'-ft',
                html: m.join('')
            });
            this.okBtn = new Ext.Button({
                renderTo: this.list.child("td.x-date-bottom", true),
                text: this.okText,
                handler: this.onSelect,
                scope: this
            });
            this.assetHeight += this.footer.getHeight();
        }
        
        if(this.pageSize){
            this.pageTb = new Ext.form.ComboPagingToolbar({
                store: this.store, pageSize: this.pageSize
            });
        }
        var gridConfig = Ext.applyIf({
            store: this.store,
            colModel: this.colModel,
            selModel: this.selModel,
            bbar: this.pageTb,
            viewConfig: this.viewConfig,
            width: this.innerList.getWidth(),
            height: this.innerList.getHeight()/* - (this.pageTb ? 20 : 0)*/,
            border: false
        }, this.gridConfig);
        this.grid = new Ext.grid.GridPanel(gridConfig);
        this.grid.on('render', function(){this.doLoad(0);}, this);
        if (this.multiSelect === false) {
            this.grid.on('rowclick', function(){this.collapse();}, this);
        }
        this.selModel.onRefresh = function(){}; // use this.onRefreshView instead
        this.grid.getView().on('refresh', this.onRefreshView, this);
        this.selModel.on('rowselect', this.onRowSelect, this);
        this.selModel.on('rowdeselect', this.onRowDeselect, this);
        this.grid.render(this.innerList);
        
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
    
    /**@private*/
    restrictHeight : function(){
        this.innerList.dom.style.height = '';
        var pad = this.list.getFrameWidth('tb')+(this.resizable?this.handleHeight:0)+this.assetHeight;
        var ha = this.getPosition()[1]-Ext.getBody().getScroll().top;
        var hb = Ext.lib.Dom.getViewHeight()-ha-this.getSize().height;
        var space = Math.max(ha, hb, this.minHeight || 0)-this.list.shadowOffset-pad-5;
        var h = Math.min(space, this.maxHeight);
        this.innerList.setHeight(h);
        this.grid.setSize(this.innerList.getWidth(), h/* - (this.pageTb ? 20 : 0)*/);
        this.list.beginUpdate();
        this.list.setHeight(h+pad);
        this.list.alignTo(this.wrap, this.listAlign);
        this.list.endUpdate();
    },

    /**@private*/
    initEvents : function(){
        Ext.form.ComboMultiSelectGridBox.superclass.initEvents.call(this);

        this.keyNav = new Ext.KeyNav(this.el, {
            "esc" : function(e){
                this.collapse();
            },
            "tab" : function(e){
                this.collapse();
                return true;
            },

            scope : this,
            forceKeyDown : true
        });
    },

    /**
     * private
     * 将初始值转换成内存中的MixedCollection结构的值，以便在表格中处理选中/取消的记录。
     * cachedList: Key为value值，Item为Text值，该值由displayFn函数提供或由依据displayField获取
     */
    initCachedList: function() {
        this.cachedList = new Ext.util.MixedCollection();
        var value = this.getValue();
        if (Ext.isEmpty(value)) {
            return;
        }
        
        var text = this.getRawValue();
        var vs = value.split(this.valueSeparate); //to be Array
        var ts = text.split(this.displaySeparate);
        for (var i = 0, len = vs.length; i < len; i++) {
            var txt = (i < ts.length) ? ts[i] : '';
            this.cachedList.add(vs[i], txt);
        }
    },
    
    /**@private*/
    initValue : function(){
        Ext.form.ComboMultiSelectGridBox.superclass.initValue.call(this);
        if(this.hiddenField){
            this.hiddenField.value =
                this.hiddenValue !== undefined ? this.hiddenValue :
                this.value !== undefined ? this.value : '';
        }
        this.initCachedList(); // important step to load original values into cache
    },
    
    /**
     * Returns the currently selected field value or empty string if no value is set.
     * @return {String} value The selected value
     */
    getValue : function(){
        if(this.hiddenField){
            return this.hiddenField.value;
        }
        return Ext.form.ComboMultiSelectGridBox.superclass.getValue.call(this);
    },

    /**
     * Clears any text/value currently set in the field
     */
    clearValue : function(){
        if(this.hiddenField){
            this.hiddenField.value = '';
        }
        this.setRawValue('');
        this.applyEmptyText();
        this.value = '';
    },

    /**@private*/
    setValue : function(v){
        if(this.hiddenField){
            this.hiddenField.value = v;
        }
        Ext.form.ComboMultiSelectGridBox.superclass.setValue.call(this, v);
        this.value = v;
    },
    
    validateValue : function(value) {
        return true;
    },

    validateBlur : function() {
        return !this.list || !this.list.isVisible();
    },

    /**@private*/
    onResize: function(w, h){
        Ext.form.ComboMultiSelectGridBox.superclass.onResize.apply(this, arguments);
        if(this.list && this.listWidth === undefined){
            var lw = Math.max(w, this.minListWidth);
            this.list.setWidth(lw);
            this.innerList.setWidth(lw - this.list.getFrameWidth('lr'));
        }
    },
    
    /**@private*/
    onEnable: function(){
        Ext.form.ComboMultiSelectGridBox.superclass.onEnable.apply(this, arguments);
        if(this.hiddenField){
            this.hiddenField.disabled = false;
        }
    },
    /**@private*/
    onDisable: function(){
        Ext.form.ComboMultiSelectGridBox.superclass.onDisable.apply(this, arguments);
        if(this.hiddenField){
            this.hiddenField.disabled = true;
        }
    },
    
    onDestroy : function() {
        if (this.grid) {
            this.grid.destroy();
        }
        if (this.list) {
            this.list.destroy();
        }
        Ext.form.ComboMultiSelectGridBox.superclass.onDestroy.call(this);
    },
    
    isExpanded : function() {
        return this.list && this.list.isVisible();
    },

    /**
     * Hides the dropdown list if it is currently expanded. Fires the {@link #collapse} event on completion.
     */
    collapse : function(){
        if(!this.isExpanded()){
            return;
        }
        this.list.hide();
        Ext.getDoc().un('mousewheel', this.collapseIf, this);
        Ext.getDoc().un('mousedown', this.collapseIf, this);
        this.fireEvent('collapse', this);
    },

    /**@private*/
    collapseIf : function(e){
        if(!e.within(this.wrap) && !e.within(this.list)){
            this.collapse();
        }
    },

    /**
     * Expands the dropdown list if it is currently hidden. Fires the {@link #expand} event on completion.
     */
    expand : function(){
        if(this.isExpanded() || !this.hasFocus){
            return;
        }
        this.list.alignTo(this.wrap, this.listAlign);
        this.list.show();
        this.innerList.setOverflow('auto'); // necessary for FF 2.0/Mac
        Ext.getDoc().on('mousewheel', this.collapseIf, this);
        Ext.getDoc().on('mousedown', this.collapseIf, this);
        this.fireEvent('expand', this);
    },

    /**@private*/
    bindStore : function(store, initial){
        if(store){
            this.store = Ext.StoreMgr.lookup(store);
            this.store.on('loadexception', this.onLoadError, this);
        }
    },
    
    /**@private*/
    // Implements the default empty TriggerField.onTriggerClick function
    onTriggerClick : function() {
        if (this.disabled) {
            return;
        }

        if (this.isExpanded()) {
            this.collapse();
            this.el.focus();
        } else {
            this.onFocus({});
            if (this.readOnly !== true) {
                this.expand();
                this.restrictHeight();
            }
            this.el.focus();
        }
    },
    
    /**
     * @private
     * @param {Ext.data.Record} record 可能为null，只在单选的情况下可能有值
     * @param {Number} index
     */
    onSelect: function(record, index) {
        var values = [], texts = [];
        this.cachedList.eachKey(function(key){
            values.push(key);
            texts.push(this.cachedList.key(key));
        }, this);
        this.setValue(values.join(this.valueSeparate));
        this.setRawValue(texts.join(this.displaySeparate));
        this.collapse();
        this.fireEvent('select', this, record, index, values, texts);
    },
    
    /**
     * Locks the selections.
     */
    lock : function(){
        this.selModel.lock();
    },

    /**
     * Unlocks the selections.
     */
    unlock : function(){
        this.selModel.unlock();
    },

    /**
     * Returns true if the selections are locked.
     * @return {Boolean}
     */
    isLocked : function(){
        return this.selModel.isLocked();
    }
    
    /**
     * @hide
     * @method autoSize
     */

});
Ext.reg('combo-grid-box', Ext.form.ComboMultiSelectGridBox);


Ext.form.ComboPagingToolbar = Ext.extend(Ext.PagingToolbar, {
    /**@private*/
    onRender : function(ct, position){
        Ext.form.ComboPagingToolbar.superclass.onRender.call(this, ct, position);
        var index1 = this.items.indexOf(this.prev);
        var index2 = this.items.indexOf(this.next);
        Ext.each(this.items.getRange(index1+1, index2-1), function(itm){
            itm.hide();
        });
    }

});

