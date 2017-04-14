var W=screen.width;
var H=screen.height;
//读取cookies
function getCookie(name){
var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
if(arr=document.cookie.match(reg)){
return (arr[2]);
}else{
return null;
}
}
function openWin(_1,w,h,_2,_3){
if(!w){
w=W/2+250;
}
if(!h){
h=H/2+150;
}
if(!_2){
_2="_win"+new Date().getTime();
}
_2=escape(_2).replace(/\W/g,"_");
var _4=screen.availWidth;
var _5=screen.availHeight;
var _6=(_4-w-6)/2-2;
var _7=(_5-h-24)/2-2;
if(_6<0){
_6=0;
}
if(_7<0){
_7=0;
}
var _8=Ext.apply({width:w,height:h,left:_6,top:_7,toolbar:"no",status:"yes",menubar:"no",scrollbars:"yes",resizable:"yes"},_3||{});
var _9=Ext.urlEncode(_8).replace(/\&/g,",");
var wh=window.open(_1,_2,_9);
if(wh!=null){
wh.focus();
}
return wh;
};
function maxWin(_a,_b,_c){
if(_b){
_b=escape(_b).replace(/\W/g,"_");
}
var _d=Ext.apply({width:W-4,height:H-35,toolbar:"no",status:"no",menubar:"no",scrollbars:"auto",resizable:"no"},_c||{});
var _e=Ext.urlEncode(_d).replace(/\&/g,",");
win=window.open(_a,_b,_e);
win.moveTo(-2,-23);
if(win!=null){
win.focus();
}
return win;
};
function maxScrollWin(_f,_10,_11){
if(_10){
_10=escape(_10).replace(/\W/g,"_");
}
var opt=Ext.apply({width:W-4,height:H-30,toolbar:"no",status:"no",menubar:"no",scrollbars:"yes",resizable:"no"},_11||{});
var str=Ext.urlEncode(opt).replace(/\&/g,",");
win=window.open(_f,_10,str);
win.moveTo(-2,-22);
if(win!=null){
win.focus();
}
return win;
};
function hidWin(url,_12,_13){
if(_12){
_12=escape(_12).replace(/\W/g,"_");
}
var opt=Ext.apply({width:30,height:30,toolbar:"yes",status:"yes",menubar:"no",scrollbars:"yes",resizable:"yes"},_13||{});
var str=Ext.urlEncode(opt).replace(/\&/g,",");
win=window.open(url,_12,str);
win.moveTo(-5000,-5000);
if(win!=null){
win.focus();
}
};
function showMessage(msg){
try{
document.getElementById("spanMessage").innerHTML="<font color='#FF0000'>"+msg+"</font>";
}
catch(e){
alert("页面中没有ID为[spanMessage]的对象 ...    ");
}
};
String.prototype.trim=function(_14){
if(_14==null){
return this.replace(/(^\s*)|(\s*$)/g,"");
}
if(_14){
return this.replace(/^\s*/g,"");
}
if(!_14){
return this.replace(/\s*$/g,"");
}
};
String.prototype.unicodeLength=function(){
var _15=this.match(/[^\x00-\xff]/ig);
return this.length+(_15==null?0:_15.length);
};
String.prototype.hashCode=function(){
var h=0,off=0;
for(var i=0,len=this.length;i<len;i++){
h=31*h+this.charCodeAt(off++);
}
var t=-2147483648*2;
while(h>2147483647){
h+=t;
}
return h;
};
String.prototype.isEmpty=function(){
return this.trim().unicodeLength()<1;
};
String.prototype.isLengthBetween=function(min,max){
return (this.unicodeLength()>min&&this.unicodeLength()<max);
};
String.prototype.actLength=function(){
var arr=this.match(/[^\x00-\xff]/ig);
return this.length+(arr==null?0:arr.length);
};
String.prototype.leftCut=function(num,_16){
var str=this.substr(0,num);
if(!_16){
return str;
}
var n=str.actLength()-str.length;
num=num-parseInt(n/2);
return this.substr(0,num);
};
String.prototype.isLow=function(min){
return (this.unicodeLength()<min);
};
String.prototype.isHight=function(max){
return (this.unicodeLength()>max);
};
String.prototype.isDateString=function(){
return isDate(this)==null;
};
String.prototype.isEMailString=function(){
return isEMail(this);
};
String.prototype.isValedateString=function(_17){
return isValedate(_17,this);
};
String.prototype.hexColor=function(){
if(this.indexOf("#")>=0){
if(this.length==4){
var cs=this.split("");
return "#"+cs[1]+cs[1]+cs[2]+cs[2]+cs[3]+cs[3];
}
return this;
}
var _18=new RegExp("2[0-4]\\d|25[0-5]|[01]?\\d\\d?","ig");
var va=this.match(_18);
if(va==null||va.length!=3){
return "#000000";
}
var _19="#";
for(var i=0;i<3;i++){
var num=parseInt(va[i]);
_19+=num<16?"0"+num.toString(16):num.toString(16);
}
return _19;
};
Array.prototype.clearAll=function(){
for(var i=this.length-1;i>=0;i--){
this.remove(this[i]);
}
return this;
};
function isDate(_1a){
var _1b=/^(\d{4})(\-)(\d{2})(\-)(\d{2})$/;
var _1c=_1a.match(_1b);
if(_1c==null){
return "错误：日期格式必须是\"YYYY-MM-DD\" ...        ";
}
year=_1c[1];
month=_1c[3];
day=_1c[5];
if(month<1||month>12){
return "错误：月份必须在01-12之间 ...        ";
}
if(day<1||day>31){
return "错误：日必须在01-31之间 ...        ";
}
if((month==4||month==6||month==9||month==11)&&day==31){
return "错误："+month+"月没有"+day+"日 ...        ";
}
if(month==2){
var _1d=(year%4==0&&(year%100!=0||year%400==0));
if(day>29||(day==29&&!_1d)){
return "错误："+year+"年2月没有"+day+"日 ...        ";
}
}
return null;
};
function isEMail(str){
var l=/^([A-Za-z])+(\w|[-]|[.])*([A-Za-z0-9])+@(\w|[-])+\..+$/;
return (l.test(str));
};
function isValedate(_1e,str){
switch(_1e){
case 1:
var _1f=/[^\d]/g;
return (_1f.test(str));
break;
case 2:
var _1f=/^[A-Za-z]+$/g;
return (_1f.test(str));
break;
case 3:
var _1f=/[\W]/g;
return (_1f.test(str));
break;
case 4:
var _1f=/[^\u4E00-\u9FA5]/g;
return (_1f.test(str));
break;
case 5:
var _1f=/[^\x00-\xff]/g;
return (_1f.test(str));
break;
case 6:
var _20=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
var _21=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
return (_20.test(str)||_21.test(str));
break;
}
};
function calculateOffset(_22,_23){
var _24=0;
while(_22){
_24+=_22[_23];
_22=_22.offsetParent;
}
return _24;
};
function calculateOffsetLocate(o){
var _25=calculateOffset(o,"offsetLeft");
var _26=calculateOffset(o,"offsetTop");
return {left:_25,top:_26};
};
function getDigitals(str){
var ret="";
for(var i=0;i<str.length;i++){
var n=parseInt(str.charAt(i));
if(!isNaN(n)){
ret+=n;
}
}
return ret;
};
function isDblbyteChar(str){
return str.isValedateString(5);
};
function encodeURL(str){
if(str==null){
return "";
}
var buf=[];
for(var i=0;i<str.length;i++){
var c=str.substring(i,i+1);
if(isDblbyteChar(c)){
buf.push(c);
}else{
buf.push(encodeURIComponent(c));
}
}
return buf.join("");
};
function formatDate(_27){
var _28=_27.getFullYear();
var _29=_27.getMonth()+1;
var day=_27.getDate();
return _28+"-"+(_29<10?"0"+_29:_29)+"-"+(day<10?"0"+day:day);
};
function formatTime(_2a){
var _2b=_2a.getHours();
var _2c=_2a.getMinutes();
var _2d=_2a.getSeconds();
var s=(_2b<10?"0"+_2b:_2b)+":"+(_2c<10?"0"+_2c:_2c)+":"+(_2d<10?"0"+_2d:_2d);
return s;
};
function formatDateTime(_2e){
var s1=formatDate(_2e);
var s2=formatTime(_2e);
return s1+" "+s2;
};
function formatChineseDate(_2f){
if(_2f==""){
return "";
}
var _30=_2f.split("-");
var _31=_30[0];
var _32=_30[1];
var day=_30[2];
return (_31+"年"+parseMyInt(_32)+"月"+parseMyInt(day)+"日");
};
function getToday(){
var _33=new Date();
return formatDate(_33);
};
function getTime(){
var _34=new Date();
return formatTime(_34);
};
function getDateTime(){
var _35=new Date();
return formatDateTime(_35);
};
function getColorDlg(_36){
var _37="";
if(Ext.isIE){
var _38=document.getElementById("dlgHelper");
if(_38==null){
_38=Ext.DomHelper.append(Ext.getBody(),"<OBJECT id=\"dlgHelper\" CLASSID=\"clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b\" width=\"0px\" height=\"0px\"></OBJECT>");
}
if(Ext.isEmpty(_36)){
_37=_38.ChooseColorDlg();
}else{
_37=_38.ChooseColorDlg(_36);
}
}
if(_37.length<6){
var _39="000000".substring(0,6-_37.length);
_37=_39.concat(_37);
}
return _37;
};
Ext.page={pageSize:15};
$g=function(id,_1){
return Ext.get(id).getValue(_1);
};
function storeCodeString(_2,_3){
var _4=_3.showEmpty?_3.showEmpty:false;
var _5=new Ext.data.JsonStore({url:"common.do?invoke=comboCodeString&codeId="+_2+"&showEmpty="+_4,root:"list",id:"itemCode",successProperty:"success",fields:["paramCode","itemCode","itemValue","itemOrder","description"]});
return _5;
};
function storeCodeTable(_6,_7){
if(Ext.isEmpty(_7.requestUrl)){
_7.requestUrl="common.do?invoke=comboCodeTable";
}
var _8={code:_6,showEmpty:(_7.showEmpty?_7.showEmpty:false),key:_7.valueField,display:_7.displayField};
if(!Ext.isEmpty(_7.baseParams)){
Ext.apply(_8,_7.baseParams);
}
var _9=new Ext.data.JsonStore({url:_7.requestUrl,baseParams:_8,root:"list",successProperty:"success",fields:[]});
_9.on("loadexception",function(_a,_b,_c,_d){
var _e=_d?_d.message:_c.statusText;
if(_c&&_c.status==Ext.AL.ABORT_REQUEST_CODE){
_e=Ext.AL.abortRequestText;
}
if(_c&&_c.status==Ext.AL.FAIL_REQUEST_CODE){
_e=Ext.AL.failRequestText;
}
extWarn(Ext.AL.storeFailText+_e);
});
return _9;
};
function getEmptyForm(){
var _f=Ext.getBody().createChild({tag:"form"});
return new Ext.form.BasicForm(_f,{timeout:90});
};
function todo(msg){
if(!msg){
msg="功能实现中, ... &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
}
Ext.MessageBox.show({title:"TODO:",msg:msg,buttons:Ext.MessageBox.OK,icon:Ext.MessageBox.INFO});
};
function extInfo(msg,fn){
extShow("info",msg,fn);
};
function extWarn(msg,fn){
extShow("warning",msg,fn);
};
function extErr(msg,fn){
extShow("error",msg,fn);
};
function extConfirm(msg,opt){
Ext.MessageBox.confirm(Ext.AL.confirmTitle,msg,function(btn){
if("yes"==btn&&Ext.type(opt)&&"function"==Ext.type(opt.fn)){
opt.fn(opt.arguments);
}
});
};
function extShow(_10,msg,fn){
var _11=Ext.MessageBox.OK;
var _12=Ext.MessageBox.INFO;
var _13="";
if("info"==_10){
_12=Ext.MessageBox.INFO;
_13=Ext.AL.infoTitle;
}else{
if("warning"==_10){
_12=Ext.MessageBox.WARNING;
_11=Ext.MessageBox.CANCEL;
_13=Ext.AL.warnTitle;
}else{
if("error"==_10){
_12=Ext.MessageBox.ERROR;
_13=Ext.AL.errorTitle;
}
}
}
Ext.MessageBox.show({title:_13,msg:msg,buttons:_11,fn:Ext.type(fn)?fn:Ext.emptyFn,icon:_12});
};
function validFormData(_14){
_14.clearInvalid();
if(!_14.isValid()){
extWarn(Ext.AL.validInfoText);
return false;
}
return true;
};
function validGridSele(sm,_15){
_15=_15||{};
if(sm.getCount()===0){
extInfo(_15.emptyText||Ext.AL.validGridText);
return false;
}
var _16=null;
if(_15.strictCount){
_16=_15.strictCount;
}
if(_16!==null&&sm.getCount()!==_16){
var _17=_15.msgs||Ext.AL.strictGridText;
var _18=new Ext.Template(_17).apply({"count":sm.getCount(),"strict":_16});
extInfo(_18);
return false;
}
return true;
};
function getPagParam(_19){
var _1a={params:{start:0,limit:_19||Ext.page.pageSize}};
return _1a;
};
function beforeShowTab(tab){
if(tab.hasLoaded){
return true;
}
if(tab.store){
tab.store.load(getPagParam(tab.pageSize));
}
tab.hasLoaded=true;
};
function reloadData(_1b,_1c){
if(!Ext.type(_1b)||!Ext.type(_1b.store)){
return false;
}
_1c=Ext.type(_1c)?_1c:true;
_1b.store.reload(_1c?getPagParam(_1b.pageSize):null);
};
function doLoadAction(_1d,_1e,_1f,_20){
var _21=_1e;
if(_1e instanceof Ext.form.FormPanel){
_21=_1e.getForm();
}
if(_21!=null&&_21!=undefined){
if(!validFormData(_21)){
return false;
}
Ext.apply(_1d.getStore().baseParams,_21.getValues());
}
if(Ext.type(_1f)=="object"){
Ext.apply(_1d.getStore().baseParams,_1f);
}
reloadData(_1d,_20);
};
function ghostSucc(_22){
Ext.MessageBox.show(Ext.apply({icon:Ext.MessageBox.INFO,title:Ext.AL.infoTitle,msg:Ext.AL.actionSuccText,closable:false},_22=_22||{}));
var _23=_22.delay?_22.delay:500;
(function(){
Ext.MessageBox.getDialog().getEl().fadeOut({duration:0.4,endOpacity:0,callback:function(){
Ext.MessageBox.hide();
Ext.callback(_22.callback,_22.scope,[this]);
}});
}).defer(_23);
};
function operSucc(_24,_25,_26){
if(!Ext.type(_25)||!Ext.type(_25.result)){
extErr(Ext.AL.actionNoResult);
return false;
}
var msg=(Ext.type(_25)&&Ext.type(_25.result)&&Ext.type(_25.result.msg))?_25.result.msg:"";
_26=_26||{};
extInfo((_26.tipText||Ext.AL.actionSuccText)+msg,_26.fn);
};
function operFail(_27,_28,_29){
var msg=(Ext.type(_28)&&Ext.type(_28.result)&&Ext.type(_28.result.msg))?_28.result.msg:"";
_29=_29||{};
if(_28.failureType==Ext.form.Action.CLIENT_INVALID){
msg=Ext.AL.actionValidFail;
}
if(_28.failureType==Ext.form.Action.CONNECT_FAILURE){
msg=Ext.AL.failRequestText;
}
extErr((_29.tipText||Ext.AL.actionFailText)+msg,_29.fn);
};
function ajaxSucc(_2a){
var xml=_2a.responseXML;
if(!Ext.type(xml)||!Ext.type(xml.getElementsByTagName("result"))){
extErr(Ext.AL.actionNoResult);
return false;
}
var _2b=xml.getElementsByTagName("result");
var _2c=_2b.length>0?_2b[0].text:"{}";
var r=Ext.decode(_2c)||{};
if(!r.success){
ajaxFail(_2a);
return;
}
var msg=r.msg||"";
extInfo(Ext.AL.actionSuccText+msg,_2a.actionFn);
};
function ajaxFail(_2d){
var xml=_2d.responseXML;
if(!Ext.type(xml)){
extErr(Ext.AL.actionRequestFail);
return false;
}
var msg="";
if(Ext.type(xml)&&Ext.type(xml.getElementsByTagName("result"))){
var _2e=xml.getElementsByTagName("result");
var _2f=_2e.length>0?_2e[0].text:"{}";
var r=Ext.decode(_2f)||{};
msg=r.msg||"";
}
extErr(Ext.AL.actionFailText+msg,_2d.actionFn);
};
function mask(_30){
_30=_30||{};
var el=_30.el||Ext.getBody();
_30.msg=_30.msg||Ext.AL.maskText;
var m=new Ext.LoadMask(el,_30);
m.show();
return m;
};
Ext.onReady(function(){
Ext.getDoc().keymap=Ext.getDoc().addKeyListener(Ext.EventObject.ESC,function(){
try{
if(window.opener){
window.close();
}
}
catch(e){
}
});
});
function expandGridRow(_31,_32,_33){
if(_31.ofCurrentRow){
Ext.fly(_31.ofCurrentRow).removeClass("x-grid3-cell-text-visible");
}
var _34=_31.getView();
var r=_34.getRow(_32);
Ext.fly(r).addClass("x-grid3-cell-text-visible");
_31.ofCurrentRow=r;
};
function disabledEditCell(_35,_36,_37){
_36.attr="style=\"background-color:#eeeeee;\"";
return _35;
};
function selectAllExt(_38){
_38.getSelectionModel().selectAll();
};
function selectOppExt(_39){
var sm=_39.getSelectionModel();
var i=0;
_39.getStore().each(function(r){
if(sm.isSelected(i)){
sm.deselectRow(i);
}else{
sm.selectRow(i,true);
}
i=i+1;
});
};
function createTask(_3a){
_3a.on("loadexception",function(_3b){
_3b.loading=false;
});
_3a.on("load",function(_3c){
_3c.loading=false;
});
var _3d={run:function(){
if(_3a.loading){
return true;
}
_3a.reload();
_3a.loading=true;
},interval:500,args:[_3a]};
return _3d;
};
function checkExistsObj(obj,_3e){
if(Ext.isEmpty(obj)){
return false;
}
var s=_3e.split(".");
var _3f=true,_40=obj;
Ext.each(s,function(p){
if(Ext.isEmpty(_40[p])){
return (_3f=false);
}
_40=_40[p];
});
return _3f;
};
function buildExtField(_1){
Ext.apply(_1,{fieldLabel:_1.fieldLabel||_1.caption,cls:_1.readOnly?"x-item-disabled":"",blankText:_1.blankText?_1.blankText:(_1.fieldLabel||_1.caption)+Ext.AL.fieldIsRequired});
if("Text"==_1.uiDefine||"textfield"==_1.xtype){
return createExtField("textfield",_1);
}
if("Textarea"==_1.uiDefine||"textarea"==_1.xtype){
return createExtField("textarea",_1);
}
if("Number"==_1.uiDefine||"numberfield"==_1.xtype){
return createExtField("numberfield",_1);
}
if("Hidden"==_1.uiDefine||"hidden"==_1.xtype){
return createExtField("hidden",_1);
}
if("ComboBox"==_1.uiDefine||"combo"==_1.xtype){
var _2=_1.store;
if(_1.codeTable){
_1.mode=_1.mode||"remote";
_1.typeAhead=_1.typeAhead||false;
_1=getCodeComboOption(_1);
}
if(_1.codeString){
_2=_2||storeCodeString(_1.codeString,_1);
}
if(_1.codeTable){
_2=_2||storeCodeTable(_1.codeTable,_1);
}
var id=Ext.id(_1);
var _3=createExtField("combo",_1,{id:id,typeAhead:Ext.type(_1.typeAhead)?_1.typeAhead:true,triggerAction:_1.readOnly?"none":"all",selectOnFocus:true,forceSelection:true,displayField:_1.displayField||"itemValue",valueField:_1.valueField||"itemCode",store:_2,mode:_1.mode||"local",minChars:Ext.type(_1.minChars)?_1.minChars:0,emptyText:_1.emptyText||Ext.AL.comboxEmptyText,hiddenName:_1.hiddenName||_1.name});
var _4=new Ext.form.ComboBox(_3);
_4.on("beforerender",function(_5){
_5.on("beforequery",function(_6){
if(_6.combo.readOnly){
return !(_6.cancel=true);
}
});
if(_5.store==null){
return true;
}
if(_1.initLoad===true){
_5.store.load({params:_1.baseParams});
}
});
return _4;
}
if("Password"==_1.uiDefine||"password"==_1.xtype){
return createExtField("textfield",_1,{inputType:"password"});
}
if("Time"==_1.uiDefine||"timefield"==_1.xtype){
return createExtField("timefield",_1,{disabled:_1.readOnly?true:false,increment:_1.increment||60,format:_1.format||getFormatOfDatetime(_1.uiFormat,"time")});
}
if("Date"==_1.uiDefine||"datefield"==_1.xtype){
return createExtField("datefield",_1,{width:_1.width||160,hideTrigger:_1.hideTrigger||_1.readOnly,format:_1.format||getFormatOfDatetime(_1.uiFormat,"date")});
}
return createExtField(_1.xtype||"textfield",_1);
};
function createExtField(_7,_8,_9){
Ext.applyIf(_8,{"xtype":_7});
Ext.apply(_8,_9||{});
return _8;
};
function buildExtFields(_a){
var _b=new Array();
for(var i=0;i<_a.length;i++){
_b.push(buildExtField(_a[i]));
}
return _b;
};
function createXmlStore(_c,_d,_e,_f){
//在函数入口第一行加入几行就好了。
var username ='';
var cookie1 = Ext.state.Manager.getProvider();
//实际上cookie中存的key值是ys-username
username = cookie1.get('username'); 
//传递request参数到过滤器
username = getCookie('ys-username');
if(_d==null){
var _d = {};
_d.cookieduserId=username;
}else{
_d.cookieduserId=username;
}
_f=_f||{};
var _10=new Ext.data.Store(Ext.apply({proxy:new Ext.data.HttpProxy({url:_c,timeout:90000,headers:{"Response-By":"XML"}}),baseParams:_d||{},reader:new Ext.data.XmlReader({record:"row",id:"id",success:"success",totalRecords:"totalCount"},_e)},_f));
_10.on("loadexception",function(_11,_12,_13,err){
var _14=err?err.message:_13.statusText;
if(_13&&_13.status==Ext.AL.ABORT_REQUEST_CODE){
_14=Ext.AL.abortRequestText;
}
if(_13&&_13.status==Ext.AL.FAIL_REQUEST_CODE){
_14=Ext.AL.failRequestText;
}
extWarn(Ext.AL.storeFailText+_14);
});
_10.on("load",function(_15,_16,_17){
if(_16&&_16.length>0){
return;
}
try{
var doc=_15.reader.xmlData;
var _18=_15.reader.readRecords(doc);
if(_18&&_18.success===false){
var _19=doc.documentElement||doc;
var msg=Ext.DomQuery.selectValue("msg",_19,null);
if(msg){
extErr(Ext.AL.storeFailText+msg);
}
}
}
catch(e){
}
});
return _10;
};
function createJsonStore(url,_1a,_1b,_1c){
var username ='';
var cookie1 = Ext.state.Manager.getProvider();
//实际上cookie中存的key值是ys-username
username = cookie1.get('username'); 
//传递request参数到过滤器
username = getCookie('ys-username');
if(_1a==null){
var _1a = {};
_1a.cookieduserId=username;
}else{
_1a.cookieduserId=username;
}
_1c=_1c||{};
var _1d=new Ext.data.JsonStore(Ext.apply({url:url,timeout:90000,baseParams:_1a||{},root:"list",successProperty:"success",totalProperty:"totalCount",fields:_1b||[]},_1c));
_1d.on("loadexception",function(_1e,_1f,_20,err){
var _21=err?err.message:_20.statusText;
if(_20&&_20.status==Ext.AL.ABORT_REQUEST_CODE){
_21=Ext.AL.abortRequestText;
}
if(_20&&_20.status==Ext.AL.FAIL_REQUEST_CODE){
_21=Ext.AL.failRequestText;
}
extWarn(Ext.AL.storeFailText+_21);
});
_1d.on("load",function(_22,_23,_24){
if(_23&&_23.length>0){
return;
}
try{
var _25=_22.reader.jsonData;
var _26=_22.reader.getSuccess(_25);
if(_26===false||_26=="false"){
var msg=_25["msg"];
if(msg){
extErr(Ext.AL.storeFailText+msg);
}
}
}
catch(e){
}
});
return _1d;
};
function buildStoreColumn(_27){
var rec={name:_27.name};
if(_27.type){
rec.type=_27.type;
}
if(_27.dateFormat){
rec.dateFormat=_27.dateFormat;
}
return rec;
};
function buildStoreColumns(_28){
var _29=new Array();
for(var i=0;i<_28.length;i++){
_29.push(buildStoreColumn(_28[i]));
}
return _29;
};
function buildGridColumn(_2a){
var col=Ext.apply({},{header:_2a.header||_2a.fieldLabel||_2a.caption,dataIndex:_2a.dataIndex||_2a.name,sortable:_2a.sortable===false?false:true},_2a);
return col;
};
function buildGridColumns(_2b,sm){
var _2c=new Array();
if(sm){
_2c.push(sm);
}
for(var i=0;i<_2b.length;i++){
_2c.push(buildGridColumn(_2b[i]));
}
return _2c;
};
function buildFromLoadedCols(_2d,_2e,sm){
var _2f=new Array();
if(sm){
_2f.push(sm);
}
for(var i=0;i<_2e.length;i++){
var _30=_2e[i];
for(var j=0;j<_2d.length;j++){
if(_30==_2d[j].name){
_2f.push(buildGridColumn(_2d[j]));
}
}
}
return _2f;
};
function buildPagingToolbar(_31,_32,_33){
return new Ext.PagingToolbar({store:_31,pageSize:_32||Ext.page.pageSize,displayInfo:(Ext.type(_33)=="boolean"?_33:true)});
};
function buildNostatPagingToolbar(_34,_35,_36){
return new Ext.ux.NostatPagingToolbar({store:_34,pageSize:_35||Ext.page.pageSize,displayInfo:(Ext.type(_36)=="boolean"?_36:true)});
};
function getFormatOfDatetime(_37,_38){
if(!Ext.type(_37)||""==_37){
_37=_38;
}
if("date"==_37){
return "Y-m-d";
}
if("time"==_37){
return "H:i:s";
}
if("datetime"==_37){
return "Y-m-d H:i:s";
}
if("timestamp"==_37){
return "Y-m-d H:i:s.u";
}
if("shorttime"==_37){
return "H:i";
}
return _37;
};
function getValueFromXmlStore(_39,_3a){
var _3b=null;
try{
var doc=_39.reader.xmlData;
var _3c=doc.documentElement||doc;
_3b=Ext.DomQuery.selectValue(_3a,_3c,null);
}
catch(e){
}
return _3b;
};
function getValueFromJsonStore(_3d,_3e){
var _3f=null;
try{
var _40=_3d.reader.jsonData;
var fn=_3d.reader.getJsonAccessor(_3e);
_3f=fn(_40);
}
catch(e){
}
return _3f;
};
function duplicateStore(_41,_42){
var _43=false;
var map=new Ext.util.MixedCollection();
_41.each(function(_44){
var _45=_44.data[_42];
if(map.containsKey(_45)){
_43={value:_45};
return false;
}
map.add(_45,_44.data);
});
return _43;
};
function checkTreeNode(_1,_2){
if(!_1.isLeaf()&&!_1.isLoaded()){
_1.expand();
}
_1.getOwnerTree().suspendEvents();
_1.bubble(function(_3){
if(_1.id==_3.id){
return true;
}
if(_2&&!_3.getUI().isChecked()){
_3.getUI().toggleCheck(true);
}
});
_1.cascade(function(_4){
if(_1.id==_4.id){
return true;
}
if(_4.getUI().isChecked()!==_2){
var _5=_4.attributes.params;
if(_5&&_5.ignoreCheckEvent){
return false;
}
_4.getUI().toggleCheck(_2);
}
});
_1.getOwnerTree().resumeEvents();
};
function allChildChecked(_6,_7){
var _8=true;
_6.eachChild(function(_9){
if(_9.getUI().isChecked()!==_7){
_8=false;
return false;
}
});
return _8;
};
function showTreeContextmenu(_a,e){
_a.select();
var c=_a.getOwnerTree().contextMenu;
c.contextNode=_a;
c.showAt(e.getXY());
};
function expandNode(_b){
var n=_b.parentMenu.contextNode;
if(!n.isLeaf()&&!n.isExpanded()){
n.expand();
}
};
function collapseNode(_c){
var n=_c.parentMenu.contextNode;
if(!n.isLeaf()&&n.isExpanded()){
n.collapse(true);
}
};
function checkNodeAll(_d,_e){
var n=_d.parentMenu.contextNode;
if(!n.isLeaf()&&!n.isLoaded()){
n.expand();
}
n.cascade(function(_f){
if(_f.getUI().isChecked()!==_e){
_f.getUI().toggleCheck(_e);
}
});
};
function refreshNode(_10){
var n=_10.parentMenu.contextNode;
if(n!=null&&Ext.type(n.reload)=="function"){
n.reload();
}
};
function reloadNode(_11,_12,_13){
var _14=Ext.type(_12)=="string"?_11.getNodeById(_12):_12;
if(_14!=null&&Ext.type(_14.reload)!==false){
_14.leaf=false;
_14.reload(_13);
}
};
function removeNode(_15,_16){
var _17=Ext.type(_16)=="string"?_15.getNodeById(_16):_16;
if(_17!=null){
_17.remove();
}
};
function updateTreeNodeTip(_18,_19,_1a){
var ui=_18.getUI();
if(ui.textNode.setAttributeNS){
ui.textNode.setAttributeNS("ext","qtip",_19);
if(_1a){
ui.textNode.setAttributeNS("ext","qtitle",_1a);
}
}else{
ui.textNode.setAttribute("ext:qtip",_19);
if(_1a){
ui.textNode.setAttribute("ext:qtitle",_1a);
}
}
};
function cascadeNode(_1b,fn,_1c,_1d){
if(fn.apply(_1c||_1b,_1d||[_1b])!==false){
var cs=_1b.childNodes;
for(var i=cs.length-1;i>=0;i--){
cascadeNode(cs[i],fn,_1c,_1d);
}
}
};
function findParentChecked(_1e){
var _1f=null;
_1e.bubble(function(_20){
if(_1e.id==_20.id){
return true;
}
if(_20.getUI().isChecked()){
_1f=_20;
return false;
}
});
return _1f;
};
function findChildrenChecked(_21){
var _22=new Array();
_21.cascade(function(_23){
if(_21.id==_23.id){
return true;
}
if(_23.getUI().isChecked()){
_22.push(_23);
}
});
return _22;
};
function getCodeComboOption(_1){
var _2=_1.displayField;
var _3=_1.valueField;
var _4="";
if("UserGroup"==_1.codeTable){
_3=_3||"groupId";
_2=_2||"groupName";
}else{
if("composition"==_1.codeTable){
_3="id";
_2="name";
}else{
if("Datasource"==_1.codeTable){
_3="datasourceId";
_2="datasourceName";
}else{
if("QuoteDiffDatasource"==_1.codeTable){
_3="datasourceId";
_2="datasourceName";
}else{
if("Adapter"==_1.codeTable){
_3="adapterId";
_2="adapterName";
}
}
}
}
}
Ext.apply(_1,{displayField:_2,valueField:_3,requestUrl:_4});
return _1;
};
Ext.app.Permission=function(_5){
Ext.apply(this,_5);
Ext.app.Permission.ps=this.ps||[];
Ext.app.Permission.gr=this.gr||0;
this.hasPermission=function(_6){
if(!Ext.isEmpty(_6.funcCode)){
if(Ext.app.Permission.ps.indexOf(_6.funcCode)<0){
return false;
}
}
if(Ext.isArray(_6.funcCodes)){
var b=false;
Ext.each(_6.funcCodes,function(fc){
if(Ext.app.Permission.ps.indexOf(fc)>=0){
return !(b=true);
}
});
return b;
}
if(!Ext.isEmpty(_6.grantNum)){
var gn=Ext.num(_6.grantNum,0);
if(gn!==(Ext.app.Permission.gr&gn)){
return false;
}
}
if(Ext.isArray(_6.grantNums)){
var b=false;
Ext.each(_6.grantNums,function(gn){
gn=Ext.num(gn,0);
if(gn==(Ext.app.Permission.gr&gn)){
return !(b=true);
}
});
return b;
}
return true;
};
Ext.Button.prototype.afterButtonRender=Ext.Button.prototype.afterRender;
Ext.menu.BaseItem.prototype.onMenuRender=Ext.menu.BaseItem.prototype.onRender;
Ext.Toolbar.prototype.afterButtonRender=Ext.Toolbar.prototype.afterRender;
Ext.Button.prototype.hasPermission=this.hasPermission;
Ext.menu.BaseItem.prototype.hasPermission=this.hasPermission;
Ext.Toolbar.prototype.hasPermission=this.hasPermission;
Ext.Button.override({afterRender:function(){
this.afterButtonRender();
if(!this.hasPermission(this)){
this.forbidden=this.disabled=true;
}
}});
Ext.menu.BaseItem.override({onRender:function(_7,_8){
this.onMenuRender(_7,_8);
if(!this.hasPermission(this)){
this.forbidden=this.disabled=true;
}
}});
Ext.Toolbar.override({afterRender:function(){
this.afterButtonRender();
for(var i=0;i<this.items.getCount();i++){
var _9=this.items.get(i);
if(!this.hasPermission(_9)){
_9.hide();
this.hideSeparator(i+1);
}
}
},hideSeparator:function(_a){
if(_a<0){
return false;
}
var _b=this.items.get(_a);
if(_b instanceof Ext.Toolbar.Separator){
_b.hide();
}
}});
};
Ext.extend(Ext.app.Permission,Ext.util.Observable,{accessible:function(_c){
if(!Ext.isArray(this.ps)){
return false;
}
return this.ps.indexOf(_c)>=0;
}});
function getMainParent(){
var p=window;
while(true){
if(p.document.getElementById("centerZone")!=null){
return p;
}
if(p.opener==null&&p==p.top){
p=null;
break;
}
p=p.opener!=null?p.opener:p.parent;
}
return p;
};
function getFactoryParent(){
var p=window;
while(true){
if(p.document.getElementById("TabFactory")!=null){
return p;
}
if(p.opener==null&&p==p.top){
p=null;
break;
}
p=p.opener!=null?p.opener:p.parent;
}
return p;
};
function cleanupTabCache(_d,_e){
var _f=Ext.query("IFRAME",_e.body.dom);
Ext.each(_f,function(_10){
_10.src="about:blank";
Ext.removeNode(_10);
});
};
/**
 * IP地址验证
 * @param {} ip IP地址
 * @return {Boolean} true: 正确；false: 不正确
 */
