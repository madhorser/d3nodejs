/**
 * 简单扩展Ext.layout.Accordion:<br>
 * 1、使Header的样式符合实际需要；2、自动适应宽度、高度的需求；3、同时可用展开多个panel浏览。
 * @class Ext.ux.layout.BizAccordion
 * @extends Ext.layout.Accordion
 */
Ext.ux.layout.BizAccordion = Ext.extend(Ext.layout.Accordion, {

    /**
     * @cfg {Boolean} False to allow multiple panels to be displayed at the same time (defaults to true)
     */
    collapseOthers: true,
    /**
     * @cfg {String} Each item panel header css class, defualt is null, and will use the default value 'x-accordion-hd'
     */
    headerCls: null,
    /**
     * @cfg {Number} 若没有设置高度时自适应高度，但发现自适应的高度太小时了将使用minHeight
     */
    minHeight: 200,

    /**
     * @cfg {Boolean} False to not scroll the expanding item to the center of view (defaults to true)
     */
    scrollToCenter: true,
    
    /**
     * @cfg {Boolean} True to prevent display horizontal scrollBar
     */
    preventHorizontalBar: true,
    
    // private
    beforeExpand : function(p, anim){
        if (this.collapseOthers === false) {
            this.activeItem = null;
        }
        Ext.ux.layout.BizAccordion.superclass.beforeExpand.apply(this, arguments);
    },
    
    renderItem: function(c, position, target) {
        Ext.ux.layout.BizAccordion.superclass.renderItem.apply(this, arguments);
        if (this.collapseOthers === false) {
            this.activeItem = null;
        }
        if (Ext.type(this.headerCls) == 'string') {
            c.header.removeClass('x-accordion-hd');
            c.header.addClass(this.headerCls);
        }
        c.on('expand', this.afterExpand, this);
    },
    
    /**
     * 展开某个Panel后自动调整到视窗的中间，使之更人性化
     * @param {Ext.Panel} p 被展开的Panel
     */
    afterExpand: function(p) {
        if (this.scrollToCenter) {
            var target = this.container.getLayoutTarget();
            var innert = p.getEl(); //inner
            var om = target.getTop() + target.getViewSize().height/2;
            var im = innert.getTop() + innert.getViewSize().height/2;
            if (om < im) {
                target.scroll('bottom', im-om, true);
            } else {
                target.scroll('top', om-im, true);
            }
        }
        if (this.preventHorizontalBar == true) {
            this.preventHorizontalBarAction();
        }
    },
    
    // private
    onLayout : function(ct, target){
        Ext.layout.FitLayout.superclass.onLayout.call(this, ct, target);
        if(!this.container.collapsed){
            var items = this.container.items.items;
            for(var i = 0, len = items.length; i < len; i++){
                this.setItemSize(items[i], target.getStyleSize());
            }
        }
    },
    
    // private
    setItemSize : function(item, size){
        if(this.fill && item){
            if (Ext.isEmpty(item.height)) {
                var items = this.container.items.items;
                var hh = 0;
                for(var i = 0, len = items.length; i < len; i++){
                    var p = items[i];
                    if(p != item){
                        hh += (p.lastSize.height || p.getSize().height);
                    }
                }
                size.height -= hh;
                if (this.minHeight != null && size.height < this.minHeight) {
                    size.height = this.minHeight;
                }
            } else {
                size.height = item.height;
            }
            if (Ext.isEmpty(item.width)) {
                size.width = size.width;
            } else {
                size.width = item.width;
            }
            item.setSize(size);
        }
    },
    
    /*
     * preventHorizontalBarAction
     */
    preventHorizontalBarAction: function() {
        var target = this.container.getLayoutTarget();
        var containerWidth = target.getViewSize().width;
        var scrollWidth = target.dom.scrollWidth;
        if (scrollWidth <= containerWidth) {return;}
        var items = this.container.items.items;
        for(var i = 0, len = items.length; i < len; i++){
            var p = items[i];
            p.setWidth(containerWidth);
        }
    }
    
});
Ext.Container.LAYOUTS['biz.accordion'] = Ext.ux.layout.BizAccordion;