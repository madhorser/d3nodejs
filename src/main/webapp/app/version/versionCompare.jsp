<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>版本维护</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/versionCompare.css">
</head>
<body>
<div id="appli-version">
    <div class="tophead">
        <p><img src="../base/images/icons/back.png" onclick="moveBack()"> 系统版本维护</p>
    </div>


    <div class="panel panel-default">
        <div class="panel-body">
            <div id="form1">
                <label for="oldVerId">
                    请选择版本：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </label>
                <div id="oldVerId" name="oldVerId" class="nui-combobox" style="width:250px;" popupWidth="400"
                     textField="verName" valueField="verId"
                     showClose="true" oncloseclick="onCloseClick">
                    <div property="columns">
                        <div field="time">定版时间</div>
                        <div field="verName">版本编号</div>
                    </div>
                </div>
                <label for="newVerId">
                    请选择版本：
                </label>
                <div id="newVerId" name="newVerId" class="nui-combobox" style="width:250px;" popupWidth="400"
                     textField="verName" valueField="verId"
                     showClose="true" emptyText="最新元数据">
                    <div property="columns">
                        <div field="time">定版时间</div>
                        <div field="verName">版本编号</div>
                    </div>
                </div>
                <br/><br/>
                <div>
                    <label for="underClassifierId">
                        元数据类型范围：
                    </label>
                    <input id="classType" class="nui-treeselect" style="width:250px;"
                           textField="text" allowInput="true" showClose="true"
                           valueField="resId" parentField="parentId" onbeforenodeselect="beforenodeselect"
                           oncloseclick="onCloseClick"/>

                    <label for="userview">
                        数据范围：&nbsp;&nbsp;&nbsp;
                    </label>
                    <input class="nui-treeselect" id="userview" name="userview" allowInput="true"
                           textField="text" style="width:250px;" onbeforeload="onBeforeTreeLoad" onnodeclick="onNodeclick"
                           oncloseclick="onViewCloseClick" showClose="true"/>
                    <input class="nui-textbox" visible="false" id="underFolderId" name="underFolderId"/>
                </div>

            </div><br/>
            <button id="searchBtn" class="btn btn-primary blue" onclick="compareCount()">统计差异</button>
            <button id="resetBtn" class="btn btn-primary blue" data-toggle="modal" data-target="#compare-tree" onclick="compareTree()">树形差异</button>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="well">
                <div id="datagrid1" class="nui-datagrid" style="height: 380px;"
                     idField="modeId" allowResize="false" sizeList="[20,30,50,100]"
                     pageSize="20" showEmptyText="true" sortMode="client" emptyText="经比较，两个版本之间的元数据没有差异。如果选择了数据范围，请清空范围试试。">


                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div name="classifierName" field="classifierName" align="center" width="100" headerAlign="center"
                             allowSort="true">
                            元数据类型
                        </div>

                        <div field="addCount" width="100" headerAlign="center" align="center"
                             allowSort="true">
                            新增
                        </div>
                        <div field="deleteCount" width="120" headerAlign="center" align="center"
                             allowSort="true">
                            修改
                        </div>
                        <div field="modifyCount" width="120" headerAlign="center" align="center"
                             allowSort="true">
                            删除
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
    <div class="modal fade" id="compare-tree" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span
                            class="sr-only">Close</span></button>
                    <h5 class="modal-title">树形差异</h5>
                </div>
                <div class="modal-body">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src=""></iframe>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    <div class="modal fade" id="summary" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                    <h5 class="modal-title">对比详情</h5>
                </div>
                <div class="modal-body">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src=""></iframe>
                    </div>
                </div>

            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>
