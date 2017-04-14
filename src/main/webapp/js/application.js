var W = screen.width;  //屏幕宽 1024 or 800
var H = screen.height; //屏幕高 768  or 600

/**
 * 打开执行窗口
 * @param url 
 * @param w 窗口宽(可选)
 * @param h 窗口高(可选)
 * @param winName 窗口名称(可选)
 * @param options {Object} 属性
 */
function openWin(url, w, h, winName, options) {
  if (!w)  w = W / 2 + 250;
  if (!h) h = H / 2 + 150;
  if (!winName) { winName = '_win'+new Date().getTime();}
  winName = escape(winName).replace(/\W/g,'_');
  var screenWidth = screen.availWidth;
  var screenHeight = screen.availHeight;
  var left = (screenWidth - w - 6) / 2 - 2;
  var top = (screenHeight - h - 24) / 2 - 2;
  if (left < 0) left = 0;
  if (top < 0)  top = 0;
  var opt = Ext.apply({
      width: w, height: h, left: left, top: top,
      toolbar:'no',status:'yes',menubar:'no',scrollbars:'yes',resizable:'yes'
  }, options||{});
  var str = Ext.urlEncode(opt).replace(/\&/g,',');
  var wh = window.open(url, winName, str);
  if (wh != null){ wh.focus();}
  return wh ;
}
/**
 * 打开一个模拟最大化窗口
 */
function maxWin(url, winName, options) {
  if (winName){ winName = escape(winName).replace(/\W/g,'_');}
  var opt = Ext.apply({
      width: W - 4, height: H - 35,
      toolbar:'no',status:'no',menubar:'no',scrollbars:'auto',resizable:'no'
  }, options||{});
  var str = Ext.urlEncode(opt).replace(/\&/g,',');
  win = window.open(url, winName,  str);
  win.moveTo(-2, -23); //移动到较中间的位置
  if (win != null){ win.focus();}
  return win ;
}

/**
 * 打开一个模拟最大化窗口
 */
function maxScrollWin(url, winName, options) {
  if (winName){ winName = escape(winName).replace(/\W/g,'_');}
  var opt = Ext.apply({
      width: W - 4, height: H - 30,
      toolbar:'no',status:'no',menubar:'no',scrollbars:'yes',resizable:'no'
  }, options||{});
  var str = Ext.urlEncode(opt).replace(/\&/g,',');
  win = window.open(url, winName, str);
  win.moveTo(-2, -22); //移动到较中间的位置
  if (win != null){ win.focus();}
  return win ;
}
/**
 * 打开一个隐藏窗口
 */
function hidWin(url, winName, options) {
  if (winName){ winName = escape(winName).replace(/\W/g,'_');}
  var opt = Ext.apply({
      width: 30, height: 30,
      toolbar:'yes',status:'yes',menubar:'no',scrollbars:'yes',resizable:'yes'
  }, options||{});
  var str = Ext.urlEncode(opt).replace(/\&/g,',');
  win = window.open(url, winName, str);
  win.moveTo(-5000, -5000); //移动到较中间的位置
  if (win != null){ win.focus();}
}

/**
 * 显示错误信息，在页面中放置<span id="JS_Message"></span>标记
 * @param message 要显示的信息
 */
function showMessage(msg) {
  try{
    document.getElementById("spanMessage").innerHTML = "<font color='#FF0000'>" + msg + "</font>";
  }catch (e){alert('页面中没有ID为[spanMessage]的对象 ...    ');}
}


//=对象属性begin===============================================
/**
 * 为String对象增加trim函数：删除前/后空格

 * e.g. 
 *  (1)"  ".trim()        = ""
 *  (2)"sr c".trim()      = "sr c"
 *  (3)" src".trim(true)  = "src"
 *  (4)"src ".trim(false) = "src"
 *  (5)"src ".trim(true)  = "src "
 */
String.prototype.trim = function(trimFlag){
  //默认：左右均删除
  if(trimFlag==null)
    return this.replace(/(^\s*)|(\s*$)/g, "");
  //true:只删除左
  if(trimFlag) 
    return this.replace(/^\s*/g, "");
  //false:只删除右
  if(!trimFlag) 
    return this.replace(/\s*$/g, "");
}

/**
 * 为String对象增加unicodeLength函数：编码长度 汉字=2×字节
 * e.g. "中e文w".unicodeLength() = 6 
 */
String.prototype.unicodeLength = function(){
  var cArr = this.match(/[^\x00-\xff]/ig);
  return this.length + (cArr == null ? 0 : cArr.length);
}

String.prototype.hashCode = function(){
    var h = 0, off = 0;
    for(var i = 0, len = this.length; i < len; i++){
        h = 31 * h + this.charCodeAt(off++);
    }
    var t=-2147483648*2;
    while(h>2147483647){
        h+=t
    }
    return h;
}

/**
 * 为String对象增加isEmpty函数：是否空值

 * e.g.
 *   "   ".isEmpty = true ;
 */
