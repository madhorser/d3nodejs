/**
 * 由于默认情况下，Ext.layout.ColumnLayout排列方式不处理组件的高度，默认按照组件内容的高度显示，
 * 导致组件的高度没有自动适应，因此这里增加了配置参数fitHeight，若设置为true则组件的高度自动计算
 * 为页面的高度(注意：适用于只有一列内容的情况下)。
 * @class Ext.ux.layout.ColumnFitLayout
 * @extends Ext.layout.ColumnLayout
 */
Ext.ux.layout.ColumnFitLayout = Ext.extend(Ext.layout.ColumnLayout, {
    /**
     * @cfg {Boolean} If set to True, the height will auto fit to the viewport
     */
    fitHeight: false,
    
    // private
    onLayout : function(ct, target){
        Ext.ux.layout.ColumnFitLayout.superclass.onLayout.apply(this, arguments);
        
        if (this.fitHeight === true) {
            var size = Ext.isIE && target.dom != Ext.getBody().dom ?
                    target.getStyleSize() : target.getViewSize();
            var cs = ct.items.items, len = cs.length, h = size.height - target.getPadding('tb');
            for(var i = 0; i < len; i++){
                cs[i].setHeight(h);
            }
        }
    }
});
Ext.Container.LAYOUTS['column-fit'] = Ext.ux.layout.ColumnFitLayout;
