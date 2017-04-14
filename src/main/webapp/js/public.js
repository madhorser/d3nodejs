Ext.page = {pageSize: 15};

/**
 * short hand for Ext.get(id).getValue(asNumber), equals document.getElementById(id).value
 * @param {String} id Element ID
 * @param {Boolean} asNumber if true then return number, else return string. Default is false.
 */
$g = function(id,asNumber){return Ext.get(id).getValue(asNumber)};

/**
 * JsonStore，用于加载CodeString列表
 */
function storeCodeString(code, option) {
    var showEmpty = option.showEmpty? option.showEmpty : false;
    var store = new Ext.data.JsonStore({
        url: 'common.do?invoke=comboCodeString&codeId='+code+'&showEmpty='+showEmpty,
        root: 'list', id:'itemCode', successProperty:'success',
        fields: ['paramCode', 'itemCode', 'itemValue', 'itemOrder', 'description']
    });
    return store;
}

/**
 * 用于加载通用查询，客户端使用时只要设置codeTable值即可生成一个下拉框，如：
 * {name: 'groupId', fieldLabel: '编组', xtype:'combo', mode:'local', 
 *  codeTable:'UserGroup', showEmpty:true, baseParams:{a:'a'}}
 * 其中，
 * (1)displayField和valueField通过module.js中的getCodeComboOption()方法设置，在其他使用的地方就不用再重复写；
 * (2)requestUrl为请求的URL，可以自己指定，也是在module.js中的getCodeComboOption()方法中，如果没有指定则使用默认的URL：
 * common.do?invoke=comboCodeTable；
 * (3)请求参数，默认提供：code,showEmpty,key,display,query。如果需要其他参数，在baseParams中设置。
 * (4)showEmpty指示是否出现空值的可选项下拉，默认为false。
 * (5)initLoad：initLoad为true，则下拉框展现时自动查询一次；否则，只在用户点击下拉框按钮时才查询。
 */
function storeCodeTable(code, option) {
    if (Ext.isEmpty(option.requestUrl)) {
        option.requestUrl = 'common.do?invoke=comboCodeTable';
    }
    var baseParams = {code:code, showEmpty: (option.showEmpty? option.showEmpty : false),
        key: option.valueField, display: option.displayField
    };
    if (!Ext.isEmpty(option.baseParams)) {
        Ext.apply(baseParams, option.baseParams);
    }
    var store = new Ext.data.JsonStore({
        url: option.requestUrl,
        baseParams: baseParams,
        root: 'list', successProperty:'success', fields: [] //get from server side
    });
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
    return store;
}

/* 
 * 动态创建一个空的BasicForm，并给它随机创建一个无意义的隐藏Hidden域。
 * 作用：使用BasicForm的load/submit方法加载或提交数据，与服务器交换json形式的数据
 * 例子：getEmptyForm().doAction('submit',{url:'your-url',params:{'anyname':any},....});
 */
function getEmptyForm() {
    var tag = Ext.getBody().createChild({tag:'form'});
    return new Ext.form.BasicForm(tag,{timeout:90});
}

function todo(msg) {
    if(!msg){ msg = '功能实现中, ... &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ';}
    Ext.MessageBox.show({
        title : 'TODO:',
        msg : msg,
        buttons : Ext.MessageBox.OK,
        icon : Ext.MessageBox.INFO 
    });
}

function extInfo(msg, fn) {
    extShow('info', msg, fn);
}
function extWarn(msg, fn) {
    extShow('warning', msg, fn);
}
function extErr(msg, fn) {
    extShow('error', msg, fn);
}
function extConfirm(msg,opt) {//注意参数opt，它不是function，要传的function在opt.fn
    Ext.MessageBox.confirm(Ext.AL.confirmTitle, msg, function(btn){
        if ('yes'==btn && Ext.type(opt) && 'function'==Ext.type(opt.fn)){
            opt.fn(opt.arguments);
        }
    });
}

function extShow(level, msg, fn) {
    var buttons = Ext.MessageBox.OK;
    var icon = Ext.MessageBox.INFO;
    var title = "";
    if('info'==level) {
        icon = Ext.MessageBox.INFO;
        title = Ext.AL.infoTitle;
    } else if('warning'==level) {
        icon = Ext.MessageBox.WARNING;
        buttons = Ext.MessageBox.CANCEL;
        title = Ext.AL.warnTitle;
    } else if('error'==level) {
        icon = Ext.MessageBox.ERROR;
        title = Ext.AL.errorTitle;
    }
    Ext.MessageBox.show({
        title : title,
        msg : msg,
        buttons : buttons,
        fn: Ext.type(fn)?fn:Ext.emptyFn,
        icon : icon
    });
}

