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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/versionRecord.css">
</head>
<body>
<div id="appli-version">

    <div class="panel panel-default">
        <div class="panel-body">
            <div id="form1">
                <label for="startDate">定版时间：</label>
                <input class="nui-datepicker" id="startDate" name="startDate"
                       placeholder="" timeFormat="">
                    --
                <input class="nui-datepicker" id="endDate" name="endDate"
                       placeholder="" timeFormat="">

                <label for="verNameLike">
                    版本编号：
                </label>
                <input class="nui-TextBox" id="verNameLike" name="verNameLike"
                       placeholder="">
                <button class="btn btn-primary blue pop-right" onclick="searchVersion()">查询</button>
                <button class="btn btn-primary blue pop-right" onclick="clear1()">重置</button>
            </div>
        </div>

    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <button class="btn btn-primary blue pop-right" onclick="compareNew()">与最新版本比对</button>&nbsp
            <button class="btn btn-primary blue pop-right" onclick="compare()">版本间比对</button>&nbsp
            <button class="btn btn-primary blue" onclick="versionExport()">版本导出</button>&nbsp
        </div>
        <div class="panel-body" >
            <div class="well" >

                      <div id="datagrid1" class="nui-datagrid" style="height:450px;"
                         dataField="data" idField="id" allowResize="false" multiSelect="true" allowResize="true" onshowrowdetail="onShowRowDetail" sortMode="client">


                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div name="verName" field="verName" align="center" width="100" headerAlign="center"
                             allowSort="true">
                            版本编号
                        </div>

                        <div field="createTime" width="100" headerAlign="center" align="center"
                             allowSort="true">
                            定版时间
                        </div>
                        <div field="userId" width="120" headerAlign="center" align="center"
                             allowSort="true">
                            定版人员
                        </div>
                        <div field="verDesc" width="120" headerAlign="center" align="center"
                             allowSort="true">
                            版本描述
                        </div>
                        <div field="verType" width="100" align="center" align="center"
                             headerAlign="center" allowSort="true">
                            是否基线版本
                        </div>
                        <div name="verId" field="verId" width="100" align="center"
                             headerAlign="center" hidden="true">
                            版本id
                        </div>
                        <div type="expandcolumn">展开</div>
                    </div>
                </div>
                <div id="detailGrid_Form" style="display:none;">
                    <div id="detail_grid" class="mini-datagrid" style="width:100%;">
                        <div property="columns">
                            <div field="classifierName" width="100" allowSort="true" renderer="onGenderRenderer" align="center"
                                 headerAlign="center">元数据类型
                            </div>
                            <div field="count" width="100" allowSort="true" align="center" headerAlign="center">数量（点击查看）
                            </div>
                            <div name="classifierId" field="classifierId" width="100" allowSort="true">类型id
                            </div>
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
</div>
    <div class="modal fade" id="summary" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><img src="../base/images/icons/close.png"><span class="sr-only">Close</span></button>
                    <h5 class="modal-title">元数据详情</h5>
                </div>
                <div class="modal-body">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src=""></iframe>
                    </div>
                </div>

            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
