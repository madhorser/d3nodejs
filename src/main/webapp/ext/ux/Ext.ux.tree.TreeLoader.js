/**
 * 修改Ext树加载控件的小问题，没有加载返回任何结点并且有错误时不回调错误处理句柄
 * @class Ext.ux.tree.TreeLoader
 * @extends Ext.tree.TreeLoader
 * @author huanglp
 * @version 1.0 2010-05-31
 */
Ext.ns('Ext.ux.tree');
Ext.ux.tree.TreeLoader = Ext.extend(Ext.tree.TreeLoader, {
    // private
    processResponse : function(response, node, callback){
        Ext.ux.tree.TreeLoader.superclass.processResponse.call(this, response, node, callback);
        var json = response.responseText;
        try {
            var o = eval("("+json+")");
            if (Ext.type(o.length) === false &&
                    (o.success === false || o.success == 'false')) {
                if (o.msg) { this.prompt(o.msg); }
                else {
                    this.handleFailure(response);
                }
            }
        }catch(e){
            this.handleFailure(response);
        }
    },
    
    // private
    prompt: function(msg) {
        extErr(msg); // 提示信息的方法，可能不同的地方还有不同的选择
    }
});
