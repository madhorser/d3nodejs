/**
 * Ext.ux.UploadGridPanel，继承GridPanel，文件上传控件。<br>
 * 无刷新技术上传文件，支持多个文件一次上传，支持最大文件数、最大文件个数、文件扩展名限制，支持客户化工具栏按钮、gird列。<br>
 * 使用的例子如下：<br><pre><code>
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/upload.css" />
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/filetype.css" />
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/file-upload.css" />
 <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ux/Ext.form.FileUploadField.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ux/Ext.ux.FileUtils.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ux/Ext.ux.UploadGridPanel.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ux/Ext.ux.FileUploader.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ux/Ext.ux.lang.zh_CN.js"></script>
 
 var upgrid = {
	 xtype:'uploadgridpanel'
	,viewConfig: {
        forceFit:true
    }
    ,bodyStyle:'width:100%;height:100%'
    ,region: 'center' ,renderTo: Ext.getBody()
    ,margins: '0 0 0 0'
    ,allowFileExtensions:['jpg', 'txt']
    ,maxFileCount:2
 };
 *</code></pre>
 *
 * @auther huanglp 2008-11-04
 */
Ext.ux.UploadGridPanel = Ext.extend(Ext.grid.GridPanel, {
	 showAddBtn: true
	,showUploadBtn: true
	,showDeleteBtn: true
	,buttonsShowAt:'tbar'
	
	,addText:'Add...'
	,uploadText:'Upload'
	,removeAllText:'Remove All'
	,removeText:'Remove'
	,stopAllText:'Stop All'
	
	,addIconCls:'icon-plus'
	,removeAllIconCls:'icon-cross'
	,removeIconCls:'icon-minus'
	,uploadIconCls:'icon-upload'
	,stopIconCls:'icon-stop'
	,fileCls:'file'
	
	,fileQueuedText: 'File <b>{0}</b> is queued for upload'
	,fileUploadingText: 'Uploading file <b>{0}</b>'
	,fileDoneText: 'File <b>{0}</b> has been successfully uploaded'
	,fileStoppedText: 'File <b>{0}</b> stopped by user'
	,fileFailedText:'File <b>{0}</b> failed to upload'
	,errorText: 'Error'
	,clickStopText: 'Click to stop'
	,clickRemoveText: 'Click to remove'
	,maxFileCountText: 'The count of selected files is up to the max value:{0}'
	,allowFileExtensionsText: 'Allow upload file is:{0}'
	,allowSameFileNameText: 'File {0} is already existed, please change the file name.'
    ,allowBlankFileNameText: 'File name can not contain blank spaces'
	,msgTitle: 'Information'
	
	,fileHeaderText: 'File'
	,stateHeaderText: 'State'
	,operHeaderText: 'Operation'
	
	,maxFileSize:524288
	,maxFileCount:100
	,allowFileExtensions:null
	,allowSameFileName: true //files called the same name in different dirs be allowed select?
    ,allowBlankFileName: true //file name can contain blank spaces? for example, not allow in unix.
	
	/**
	 * @cfg {Boolean} enableProgress true to enable querying server for progress information.
	 * If set to true, you must set progressUrl for request the progress state information.
	 */
	,enableProgress:false
	,progressUrl: null
	
	// private
    ,initComponent: function(){
    	// short hand
    	this.fu = Ext.ux.FileUtils;
    	
    	// file browse button configuration
    	var addCfg = {
    		 id: Ext.id()
			,xtype:'fileuploadfield'
			,buttonOnly:true
			,listeners: {'fileselected': {fn:this.onAddFile, scope:this}}
			,buttonCfg: {
				 text: this.addText
				,tooltip:this.addText
				,iconCls: this.addIconCls
				,hidden: !this.showAddBtn
			}
		};
    	
    	// upload button configuration
		var upCfg = {
			 id: Ext.id()
			,xtype:'button'
			,iconCls:this.uploadIconCls
			,text:this.uploadText
			,tooltip:this.uploadText
			,hidden: !this.showUploadBtn
			,scope:this
			,handler:this.onUpload
			,disabled:true
		};

		// remove all button configuration
		var removeAllCfg = {
			 id: Ext.id()
			,xtype:'button'
			,text:this.removeAllText
			,iconCls:this.removeAllIconCls
			,tooltip:this.removeAllText
			,hidden: !this.showDeleteBtn
			,scope:this
			,handler:this.onRemoveAllClick
			,disabled:true
		};
		
		// save btns Id
		this.addBtnId = addCfg.id;
		this.upldBtnId = upCfg.id;
		this.rmvAllBtnId = removeAllCfg.id;
    	
    	// add buttons to tbar or bbar
    	var bars = this.buttonsShowAt=='tbar' ? this.tbar : this.bbar;
    	var btns = new Array();
    	btns.push(addCfg);
    	btns.push(upCfg);
    	if (bars) {
    		if (Ext.isArray(bars)) btns = btns.concat(bars);
    		else btns.push(bars);
    	}
    	btns.push('->');
    	btns.push(removeAllCfg);
    	if (this.buttonsShowAt=='tbar') {
    		this.tbar = btns;
    	} else {
    		this.bbar = btns;
    	}
    	
    	var fields = this.getAllFields(); //get all predefined fields
    	
    	// add custom fields if passed
		if (Ext.isArray(this.customFields)) {
			fields = fields.concat(this.customFields);
		}
		else if (Ext.type(this.customFields) == 'string') {
			fields.push(this.customFields);
		}
		
    	// create store
		this.store = new Ext.data.SimpleStore({
			 id:0
			,fields:fields
			,data:[]
		});
		
		var cmArray = [{
			header: this.fileHeaderText, sortable: true, dataIndex: 'shortName',
			hideable:false, renderer: this.renderFileName.createDelegate(this)
		},{
			header: this.stateHeaderText, sortable: true, dataIndex: 'error',
			hideable:true, renderer: this.renderUploadState.createDelegate(this)
		},{
			header: this.operHeaderText, sortable: false, dataIndex: 'state',
			hideable:false, width:20, renderer: this.renderOperImage.createDelegate(this)
		}];
		
		// add custom columns if passed
		if (Ext.isArray(this.customColumns)) {
			cmArray = cmArray.concat(this.customColumns);
		}
		else if (Ext.type(this.customColumns) == 'string') {
			cmArray.push(this.customColumns);
		}
		
		// simple grid configurations
		this.cm = this.cm || new Ext.grid.ColumnModel(cmArray);
		
		this.sm = this.sm || new Ext.grid.RowSelectionModel({
			singleSelect: true
		});
		
		this.viewConfig = Ext.apply({
            forceFit:true
        }, this.viewConfig||{});
        
    	Ext.ux.UploadGridPanel.superclass.initComponent.call(this);
    	
    	// add events
		this.addEvents(
			/**
			 * Fires before the file is added to store. Return false to cancel the add
			 * @event beforefileadd
			 * @param {Ext.ux.UploadGridPanel}
			 * @param {Ext.form.FileUploadField}
			 * @param {String} file-name selected
			 */
			'beforefileadd'
			/**
			 * Fires after the file is added to the store
			 * @event fileadd
			 * @param {Ext.ux.UploadGridPanel} this
			 * @param {Ext.data.Store} store
			 * @param {Ext.data.Record} Record (containing the input) that has been added to the store
			 */
			,'fileadd'
			/**
			 * Fires before the file is removed from the store. Return false to cancel the remove
			 * @event beforefileremove
			 * @param {Ext.ux.UploadGridPanel} this
			 * @param {Ext.data.Store} store
			 * @param {Ext.data.Record} Record (containing the input) that is being removed from the store
			 */
			,'beforefileremove'
			/**
			 * Fires after the record (file) has been removed from the store
			 * @event fileremove
			 * @param {Ext.ux.UploadGridPanel} this
			 * @param {Ext.data.Store} store
			 */
			,'fileremove'
			/**
			 * Fires before all files are removed from the store (queue). Return false to cancel the clear.
			 * Events for individual files being removed are suspended while clearing the queue.
			 * @event beforequeueclear
			 * @param {Ext.ux.UploadGridPanel} this
			 * @param {Ext.data.Store} store
			 */
			,'beforequeueclear'
			/**
			 * Fires after the store (queue) has been cleared
			 * Events for individual files being removed are suspended while clearing the queue.
			 * @event queueclear
			 * @param {Ext.ux.UploadGridPanel} this
			 * @param {Ext.data.Store} store
			 */
			,'queueclear'
			/**
			 * Fires after the upload button is clicked but before any upload is started
			 * Return false to cancel the event
			 * @param {Ext.ux.UploadGridPanel} this
			 */
			,'beforeupload'
		);
		
		// create uploader
		var config = {
			 store:this.store
			,singleUpload:this.singleUpload
			,maxFileSize:this.maxFileSize
			,enableProgress:this.enableProgress
			,url:this.url
			,path:this.path
		};
		if(this.baseParams) {
			config.baseParams = this.baseParams;
		}
		if(this.enableProgress && this.progressUrl) {
			config.progressUrl = this.progressUrl;
		}
		this.uploader = new Ext.ux.FileUploader(config);

		// relay uploader events
		this.relayEvents(this.uploader, [
			 'beforeallstart'
			,'allfinished'
			,'progress'
		]);
		
		// install event handlers
		this.on({
			 beforeallstart:{scope:this, fn:function() {
			 	this.uploading = true;
				this.updateButtons();
			}}
			,allfinished:{scope:this, fn:function() {
				this.uploading = false;
				this.updateButtons();
			}}
			,progress:{scope:this, fn:this.onProgress}
			,beforefileadd:{scope:this, fn:this.onBeforeFileAdd}
			,cellclick:{scope:this, fn:this.onImgCellClick}
			,rowclick:{scope:this, fn:this.expandGridRow}
		});
    }
    
    ,onRender:function() {
		Ext.ux.UploadGridPanel.superclass.onRender.apply(this, arguments);

		// save useful references
		this.addBtn = Ext.getCmp(this.addBtnId);
		this.uploadBtn = Ext.getCmp(this.upldBtnId);
		this.removeAllBtn = Ext.getCmp(this.rmvAllBtnId);
		
		if (!this.addBtn.wrap.isShowTip) {
			this.addBtn.wrap.isShowTip = true;
			new Ext.ToolTip({
		        target: this.addBtn.wrap,
		        html: this.addBtn.button.tooltip || this.addBtn.button.text
		    });
		}
	}
    
    ,getAllFields: function() {
    	var fields = [
			 {name:'id', type:'text', system:true}
			,{name:'shortName', type:'text', system:true}
			,{name:'fileName', type:'text', system:true}
			,{name:'filePath', type:'text', system:true}
			,{name:'fileCls', type:'text', system:true}
			,{name:'input', system:true} //input file field object
			,{name:'form', system:true}  //input file form object
			,{name:'state', type:'text', system:true}
			,{name:'error', type:'text', system:true}
			,{name:'progressId', type:'int', system:true}
			,{name:'bytesTotal', type:'int', system:true}
			,{name:'bytesUploaded', type:'int', system:true}
			,{name:'estSec', type:'int', system:true}
			,{name:'filesUploaded', type:'int', system:true}
			,{name:'speedAverage', type:'int', system:true}
			,{name:'speedLast', type:'int', system:true}
			,{name:'timeLast', type:'int', system:true}
			,{name:'timeStart', type:'int', system:true}
			,{name:'pctComplete', type:'int', system:true}
            ,{name:'serverFileName', type:'text', system:true} //file name in server(includes full path)
		];
		return fields;
    }
    
    ,renderFileName: function(value, cell, record, rowIndex, colIndex) {
		var tpl = new Ext.XTemplate('<tpl for=".">',
		    '<div style="dispaly:inline;white-space:nowrap;">',
			'<div class="ux-up-icon-file {fileCls}">&#160;</div>',
			'<div class="ux-up-text x-unselectable" ext:qtip="{fileName}">{shortName}</div>',
			'</div>', '</tpl>', {scope:this}
		);
		return tpl.apply(record.data);
	}
	
	,renderUploadState: function(value, cell, record, rowIndex, colIndex) {
		return this.getQtip(record.data);
	}
	
	,renderOperImage: function(value, cell, record, rowIndex, colIndex) {
		var tpl = new Ext.XTemplate('<tpl for=".">',
			'<div id="remove-{[values.input.id]}" class="ux-up-icon-state ux-up-icon-{state}" ',
			'ext:qtip="{[this.getQtip(values,this.scope)]}">&#160;</div>',
			'</tpl>', {scope:this,
			getQtip:function(values,scope){
				var s = values.state, tip = '';
				if ('queued'==s || 'done'==s || 'failed'==s || 'stopped'==s) {
					tip = scope.clickRemoveText;
				} else if ('uploading'==s) {
					tip = String.format(scope.fileUploadingText, values.shortName);
					tip = scope.singleUpload ? tip :scope.clickStopText;
				}
				return tip;
			}}
		);
		return tpl.apply(record.data);
	}
    
	/**
	 * called by XTemplate to get qtip depending on state
	 * @private
	 * @param {Object} values XTemplate values
	 */
	,getQtip:function(values) {
		var qtip = '';
		switch(values.state) {
			case 'queued':
				qtip = String.format(this.fileQueuedText, values.fileName);
			break;

			case 'uploading':
				qtip = String.format(this.fileUploadingText, values.fileName);
				qtip += this.enableProgress ? ('<br>' + values.pctComplete + '% complete') : '';
			break;

			case 'done':
				qtip = String.format(this.fileDoneText, values.fileName);
			break;

			case 'failed':
				qtip = String.format(this.fileFailedText, values.fileName);
				qtip += '<br>' + this.errorText + ':' + values.error;
			break;

			case 'stopped':
				qtip = String.format(this.fileStoppedText, values.fileName);
			break;
		}
		return qtip;
	}
	
	/**
	 * Updates buttons states depending on uploading state
	 * @private
	 */
	,updateButtons:function() {
		if(true === this.uploading) {
			this.addBtn.disable();
			this.uploadBtn.disable();
			this.removeAllBtn.setIconClass(this.stopIconCls);
			this.removeAllBtn.getEl().child(this.removeAllBtn.buttonSelector).dom[this.removeAllBtn.tooltipType] = this.stopAllText;
		}
		else {
			this.addBtn.enable();
			this.uploadBtn.setDisabled(this.getUploadRecords().getCount()==0);
			this.removeAllBtn.setIconClass(this.removeAllIconCls);
			this.removeAllBtn.getEl().child(this.removeAllBtn.buttonSelector).dom[this.removeAllBtn.tooltipType] = this.removeAllText;
		}
	}
	
	/**
	 * called when file is added - adds file to store
	 * @private
	 * @param {Ext.form.FileUploadField}
	 * @param {String} file-name selected
	 */
	,onAddFile:function(uf, value) {
		if (false === this.fireEvent('beforefileadd', this, uf, value)) {
			return false;
		}
		var inp = uf.attachInpEl;

		// create new record and add it to store
		var rec = new this.store.recordType({
			 input:inp
			,fileName: value
			,filePath: this.fu.getFilePath(value)
			,shortName: this.fu.getShortFileName(value)
			,fileCls: this.fu.getFileCls(value,this.fileCls)
			,state:'queued'
		}, inp.id);
		rec.commit();
		this.store.add(rec);

		this.uploadBtn.enable();
		this.removeAllBtn.enable();

		this.fireEvent('fileadd', this, this.store, rec);
	}
	
	/**
	 * called before file is added to store
	 * @private
	 * @param {Ext.ux.UploadGridPanel}
	 * @param {Ext.form.FileUploadField}
	 * @param {String} file-name selected
	 */
	,onBeforeFileAdd: function(upgrid, uf, value) {
		// detach the input file element, then we can move it to upload form
		var inp = this.fu.detachInputFile(uf);
		inp.addClass('x-hidden');
		
        // file name can not contain blank spaces
        if (this.allowBlankFileName === false) {
            var sname = this.fu.getShortFileName(value);
            if (sname.indexOf(' ') >= 0) {
                this.xmsg(this.msgTitle, this.allowBlankFileNameText);
                inp.remove();
                return false;
            }
        }
        
		// check max file count
		if (this.maxFileCount && this.maxFileCount > 0) {
			if (this.store.getCount() >= this.maxFileCount) {
				this.xmsg(this.msgTitle, 
					String.format(this.maxFileCountText, this.maxFileCount));
				inp.remove();
				return false;
			}
		}
		
		// check file extensions
		var xts = this.fu.getFileNameExt(value);
		var allows = this.allowFileExtensions;
		if (!this.fu.matchsFileExtension(xts, allows)) {
			var filexs = allows.join(',');
			this.xmsg(this.msgTitle,
				String.format(this.allowFileExtensionsText, filexs));
			inp.remove();
			return false;
		}
		
		// check if file is duplicate selected
		var duplicate = false;
		this.store.each(function(rec){
			if (value == rec.get('fileName')) {
				duplicate = true;
				inp.remove();
				return false;
			}
		});
		if (duplicate) return false;
		
		// check if not allow select the same name files in different dir
		if (!this.allowSameFileName) {
			var same = false;
			var sname = this.fu.getShortFileName(value);
			this.store.each(function(rec){
				if (sname == rec.get('shortName')) {
					inp.remove();
					return !(same = true);
				}
			});
			if (same) {
				this.xmsg(this.msgTitle,
					String.format(this.allowSameFileNameText, sname));
				return false;
			}
		}
		
		// after all is valided, then we move it to upload form
		uf.attachInpEl = inp;
		
		return true;
	}
	
	/**
	 * tells uploader to upload
	 * @private
	 */
	,onUpload:function() {
		if(false === this.fireEvent('beforeupload', this)) {
			return false;
		}
		this.uploader.upload();
	}
	
	/**
	 * Remove All/Stop All button click handler
	 * @private
	 */
	,onRemoveAllClick:function(btn) {
		if(true === this.uploading) {
			this.stopAll();
		} else {
			this.removeAll();
		}
	}

	,stopAll:function() {
		this.uploader.stopAll();
	}
	
	/**
	 * Removes all files from store and destroys file inputs
	 */
	,removeAll:function() {
		if(false === this.fireEvent('beforequeueclear', this, this.store)) {
			return false;
		}

		this.store.each(this.onRemoveFile, this);
		this.fireEvent('queueclear', this, this.store);
	}
	
	/**
	 * called when file remove icon is clicked - performs the remove
	 * @private
	 * @param {Ext.data.Record}
	 */
	,onRemoveFile:function(record) {
		if(false === this.fireEvent('beforefileremove', this, this.store, record)) {
			return;
		}

		// remove DOM elements
		var inp = record.get('input');
		inp.remove();

		// remove record from store
		this.store.remove(record);

		var count = this.store.getCount();
		this.uploadBtn.setDisabled(!count);
		this.removeAllBtn.setDisabled(!count);

		this.fireEvent('fileremove', this, this.store);
	}
	
	/**
	 * called when remove-icon in the cell is clicked
	 * @private
	 * @param {Ext.ux.UploadGridPanel} grid
	 * @param {Number} rowIndex
	 * @param {Number} columnIndex
	 * @param {Ext.EventObject} e
	 */
	,onImgCellClick:function(grid, rowIndex, columnIndex, e) {
		var t = e.getTarget('div:any(.ux-up-icon-queued|.ux-up-icon-failed|.ux-up-icon-done|.ux-up-icon-stopped)');
		var record = grid.getStore().getAt(rowIndex);
		if(t) {
			this.onRemoveFile(record);
		}
		t = e.getTarget('div.ux-up-icon-uploading');
		if(t) {
			this.uploader.stopUpload(record);
		}
	}
	
	/**
	 * url setter
	 */
	,setUrl:function(url) {
		this.url = url;
		this.uploader.setUrl(url);
	}
	
	/**
	 * 设置允许的文件格式
	 * @param {Array} fileExts 文件后缀列表，如['jpg', 'txt']
	 */
	,setAllowFileExtensions: function(fileExts) {
		if (Ext.isArray(fileExts)) {
			this.allowFileExtensions = fileExts;
		}
		if (Ext.type(fileExts) == 'string') {
            this.allowFileExtensions = fileExts.split(',');
        }
	}
	
	/**
	 * destroys child components
	 * @private
	 */
	,onDestroy:function() {
		// destroy uploader
		if(this.uploader) {
			this.uploader.stopAll();
			this.uploader.purgeListeners();
			this.uploader = null;
		}
		Ext.ux.UploadGridPanel.superclass.onDestroy.call(this);
	}
	
	/**
	 * progress event handler
	 * @private
	 * @param {Ext.ux.FileUploader} uploader
	 * @param {Object} data progress data
	 * @param {Ext.data.Record} record
	 */
	,onProgress:function(uploader, data, record) {
		var bytesTotal, bytesUploaded, pctComplete, state, rowidx, celidx, item, width, pgWidth;
		if(record) {
			state = record.get('state');
			bytesTotal = record.get('bytesTotal') || 1;
			bytesUploaded = record.get('bytesUploaded') || 0;
			if('uploading' === state) {
				pctComplete = Math.round(1000 * bytesUploaded/bytesTotal) / 10;
			} else if('done' === 'state') {
				pctComplete = 100;
			} else {
				pctComplete = 0;
			}
			record.set('pctComplete', pctComplete);

			rowidx = this.store.indexOf(record);
			celidx = this.getColumnModel().getColumnCount()-1; //operation column
			item = this.view.getCell(rowidx, celidx);
			if(item) {
				width = item.getWidth();
				item.applyStyles({'background-position':width * pctComplete / 100 + 'px'});
			}
		}
	}
	
	/**
	 * update grid state and error info by fileName or fieldName
	 * @public
	 * @param {String} name fileName or fieldName
	 * @param {Boolean} succ succ or fail
	 * @param {String} msg message or exception message
	 */
	,updateState: function(name, succ, msg) {
		if (this.store.getCount() <= 0) return false;
		var records = this.store.queryBy(function(r){
			return (r.get('id')==name || r.get('fileName')==name || r.get('shortName')==name);
		});
		if (!succ) {
			msg = msg ? msg : this.unknownErrorText;
		}
		records.each(function(record) {
			if (succ) {
				record.set('state', 'done');
				record.set('error', msg);
			} else {
				record.set('state', 'failed');
				record.set('error', msg);
				Ext.getBody().appendChild(record.get('input'));
			}
			record.commit();
		}, this);
	}
	
	/**
	 * set grid state to uploading.
	 * @public
	 * @param {MixedCollection} records The records in this grid
	 */
	,setStateToUploading: function(records) {
		records.each(function(rec){
			rec.set('state', 'uploading');
			rec.commit();
		});
	}
	
	/**
     * set grid state to queued.
     * @public
     * @param {MixedCollection} records The records in this grid
     */
    ,setStateToQueued: function(records) {
        records.each(function(rec){
            rec.set('state', 'queued');
            rec.commit();
        });
    }
	
	/**
	 * get grid records which's state is not 'done'.
	 * @public
	 * @return {MixedCollection} uploading Is uploading or in queue
	 */
	,getUploadRecords: function() {
		return this.store.queryBy(function(r){return 'done'!==r.get('state');});
	}
	
	/**
	 * short hand for Ext.Msg.show
	 * @private
	 * @param {String} title
	 * @param {String} msg
	 * @param {Function} fn
	 */
	,xmsg: function(title, msg, fn){
        Ext.Msg.show({
            title: title, 
            msg: msg,
            fn: Ext.type(fn)?fn:Ext.emptyFn,
            icon: Ext.Msg.INFO,
            buttons: Ext.Msg.OK
        });
    }
    
    /**
	 * expand grid row to show more content
	 * @private
	 * @param {Ext.grid.GridPanel} grid
	 * @param {Number} row index number
	 * @param {Ext.EventObject} e
	 */
    ,expandGridRow: function(grid, rowIndex, e) {
		if (grid.ofCurrentRow) {
			Ext.fly(grid.ofCurrentRow).removeClass('x-grid3-cell-text-visible');
		}
		var view = grid.getView();
		var r = view.getRow(rowIndex);
		Ext.fly(r).addClass('x-grid3-cell-text-visible');
		grid.ofCurrentRow = r;
	}

});
Ext.reg('uploadgridpanel', Ext.ux.UploadGridPanel);