<script type="text/javascript">
    function popOut(){
        $('.dRight').addClass('menu-right');
        var hideobj=document.getElementsByClassName("hidebg")[0];
        hideobj.style.display="block";
        hideobj.style.height=document.body.clientHeight+"px";

        /*var url=$(this).attr('url');
        $(".dRight iframe").attr("src",url);*/


    }
    $('.hidebg').click(function(){
        $('.dRight').removeClass('menu-right');
        document.getElementsByClassName("hidebg")[0].style.display="none";
    })
    nui.parse();
    //为结果列表赋值
    var grid1 = nui.get("datagrid1");//版本展示
    var detail_grid = nui.get("detail_grid");//版本展开的表格
    var detailGrid_Form = document.getElementById("detailGrid_Form");//detail_grid所在的form
    var instanceId = "<%=request.getParameter("id")%>";
    var url1 = "<%=request.getContextPath()%>/version.do?invoke=newsearchVersion&instanceId=" + instanceId;
    grid1.setUrl(url1);
    grid1.load();
    grid1.hideColumn("verId");//隐藏版本id列
    grid1._rowsViewEl.style.height="100%";

    detail_grid.hideColumn("classifierId");//隐藏类型id列
    grid1.on("drawcell", function (e) {
        var record = e.record,
                column = e.column,
                field = e.field,
                value = e.value;

        //格式化日期
        if (field == "createTime") {
            value = new Date(value);
            if (nui.isDate(value)) e.cellHtml = nui.formatDate(value, "yyyy-MM-dd HH:mm:ss");

        }

        //是否基线版本
        if (field == "verType") {
            if (value == 0) {
                e.cellHtml = "否";
            }
            else {
                e.cellHtml = "是";
            }
        }
    });
    //查询
    function searchVersion() {
        var form = new nui.Form("#form1");
        var data = form.getData();
        var startDate = nui.formatDate(new Date(data.startDate), "yyyy-MM-dd");
        var endDate = nui.formatDate(new Date(data.endDate), "yyyy-MM-dd");
        var verNameLike = data.verNameLike;
        grid1.filter(function (row) {
            var r1 = true;
            if (startDate) {
                r1 = false;
                var startTime = nui.parseDate(startDate).getTime();
                if (row.createTime >= startTime) r1 = true;
            }
            var r2 = true;
            if (verNameLike) {
                r2 = String(row.verName).toLowerCase().indexOf(verNameLike) != -1;
            }
            var r3 = true;
            if (endDate) {
                r3 = false;
                var endTime = nui.parseDate(endDate).getTime()+86400000;
                if (row.createTime <= endTime) r3 = true;
            }
            return r1&& r2 && r3;
        });
    }
    //重置
    function clear1() {
        var form = new nui.Form("#form1");
        form.reset();
        grid1.load();

    }
    //版本间对比
    function compare() {
        var row = grid1.getSelecteds();
        if (typeof(row) == "undefined") {
            nui.alert("请选择两条数据");
            return false;
        }
        else if (row.length != 2) {
            nui.alert("请选择两条数据");
            return false;
        }
        var url = "<%=request.getContextPath()%>/app/version/versionCompare.jsp?oldVerId=" + row[0].verId + "&instanceId=" + instanceId + "&isVariation=false&newVerId=" + row[1].verId;
        $(".dRight iframe").attr("src",url)
        popOut();
        /*nui.open({
            url: url, width: 850, height: 500
        });*/
    }
    //与最新版本对比
    function compareNew() {
        var rows = grid1.getSelecteds();
        if (typeof(rows) == "undefined") {
            nui.alert("请选择一条数据");
            return false;
        }
        else if (rows.length != 1) {
            nui.alert("请选择一条数据");
            return false;
        }
        var row = rows[0];
        var url = "<%=request.getContextPath()%>/app/version/versionCompare.jsp?oldVerId=" + row.verId + "&instanceId=" + instanceId + "&isVariation=true&oldVerName=" + row.verName;
        $(".dRight iframe").attr("src",url)
        popOut();
       /* nui.open({
            url: url, width: 850, height: 500
        });*/
    }
    //导出
    function versionExport() {
        var rows = grid1.getSelecteds();
        if(rows.length==0){
            nui.alert("请选中版本信息！");
            return false;
        }
        var verIds = "";
        for (var i = 0; i < rows.length; i++) {
            verIds += rows[i].verId + ",";
        }
        var url = "<%=request.getContextPath()%>/version.do?invoke=downloadVersion&verIds=" + verIds;
        window.open(url);
    }

    function onShowRowDetail(e) {
 
        var grid = e.sender;
        var row = e.record;

        var td = grid1.getRowDetailCellEl(row);
        td.appendChild(detailGrid_Form);
        detailGrid_Form.style.display = "block";
        var url = "<%=request.getContextPath()%>/version.do?invoke=newsummarizeVersion";
        detail_grid.setUrl(url);
        detail_grid.load({verId: row.verId});
        detail_grid._rowsViewEl.style.height="100%";

        //数量为超链接
      /*   detail_grid.on("drawcell", function (e) {
            var record = e.record,
                    column = e.column,
                    field = e.field,
                    value = e.value;
        	console.log(field);

            var classifierId;
            //count列，超连接操作按钮
            if (field == "count") {
                e.cellStyle = "text-align:center";
                e.cellHtml = '<a href="javascript:show(\'' + row.verId + '\',\'' + row.verName + '\')">' + value + '</a>&nbsp; '
            }

        }); */
    }

    function show(verId, verName) {
        nui.parse();
        var row = detail_grid.getSelected();
        if (typeof(row) == "undefined") {
            nui.alert('请选择一条记录');
            return false;
        }
        var url = "<%=request.getContextPath()%>/app/version/versionSummarizeMetaData.jsp?classifierId=" + row.classifierId + "&verId=" + verId + "&verName=" + verName;
        $('#summary iframe').attr('src',url);
        jQuery.noConflict();
        $('#summary').modal('show')

    }

</script>

</body>
</html>