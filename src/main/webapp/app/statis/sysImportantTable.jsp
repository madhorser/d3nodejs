<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/packages.jsp"%>

<!DOCTYPE html />
<html>
<head>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/base//nui/nui.js"></script>
<title></title>
<link href="<%=request.getContextPath()%>/app/base/nui/demo.css"
	rel="stylesheet" type="text/css" />

</head>
<body>
	 <div id="datagrid1" class="nui-datagrid" style="width:725px;height:250px;" multiSelect="true" allowResize="true" dataField="data"
             url="org.gocom.components.nui.demo.newdataset.impl.TEmployee.queryEmployee.biz.ext" valueField="id" >
           <div property="columns">            
                          
                <div field="loginname" width="120" headerAlign="center" allowSort="true">系统名称</div>  
                 <div field="createtime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">上线日期</div>
                 <div field="departure" width="120" headerAlign="center" allowSort="true">主管部门</div>                 
                <div field="import" width="100" allowSort="true" align="center" headerAlign="center">接受数量</div>
                 <div field="export" width="100" allowSort="true" align="center" headerAlign="center">输出数量</div>    
                 <div field="allnum" width="100" allowSort="true" align="center" headerAlign="center">关联总数</div>                 
              
           </div>
        </div> 
</body>
</html>
<script type="text/javascript">
	  nui.parse();
            var grid = nui.get("datagrid1");
            grid.load();
            //绑定表单
            var db = new nui.DataBinding();
            db.bindForm("editForm1", grid);
</script>