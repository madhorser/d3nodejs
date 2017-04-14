Ext.ns('Ext.mm');
/**
 * 提供一些对控件展开收缩的功能
 * @type Ext.mm.Expander
 */
Ext.mm.Expander = {
    /**
     * 最大化中间控件
     */
    maximizeCenter: function(event,toolEl,panel) {
        var n = panel.ownerCt.getLayout()["north"];
        if (n && n.collapsible) {
            n.panel.collapse();
        }
        toolEl.hide();
        panel.tools.restore.show();
    }
    
    /**
     * 还原中间控件
     */
    ,restoreCenter: function(event,toolEl,panel) {
        var n = panel.ownerCt.getLayout()["north"];
        if (n && n.collapsible) {
            n.panel.expand();
        }
        toolEl.hide();
        panel.tools.maximize.show();
    }
    
    /**
     * 增加对窗口的Header栏的双击事件：展开或收缩。
     * @param {Ext.Panel} panel
     */
    ,enableHeaderCollapse: function (panel) {
        if (panel.header == null || panel.header == undefined) {
            return false;
        }
        panel.header.on('dblclick', function(event){
            if (panel.region == 'center') {
                if (panel.tools.maximize.isVisible()) {
                    Ext.mm.Expander.maximizeCenter(event, panel.tools.maximize, panel);
                } else {
                    Ext.mm.Expander.restoreCenter(event, panel.tools.restore, panel);
                }
            } else {
                panel.toggleCollapse();
            }
        });
    }
    
    /**
     * 自动伸缩左右。收缩左边则展开右边，收缩右边则展开左边。
     * @param {Ext.Panel} p
     */
    ,autoLayoutExpand: function(p) {
        var layout = p.ownerCt.getLayout();
        var op = layout[p.region=='west' ? 'east':'west'].panel;
        var w = (Ext.getBody().getWidth()-centerWidth)*0.5;
        var cs = layout['center'].getSize();
        if (p.isVisible() && op.isVisible()) {
            op.setWidth(w);
            p.setWidth(w);
        } else if (p.isVisible()) {
            op.setWidth(cs.width-25);
        }
        layout['center'].panel.setSize(25, cs.height);
        p.ownerCt.doLayout();
    }
    
    /**
     * 自动伸缩左右。收缩左边则展开右边，收缩右边则展开左边。
     * @param {Ext.Panel} p
     */
    ,autoLayoutCollapse: function(p) {
        var layout = p.ownerCt.getLayout();
        var op = layout[p.region=='west' ? 'east':'west'].panel;
        var w = (Ext.getBody().getWidth()-centerWidth)*0.5;
        var cs = layout['center'].getSize();
        if (op.isVisible()) {
            op.setWidth(w+cs.width-25);
        }
        layout['center'].panel.setSize(25, cs.height);
        p.ownerCt.doLayout();
    }

};
