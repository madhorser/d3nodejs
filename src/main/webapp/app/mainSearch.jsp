<%@ page contentType="text/html; charset=UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/css/mainSearch.css">
<style>
.btn-primary{
    color: #fff;
    background-color: #99c4e8;
    border-color: #99c4e8;
}
</style>
</head>

<body>
<div id="search">
    <div class="a1">
			<a href="#" data-toggle="modal" data-target="#myModal">高级检索</a>
		</div>
    <div class="search-text">
        <div class="col-md-4 col-md-offset-5">
            <img src="<%=request.getContextPath()%>/app/base/images/logo.jpg">
        </div>
        <div class="col-md-6 col-md-offset-3">
            <div class="input-group input-group-lg">
                <input type="text" class="form-control" id="firstvalue"  onkeyup="searchenter(event);">
                <span class="input-group-btn">
                    <button id="submit" class="btn btn-default" type="button" style="padding-left: 40px;padding-right: 40px;" onclick="searchTo()">检索</button>
                </span>
            </div>
        </div>
    </div>
    <div class="search-menu" id="testmain">
        <div class="col-md-offset-3">
            <ul class="nav nav-pills" role="tablist">
                <li><button type="button" class="btn btn-primary"
                            onclick="viewSystem()">系统信息</button></li>
                <li><button type="button" class="btn btn-primary"
                            onclick="viewReport()">报表信息</button></li>
                <li><button type="button" class="btn btn-primary"
                            onclick="dataStandard()">数据标准</button></li>
                <li><button type="button" class="btn btn-primary"
                            onclick="branchStaff()">组织机构与人员</button></li>
                <li><button type="button" class="btn btn-primary"
                            onclick="viewDatabase()">数据库</button></li>
                <li><button type="button" class="btn btn-primary"
                            onclick="physicsMm()">物理模型</button></li>
                <li><button type="button" class="btn btn-primary"
                            onclick="moreOthers()">更多>></button></li>
            </ul>
        </div>
    </div>
    </div>
    
    <div class="topdiv">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header" style="background-color:#4682B4 ">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h5 class="modal-title" id="myModalLabel" style="color: #FFFFFF">
					高级查询
				</h5>
			</div>
			
			<div class="modal-body" style="height:260px;">
			<div class="wrap">
					<div class="row">
							<label  class="col-sm-2 control-label">元数据类型</label>
							<div class="col-sm-8">
								<input id="btnEdit1" style="width:100%" class="nui-buttonedit"
									onbuttonclick="onButtonEdit" />
							</div>
						</div>

                   <div class="row">
						
							<label   class="col-sm-2 control-label">元数据代码</label>
							<div class="col-sm-8">
								<input class="nui-textbox" style="width:100%" type="text" id="code" />
								</div>
							
						</div>
						<div class="row">
							<label class="col-sm-2 control-label">元数据名称</label>
							<div class="col-sm-8">
								<input class="nui-textbox" style="width:100%" type="text" id="name" />
							</div>
						</div>



						<div class="row">
							<label class="col-sm-2 control-label">元数据属性</label>
							<div class="col-sm-8">
								<form role="form">
									<div class="form-group">
										<select class="form-control" style="width:100%" id="attrimenu"
											onmouseover="getattri()">
										</select>
									</div>
								</form>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-offset-4 col-sm-4">
								<button type="button" class="btn btn-success"
									onclick="advancedSearchTo()" data-dismiss="modal">高级查询</button>
							</div>
						</div>
						</div>
			</div>
		</div>
	</div>
	</div>
	</div>





</body>
<script type="text/javascript">
	document.getElementById("firstvalue").value = "";
	var typeid="";
    var name1="";
    var code1="";
    var attribute="";
    $("#attrimenu").empty();
    nui.parse();
    var codetext= nui.get("code");
	codetext.setValue("");
    var nametext= nui.get("name");
	nametext.setValue("");
	var attri1=$("#attrimenu option:selected");
	
	function onButtonEdit(e) {
    var btnEdit = this;
       nui.open({
        url:"<%=request.getContextPath()%>/app/search/selectType.jsp",
        showMaxButton: false,
        title: "选择元数据类型",
        width: 350,
        height: 350,
        ondestroy: function (action) {
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.GetData();
                data = nui.clone(data);
                if (data) {
                    btnEdit.setValue(data.id);
                    btnEdit.setText(data.text);
                    //alert(data.id);
                    //alert(btnEdit.value);
                    typeid = btnEdit.value;
                }
                var jsonObject = {
                    "classifierId": typeid
                };
                var url = "<%=request.getContextPath()%>/query.do?invoke=getAttributeList";
                $.ajax({
                    url: url,
                    dataType: 'json',
                    type: 'post',
                    data: jsonObject,
                    async: true,
                    success: function (data) {
                        $("#attrimenu").empty();
                        var resultlist = data.list;
                        $.each(resultlist, function (index, value) {
                            var name1 = value.name;
                            //alert(name1);
                            var temp = " <option>" + name1 + "</option>";
                            $("#attrimenu").append(temp);
                        });
                    }
                });

            }
        }
    });
     
}

	function getattri(){
     var attribute=document.getElementById("attrimenu").getElementsByTagName("option");
	for (i = 0; i < attribute.length; i++) {
     attribute[i].onclick = function() {		
     var options=$("#attrimenu option:selected");
 	    }
	}
   }
   
    function searchenter(event) {
        var textvalue= document.getElementById("firstvalue").value;
        event = event || window.event;
        if (event.keyCode == 13) {
            if (textvalue==""||textvalue==" "||textvalue=="  "||textvalue=="   "||textvalue=="    ") {
                return;
            }           
           var url="search/search.jsp?firstvalue=" + textvalue;
		
		window.location.href = encodeURI(url);
        }
    }
	function searchTo() {
		var getval = document.getElementById("firstvalue").value;
		if(getval==""||getval==" "||getval=="  "||getval=="   "||getval=="    "){
		//alert("请输入检索条件！");
		return;
		}		//url="search.jsp";
		var url="search/search.jsp?firstvalue=" + getval;
		
		window.location.href = encodeURI(url);
	}
	function advancedSearchTo(){
	code1 = codetext.getValue();
	 console.log(code1);
	 name1 = nametext.getValue();
	 console.log(name1);
	 
	 attribute=attri1.text();
	 console.log(attribute);
	 if(typeid==""){
		alert("请选择要查询的元数据类型！");
		codetext.setValue("");
        nametext.setValue("");
		return;
		}
	 var url="search/search.jsp?name=" + name1+"&type="+typeid+"&name="+name1+"&code="+code1+"&attribute="+attribute;
	 window.location.href = encodeURI(url);
	}
</script>

</html>
