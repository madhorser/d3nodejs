Ext.namespace("Ext.ux.form");
Ext.ux.form.IpField = Ext.extend(Ext.ux.form.FieldPanel, {
	border: false,
	baseCls: null,
	layout: 'table',
	token: '.',
	value: '0.0.0.0',
	layoutConfig: {
		columns: 7
	},
	width: 200,
	allowBlank:false,
	// private
	initComponent: function()
	{
		this.items = [{
			xtype:'numberfield',
			width:45,
			style:{
				'text-align':'center'
			},
			id: this.name + '0',
			name: this.name + '0',
			allowBlank:false
			/*,
			listeners:{'blur': function(){
				var b = /^[0-9]{1,2}$/.test(this.value);
				var c = /^1[0-9][0-9]$/.test(this.value);
				var d = /^2[0-5][0-5]$/.test(this.value);
				if(!b & !c & !d){
					Ext.Msg.alert("系统提示", "请输入正确IP地址/掩码");
					//Ext.getCmp(this.id).focus(true, 1200);
					return false;
				}
				return true;
			}}*/
		}, {
			html: '&nbsp;.&nbsp;',
			baseCls: null,
			bodyStyle: 'font-weight: bold; font-size-adjust: .5',
			border: false
		}, {
			xtype:'numberfield',
			width:44,
			style:{
				'text-align':'center'
			},
			id: this.name + '1',
			name: this.name + '1',
			allowBlank:false
			/*,
			listeners:{'blur': function(){
				var b = /^[0-9]{1,2}$/.test(this.value);
				var c = /^1[0-9][0-9]$/.test(this.value);
				var d = /^2[0-5][0-5]$/.test(this.value);
				if(!b & !c & !d){
					Ext.Msg.alert("系统提示", "请输入正确IP地址/掩码");
					//Ext.getCmp(this.id).focus(true, 1200);
					return false;
				}
				return true;
			}}*/
		}, {
			html: '&nbsp;.&nbsp;',
			baseCls: null,
			bodyStyle: 'font-weight: bold; font-size-adjust: .5',
			border: false
		}, {
			xtype:'numberfield',
			width:44,
			style:{
				'text-align':'center'
			},
			id: this.name + '2',
			name: this.name + '2',
			allowBlank:false
			/*,
			listeners:{'blur': function(){
				var b = /^[0-9]{1,2}$/.test(this.value);
				var c = /^1[0-9][0-9]$/.test(this.value);
				var d = /^2[0-5][0-5]$/.test(this.value);
				if(!b & !c & !d){
					Ext.Msg.alert("系统提示", "请输入正确IP地址/掩码");
					//Ext.getCmp(this.id).focus(true, 1200);
					return false;
				}
				return true;
			}}*/
		}, {
			html: '&nbsp;.&nbsp;',
			baseCls: null,
			bodyStyle: 'font-weight: bold; font-size-adjust: .5',
			border: false
		}, {
			xtype:'numberfield',
			width:45,
			style:{
				'text-align':'center'
			},
			id: this.name + '3',
			name: this.name + '3',
			allowBlank:false
			/*,
			listeners:{'blur': function(){
				var b = /^[0-9]{1,2}$/.test(this.value);
				var c = /^1[0-9][0-9]$/.test(this.value);
				var d = /^2[0-5][0-5]$/.test(this.value);
				if(!b & !c & !d){
					Ext.Msg.alert("系统提示", "请输入正确IP地址/掩码");
					//Ext.getCmp(this.id).focus(true, 1200);
					return false;
				}
				return true;
			}}*/
		}]
		Ext.ux.form.IpField.superclass.initComponent.call(this);
	}
});
Ext.reg('uxipfield', Ext.ux.form.IpField);
