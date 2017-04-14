Ext.ns('Ext.ux.plugin');
/**
 * 针对按钮的插件。当设置menu属性时按钮会出现一个小箭头图标，而此插件就是为了去掉这个小箭头。
 * @author huanglp
 * @version 1.0 2010-05-31
 */
Ext.ux.plugin.NoArrow = Ext.extend(Ext.util.Observable, {
    init: function(btn){
        this.button = btn;
        btn.afterMethod('onRender', this.removeArrow, this);
    },
    
    removeArrow: function(ct, position){
        var b = this.button;
        b.el.child(b.menuClassTarget).removeClass("x-btn-with-menu");
    }
})
