/**
 * CodePress是一个采用JavaScript开发，基于web的源代码编辑器。<br>
 * 当你在编辑框中，编写源代码时能够实时对语法进行着色加亮显示。<br>
 * 网址 - http://codepress.org/ http://codepress.sourceforge.net/
 * @author huanglp 黄龙平
 * @class Ext.ux.CodePress
 * @extends Ext.form.TextArea
 */
Ext.ux.CodePress = Ext.extend(Ext.form.TextArea, {
    /**
     * @cfg {Boolean} readOnly 是否只读。可以通过toggleReadOnly()方法修改。默认false
     */
    readOnly: false,
    
    /**
     * @cfg {Boolean} lineNumbers 是否显示行号。可以通过toggleLineNumbers()方法修改。默认true
     */
    lineNumbers: true,
    
    /**
     * @cfg {Boolean} autoComplete 是否自动完成代码。可以通过toggleAutoComplete()方法修改。默认true
     */
    autoComplete: true,
    
    /**
     * @cfg {String} editMode 编辑模式，分为html、text两种。默认为html模式。
     */
    editMode: 'html',
    
    /**
     * @cfg {Mix} sourceEl The id of the element or Element to pull code from
     */
    sourceEl: null,
    
    /**
     * @cfg {String} code The code to use in the editor when initialize
     */
    code: null,
    
    /**
     * @cfg {String} language The language to render the code with
     */
    language: 'generic',
    
    /**
     * @cfg {String} path The path to pull the codepress js and css file from
     */
    path: null,
    
    // private 
    initComponent : function(){
        Ext.ux.CodePress.superclass.initComponent.call(this);
        
        // Hide the sourceEl if provided
        if(this.sourceEl){
            this.textarea = this.el = Ext.get(this.sourceEl);
            this.el.hide();
        }
    },
    
    // private
    onRender : function(ct, position){
        if (!this.el) {
            Ext.ux.CodePress.superclass.onRender.call(this, ct, position);
            this.textarea = this.el;
        }
        this.el.addClass('x-hidden');
        if(Ext.isIE){ // fix IE 1px bogus margin
            this.el.applyStyles('margin-top:-1px;margin-bottom:-1px;')
        }
        //this.textarea.dom.style.overflow = 'hidden';
        this.textarea.dom.style.overflow = 'auto';
        
        this.findPath(); //init path
        
        // Create the iframe
        this.iframe = Ext.get(document.createElement('iframe'));
        this.iframe.dom.src = (Ext.SSL_SECURE_URL || 'javascript:return false;');
        this.iframe.dom.frameBorder = 0; // remove IE internal iframe border
        this.iframe.setStyle({
            'height': this.textarea.getComputedHeight() +'px',
            'width': this.textarea.getComputedWidth() +'px',
            'visibility':'hidden', 'position':'absolute',
            'border':'1px solid gray'
        });
        this.options = this.textarea.dom.className;
        
        this.wrap = this.el.wrap({cls: "x-form-field-wrap"});
        this.iframe.insertBefore(this.textarea.dom);
        
        this.edit();
    },
    
    /**
     * 找到请求路径，以便获取codepress的js和css文件
     */
    findPath: function() {
        if (!this.path) {
            var s = document.getElementsByTagName('script');
            for(var i=0,n=s.length; i<n; i++) {
                if (s[i].src.match('Ext.ux.CodePress.js')) {
                    this.path = s[i].src.replace('Ext.ux.CodePress.js','');
                    break;
                }
            }
        }
        return this.path;
    },
    
    /**
     * 初始化代码编辑器，使之可见
     */
    initialize: function() {
        if(Ext.isIE){
            this.doc = this.iframe.dom.contentWindow.document;
            this.win = this.iframe.dom.contentWindow;
        } else {
            this.doc = this.iframe.dom.contentDocument;
            this.win = this.iframe.dom.contentWindow;
        }
        
        this.editor = this.win.CodePress;
        this.editor.body = this.doc.getElementsByTagName('body')[0];
        Ext.get(this.editor.body).setStyle('height:100%;width:100%;margin:0;');
        this.editor.setCode(this.getInitValue());
        this.setOptions();
        this.editor.syntaxHighlight('init');
        
        this.textarea.dom.style.display = 'none';
        this.iframe.setStyle({
            'visibility':'visible', 'position':'static',
            'display':'block'
        });
        if(this.disabled) {
            this.editor.readOnly();
        }
        this.onResize(this.width,this.height);
    },
    
    /**
     * 编辑输入域
     * @param {Mix} el String id of element or element object
     * @param {String} language 
     */
    edit: function(el,language) {
        if (el) {
            var element = Ext.get(el);
            this.textarea.dom.value = (element ? element.getValue() : el);
        }
        this.language = language ? language : this.getLanguage();
        this.iframe.dom.src = this.path+'codepress.html?language='+this.language+'&ts='+(new Date).getTime();
        this.iframe.removeListener('load', this.initialize);
        this.iframe.on('load', this.initialize, this);
    },
    
    /**
     * 获取高亮的语言
     * @return {String} this.language or default 'generic'
     */
    getLanguage: function() {
        if (this.language) {
            return this.language;
        }
        for (language in Ext.ux.CodePress.languages) {
            if(this.options.match('\\b'+language+'\\b')) {
                return Ext.ux.CodePress.languages[language] ? language : 'generic';
            }
        }
    },
    
    /**
     * 设置参数
     */
    setOptions : function() {
        if(this.options.match('autocomplete-off') || !this.autoComplete){
            this.toggleAutoComplete();
        }
        if(this.options.match('readonly-on') || this.readOnly) {
            this.toggleReadOnly();
        }
        if(this.options.match('linenumbers-off') || !this.lineNumbers) {
            this.toggleLineNumbers();
        }
        if(this.editMode != 'html') {
            this.toggleEditor();
        }
    },
    
    getCode: function() {
        if(!this.rendered) {
            return this.getInitValue();
        }
        if (this.editMode == 'html') {
            return this.editor != null ? this.editor.getCode() : '';
        } else {
            return this.textarea.dom.value;
        }
    },
    
    setCode : function(code) {
        if (this.editMode == 'html') {
            if (this.editor != null) {
                this.editor.setCode(code);
                try{this.editor.syntaxHighlight('init');} catch(e){}
            }
        } else {
            this.textarea.dom.value = code;
        }
    },
    
    toggleAutoComplete : function() {
        this.autoComplete = this.editor.autocomplete = !(this.editor.autocomplete);
    },
    
    toggleReadOnly : function() {
        this.readOnly = this.textarea.dom.readOnly = !(this.textarea.dom.readOnly);
        if (this.iframe.dom.style.display != 'none') {// prevent exception on FF + iframe with display:none
            this.editor.readOnly(this.textarea.dom.readOnly);
        }
    },
    
    toggleLineNumbers : function() {
        Ext.fly(this.editor.body).toggleClass('hide-line-numbers');
        Ext.fly(this.editor.body).toggleClass('show-line-numbers');
        this.lineNumbers = !(this.lineNumbers);
    },
    
    toggleEditor : function() {
        if(this.editMode == 'html') {
            this.textarea.dom.value = this.getCode();
            this.iframe.dom.style.display = 'none';
            this.textarea.dom.style.display = 'block';
            this.editMode = 'text';
        }
        else {
            this.editor.setCode(this.textarea.dom.value);
            this.editor.syntaxHighlight('init');
            this.iframe.dom.style.display = 'block';
            this.textarea.dom.style.display = 'none';
            this.editMode = 'html';
        }
    },
    
    adjustSize : Ext.BoxComponent.prototype.adjustSize,
    
    // private
    onResize : function(w, h){
        Ext.ux.CodePress.superclass.onResize.call(this, w, h);
        var frm = Ext.get(this.iframe.dom);
        if(typeof w == 'number'){
            frm.setWidth(this.adjustWidth('input', w));
        } else {
            if (this.ownerCt) this.ownerCt.doLayout();
        }
        if(typeof h == 'number'){
            frm.setHeight(h);
        }
        this.wrap.setWidth(this.el.getWidth());
    }
    
    /**
     * 同步textarea与editor的值
     */
    ,syncValue: function() {
        if(this.editMode == 'html') {
            this.textarea.dom.value = this.editor.getCode();
        } else {
            if (this.editor != null) {
                this.editor.setCode(this.textarea.dom.value);
            }
        }
    }
    
    ,getInitValue : function() {
        return (!Ext.isEmpty(this.code)) ? this.code : 
               (!Ext.isEmpty(this.value)) ? this.value : this.textarea.dom.value;
    }
    
    /**
     * @method initValue
     * @hide
     */
    ,initValue : function(){
        var v = this.getInitValue();
        if (v == null || typeof(v) == 'undefined') {
            return;
        }
        this.setValue(v);
    }
    /**
     * @method getValue
     * @hide
     */
    ,getValue : function(){
        return this.getCode();
    }
    /**
     * @method getRawValue
     * @hide
     */
    ,getRawValue : function(){
        return Ext.ux.CodePress.superclass.getRawValue.call(this);
    }
    /**
     * @method setValue
     * @hide
     */
    ,setValue : function(v){
        Ext.ux.CodePress.superclass.setValue.call(this, v);
        this.setCode(v);
    }
    /**
     * @method setRawValue
     * @hide
     */
    ,setRawValue : function(v){
        Ext.ux.CodePress.superclass.setRawValue.call(this, v);
    }
    
    /**
     * Clears any text/value currently set in the field
     */
    ,clearValue : function(){
        this.setCode('');
        this.setRawValue('');
        this.value = '';
    }
    
    /**
     * Validates a value according to the field's validation rules and marks the field as invalid
     * if the validation fails
     * @param {Mixed} value The value to validate
     * @return {Boolean} True if the value is valid, else false
     */
    ,validateValue : function(value){
        value = Ext.isEmpty(value) ? '' : value.trim();
        return Ext.ux.CodePress.superclass.validateValue.call(this, value);
    },
    
    focus: function() {
        if(this.editMode == 'html') {return false;}
        Ext.ux.CodePress.superclass.focus.apply(this, arguments);
    },
    
    /**
     * Inserts the passed text at the current cursor position. Note: the editor must be initialized and activated
     * to insert text.
     * @param {String} text
     */
    insertAtCursor : function(text){
        var code = this.getCode() + text;
        this.setCode(code);
    }
    
});
Ext.reg('codepress', Ext.ux.CodePress);

Ext.ux.CodePress.languages = {  
    csharp : 'C#', 
    css : 'CSS', 
    generic : 'Generic',
    html : 'HTML',
    java : 'Java', 
    javascript : 'JavaScript', 
    perl : 'Perl', 
    ruby : 'Ruby',  
    php : 'PHP', 
    text : 'Text', 
    sql : 'SQL',
    vbscript : 'VBScript'
}
