/**
 * 带动画效果的CardLayout
 * @class Ext.layout.CardLayoutAnimate
 * @extends Ext.layout.CardLayout
 * @author huanglp
 * @version 1.0 2010-05-21
 */
Ext.layout.CardLayoutAnimate = Ext.extend(Ext.layout.CardLayout, {
    /**
     * Sets the active (visible) item in the layout.
     * @param {String/Number} item The string component id or numeric index of the item to activate
     */
    setActiveItem : function(item){
        item = this.container.getComponent(item);
        if(this.activeItem != item){
            var oldItem = this.activeItem;
            this.activeItem = item;
            this.layout();
            this.animateActiveItem(oldItem, item);
        }
    },
    
    /**
     * 动画效果的隐藏和显示
     * @param {Ext.Component} oldItem
     * @param {Ext.Component} newItem
     */
    animateActiveItem: function(oldItem, newItem) {
        if (oldItem != null) {
            oldItem.hide();
        }
        newItem.show();
        newItem.getEl().slideIn('l', {stopFx:true,duration:.2});
    }
    
});
Ext.Container.LAYOUTS['animatecard'] = Ext.layout.CardLayoutAnimate;