//===================================
//校验Form/Grid
//===================================
function validFormData(form) {
    form.clearInvalid();
    if (!form.isValid()) {
        extWarn(Ext.AL.validInfoText);
        return false;
    }
    return true;
}

/* 
 * 校验Grid的选择的行数，当没有选择任何记录时提示用户，
 * 当选择行数的数目不符合时也应提示用户，且提示信息可以自定义。用法：
 * validGridSele(sm, {strictCount:2, msgs:'选择了{count}行，用户需要{strict}行', emptyText:'请选择XX'});
 */
function validGridSele(sm, options) {
	options = options || {};
    if (sm.getCount() === 0) {
        extInfo(options.emptyText || Ext.AL.validGridText);
        return false;
    }
    var strictCount = null;
    if (options.strictCount) {
        strictCount = options.strictCount;
    }
    if (strictCount!==null && sm.getCount()!==strictCount) {
        var msgs = options.msgs || Ext.AL.strictGridText;
        var info = new Ext.Template(msgs).apply({'count':sm.getCount(),'strict':strictCount});
        extInfo(info);
        return false;
    }
    return true;
}

//分页参数：paging param====================
function getPagParam(pageSize) {
    var pagParam = {params:{
        start: 0,
        limit: pageSize||Ext.page.pageSize
    }};
    return pagParam;
}

//Tab page第一次出现时加载数据
function beforeShowTab(tab) {
    if (tab.hasLoaded){ return true;}
    if (tab.store){ tab.store.load(getPagParam(tab.pageSize));}
    tab.hasLoaded = true;
}

/*
 * 将grid的数据由其store进行重载reload。
 * 公共方法：用于页面增删改后的刷新操作。paging默认为true，即默认分页。
 */
function reloadData(grid,paging) {
    if (!Ext.type(grid) || !Ext.type(grid.store)){ return false;}
    paging = Ext.type(paging) ? paging:true; //default:true
    grid.store.reload(paging?getPagParam(grid.pageSize):null);
}

/**
 * 默认的查询Form与Grid
 * @param {GridPanel} grid
 * @param {FormPanel/BasicForm} form
 * @param {Object} otherparam
 * @param {Boolean} paging Default is true 
 */
function doLoadAction(grid, form, otherparam, paging) {
    var basicForm = form;
    if (form instanceof Ext.form.FormPanel) {
        basicForm = form.getForm();
    }
    if (basicForm != null && basicForm != undefined) {
        if (!validFormData(basicForm)){ return false;}
        Ext.apply(grid.getStore().baseParams, basicForm.getValues());
    }
    if (Ext.type(otherparam) == 'object') {
        Ext.apply(grid.getStore().baseParams, otherparam);
    }
    reloadData(grid, paging);
}

/**
 * 操作成功的提示消息框，出现后n秒自动消失
 * @param {Object} option 配置
 */
function ghostSucc(option){
    Ext.MessageBox.show(Ext.apply({
        icon: Ext.MessageBox.INFO,
        title: Ext.AL.infoTitle,
        msg: Ext.AL.actionSuccText,
        closable: false
    }, option=option||{}));
    var delay = option.delay ? option.delay : 500;
    (function(){
        Ext.MessageBox.getDialog().getEl().fadeOut({
            duration: 0.4, endOpacity: 0,
            callback: function(){Ext.MessageBox.hide();
                Ext.callback(option.callback, option.scope, [this]);
            }
        });
    }).defer(delay);
}

/*
 * operSucc/operFail：Ext.form.BasicForm提交数据操作的成功/失败回调方法。
 * 返回的json串应该是一个对象串，它将被赋值为BasicForm的action.result，如：
 * action.result例子：{'success':true,msg:'操作成功，共删除记录3条。'}
 * 需要回调的客户端方法callback可设置在option.fn，如：
 * 而function doSucc(form,action){operSucc(form,action,{fn:someFn})}。
 */
function operSucc(form,action,option) {
    if (!Ext.type(action) || !Ext.type(action.result)) {
        extErr(Ext.AL.actionNoResult);
        return false;
    }
    var msg = (Ext.type(action) && Ext.type(action.result)
        && Ext.type(action.result.msg)) ? action.result.msg : "";
    option = option || {};
    extInfo((option.tipText||Ext.AL.actionSuccText)+msg, option.fn);
}

function operFail(form,action,option) {
    var msg = (Ext.type(action) && Ext.type(action.result)
        && Ext.type(action.result.msg)) ? action.result.msg : "";
    option = option||{};
    if (action.failureType==Ext.form.Action.CLIENT_INVALID) {
        msg = Ext.AL.actionValidFail;
    }
    if (action.failureType==Ext.form.Action.CONNECT_FAILURE) {
        msg = Ext.AL.failRequestText;
    }
    extErr((option.tipText||Ext.AL.actionFailText)+msg, option.fn);
}

