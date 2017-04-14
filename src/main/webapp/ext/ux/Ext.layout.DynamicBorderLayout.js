/**
 * 主题{@link http://www.javaeye.com/topic/222701}
 * @author lphuang copy
 * @class Ext.layout.DynamicBorderLayout
 * @extends Ext.layout.BorderLayout
 */
Ext.layout.DynamicBorderLayout = Ext.extend(Ext.layout.BorderLayout, {
    onLayout : function(ct, target) {
        var collapsed = [];
        target.position();
        if (!this.rendered) {
            target.addClass('x-border-layout-ct');
            this.rendered = true;
        }

        //这部分代码直接从上面this.rendered的条件移出来,增加typeof this[pos] == "undefined"的判断
        var items = ct.items.items;
        for (var i = 0, len = items.length; i < len; i++) {
            var c = items[i];
            var pos = c.region;
            if (typeof this[pos] == "undefined")
            {
                if (c.collapsed) {
                    collapsed.push(c);
                }
                c.collapsed = false;
                if (!c.rendered) {
                    c.cls = c.cls ? c.cls + ' x-border-panel' : 'x-border-panel';
                    c.render(target, i);
                }
                this[pos] = pos != 'center' && c.split ?
                            new Ext.layout.BorderLayout.SplitRegion(this, c.initialConfig, pos) :
                            new Ext.layout.BorderLayout.Region(this, c.initialConfig, pos);
                this[pos].render(target, c);
            }
        }

        //删除掉不需要的区域属性
        this.removeNotExistsRegion(ct.items);
        var size = target.getViewSize();
        if (size.width < 20 || size.height < 20) { // display none?
            if (collapsed) {
                this.restoreCollapsed = collapsed;
            }
            return;
        } else if (this.restoreCollapsed) {
            collapsed = this.restoreCollapsed;
            delete this.restoreCollapsed;
        }

        var w = size.width, h = size.height;
        var centerW = w, centerH = h, centerY = 0, centerX = 0;

        var n = this.north, s = this.south, west = this.west, e = this.east, c = this.center;
        if (!c) {
            throw 'No center region defined in BorderLayout ' + ct.id;
        }

        if (n && n.isVisible()) {
            var b = n.getSize();
            var m = n.getMargins();
            b.width = w - (m.left + m.right);
            b.x = m.left;
            b.y = m.top;
            centerY = b.height + b.y + m.bottom;
            centerH -= centerY;
            n.applyLayout(b);
        }
        if (s && s.isVisible()) {
            var b = s.getSize();
            var m = s.getMargins();
            b.width = w - (m.left + m.right);
            b.x = m.left;
            var totalHeight = (b.height + m.top + m.bottom);
            b.y = h - totalHeight + m.top;
            centerH -= totalHeight;
            s.applyLayout(b);
        }
        if (west && west.isVisible()) {
            var b = west.getSize();
            var m = west.getMargins();
            b.height = centerH - (m.top + m.bottom);
            b.x = m.left;
            b.y = centerY + m.top;
            var totalWidth = (b.width + m.left + m.right);
            centerX += totalWidth;
            centerW -= totalWidth;
            west.applyLayout(b);
        }
        if (e && e.isVisible()) {
            var b = e.getSize();
            var m = e.getMargins();
            b.height = centerH - (m.top + m.bottom);
            var totalWidth = (b.width + m.left + m.right);
            b.x = w - totalWidth + m.left;
            b.y = centerY + m.top;
            centerW -= totalWidth;
            e.applyLayout(b);
        }

        var m = c.getMargins();
        var centerBox = {
            x: centerX + m.left,
            y: centerY + m.top,
            width: centerW - (m.left + m.right),
            height: centerH - (m.top + m.bottom)
        };
        c.applyLayout(centerBox);

        if (collapsed) {
            for (var i = 0, len = collapsed.length; i < len; i++) {
                collapsed[i].collapse(false);
            }
        }

        if (Ext.isIE && Ext.isStrict) { // workaround IE strict repainting issue
            target.repaint();
        }
    },
    
    removeNotExistsRegion:function(items) {
        var regions = ["north","south","west","east"];
        for (var i = 0; i < regions.length; i++)
        {
            if (this[regions[i]] && !items.find(function(item) {
                return item.region == regions[i]
            }))
            {
                this[regions[i]] = undefined;
            }
        }
    }
})
Ext.Container.LAYOUTS['dynamicborder'] = Ext.layout.DynamicBorderLayout;