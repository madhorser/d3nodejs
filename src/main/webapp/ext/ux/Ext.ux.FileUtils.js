/**
 * Ext.ux.FileUtils，单实例，公共工具类。
 * Reusable file utils functions
 * @singleton
 * @auther huanglp 2008-11-04
 */
Ext.ux.FileUtils = function(){
	return {
		/**
		 * returns file class based on name extension
		 * @param {String} name File name to get class of
		 * @param {String} cls Default style class, default 'file'
		 * @param {Boolean} isDir Is or not a directory
		 * @param {Boolean} isDirOpened Is or not a directory opened
		 * @return {String} class to use for file type icon
		 */
		getFileCls: function(name, cls, isDir, isDirOpened) {
			if (isDir) {
				return isDirOpened ? (cls + '-dir-open') : (cls + '-dir');
			}
			var atmp = name.split('.');
			if (1 === atmp.length) {
				return cls;
			} else {
				return cls + '-' + atmp.pop().toLowerCase();
			}
		}
		
		/**
		 * get short file name
		 * @param {String} filename containing the full file path
		 * @return {String}
		 */
		,getShortFileName:function(filename) {
			return filename.split(/[\/\\]/).pop();
		}
		
		/**
		 * get file path (excluding the file name)
		 * @param {String} filename containing the full file path
		 * @return {String}
		 */
		,getFilePath:function(filename) {
			return filename.replace(/[^\/\\]+$/,'');
		}
		
		/**
		 * get file name extension
		 * @param {String} filename containing the full file path
		 * @return {String}
		 */
		,getFileNameExt:function(filename) {
			if (filename.indexOf('.') <= 0) return '';
			return filename.split('.').pop();
		}
		
		/**
		 * check if match file name extension
		 * @param {String} filename extension to be checked
		 * @param {String} or {Array} filename extension
		 * @return {String}
		 */
		,matchsFileExtension:function(extension, exs) {
			if (exs == undefined || exs == null || exs == ''){ return true;}
			if (Ext.type(exs)=='string'){ exs = [exs];}
			if (Ext.isArray(exs)) {
				for (var i=0; i<exs.length; i++) {
					if (Ext.type(exs[i]) != 'string') continue;
					if (extension.toLowerCase() == exs[i].toLowerCase()) {
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * Detaches the input file associated with the Ext.form.FileUploadField
		 * so that it can be used for other purposed (e.g. uplaoding).
		 * @param {Ext.form.FileUploadField} upfield
		 * @return {Ext.Element} the detached input file element.
		 */
		,detachInputFile: function(upfield){
			var result = upfield.fileInput;
			
			// remove
			upfield.fileInput.remove();
			
			// create
			upfield.fileInput = upfield.wrap.createChild({
				id: Ext.id(),
	            name: upfield.name||upfield.getId(),
	            cls: 'x-form-file',
	            tag: 'input',  type: 'file', size: 1
			});
			
	        upfield.fileInput.on('change', function(){
	            var v = this.fileInput.dom.value;
	            this.setValue(v);
	            this.fireEvent('fileselected', this, v);
	        }, upfield);
	        upfield.button.on('click', function(){
	        	upfield.fileInput.dom.click();
	        });
			return result;
		}
	
	}
}();