/*
 * ajaxSucc/ajaxFail，Ext.Ajax.request的结果成功/失败的操作方法。
 * 要求服务器返回的XML必须包含result结点，其内容为json字符串，如：
 * <root><result>{'success':true,msg:'操作成功，共删除记录3条。'}</result></root>
 * 需要回调的客户端方法callback可设置在response.actionFn，如：
 * 请求时设置调用成功的回调方法：Ext.Ajax.request({success:doSucc,...})，
 * 而function doSucc(response){response.actionFn=someFn; ajaxSucc(response)}。
 */
function ajaxSucc(response) {
    var xml = response.responseXML;
    if (!Ext.type(xml) || !Ext.type(xml.getElementsByTagName("result"))) {
        extErr(Ext.AL.actionNoResult);
        return false;
    }
    var results = xml.getElementsByTagName("result");
    var result = results.length>0 ? results[0].text : "{}";
    var r = Ext.decode(result) || {};
    if (!r.success) {
        ajaxFail(response); return;
    }
    var msg = r.msg||"";
    extInfo(Ext.AL.actionSuccText+msg, response.actionFn);
}

function ajaxFail(response) {
    var xml = response.responseXML;
    if (!Ext.type(xml)) {
        extErr(Ext.AL.actionRequestFail);
        return false;
    }
    var msg = "";
    if (Ext.type(xml) && Ext.type(xml.getElementsByTagName("result"))) {
        var results = xml.getElementsByTagName("result");
        var result = results.length>0 ? results[0].text : "{}";
        var r = Ext.decode(result) || {};
        msg = r.msg||"";
    }
    extErr(Ext.AL.actionFailText+msg, response.actionFn);
}

/**
 * 实现遮罩功能，默认将遮罩HTML-Body对象。
 * 用法：mask()或者mask({el:grid, msg:'waiting..', msgCls:''})
 */
function mask(options) {
    options = options || {};
    var el = options.el || Ext.getBody();
    options.msg = options.msg || Ext.AL.maskText;
    var m = new Ext.LoadMask(el, options);
    m.show();
    return m;
}

/**
 * 在弹出的页面键入[ESC]键，将退出窗口
 */
Ext.onReady(function(){
    Ext.getDoc().keymap = Ext.getDoc().addKeyListener(Ext.EventObject.ESC,
        function(){
            try{if (window.opener) window.close();}catch(e){}
        }
    );
});

/**
 * Ext.grid的单元格对数据显示都是采用省略的办法来处理的，通过该方法可以显示完整的内容。
 * 用法：可在grid的单击事件上调用该方法，如listeners:{rowclick:expandGridRow}
 */
function expandGridRow(grid, rowIndex, eventObject) {
    if (grid.ofCurrentRow) {
        Ext.fly(grid.ofCurrentRow).removeClass('x-grid3-cell-text-visible');
    }
    var view = grid.getView();
    var r = view.getRow(rowIndex);
    Ext.fly(r).addClass('x-grid3-cell-text-visible');
    grid.ofCurrentRow = r;
}

/** 编辑表格中不可编辑的单元格，设置其背景色为灰色 */
function disabledEditCell(value, cell, record) {
    cell.attr = 'style="background-color:#eeeeee;"';
    return value;
}

/** 全选grid的行 */
function selectAllExt(grid) {
    grid.getSelectionModel().selectAll();
}
/** 反选grid的行 */
function selectOppExt(grid) {
    var sm = grid.getSelectionModel();
    var i = 0;
    grid.getStore().each(function(r){
        if (sm.isSelected(i)) {
            sm.deselectRow(i);
        } else {
            sm.selectRow(i, true);
        }
        i = i+1;
    });
}

/**
 * 创建定时任务(循环执行加载与刷新，间隔500毫秒)。
 * @param {Ext.data.Store} store 加载器
 * @return {Ext.util.TaskRunner.TaskObj} 交付TaskRunner执行的任务对象
 */
function createTask(store) {
    store.on('loadexception', function(store) { // 异常
        store.loading = false;
    });
    store.on('load', function(store) { //成功
        store.loading = false;
    });
    var task = {
        run: function(){
            if (store.loading) {
                return true;
            }
            store.reload();
            store.loading = true;
        },
        interval: 500, //milliseconds
        args: [store]
    }
    return task;
}

function checkExistsObj(obj, props) {
    if (Ext.isEmpty(obj)) {
        return false;
    }
    var s = props.split('.');
    var exists = true, tempObj = obj;
    Ext.each(s, function(p){
        if (Ext.isEmpty(tempObj[p])){
            return (exists = false);
        }
        tempObj = tempObj[p];
    });
    return exists;
}
