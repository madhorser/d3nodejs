/**
 * @class Ext.ux.ToggleButtonGroup
 * @extends Ext.Toolbar.Item
 * @auther lphuang 黄龙平
 * 工具栏排斥按钮组，只有一个按钮能够处于被按下的状态。
 * @param {Object} config Configuration options
 */
Ext.ux.ToggleButtonGroup = function(options){
    Ext.apply(this, options);
    var s = document.createElement("span");
    //s.className = "ytb-text";
    Ext.ux.ToggleButtonGroup.superclass.constructor.call(this, s);
    Ext.apply(this, new Ext.util.Observable());
};

Ext.extend(Ext.ux.ToggleButtonGroup, Ext.Toolbar.Item, {
    
    /**
     * @cfg {String} pressCls The style to display when button is pressed (defaults to "x-btn-pressed"). 
     */
    pressCls: 'ux-btn-pressed',
    
    // private
	initEvents : function(){
        this.addEvents(
            /**
             * @event actionfilter
             * This event fires if the filter button click or the filter keys Enter.
             * @param {Ext.ux.ToggleButtonGroup} this
             * @param {Ext.Button} click button
             * @param {Ext.Button} original button
             */
            'beforetoggle',
            /**
             * @event actionfilter
             * This event fires if the filter button click or the filter keys Enter.
             * @param {Ext.ux.ToggleButtonGroup} this
             * @param {Ext.Button} toggle button
             */
            'toggle'
        );
    },
    
    // private
    render : function(td){
        this.panel = new Ext.Panel({
            layout:'table', items: this.buttons, bodyStyle:'background-color:transparent;',
            defaultType: 'button', defaults:{hideParent: true}, border: false,
            renderTo: this.el
        });
        Ext.ux.ToggleButtonGroup.superclass.render.call(this, td);
        
        delete this.buttons;
        this.buttons = [];
        this.panel.items.each(function(b){
            if (b instanceof Ext.Button) {
                b.on('click', this.onButtonClick, this);
                this.buttons.push(b);
            }
        }, this);
        this.initEvents();
    },
    
    // private
    onResize : function(w, h){
        this.panel.setSize(w, h);
        this.panel.doLayout();
    },

    /**
     * @method getValue
     * @hide
     */
    getValue : function(){
        return this.value;
    },
    
    //private
    onButtonClick: function(btn, eventObj) {
    	this.toggleButton = btn;
    	if (false === this.fireEvent('beforetoggle', this, btn, this.toggleButton)) {
            return false;
        }
        if (null != this.toggleButton) {
            this.toggleButton.el.removeClass(this.pressCls);
        }
        if (btn != this.toggleButton) {
            btn.el.addClass(this.pressCls);
        }
        this.toggleButton = btn;
        this.fireEvent('toggle', this, this.toggleButton);
    }
    
});

Ext.reg('togglebuttongroup', Ext.ux.ToggleButtonGroup);
