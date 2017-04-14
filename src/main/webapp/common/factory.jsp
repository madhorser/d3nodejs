<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<fmt:setBundle basename="resource.main_page" />
<HTML>
<HEAD>
<TITLE></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/menu.css" />
</HEAD>
<BODY>
<div id="MainPanel" style="width:100%;height:100%;">
    <iframe src="<%=request.getAttribute("forwardUrl")%>" frameborder="0" width="100%" height="100%"></iframe>
</div>
</BODY>
<script language="javascript">
Ext.onReady(function(){
    var center = new Ext.TabPanel({
        id: 'TabFactory',
        tabPosition: 'bottom',
        border: false,
        deferredRender: false,
        activeTab: 0,
        plugins: new Ext.ux.TabCloseMenu(),
        listeners: {'beforeremove': cleanupTabCache},
        items:[{
            title: '<fmt:message key="I18n.main.fatoryPage"/>', iconCls: 'ico_tab_list',
            closable: false,
            autoScroll: true,
            contentEl: 'MainPanel'
        }]
    });
     
    var viewport = new Ext.Viewport({
        layout: 'fit',
        border: false,
        items: [center]
    });
});

function addBottomTab(node) {
    var factory = Ext.getCmp("TabFactory");
    var tab = factory.findById(node.id);
    if (tab == null) {
        //处理同时打开太多内存泄漏、并发等问题
        if (factory.items.length > 20) {
            Ext.Msg.alert('<fmt:message key="I18n.main.displayError"/>',
                '<fmt:message key="I18n.main.displayTabError"><fmt:param value="20"/></fmt:message>');
            return false;
        }
        tab = factory.insert(1,{
            title: Ext.util.Format.htmlEncode(node.text),
            tabTip: node.tabTip,
            id: node.id,
            html: '<iframe border="0" frameBorder="0" width="100%" height="100%" src="#"></iframe>',
            closable: true,
            iconCls: node.iconCls||'ico_tab_list'
        });
        tab.show();
        tab.getEl().child('IFRAME',true).src = node.uri;
    } else {
        tab.show();
    }
}

function closeBottomTab(id) {
    var factory = Ext.getCmp("TabFactory");
    var tab = factory.findById(id);
    if (tab != null) {
        factory.remove(tab);
    }
}

function closeActiveTab() {
    var factory = Ext.getCmp("TabFactory");
    var tab = factory.getActiveTab();
    if (tab != null && tab.closable) {
        factory.remove(tab);
    }
}

function getBottomActiveTab() {
	var factory = Ext.getCmp("TabFactory");
    return factory.getActiveTab();
}
</script>
</HTML>