String.prototype.isEmpty = function(){
  return this.trim().unicodeLength() < 1 ;
}

/**
 * 为String对象增加isBetween函数:判断长度是否在 给定区间内

 * e.g. 
 *   "中e文w".isLengthBetween(0,5) = false ; 
 */
String.prototype.isLengthBetween = function(min,max){
	return (this.unicodeLength()>min && this.unicodeLength()<max) ;  
}

/**
 * 测字符串实际长度
 * @return {int} Length
 */
String.prototype.actLength = function(){
    var arr=this.match(/[^\x00-\xff]/ig);
    return this.length+(arr==null?0:arr.length);
}
/**
 * 字符串左取
 * @param {int} num 长度
 * @param {boolean} mode 是否按照字节数模式
 * @return {String} this or String being cut
 */
String.prototype.leftCut = function(num,mode){
    var str = this.substr(0,num);
    if(!mode) return str;
    var n = str.actLength() - str.length;
    num = num - parseInt(n/2);
    return this.substr(0,num);
}

/**
 * 为String对象增加isLow函数:判断长度是否小于给定值

 */
String.prototype.isLow = function(min){
	return (this.unicodeLength()<min) ;  
}

/**
 * 为String对象增加isHight函数:判断长度是否大于给定值

 */
String.prototype.isHight = function(max){
	return (this.unicodeLength()>max) ;  
}

/**
 * 为String对象增加isDateString函数:判断字符串是否是合法的日期字符串
 * e.g.
 *   "2004-12-11".isDateString() = true ;
 *   "2004-13-11".isDateString() = false ;
 */
String.prototype.isDateString = function(){
  return isDate(this)==null;
}

/**
 * 为String对象增加isEmailString函数:判断字符串是否是合法的日期字符串
 * e.g.
 */
String.prototype.isEMailString = function(){
  return isEMail(this);
}

/**
 * 为String对象增加isValedateString函数:判断字符串是否是合法的字符串
 */
String.prototype.isValedateString = function(mode){
  return isValedate(mode,this);
}

/**
 *由于firefox在返回一个元素的color的时候往往是返回一个字符串比如rgb(255, 255, 255)
 *而IE往往返回#FFFFFF这种形式，在有时候做颜色判断时很难做比较，于是我便写了这个函数
 *方便从一个含有三个颜色值的字符串转换为一个Hex的颜色值。
 *可转换字符串："rgb(255, 254, 253)", "255,254,253", "#ff36ff"
 */
String.prototype.hexColor = function(){
    if(this.indexOf("#") >= 0) {
    	if (this.length == 4) {
    		var cs = this.split("");
    		return "#"+cs[1]+cs[1]+cs[2]+cs[2]+cs[3]+cs[3]; //#369-->#336699
    	}
    	return this;//如果是一个hex值则直接返回
    }
    var pattern = new RegExp("2[0-4]\\d|25[0-5]|[01]?\\d\\d?","ig");//这个正则是取 0 ~ 255的数字
    var va = this.match(pattern);
    if (va == null || va.length != 3) return "#000000";
    var result = "#";
    for(var i = 0; i < 3; i++) {
        var num = parseInt(va[i]);
        result += num < 16 ? "0" + num.toString(16) : num.toString(16);//如果小于F在前面补0
    }
    return result;
}

/**
 * 清空Array列表。（要放在Ext的脚本后）
 * @return {Array} 空列表
 */
Array.prototype.clearAll = function() {
    for (var i=this.length-1; i>=0; i--) {
        this.remove(this[i]);
    }
    return this;
}
//=对象属性end===============================================


//===========================================================
//= 常用函数
//===========================================================
/**
 * 日期
 */
function isDate(strDate) {
  var datePat = /^(\d{4})(\-)(\d{2})(\-)(\d{2})$/;
  var matchArray = strDate.match(datePat);
  if (matchArray == null) {
    return "错误：日期格式必须是\"YYYY-MM-DD\" ...        ";
  }
  year = matchArray[1];
  month = matchArray[3];
  day = matchArray[5];
  if (month < 1 || month > 12) {
    return "错误：月份必须在01-12之间 ...        ";
  }
  if (day < 1 || day > 31) {
    return "错误：日必须在01-31之间 ...        ";
  }
  if ((month==4 || month==6 || month==9 || month==11) && day==31) {
    return "错误："+month+"月没有"+day+"日 ...        ";
  }
  if (month == 2) { // check for february 29th
    var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
    if (day > 29 || (day==29 && !isleap)) {
      return "错误："+year+"年2月没有"+day+"日 ...        ";
    }
  }
  return null;
}

/**
 * 邮件地址
 */
