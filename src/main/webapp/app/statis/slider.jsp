<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ECharts</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/slider.css">
</head>

<body>


<div id="demo"> 
<div id="demo1"> 
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/ER.jpg" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/IBM.png" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/SYSBASE.png" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/microsoft.png" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/ORACLE.jpg" border="0" /></a>
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/ER.jpg" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/IBM.png" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/SYSBASE.png" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/microsoft.png" border="0" /></a> 
<br>
<a href="#"><img src="<%=request.getContextPath()%>/app/base/images/collectimg/ORACLE.jpg" border="0" /></a>
<br>



</div> 
<div id="demo2"></div> 
</div> 
</body>
<script>


var speed=20; //数字越大速度越慢 
var tab=document.getElementById("demo"); 
var tab1=document.getElementById("demo1"); 
var tab2=document.getElementById("demo2"); 
tab2.innerHTML=tab1.innerHTML; //克隆demo1为demo2 
function Marquee(){ 
if(tab2.offsetTop-tab.scrollTop<=0)//当滚动至demo1与demo2交界时 
tab.scrollTop-=tab1.offsetHeight //demo跳到最顶端 
else{ 
tab.scrollTop++ 
} 
} 
var MyMar=setInterval(Marquee,speed); 
tab.onmouseover=function() {clearInterval(MyMar)};//鼠标移上时清除定时器达到滚动停止的目的 
tab.onmouseout=function() {MyMar=setInterval(Marquee,speed)};//鼠标移开时重设定时器 

</script>
</html>
	