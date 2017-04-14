<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html lang="en">
<head>
<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/app/base/js/go-debug.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
<style>
    .top-menu{
	    position:fixed;
	    z-index:2000;
	    top:10px;
	    right:40px;
	}
</style>
<body>
<div class="top-menu">
   <div class="menu">
      <button class="btn btn-default" onclick="myDiagram.commandHandler.increaseZoom()" title="放大"><img src="../base/images/dm/zoomIn.png"></button>
      <button class="btn btn-default" onclick="myDiagram.commandHandler.decreaseZoom()" title="缩小"><img src="../base/images/dm/zoomOut.png"></button>
      <button class="btn btn-default" onclick="fullScreen()" title="全屏"><img src="../base/images/dm/full.png"></button>
      <button class="btn btn-default" onclick="myDiagram.saveModelToJson()" title="保存位置"><img src="../base/images/dm/save.png"></button>
      <button class="btn btn-default" onclick="myDiagram.refresh()" title="刷新"><img src="../base/images/dm/refresh.png"></button>
      <button class="btn btn-default" onclick="myDiagram.printImage()" title="打印"><img src="../base/images/dm/exp.png"></button>
   </div>
</div>
<div id="diagramContainer">
    <div id="myDiagramDiv" style="width:100%; height:100%; background-color: #DAE4E4;"></div>
