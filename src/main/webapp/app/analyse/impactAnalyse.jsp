<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<head>
<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/app/base/js/go-debug.js"></script>
<body>
<style>
	.gshDisplay {
	  border-color: #66cdcf;
	  font-size: 12;
	  margin-bottom: 4;
	}
    .top-menu{
	    position:fixed;
	    z-index:2000;
	    top:10px;
	    right:40px;
	}
</style>
<div class="top-menu">
   <div class="menu">
      <button class="btn btn-default" onclick="myDiagram.commandHandler.increaseZoom()" title="放大"><img src="../base/images/dm/zoomIn.png"></button>
      <button class="btn btn-default" onclick="myDiagram.commandHandler.decreaseZoom()" title="缩小"><img src="../base/images/dm/zoomOut.png"></button>
      <button class="btn btn-default" onclick="fullScreen()" title="全屏"><img src="../base/images/dm/full.png"></button>
      <button class="btn btn-default" onclick="myDiagram.refresh()" title="刷新"><img src="../base/images/dm/refresh.png"></button>
      <button class="btn btn-default" onclick="myDiagram.printImage()" title="打印"><img src="../base/images/dm/exp.png"></button>
   </div>
</div>
<div id="diagramContainer">
<div id="myDiagramDiv" style="width:100%; height:100%; background-color: #DAE4E4;"></div>
</div>
</body>
<div id="content"></div>
<script type="text/javascript">

	var jq = $.noConflict();
	var a=0;
	function fullScreen(){
		if(a==0){
			parent.$('.modal-right .modal-dialog').css('width','99%');
			parent.$('.modal-right.in .modal-dialog').css('transform','translate(0%,0)');
			parent.$('.modal-header').hide();
			parent.parent.$('.min-menu').hide();			
			parent.parent.parent.fullScreen();
			jq('#diagramContainer').css({
	            width:'100%',
	            height:'100%'
	        });
			a=1;
		}else{
			parent.$('.modal-right .modal-dialog').css('width','89%');
			parent.$('.modal-right.in .modal-dialog').css('transform','translate(11%,0)');
			parent.$('.modal-header').show();
			parent.parent.$('.min-menu').show();
			parent.parent.parent.exitFullScreen();
	        jq('#diagramContainer').css({
	            width:'100%',
	            height:'100%'
	        });
			a=0;
		}
	}
	
	//创建全局变量$
    var $ = go.GraphObject.make;
    //间距变量
    var space=100;
    //创建图表diagram
    var myDiagram =
      $(go.Diagram, "myDiagramDiv",
        {
          initialContentAlignment: go.Spot.Center, // center Diagram contents
          "undoManager.isEnabled": true, // enable Ctrl-Z to undo and Ctrl-Y to redo
          "toolManager.mouseWheelBehavior": go.ToolManager.WheelNone,
          layout:$(go.GridLayout,
              { wrappingWidth: Infinity, 
                alignment: go.GridLayout.Position, 
                cellSize: new go.Size(1, 1),
                isOngoing:false,
                //isInitial:false,
                spacing: new go.Size(space,0)
              })
        });
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
      //console.log(node);
      //var nodeKey = node.data.key;
      //node.findLinksConnected().each(function(m){m.visible = false});
      //console.log(links);
    };

    function onNodeMouseLeave(e, obj) {
      //myDiagram.startTransaction("no highlighteds");
      myDiagram.clearHighlighteds();
      //var Groups=myDiagram.findTopLevelGroups();
      //console.log('groups is '+ Groups);
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
         locationSpot: go.Spot.Center, // Node.location is the center of the Shape
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
              new go.Binding("text", "name").makeTwoWay())
          ),
        {
              cursor:"pointer",
              toolTip:  // define a tooltip for each node that displays the color as text
                $(go.Adornment, "Auto",
                  $(go.Shape, "RoundedRectangle",{ 
                    fill: "#f3f19a" ,
                    strokeWidth:1,
                    stroke:"#f3f19a"
                  }),
                  $(go.Panel, "Vertical",
                    $(go.TextBlock, { margin: 3,alignment:go.Spot.Left,font: "12px sans-serif" },
                      new go.Binding("text", "code",function(s){return "代码: "+s;})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "name",function(s){return "名称: "+s})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "type",function(s){return "元数据类型: "+s})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "url",function(s){return "路径: "+s})))
                  /*$(go.TextBlock, { 
                    alignment: go.Spot.Center,
                    margin: 10,
                    font: "14px sans-serif"
                  },
                  new go.Binding("text", "name"))*/
                )  // end of Adornment
            }
      );
    //group模板
    // There are two templates for Groups, "ParentGroup" and "ChildGroup".
    //ParentGroup
    myDiagram.groupTemplateMap.add("ParentGroup",
      $(go.Group, "Auto",
        {
         selectionAdorned:false,
         selectionChanged:onSelectionChanged,
         computesBoundsAfterDrag: true,
         layout:
            $(go.GridLayout,
              { wrappingColumn: 1, alignment: go.GridLayout.Position,
                  cellSize: new go.Size(1, 1), spacing: new go.Size(4, 4) })
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
                margin: 20,
                font: "bold 14px sans-serif",
                opacity: 0.75,
                stroke: "#404040"
              },
              new go.Binding("text", "name").makeTwoWay())
          ),  // end Horizontal Panel
          {
              cursor:"pointer",
              toolTip:  // define a tooltip for each node that displays the color as text
                $(go.Adornment, "Auto",
                  $(go.Shape, "RoundedRectangle",{ 
                    fill: "#f3f19a" ,
                    strokeWidth:1,
                    stroke:"#f3f19a"
                  }),
                  $(go.Panel, "Vertical",
                    $(go.TextBlock, { margin: 3,alignment:go.Spot.Left,font: "12px sans-serif" },
                      new go.Binding("text", "code",function(s){return "代码: "+s;})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "name",function(s){return "名称: "+s})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "type",function(s){return "元数据类型: "+s})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "url",function(s){return "路径: "+s})))
                  /*$(go.TextBlock, { 
                    alignment: go.Spot.Center,
                    margin: 10,
                    font: "14px sans-serif"
                  },
                  new go.Binding("text", "name"))*/
                )  // end of Adornment
            },
          $(go.Placeholder,
            { padding: 5, alignment: go.Spot.TopLeft })
        ) // end Vertical Panel
      ));
    //ChildGroup
    myDiagram.groupTemplateMap.add("ChildGroup", 
      $(go.Group, "Auto",
        {
         selectionAdorned:false,
         selectionChanged:onSelectionChanged,
         computesBoundsAfterDrag: true,
         //subGraphExpandedChanged:objectGraphHideLinks,
         isSubGraphExpanded:false,
         layout:
            $(go.GridLayout,
              { wrappingColumn: 1, 
              	alignment: go.GridLayout.Position,
                cellSize: new go.Size(1, 1), 
                spacing: new go.Size(4, 4) })
       },
       new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
        $(go.Shape, "Rectangle",
          { name:"SHAPE",fill: null, stroke: "#eff4f8", strokeWidth: 2,margin:-1},
          // the Shape.stroke color depends on whether Link.isHighlighted is true
          new go.Binding("stroke","isHighlighted",function(h){ return h? "red":"#eff4f8"})
          .ofObject()),
        $(go.Panel, "Vertical",  // title above Placeholder
          $(go.Panel, "Horizontal",  // picture next to TextBlock
            { stretch: go.GraphObject.Horizontal, background: "#eff4f8" },
            $("SubGraphExpanderButton",
              { alignment: go.Spot.Right, margin: 5 }),
            $(go.Picture,
              { alignment: go.Spot.Right, margin: 5,width: 29, height: 29 },
              new go.Binding("source")),
            $(go.TextBlock,
              {
                alignment: go.Spot.Left,
                margin: 15,
                font: "bold 14px sans-serif",
                opacity: 0.75,
                stroke: "#404040"
              },
              new go.Binding("text", "name").makeTwoWay())
          ),  // end Horizontal Panel
          {
              cursor:"pointer",
              toolTip:  // define a tooltip for each node that displays the color as text
                $(go.Adornment, "Auto",
                  $(go.Shape, "RoundedRectangle",{ 
                    fill: "#f3f19a" ,
                    strokeWidth:1,
                    stroke:"#f3f19a"
                  }),
                  $(go.Panel, "Vertical",
                    $(go.TextBlock, { margin: 3,alignment:go.Spot.Left,font: "12px sans-serif" },
                      new go.Binding("text", "code",function(s){return "代码: "+s;})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "name",function(s){return "名称: "+s})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "type",function(s){return "元数据类型: "+s})),
                    $(go.TextBlock, { margin: 3 ,alignment:go.Spot.Left,font: "12px sans-serif"},
                      new go.Binding("text", "url",function(s){return "路径: "+s})))
                  /*$(go.TextBlock, { 
                    alignment: go.Spot.Center,
                    margin: 10,
                    font: "14px sans-serif"
                  },
                  new go.Binding("text", "name"))*/
                )  // end of Adornment
            },
          $(go.Placeholder,
            { padding: new go.Margin(0,5), alignment: go.Spot.TopLeft })
        )// end Vertical Panel
      ));
    // link模板
    // There are three templates for link, "ParentGroupLink","ChildGroupLink" and "NodeLink".
    //ParentGroupLink
    myDiagram.linkTemplateMap.add("ParentGroupLink", 
      $(go.Link,
        { routing: go.Link.Normal, 
          curve: go.Link.Bezier ,
          toShortLength: 30, 
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
              .ofObject())
      ));
    //ChildGroupLink
    myDiagram.linkTemplateMap.add("ChildGroupLink", 
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
              .ofObject())
      ));
    //NodeLink
    myDiagram.linkTemplateMap.add("NodeLink", 
      $(go.Link,
        { routing: go.Link.Orthogonal, 
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
        //NodeDashLink
    myDiagram.linkTemplateMap.add("NodeDashLink", 
      $(go.Link,
        { routing: go.Link.Orthogonal, 
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
          { isPanelMain: true, stroke: "black", strokeWidth: 1 ,strokeDashArray:[4,2]},
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
	
	//数据模型
	//Model Data
	var model = $(go.GraphLinksModel);
    
    var instanceId = "<%=request.getParameter("id")%>";
    
    nui.parse();
	var nodeDataStr;
	nui.ajax({
	    url: "<%=request.getContextPath()%>/analyseCmd.do?invoke=getAnalyseNode&displayType=2&analyseType=impact&instanceId=" + instanceId,
	    contentType: 'text/json',
	    async : false,
		success: function (text) {
			var strToObj=JSON.parse(text);
			nodeDataStr =  strToObj;
	    }
	}); 
	
	var linkDataStr;
	nui.ajax({
	    url: "<%=request.getContextPath()%>/analyseCmd.do?invoke=getAnalyseLink&displayType=2&analyseType=impact&instanceId=" + instanceId,
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

    //saveModelToJson
    myDiagram.saveModelToJson=function(){
       var nodeData=myDiagram.model.nodeDataArray;
       var nodeDataToJson=JSON.stringify(nodeData);

       //alert("Model to Json: "+modelToJson.nodeDataArray);
       console.log(nodeData);
       alert(nodeDataToJson);
    }
    //getTopLevelGroups
    myDiagram.getGroupsLocation=function(){
      var groups=myDiagram.findTopLevelGroups();
      var locArray=[];
      while(groups.next()){
          var loc=groups.value.location;
          locArray.push(loc);
          //var pos=groups.value.position;
          //alert("Groups'location: "+loc.x.toFixed(2)+" "+loc.y.toFixed(2));
          console.log("Groups'location: "+loc.x.toFixed(2)+" "+loc.y.toFixed(2));
      }
      alert("Groups'location: "+locArray);
    }
    //objectGraphHideLinks
    function objectGraphHideLinks(group){
      var groupObj = group;
      //获取Group内的node组
      var nodes = groupObj.findSubGraphParts().iterator;
      while(nodes.next()){
          //var nodeKey = nodes.value.data.key;
          //获取关联node
          var relatedNode = nodes.value.findNodesConnected();
          //隐藏或展示node连线关系
          nodes.value.findLinksConnected().each(function(m){
            m.visible = false;
            //判断Group及关联Group是收缩或展开
            if(groupObj.isSubGraphExpanded == true ){
               //关联Group
               relatedNode.each(function(n){
                 if(n.findCommonContainingGroup(n).isSubGraphExpanded){
                    m.visible=true;
                 }
              }); 
            }
          });
      } 
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
	
	var isFirstLoad = parent.document.getElementById("isFristLoadTag").getAttribute("isFirst");
	if(isFirstLoad == "true"){
		parent.document.getElementById("isFristLoadTag").setAttribute("isFirst", "false");
		myDiagram.refresh();
	}
	
</script>