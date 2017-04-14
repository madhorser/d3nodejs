<%@ page contentType="text/html; charset=UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<head>
    <title>My JSP 'search.jsp' starting page</title>
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
    <script
            src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
    <script
            src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/app/base/css/msg.css">
</head>

<body>
<div id="news">
    <div class="left">
        <ul id="myTab" class="nav nav-pills nav-stacked">
            <li class="tabs active"><a href="#change" data-toggle="tab"
                                  id="home_tab" onclick="readchange()"></a></li>
            <li class="tabs"><a href="#version" data-toggle="tab" id="v_tab"
                   onclick="readversion()"> </a></li>
            <li class="tabs"><a href="#comparison" data-toggle="tab" id="c_tab"
                   onclick="readcmp()"></a></li>
            <li class="tabs"><a href="#system" data-toggle="tab" id="s_tab"
                   onclick="readsys()"></a></li>
            <li class="tabs"><a href="#announcement" data-toggle="tab" id="a_tab"
                   onclick="readannouce()"></a></li>

        </ul>
    </div>
    <div class="right">
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane fade in active" id="change">
                <div class="panel-body"
                     style="background-color:rgb(249, 249, 249);color:#3289ff;font-weight:bold;"
                     role="alert">变更通知
                    <div class="btn-group">
                        <button type="button"
                                class="btn btn-default dropdown-toggle btn-xs"
                                data-toggle="dropdown">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" data-toggle="modal" data-target="#change1">清空</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#change2">屏蔽</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#change3">取消屏蔽</a></li>
                        </ul>
                    </div>
                </div>
                <div class="modal fade" id="change1" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">即将清空该类型下的所有消息，是否继续？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="deletechange()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="change2" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否屏蔽变更通知？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="shiledchange()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="change3" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否解除屏蔽变更通知？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="reshiledchange()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>
                <br>
                <div id="changcontent"></div>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="version">
                <div class="alert"
                     style="background-color:rgb(249, 249, 249);color:#3289ff;font-weight:bold;"
                     role="alert">
                    版本发布
                    <div class="btn-group">
                        <button type="button"
                                class="btn btn-default dropdown-toggle btn-xs"
                                data-toggle="dropdown">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" data-toggle="modal" data-target="#version1">清空</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#version2">屏蔽</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#version3">取消屏蔽</a></li>

                        </ul>
                    </div>
                </div>

                <div class="modal fade" id="version1" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">即将清空该类型下的所有消息，是否继续？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="deleteversion()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="version2" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否屏蔽版本发布？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="shiledversion()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="version3" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否解除屏蔽版本发布？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="reshiledversion()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>
                <br>
                <div id="versioncontent"></div>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="comparison">
                <div class="alert"
                     style="background-color:rgb(249, 249, 249);color:#3289ff;font-weight:bold;"
                     role="alert">
                    对比任务
                    <div class="btn-group">
                        <button type="button"
                                class="btn btn-default dropdown-toggle btn-xs"
                                data-toggle="dropdown">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" data-toggle="modal" data-target="#comp1">清空</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#comp2">屏蔽</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#comp3">取消屏蔽</a></li>

                        </ul>
                    </div>
                </div>

                <div class="modal fade" id="comp1" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">即将清空该类型下的所有消息，是否继续？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="deletecmp()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="comp2" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否屏蔽对比任务？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="shiledcmp()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="comp3" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否解除屏蔽对比任务？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="reshiledcmp()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>
                <br>
                <div id="compcontent"></div>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="system">
                <div class="alert"
                     style="background-color:rgb(249, 249, 249);color:#3289ff;font-weight:bold;"
                     role="alert">
                    系统接入/下线
                    <div class="btn-group">
                        <button type="button"
                                class="btn btn-default dropdown-toggle btn-xs"
                                data-toggle="dropdown">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" data-toggle="modal" data-target="#sys1">清空</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#sys2">屏蔽</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#sys3">取消屏蔽</a></li>

                        </ul>
                    </div>

                </div>
                <div class="modal fade" id="sys1" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">即将清空该类型下的所有消息，是否继续？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="deletesys()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="sys2" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否屏蔽系统接入/下线？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="shiledsys()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="sys3" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否解除屏蔽系统接入/下线？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="reshiledsys()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>


                <br>
                <div id="syscontent"></div>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="announcement">
                <div class="alert"
                     style="background-color:rgb(249, 249, 249);color:#3289ff;font-weight:bold;"
                     role="alert">
                    系统通知
                    <div class="btn-group">
                        <button type="button"
                                class="btn btn-default dropdown-toggle btn-xs"
                                data-toggle="dropdown">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" data-toggle="modal" data-target="#annnou1">清空</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#annnou2">屏蔽</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#annnou3">取消屏蔽</a></li>

                        </ul>
                    </div>

                </div>


                <div class="modal fade" id="annnou1" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">即将清空该类型下的所有消息，是否继续？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="deleteannounce()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="annnou2" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否屏蔽系统通知？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="shiledannounce()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>

                <div class="modal fade" id="annnou3" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">提示</h4>
                            </div>
                            <div class="modal-body">是否解除屏蔽系统通知？</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-primary"
                                        onclick="reshiledannounce()">确定
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal -->
                </div>
                <br>
                <div id="announcecontent"></div>
            </div>
        </div>
    </div>