</div>
</body>
</html>
<script>
	var jq = $.noConflict();
	var a=0;
	function fullScreen(){
		if(a==0){
			parent.$('#ulTabs').hide();
            parent.$('.tab-content').css({
                'margin-left':0,
                'margin-right':0
            });
			parent.parent.fullScreen();
           parent.fullScreen();
			jq('#diagramContainer').css({
                width:'100%',
                height:'100%'
            });
			a=1;
		}else{
			parent.$('#ulTabs').show();
            parent.$('.tab-content').css({
                'margin-left':'20px',
                'margin-right':'10px'
            });
			parent.parent.exitFullScreen();
            parent.exitFullScreen();
            jq('#diagramContainer').css({
                width:'100%',
                height:'100%'
            });
			a=0;
		}
	}
	
	//创建全局变量$
	var $ = go.GraphObject.make;
	//创建图表diagram
	var myDiagram =
	  $(go.Diagram, "myDiagramDiv",
	    {
	      initialContentAlignment: go.Spot.Center, // center Diagram contents
	      "undoManager.isEnabled": true, // enable Ctrl-Z to undo and Ctrl-Y to redo
	      "toolManager.mouseWheelBehavior": go.ToolManager.WheelNone
	      /*
	      layout:$(go.GridLayout,
	          { wrappingWidth: Infinity, 
	            alignment: go.GridLayout.Position, 
	            cellSize: new go.Size(1, 1),
	            isOngoing:false 
	          })*/
	        // Diagram has simple horizontal layout  
	    }
	  );
	
	//交互行为
	//选中group
	function onSelectionChanged(node){
	  var icon=node.findObject("SHAPE");
	  if(icon!==null){
	    if(node.isSelected){
	      icon.fill="#e6ead4";
	    }else{
	      icon.fill="white";
	    }
	  }
	}
	//高亮事件
	 function onNodeMouseEnter(e, node) {
	  var diagram = node.diagram;
	  diagram.startTransaction("highlight");
	  // remove any previous highlighting
	  diagram.clearHighlighteds();
	  node.isHighlighted = true;
	  // for each Link coming out of the Node, set Link.isHighlighted
	  node.findLinksOutOf().each(function(l) { l.isHighlighted = true; });
	  // for each Node destination for the Node, set Node.isHighlighted
	  node.findNodesOutOf().each(function(n) { n.isHighlighted = true; });
	  diagram.commitTransaction("highlight");
	};
	
	function onNodeMouseLeave(e, obj) {
	  //myDiagram.startTransaction("no highlighteds");
	  myDiagram.clearHighlighteds();
	  //myDiagram.commitTransaction("no highlighteds");
	};
	
	function onLinkMouseEnter(e, link) {
	  var diagram = link.diagram;
	  diagram.startTransaction("highlight");
	  // remove any previous highlighting
	  diagram.clearHighlighteds();
	  link.isHighlighted = true;
	  link.fromNode.isHighlighted = true;
	  link.toNode.isHighlighted = true;
	  diagram.commitTransaction("highlight");
	};
	
	function onLinkMouseLeave(e, obj) {
	  //myDiagram.startTransaction("no highlighteds");
	  myDiagram.clearHighlighteds();
	  //myDiagram.commitTransaction("no highlighteds");
	};
	//数据模型
	// node模板
	myDiagram.nodeTemplate =
	  $(go.Node, "Auto",
	    {selectionAdorned:false,
	     mouseEnter:onNodeMouseEnter,
	     mouseLeave:onNodeMouseLeave,
	     locationSpot: go.Spot.Center
	   },
	    new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
	    // the entire node will have a light-blue background
	    $(go.Shape,"Rectangle",{name:"SHAPE",fill:"lightgray",strokeWidth:2,strokeDashArray:[3,1]},
	       // the Shape.stroke color depends on whether Link.isHighlighted is true
	      new go.Binding("stroke","isHighlighted",function(h){ return h? "red":"lightgray"})
	      .ofObject()),
	    $(go.Panel, "Horizontal",  
	        { stretch: go.GraphObject.Horizontal, background: "white" ,cursor:"pointer"},
	        /*$(go.Picture,
	          { alignment: go.Spot.Right, margin: 5,width: 20, height: 20 },
	          new go.Binding("source")),*/
	        $(go.TextBlock,
	          {
	            name:"TEXT",
	            alignment: go.Spot.Center,
	            margin: 10,
	            font: "14px sans-serif",
	            opacity: 0.75,
	            stroke: "#404040"
	          },
	          new go.Binding("stroke", "isHighlighted", function(h) {
	                        return h ? "crimson" : "#404040";
	                    }).ofObject(),
	          new go.Binding("text", "name").makeTwoWay()),
	        {
	          cursor:"pointer",
	          toolTip:  // define a tooltip for each node that displays the color as text
	            $(go.Adornment, "Auto",
	              $(go.Shape, { 
	                fill: "white" ,
	                strokeWidth:0
	              }),
	              $(go.TextBlock, { 
	                alignment: go.Spot.Center,
	                margin: 10,
	                font: "14px sans-serif"
	              },
	              new go.Binding("text", "name"))
	            )  // end of Adornment
	        }
	      )
	  );
	//group模板
	myDiagram.groupTemplate =
	  $(go.Group, "Auto",
	    {selectionAdorned:false,
	     selectionChanged:onSelectionChanged,
	     computesBoundsAfterDrag: false//,
	     /* layout:
	        $(go.GridLayout,
	          { wrappingColumn: 1, alignment: go.GridLayout.Position,
	              cellSize: new go.Size(1, 1), spacing: new go.Size(4, 4) }) */
	   },
	   new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
	    $(go.Shape, "Rectangle",
	      { name:"SHAPE",fill: "white", stroke: "#eff4f8", strokeWidth: 2,margin:-1 },
	      // the Shape.stroke color depends on whether Link.isHighlighted is true
	      new go.Binding("stroke","isHighlighted",function(h){ return h? "red":"#eff4f8"})
	      .ofObject()),
	    $(go.Panel, "Vertical", // title above Placeholder
	      $(go.Panel, "Horizontal",  // picture next to TextBlock
	        { stretch: go.GraphObject.Horizontal, background: "#eff4f8" },
	        $(go.Picture,
	          { alignment: go.Spot.Right, margin: 5,width: 29, height: 29 },
	          new go.Binding("source")),
	        $(go.TextBlock,
	          {
	            alignment: go.Spot.Left,
	            margin: new go.Margin(20,20,20,5),
	            font: "bold 14px sans-serif",
	            opacity: 0.75,
	            stroke: "#404040"
	          },
	          new go.Binding("text", "name").makeTwoWay()),
	        {
	          cursor:"pointer",
	          toolTip:  // define a tooltip for each node that displays the color as text
	            $(go.Adornment, "Auto",
	              $(go.Shape, { 
	                fill: "white" ,
	                strokeWidth:0
	              }),
	              $(go.TextBlock, { 
	                alignment: go.Spot.Center,
	                margin: 10,
	                font: "14px sans-serif"
	              },
	              new go.Binding("text", "name"))
	            )  // end of Adornment
	        }
	      ),  // end Horizontal Panel
	      $(go.Placeholder,
	        { padding: 5, alignment: go.Spot.TopLeft })
	    ) // end Vertical Panel
	  );
	// link模板
	//GroupLink
	myDiagram.linkTemplateMap.add("GroupLink", 
	  $(go.Link,
	    { routing: go.Link.Normal,
	      curve: go.Link.Bezier , 
	      toShortLength: 20, 
	      selectable: false ,
	      cursor:"pointer",
	      mouseEnter:onLinkMouseEnter,
	      mouseLeave:onLinkMouseLeave,
	      toolTip:  // define a tooltip for each node that displays the color as text
	      $(go.Adornment, "Auto",
	        $(go.Shape, { 
	          fill: "white" ,
	          strokeWidth:0
	        }),
	        $(go.TextBlock, { 
	          alignment: go.Spot.Center,
	          margin: 10,
	          font: "14px sans-serif"
	        },
	        new go.Binding("text", "text"))
	      )  // end of Adornment
	    },
	    $(go.Shape,
	      { isPanelMain: true, stroke: "black", strokeWidth: 1 },
	      // the Shape.stroke color depends on whether Link.isHighlighted is true
	      new go.Binding("stroke", "isHighlighted", function(h) { return h ? "red" : "gray"; })
	          .ofObject(),
	      new go.Binding("strokeWidth","width")),
	    $(go.Shape,
	      { toArrow: "Triangle", stroke: null },
	      new go.Binding("scale","scale"),
	      // the Shape.fill color depends on whether Link.isHighlighted is true
	      new go.Binding("fill", "isHighlighted", function(h) { return h ? "red" : "gray"; })
	          .ofObject())/*,
	     $(go.TextBlock,
	      new go.Binding("stroke", "isHighlighted", function(h) {
	                    return h ? "crimson" : "#404040";
	                }).ofObject(),
	      new go.Binding("text", "text"))*/
	  ));
	//NodeLink
	myDiagram.linkTemplateMap.add("NodeLink", 
	  $(go.Link,
	    { routing: go.Link.Normal, 
	      curve: go.Link.Bezier ,
	      toShortLength: 4, 
	      selectable: false ,
	      cursor:"pointer",
	      mouseEnter:onLinkMouseEnter,
	      mouseLeave:onLinkMouseLeave,
	      toolTip:  // define a tooltip for each node that displays the color as text
	      $(go.Adornment, "Auto",
	        $(go.Shape, { 
	          fill: "white" ,
	          strokeWidth:0
	        }),
	        $(go.TextBlock, { 
	          alignment: go.Spot.Center,
	          margin: 8,
	          font: "12px sans-serif"
	        },
	        new go.Binding("text", "text"))
	      )  // end of Adornment
	    },
	    $(go.Shape,
	      { isPanelMain: true, stroke: "black", strokeWidth: 1 },
	      // the Shape.stroke color depends on whether Link.isHighlighted is true
	      new go.Binding("stroke", "isHighlighted", function(h) { return h ? "red" : "gray"; })
	          .ofObject(),
	      new go.Binding("strokeWidth","width")),
	    $(go.Shape,
	      { toArrow: "Triangle", stroke: null },
	      new go.Binding("scale","scale"),
	      // the Shape.fill color depends on whether Link.isHighlighted is true
	      new go.Binding("fill", "isHighlighted", function(h) { return h ? "red" : "gray"; })
	          .ofObject())/*,
	     $(go.TextBlock,
	      new go.Binding("stroke", "isHighlighted", function(h) {
	                    return h ? "crimson" : "#404040";
	                }).ofObject(),
	      new go.Binding("text", "text"))*/
	  ));
	
    //saveModelToJson
    myDiagram.saveModelToJson=function(){
       var nodeData=myDiagram.model.nodeDataArray;
       var nodeArrayJson=JSON.stringify(nodeData);

       console.log(nodeData);
       
       nui.ajax({
	   	   url: "<%=request.getContextPath()%>/map.do?invoke=genMapPos&nodeArrayJson=" + nodeArrayJson,
	   	   async : false,
	   	   success: function (text) {
		   	   if(text=='1'){
		   	   	  nui.alert("保存成功");
		   	   }else{
		   		  nui.alert("保存失败");
		   	   }
	   	   }
   	   }); 
       
    }
    
    myDiagram.openFullScreen=function() {
        // 判断各种浏览器，找到正确的方法
        var element=document.getElementById("diagramContainer");
        var requestMethod = element.requestFullScreen || //W3C
        element.webkitRequestFullScreen ||    //Chrome等
        element.mozRequestFullScreen || //FireFox
        element.msRequestFullScreen; //IE11
        if (requestMethod) {
            requestMethod.call(element);
        }
        else if (typeof window.ActiveXObject !== "undefined") {//for Internet Explorer
            var wscript = new ActiveXObject("WScript.Shell");
            if (wscript !== null) {
                wscript.SendKeys("{F11}");
            }
        }
      }

      //退出全屏 判断浏览器种类
      myDiagram.exitFullScreen=function () {
          // 判断各种浏览器，找到正确的方法
          var exitMethod = document.exitFullscreen || //W3C
          document.mozCancelFullScreen ||    //Chrome等
          document.webkitExitFullscreen || //FireFox
          document.webkitExitFullscreen; //IE11
          if (exitMethod) {
              exitMethod.call(document);
          }
          else if (typeof window.ActiveXObject !== "undefined") {//for Internet Explorer
              var wscript = new ActiveXObject("WScript.Shell");
              if (wscript !== null) {
                  wscript.SendKeys("{F11}");
              }
          }
      }
      
    //数据模型
    var model = $(go.GraphLinksModel);
    
    nui.parse();
	var nodeDataStr;
	nui.ajax({
	    url: "<%=request.getContextPath()%>/map.do?invoke=genMapNode",
	    contentType: 'text/json',
	    async : false,
		success: function (text) {
			var strToObj=JSON.parse(text);
			nodeDataStr =  strToObj;
	    }
	}); 
	
	var linkDataStr;
	nui.ajax({
	    url: "<%=request.getContextPath()%>/map.do?invoke=genMapLink",
	    contentType: 'text/json',
	    async : false,
		success: function (text) {
			var strToObj=JSON.parse(text);
			linkDataStr =  strToObj;
	    }
	}); 
    
   	model.nodeDataArray=nodeDataStr;
    
   	model.linkDataArray=linkDataStr;
    
    myDiagram.model = model;
    
  //保存图片
	myDiagram.printImage=function(){
	  var img=myDiagram.makeImage();
	  var DialogHeight = document.getElementById("diagramContainer").offsetHeight /2;//设置window.open高度
	  var DialogWidth = document.getElementById("diagramContainer").offsetWidth /2;
	  var openStyle = 'width=' + DialogWidth + ',height=' + DialogHeight + ',top=200,left=200,toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no';
	  window.open(img.src, "Image Print", openStyle);
	}
  	
	//refresh
	myDiagram.refresh=function(){
		location.reload();
	}
	
</script>