<script type="text/javascript">
    nui.parse();
    //为结果列表赋值
    var grid1 = nui.get("datagrid1");

    grid1.hideColumn("ver_Id");//隐藏版本id列
    grid1.on("drawcell", function (e) {
        var record = e.record,
                column = e.column,
                field = e.field,
                value = e.value;

                 if(field=="addCount"){
                    if(typeof(value)=="undefined"){
                        e.cellHtml=0;
                    }
                    else{
                        var alterType = "A";
                        e.cellHtml = '<a href="javascript:show(\''+alterType+'\')">'+value+'</a>&nbsp; ';
                    }
                }
                if(field=="deleteCount"){
                    if(typeof(value)=="undefined"){
                        e.cellHtml=0;
                    }
                    else{
                        var alterType = "D";
                        e.cellHtml = '<a href="javascript:show(\''+alterType+'\')">'+value+'</a>&nbsp; ';
                    }
                }
                if(field=="modifyCount"){
                    if(typeof(value)=="undefined"){
                        e.cellHtml=0;
                    }
                    else{
                        var alterType = "M";
                        e.cellHtml = '<a href="javascript:show(\''+alterType+'\')">'+value+'</a>&nbsp; ';
                    }
                }

    });
    var instanceId = "<%=request.getParameter("instanceId")%>";
    var isVariation = "<%=request.getParameter("isVariation")%>";
    var oldV = "<%=request.getParameter("oldVerId")%>";
    var newV = "<%=request.getParameter("newVerId")%>";


    //为左侧系统版本赋值
    var oldVerId = nui.get("oldVerId");
    var oldVer = "<%=request.getContextPath()%>/version.do?invoke=listVersion&instanceId=" + instanceId + "&isVariation=false";
    oldVerId.load(oldVer);

    //为右侧系统版本赋值
    var newVerId = nui.get("newVerId");
    var newVer = "<%=request.getContextPath()%>/version.do?invoke=listVersion&instanceId=" + instanceId + "&isVariation=true";
    newVerId.load(newVer);

    //为元数据类型范围赋值
    var classType = nui.get("classType");
    var classurl = "<%=request.getContextPath()%>/packageCommandCmd.do?invoke=tree&useAuth=1";
    //classType.setUrl(classurl);
    classType.load(classurl);

    //为数据范围赋值
    var underFolderId = nui.get("underFolderId");
    var userview = nui.get("userview");
    var viewurl = "<%=request.getContextPath()%>/userViewCmd.do?invoke=treeUserView";
    userview.load(viewurl);
    function onBeforeTreeLoad(e) {
        var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var params = e.params;  //参数对象
        params.skeletonOnly = "true";
        if (typeof(node.resource) == "undefined") {
            params.resource = "root";
            params.orderBy = "name";

        }
        else if (node.resource == "metadata" || node.resource == "page" || node.resource == "class") {
            params.resource = node.resource;
            params.instanceId = node.instanceId;
            params.classifierId = node.classifierId;
            params.start = node.start;
            params.orderBy = "name";
        }
        else if (node.resource == "view") {
            params.resource = node.resource;
            params.orderBy = "name";
            params.viewId = node.viewId;
        }
        else {
            params.resource = node.resource;
            params.orderBy = "name";
            params.viewId = node.viewId;
            params.folderId = node.folderId;
            params.start = node.start;
        }
    }

    //初次进入界面就执行一次统计查询
    function compareInit() {
        if (isVariation == "true") {
            //newVerId.setValue("");
            oldVerId.setValue(oldV);
        }
        else {
            oldVerId.setValue(oldV);
            newVerId.setValue(newV);
        }
        this.compareCount();
    }

    this.compareInit();
    //统计差异
    function compareCount() {
        var newVer_Id = newVerId.getValue();
        var oldVer_Id = oldVerId.getValue();
        if (oldVer_Id == null || oldVer_Id == "") {
            nui.alert("请选择正确的版本！");
            return false;
        }
        var underInstanceId = instanceId;
        var underclassifierId = classType.getValue();
        var url1 = "<%=request.getContextPath()%>/verCompareCmd.do?invoke=summarizeVersions&newVerId=" + newVer_Id
                + "&oldVerId=" + oldVer_Id + "&underInstanceId=" + underInstanceId + "&underClassifierId=" + underclassifierId
                + "&underViewId=" + userview.getValue() + "&underFolderId=" + underFolderId.getValue();
        grid1.setUrl(url1);
        grid1.load();
    }
    //树形差异
    function compareTree() {
        var newVer_Id = newVerId.getValue();
        var oldVer_Id = oldVerId.getValue();
        var underInstanceId = instanceId;
        var newVer_Name = newVerId.getText();
        var oldVer_Name = oldVerId.getText();
        if (newVer_Name == "" || newVer_Name == null) {
            newVer_Name = "最新元数据";
        }
        var url1 = "<%=request.getContextPath()%>/app/version/versionCompareTree.jsp?newVerId=" + newVer_Id + "&newVerName=" + newVer_Name + "&oldVerId=" + oldVer_Id + "&oldVerName=" + oldVer_Name + "&underInstanceId=" + underInstanceId;
        $('#compare-tree iframe').attr('src',url1);
        /*nui.open({
            url: url1, width: 850, height: 500
        });*/
    }

    //禁止选中package和datatype
    function beforenodeselect(e) {
        var node = e.node;
        if (node.resource == "package" || node.resource == "datatype") e.cancel = true;
    }
    //点击清除
    function onCloseClick(e) {
        var obj = e.sender;
        obj.setText("");
        obj.setValue("");
    }
    //点击数据范围节点时，赋值
    function onNodeclick(e) {
        var tree = e.sender;
        var node = e.node;

        if (node.resource == "view") {
            userview.setValue(node.viewId);
            userview.setText(node.text);
            underFolderId.setValue('');
        }
        else if (node.resource == "viewFolder") {
            userview.setValue(node.viewId);
            userview.setText(node.text);
            underFolderId.setValue(node.folderId);
        }

    }
    //点击数据范围的清除
    function onViewCloseClick(e) {
        var obj = e.sender;
        obj.setText("");
        obj.setValue("");
        underFolderId.setValue("");
    }

    function show(alterType) {
            nui.parse();
            var row = grid1.getSelected();
            if (typeof(row) == "undefined") {
                nui.alert('请选择一条记录');
                return false;
            }

            var url = "<%=request.getContextPath()%>/app/version/versionSummarizeCompare.jsp?classifierId="+row.classifierId+"&alterType="+alterType
            +"&newVerId="+newVerId.getValue()+"&oldVerId="+oldVerId.getValue()+"&underInstanceId=<%=request.getParameter("instanceId")%>&underClassifierId=" + classType.getValue()
            + "&underViewId=" + userview.getValue() + "&underFolderId=" + underFolderId.getValue();
            $('#summary iframe').attr('src',url);
            jQuery.noConflict();
            $('#summary').modal('show')
            
        }
      function moveBack(){
          parent.$('.hidebg').click();
      }      

</script>

</body>
</html>