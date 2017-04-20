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
			建关系任务名称：
			<input class="nui-TextBox" id="verNameLike" name="verNameLike" placeholder="">
			
			字段名称：
		 	<input class="nui-TextBox" id="verNameLike" name="verNameLike" placeholder="">
		 	
		 	相似度范围：
		 	<input class="nui-TextBox" id="verNameLike" name="verNameLike" placeholder="">
		 	至
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

		<div class="well">

			
<div id="datagrid1" class="nui-datagrid" style="height: 500px;"
                          allowResize="false" sortMode="client" dataField="data" idField="id">
                        <div property="columns">
                            <div name="name" field="name" align="center" width="100" headerAlign="center"
                                 allowSort="true">
                                字段名
                            </div>

                            <div field="manager_name" width="100" headerAlign="center" align="center"
                                 allowSort="true">
                                来源表
                            </div>
                           <div field="manager_name" width="100" headerAlign="center" align="center"
                                 allowSort="true">
                                对比字段名
                            </div>
                            <div field="userId" width="120" headerAlign="center" align="center"
                                 allowSort="true">
                                对比字段来源表
                            </div>
                           <div field="userId" width="120" headerAlign="center" align="center"
                                 allowSort="true">
                                距离（相似度）
                            </div>
                            <div field="manager" width="120" headerAlign="center" align="center"
                                 allowSort="true" renderer="showText">
                                操作
                            </div>
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
    //为结果列表赋值
    var grid1 = nui.get("datagrid1");
    var url1 = "a1.json";
    grid1.setUrl(url1);
    grid1.load();

    //重置
    function reset() {
        var form = new nui.Form("#form1");
        form.reset();
        grid1.load();

    }
    
    function showText(e){
	    var builtIn = e.value;
	    return  "<a href=\"javascript:void(0);\">新增&nbsp;&nbsp;</a>"+ "<a href=\"javascript:void(0);\">修改&nbsp;&nbsp;</a>"+ "<a href=\"javascript:void(0);\">删除</a>";
    }

</script>

</body>
</html>