function isEMail(str){
    //  +表示，至少一次   *表是任意次    .表示任意字符  \w表示字母数字和下画线 _ 
	var l=/^([A-Za-z])+(\w|[-]|[.])*([A-Za-z0-9])+@(\w|[-])+\..+$/ ;
    //var l=/^([A-Za-z])+(\w|[-]|[.])*([A-Za-z0-9])+@(\w|[-])+\..+$/ ;
	//  开始 (字母开头)  ( 允许的字符) (结尾字符)  @()(.后至少一个任意字符) 
    return (l.test(str))
}

/**
 * 正则表达式验证

 */
function isValedate(mode,str){
	switch(mode){
		// 数字
		case 1:
			var letters=/[^\d]/g;
			return (letters.test(str))
			break;

		// 英文
		case 2:
			var letters=/^[A-Za-z]+$/g;
			return (letters.test(str))
			break;

		// 数字、英文、下划线
		case 3:
			var letters=/[\W]/g;
			return (letters.test(str))
			break;

		// 中文
		case 4:
			var letters=/[^\u4E00-\u9FA5]/g;
			return (letters.test(str))
			break;
		
		// 双字节

		case 5:
			var letters=/[^\x00-\xff]/g;
			return (letters.test(str))
			break;

		// 身份证

		case 6:
			var letters1=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
			var letters2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
			return (letters1.test(str) || letters2.test(str))
			break;
	}
}

//=================================================================================
//Purpose: 计算Element的位置

//Parameter:field-需要计算的Element；attr-offsetTop,offsetLeft等

//====================================================================
function calculateOffset(field, attr)
{
	var offset = 0;
	while (field) {
		offset += field[attr];
		field = field.offsetParent;
	}
	return offset;
}

function calculateOffsetLocate(o) {
	var posx = calculateOffset(o, "offsetLeft");
	var posy = calculateOffset(o, "offsetTop");
	return {left: posx, top: posy};
}

//取字符串里所有的数字
function getDigitals(str) {
	var ret = "";
	for (var i=0; i<str.length; i++) {
		var n = parseInt(str.charAt(i));
		if (!isNaN(n)) ret += n;
	}
	return ret;
}

//判断字符串是否双字节
function isDblbyteChar(str) {
	return str.isValedateString(5);
}

/** 对请求参数编码，如果是双字节字符则不编码 */
function encodeURL(str) {
	if (str==null) return "";
	var buf = [];
	for (var i=0; i<str.length; i++) {
		var c = str.substring(i,i+1);
		if (isDblbyteChar(c))
			buf.push(c);
		else
			buf.push(encodeURIComponent(c));
	}
	return buf.join("");
}

//==========================================
//in:date对象
//out:yyyy-mm-dd
//==========================================
function formatDate(date)
{
    var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	return year+"-"+(month<10?"0"+month:month)+"-"+(day<10?"0"+day:day);
}

//==========================================
//in:date对象
//out:hh:mi:ss
//==========================================
function formatTime(date)
{
    var hour = date.getHours();
    var minute = date.getMinutes();
    var second = date.getSeconds();
    var s = (hour<10?"0"+hour:hour)+":"+(minute<10?"0"+minute:minute)+":"+(second<10?"0"+second:second);
	return s;
}

//==========================================
//in:date对象
//out:yyyy-mm-dd hh:mi:ss
//==========================================
function formatDateTime(date)
{
    var s1 = formatDate(date);
    var s2 = formatTime(date);
	return s1 + " " + s2;
}

//==========================================
//in:date:yyyy-mm-dd
//out:yyyy年mm月dd日

//==========================================
function formatChineseDate(date)
{
    if (date == "") return "";
    var dateArr = date.split("-");
    var year = dateArr[0];
    var month = dateArr[1];
    var day = dateArr[2];
    return (year+"年"+parseMyInt(month)+"月"+parseMyInt(day)+"日");
}

//取当前日期字符串：yyyy-MM-dd
function getToday()
{
	var	today = new Date();
	return formatDate(today);
}

//取当前时间字符串：hh:mm:ss
function getTime()
{
    var	today = new Date();
	return formatTime(today);
}

//取当前日期时间字符串：yyyy-MM-dd hh:mm:ss
function getDateTime()
{
	var	today = new Date();
	return formatDateTime(today);
}

/**
 * 打开颜色对话框
 * @param {String} color 初始颜色
 * @return {String} 选择的颜色
 */
function getColorDlg(color) {
	var choose = "";
	if (Ext.isIE) {
		var dlgHelper = document.getElementById("dlgHelper");
		if (dlgHelper == null) {
			dlgHelper = Ext.DomHelper.append(Ext.getBody(), '<OBJECT id="dlgHelper" CLASSID="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" width="0px" height="0px"></OBJECT>');
		}
		if (Ext.isEmpty(color)) {
			choose = dlgHelper.ChooseColorDlg();
		} else {
			choose = dlgHelper.ChooseColorDlg(color);
		}
	}
	if (choose.length < 6) {
		var sTempString = "000000".substring(0,6-choose.length);
		choose = sTempString.concat(choose);
	}
	return choose;
}