</div>
</body>
<script type="text/javascript">
    //修改单条消息del标志
    var result1;
    var result2;
    var result3;
    var result4;
    var result5;
    function deleteflag(t) {
        //alert(t.parentNode.id);
        //var msgId=$("#dlt").parent().attr("id");
        var msgId = t.parentNode.id;
        var url = "<%=request.getContextPath()%>/message.do?invoke=deleteMsg";
        var jsonObject = {
            "msgId": msgId
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });

    }
    //清空change
    function deletechange() {
        $("#changcontent").empty();
        $.each(result1, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=deleteMsg";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });

    }
    //清空version
    function deleteversion() {
        $("#versioncontent").empty();
        $.each(result2, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=deleteMsg";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });

    }
    //清空cmp
    function deletecmp() {
        $("#compcontent").empty();
        $.each(result3, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=deleteMsg";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });
    }
    //清空sys
    function deletesys() {
        $("#syscontent").empty();
        $.each(result4, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=deleteMsg";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });

    }
    //清空announce
    function deleteannounce() {
        $("#announcecontent").empty();
        $.each(result5, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=deleteMsg";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });

    }
    //readchange
    function readchange() {
        $("#111").empty();
        $("#111").append("无未读消息");
        $.each(result1, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=isRead";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });
    }
    //readversion
    function readversion() {
        $("#222").empty();
        $("#222").append("无未读消息");
        $.each(result2, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=isRead";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });
    }
    //read comp
    function readcmp() {
        $("#333").empty();
        $("#333").append("无未读消息");
        $.each(result3, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=isRead";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });

    }
    //read sys
    function readsys() {
        $("#444").empty();
        $("#444").append("无未读消息");
        $.each(result4, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=isRead";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });

    }
    //read annouce
    function readannouce() {
        $("#555").empty();
        $("#555").append("无未读消息");
        $.each(result5, function (index, value) {
            var msgId = value.MSG_ID;
            var url = "<%=request.getContextPath()%>/message.do?invoke=isRead";
            var jsonObject = {
                "msgId": msgId
            };
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'post',
                async: true,
                data: jsonObject,
                success: function (data) {
                }
            });

        });

    }
    //解除屏蔽01
    function reshiledchange() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=reshield";
        var jsonObject = {
            "msgType": "01"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //解除屏蔽02
    function reshiledversion() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=reshield";
        var jsonObject = {
            "msgType": "02"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //解除屏蔽03
    function reshiledcmp() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=reshield";
        var jsonObject = {
            "msgType": "03"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //解除屏蔽04
    function reshiledsys() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=reshield";
        var jsonObject = {
            "msgType": "04"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //解除屏蔽05
    function reshiledannounce() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=reshield";
        var jsonObject = {
            "msgType": "05"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }

    //屏蔽01
    function shiledchange() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=shield";
        var jsonObject = {
            "msgType": "01"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //屏蔽02
    function shiledversion() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=shield";
        var jsonObject = {
            "msgType": "02"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //屏蔽03
    function shiledcmp() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=shield";
        var jsonObject = {
            "msgType": "03"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //屏蔽04
    function shiledsys() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=shield";
        var jsonObject = {
            "msgType": "04"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }
    //屏蔽05
    function shiledannounce() {
        var url = "<%=request.getContextPath()%>/message.do?invoke=shield";
        var jsonObject = {
            "msgType": "05"
        };
        $.ajax({
            url: url,
            dataType: 'json',
            type: 'post',
            async: true,
            data: jsonObject,
            success: function (data) {
            }
        });
    }


    var url = "<%=request.getContextPath()%>/message.do?invoke=queryMsgInfo";
    var jsonObject = {
        "start": 0,
        "limit":50
    };
    $.ajax({
        url: url,
        dataType: 'json',
        type: 'post',
        async: true,
        data: jsonObject,
        success: function (data) {
            //$("#changcontent").empty();
            result1 = data.changcontent;
            $.each(result1, function (index, value) {
                var time = value.CREATED_TIME;
                var content = value.MSG_CONTENT;
                var id = value.MSG_ID;
                var name = value.MSG_NAME;
                //alert(id);
                $("#changcontent").append("<div class=\"alert alert-deletable\"  role=\"alert\" id=\"" + id + "\"" + ">"
                +"<p><span>"+time+"</span></p>"+"<div class=\"panel panel-info\">"+" <div class=\"panel-heading\">"
                 + "<button id=\"dlt1\" type=\"button\" class=\"close\" data-dismiss=\"alert\" onclick=\"deleteflag(this)\">"+"<span aria-hidden=\"true\" >" + "&times;" + "</span><span class=\"sr-only\">Close</span></button>"
               + name +"</div>"+"<div class=\"panel-body\">"+content+ "</div>"+ "</div>"+ "</div>");
              
            });
            $("#versioncontent").empty();
            result2 = data.versioncontent;
            $.each(result2, function (index, value) {
                var time = value.CREATED_TIME;
                var content = value.MSG_CONTENT;
                var id = value.MSG_ID;
                var name = value.MSG_NAME;
                $("#versioncontent").append("<div class=\"alert alert-deletable\"  role=\"alert\" id=\"" + id + "\"" + ">"
                +"<p><span>"+time+"</span></p>"+"<div class=\"panel panel-info\">"+" <div class=\"panel-heading\">"
                 + "<button id=\"dlt1\" type=\"button\" class=\"close\" data-dismiss=\"alert\" onclick=\"deleteflag(this)\">"+"<span aria-hidden=\"true\" >" + "&times;" + "</span><span class=\"sr-only\">Close</span></button>"
               + name +"</div>"+"<div class=\"panel-body\">"+content+ "</div>"+ "</div>"+ "</div>");
              
            });
            $("#compcontent").empty();
            result3 = data.compcontent;
            $.each(result3, function (index, value) {
                var time = value.CREATED_TIME;
                var content = value.MSG_CONTENT;
                var id = value.MSG_ID;
                var name = value.MSG_NAME;
                $("#compcontent").append("<div class=\"alert alert-deletable\"  role=\"alert\" id=\"" + id + "\"" + ">"
                +"<p><span>"+time+"</span></p>"+"<div class=\"panel panel-info\">"+" <div class=\"panel-heading\">"
                 + "<button id=\"dlt1\" type=\"button\" class=\"close\" data-dismiss=\"alert\" onclick=\"deleteflag(this)\">"+"<span aria-hidden=\"true\" >" + "&times;" + "</span><span class=\"sr-only\">Close</span></button>"
               + name +"</div>"+"<div class=\"panel-body\">"+content+ "</div>"+ "</div>"+ "</div>");

            });

            $("#syscontent").empty();
            result4 = data.syscontent;
            $.each(result4, function (index, value) {
                var time = value.CREATED_TIME;
                var time = value.CREATED_TIME;
                var content = value.MSG_CONTENT;
                var id = value.MSG_ID;
                var name = value.MSG_NAME;
                $("#syscontent").append("<div class=\"alert alert-deletable\"  role=\"alert\" id=\"" + id + "\"" + ">"
                +"<p><span>"+time+"</span></p>"+"<div class=\"panel panel-info\">"+" <div class=\"panel-heading\">"
                 + "<button id=\"dlt1\" type=\"button\" class=\"close\" data-dismiss=\"alert\" onclick=\"deleteflag(this)\">"+"<span aria-hidden=\"true\" >" + "&times;" + "</span><span class=\"sr-only\">Close</span></button>"
               + name +"</div>"+"<div class=\"panel-body\">"+content+ "</div>"+ "</div>"+ "</div>");
            });
            $("#announcecontent").empty();
            result5 = data.announcecontent;
            $.each(result5, function (index, value) {
                var time = value.CREATED_TIME;
                var content = value.MSG_CONTENT;
                var id = value.MSG_ID;
                var name = value.MSG_NAME;
                $("#announcecontent").append("<div class=\"alert alert-deletable\"  role=\"alert\" id=\"" + id + "\"" + ">"
                +"<p><span>"+time+"</span></p>"+"<div class=\"panel panel-info\">"+" <div class=\"panel-heading\">"
                 + "<button id=\"dlt1\" type=\"button\" class=\"close\" data-dismiss=\"alert\" onclick=\"deleteflag(this)\">"+"<span aria-hidden=\"true\" >" + "&times;" + "</span><span class=\"sr-only\">Close</span></button>"
               + name +"</div>"+"<div class=\"panel-body\">"+content+ "</div>"+ "</div>"+ "</div>");

            });
        }
    });


    var url = "<%=request.getContextPath()%>/message.do?invoke=queryMsgNum";
    $.ajax({
        url: url,
        dataType: 'json',
        type: 'post',
        async: true,
        success: function (data) {
            var num1 = data.changcontentNum;
            $("#home_tab").append(
                    "<br>" + "<p class='msg-p' id=\"111\" color=\"grey\">" + num1
                    + "条未读消息</p>");
            var num2 = data.versioncontentNum;
            $("#v_tab").append(
                    "<br>" + "<p class='msg-p' id=\"222\" color=\"grey\">" + num2
                    + "条未读消息</p>");
            var num3 = data.compcontentNum;
            $("#c_tab").append(
                    "<br>" + "<p class='msg-p' id=\"333\" color=\"grey\">" + num3
                    + "条未读消息</p>");
            var num4 = data.syscontentNum;
            $("#s_tab").append(
                    "<br>" + "<p class='msg-p' id=\"444\" color=\"grey\">" + num4
                    + "条未读消息</p>");
            var num5 = data.announcecontentNum;
            $("#a_tab").append(
                    "<br>" + "<p class='msg-p' id=\"555\" color=\"grey\">" + num5
                    + "条未读消息</p>");
        }
    });
</script>

</html>
