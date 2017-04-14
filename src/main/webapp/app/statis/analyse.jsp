<!DOCTYPE html>
<html>
<head>
<%@page pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>ECharts</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/app/base/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/app/base/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/app/base/js/nui/nui.js"></script>

<style>
#analyze .menu ul {
	
}

#analyze .menu ul li {
	display: inline-block;
}

#analyze .menu ul li a {
	padding: 0;
}

#analyze .menu ul li .panel {
	margin-bottom: 0;
}

#analyze .menu ul li .panel .panel-body p {
	color: black;
}

#analyze .menu ul li .panel .panel-body p span {
	font-size: 35px;
}

#analyze .menu ul li .panel .panel-body p small {
	
}

.embed-responsive {
	padding: 0 !important;
	height: 380px;
}
</style>


</head>

<body>
	<div id="analyze">

		<div class="tab-content">
			<div id="red" class="tab-pane fade in active">
				<div class="left">
					<div class="panel panel-default">
						<div class="panel-heading">元数据分布图</div>
						<div class="panel-body">
							<div class="embed-responsive embed-responsive-16by9">
								<iframe class="embed-responsive-item"
									src="<%=request.getContextPath()%>/app/statis/distribution.jsp"></iframe>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">元数据变更趋势图</div>
						<div class="panel-body">
							<div class="embed-responsive embed-responsive-16by9">
								<iframe class="embed-responsive-item"
									src="<%=request.getContextPath()%>/app/statis/changeTrend.jsp"></iframe>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">系统重要性统计图</div>
						<div class="panel-body">
							<div class="embed-responsive embed-responsive-16by9">
								<iframe class="embed-responsive-item"
									src="<%=request.getContextPath()%>/app/statis/sysImportant.jsp"></iframe>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">使用情况统计图</div>
						<div class="panel-body">
							<div class="embed-responsive embed-responsive-16by9">
								<iframe class="embed-responsive-item"
									src="<%=request.getContextPath()%>/app/statis/usingInfo.jsp"></iframe>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">人员活跃度统计图</div>
						<div class="panel-body">
							<div class="embed-responsive embed-responsive-16by9">
								<iframe class="embed-responsive-item"
									src="<%=request.getContextPath()%>/app/statis/sysActive.jsp"></iframe>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>




	</div>


	<script type="text/javascript">
		var w = $(window).width() - 30;
		$(".menu-li a .panel").width(w / 5);
		$(window).resize(function() {
			var w = $(window).width() - 30;
			$(".menu-li a .panel").width(w / 5);
		})
	</script>
</body>