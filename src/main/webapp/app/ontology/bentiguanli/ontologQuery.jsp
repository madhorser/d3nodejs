<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>
<html>
<head>
    <title>比对规则管理</title>

	<!--NUI-->
	<script src="<%=request.getContextPath() %>/app/base/js/nui/nui.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/bootstrap.min.css">
	<script src="<%=request.getContextPath() %>/app/base/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/app/base/js/bootstrap.min.js"></script>
		
    <%
		String contextPath=request.getContextPath();
	%>
	<script>
		nui.context='<%=contextPath %>';
	</script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/version.css">
</head>

<body>
<div class="tophead">
 	<p><span id="backAppli" class="glyphicon glyphicon-circle-arrow-left" style="font-size: 17px;float: left;"></span> 综合应用 / 系统版本维护</p>
</div>
<div class="panel panel-default">
	<div class="panel-body">
	 	<p class="p-head"><span></span>查询设置</p>
		<div id="form1" >
			本体名称：
			<input class="nui-TextBox" id="verNameLike" name="verNameLike" placeholder="">
			<br/><br/>
			<button id="searchBtn" class="btn btn-primary blue" onclick="searchVersion()">查询</button>
			<button id="clearBtn" class="btn btn-primary blue" onclick="reset()">重置</button>
		</div>
	</div> 
	
	        
	
</div>
<div class="panel panel-default">
	<div class="panel-body">
        <p class="p-head"><span></span>结果列表</p>

			
		<div id="p3" class="mini-panel" title="本体：" iconCls="icon-tip" style="float:left;width:28%;height:50%;" >
		
		<div id="datagrid2" class="nui-datagrid" style="width:100%;height:100%;" 
		
        url="a.json"   sortMode="client">
        <div property="columns"> 
                   
            <div field="name" width="" headerAlign="center" align="center" allowSort="true">本体名称</div>    
            <div field="id" width="" headerAlign="center"  align="center" allowSort="true" renderer="showText">操作</div>
        </div>
        </div>
		    
		</div>
		
		<div id="p4" class="mini-panel" title="本体关系：" iconCls="icon-tip" style="float:right;width:66%;height:50%;margin-right:55px;" >
		   
		<div id="datagrid3" class="nui-datagrid" style="width:100%;height:100%;" 
		borderStyle="border:0;"
        url="b.json"   sortMode="client" allowCellSelect="true"  allowCellEdit="true">
        <div property="columns"> 
            <div field="name" width="100" headerAlign="center" align="center" allowSort="true">本体名称</div>     
            <div  field="gender"  width="100"  headerAlign="center" align="center" allowSort="true" renderer="onGenderRenderer">关系类型
            		<input    property="editor" class="nui-combobox" style="width:100%;" data="Genders" />
            </div>    
            <div name="schoolname" field="school" width="100" headerAlign="center" align="center" allowSort="true" >关系名称
            <input property="editor" class="nui-textbox" style="width:100%;" minHeight="80"/>
            </div>
            <div field="id" width="100" headerAlign="center" align="center" allowSort="true" renderer="showText2">操作</div>
        </div>
        </div>
		    
		</div>
			
		
	</div>
</div>
 <div class="hidebg"></div>
<div class="dRight">
        <div class="embed-responsive embed-responsive-16by9">
            <iframe class="embed-responsive-item" src=""></iframe>
        </div>
</div>

	
<script type="text/javascript">
    nui.parse();
    
    
    function showText(e){
	    var builtIn = e.value;
	    return "<a href=\"javascript:void(0);\">查看</a>&nbsp;&nbsp;"+ "<a href=\"javascript:void(0);\">新增&nbsp;&nbsp;</a>"+ "<a href=\"javascript:void(0);\">修改&nbsp;&nbsp;</a>"+ "<a href=\"javascript:void(0);\">删除</a>";
    }
    
    function showText2(e){
	    var builtIn = e.value;
	    return "<a href=\"javascript:void(0);\">关联</a>";
    }
    
    var Genders = [{ id: 1, text: '组合关系' }, { id: 2, text: '分类关系'}, { id: 3, text: '关联关系'}];
    function onGenderRenderer(e) {
        for (var i = 0, l = Genders.length; i < l; i++) {
            var g = Genders[i];
            if (g.id == e.value) return g.text;
        }
        return "选择关系";
    }


</script>

</body>
</html>
