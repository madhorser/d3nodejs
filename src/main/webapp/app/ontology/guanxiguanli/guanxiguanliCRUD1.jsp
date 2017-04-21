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
			关系：
			<input name="shuyutype" showNullItem="true" class="nui-combobox" url="shuyuzhuangtai.txt" value="1" textField="text" valueField="id" />
			
			元数据库：
		 	<input name="shuyutype" showNullItem="true" class="nui-combobox" url="shuyuzhuangtai.txt" value="1" textField="text" valueField="id" />
		 	
		 	元数据表：
		 	<input name="shuyutype" showNullItem="true" class="nui-combobox" url="shuyuzhuangtai.txt" value="1" textField="text" valueField="id" />
		 	
		 	
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

                            <div field="manager_name" width="100" headerAlign="center" align="center"
                                 allowSort="true">
                                字段
                            </div>
                           <div field="manager_name" width="100" headerAlign="center" align="center"
                                 allowSort="true">
                                字段备注
                            </div>
                            <div field="userId" width="120" headerAlign="center" align="center"
                                 allowSort="true">
                                表名
                            </div>
                           <div field="userId" width="120" headerAlign="center" align="center"
                                 allowSort="true">
                                表名备注
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
	    return  "<a href=\"javascript:void(0);\">来源</a>";
    }
    


</script>

</body>
</html>