function validataIP(ip){  
	var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;  
	var flag = ip.match(exp);  
	if(flag != undefined && flag != ""){  
	   return true;  
	} else {  
	  return false;  
	}  
} 
/**
 * 获得下拉框(Combox)系统配置参数
 * @param url 请求路径
 * @param displayName 下拉框(Combox)显示名称
 * @param paramValue 下拉框(Combox)值
 * @param paramCode 查询条件
 * @return
 */
function getComboxStoreData(url, displayName, paramValue, paramCode){
	return new Ext.data.Store({
		autoLoad:false,
		proxy : new Ext.data.HttpProxy({
			url: url
		}),
		baseParams: {'PARAMCODE': paramCode, 'DISPLAYNAME': displayName, 'PARAMVALUE': paramValue},
		reader : new Ext.data.JsonReader({
			root : 'EntityArray',
			totalProperty: 'TotalResults',
			id: paramValue
		},[paramValue, displayName]),
		remoteSort:true
	});
}
/**
 * 获得下拉框(Combox)系统配置参数
 * @param url 请求路径
 * @param classifierId 查询条件：元模型ID
 * @param instanceCode 查询条件：元数据编码
 * @param parentId 查询条件：父元数据ID
 * @return
 */
function getMetadataComboxStore(url, classifierId, instanceCode, parentId){
	return new Ext.data.Store({
		autoLoad:false,
		proxy : new Ext.data.HttpProxy({
			url: url
		}),
		baseParams: {'classifierId': classifierId, 'instanceCode': instanceCode, 'parentId': parentId},
		reader : new Ext.data.JsonReader({
			root : 'EntityArray',
			totalProperty: 'TotalResults',
			id: 'instanceId'
		},['instanceId', 'instanceName', 'instanceCode', 'classifierId', 'namespace', 'parentId', 'startTime']),
		remoteSort:true
	});
}
