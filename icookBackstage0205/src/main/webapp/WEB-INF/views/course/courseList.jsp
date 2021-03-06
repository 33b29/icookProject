<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">

	<style>
		/* ul.pagination { */
		/*     margin: 2px 0; */
		/*     white-space: nowrap; */
		/*     justify-content: flex-end; */
		/* } */
		/* .pagination { */
		/*     display: flex; */
		/*     padding-left: 0; */
		/*     list-style: none; */
		/*     border-radius: .35rem; */
		/* } */
		textarea {
			width: 300px;
			height: 100px;
		}

		.testImgx {
			max-width: 150px;
			max-height: 150px;
		}
	</style>

	<title>Demo_MyProduct</title>

	<!-- Custom fonts for this template-->
	<link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
		type="text/css">
	<link
		href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
		rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

	<!-- dataTables的CSS -->
	<!-- <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet"> -->

	<!-- 測試 -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script>
		$(function () {
			$("#tabs").tabs();
		});
	</script>

</head>

<body>
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- 側欄 -->
		<jsp:include page="/WEB-INF/views/fragment/SideBar.jsp" />
		<!-- 側欄 End -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<!-- Topbar -->
				<jsp:include page="/WEB-INF/views/fragment/TopBar.jsp" />
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
				<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">課程查詢</h1>
				</div>
				<div class="ui-tabs ui-corner-all ui-widget ui-widget-content">
				<div class='ui-tabs-panel ui-corner-bottom ui-widget-content'>	
					
<!-- 					搜尋列 -->
					<div id="tabs-1">
						<form method="POST">
							<div style="margin-left: 500px;"
								class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
								<div class="input-group">
										<input type="text" class="form-control bg-light border-0 small searchInput"
											placeholder="請輸入課程名稱" aria-label="Search" name="courseName"
											aria-describedby="basic-addon2" id='searchIn1'>
										<div class="input-group-append">
											<button class="btn btn-primary search" type="submit">
												<i class="fas fa-search fa-sm"></i>
											</button>
									</div>
								</div>
							</div>
						</form>
<!-- 						搜尋列 -->
					<!-- 課程列表 -->
					<div class="bs-docs-example div-height" align='center'>
						<table id='table1' class="table table-hover">
							<thead>
								<tr>
									<th>課程名稱</th>
									<th>剩餘數量</th>
									<th>課程價格</th>
									<th>上課時間</th>
									<th>更新時間</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody id='main'>
								<%-- 					 未加入分頁功能begin="${pageNo}" end="${endPage-1} --%>
								<c:forEach varStatus="i" var="bean" items="${courses}">
									<tr>
										<td>${bean.courseName}
										<td>${courseStock.get(bean.courseId)}
											<%-- 									<td>${bean.courseStartDate} --%>
											<%-- 									<td>${bean.courseEndDate} --%>
										<td><fmt:formatNumber value="${bean.coursePrice}" pattern="#,###" />
										<td>${bean.courseStartDate}
										<td><fmt:formatDate value="${bean.updateTime}" pattern="YYYY-MM-dd" />
										<td><input style='float: right;' class='btn btn-default btn-secondary btn-sm'
												type='button'
												onclick="javascript:location.href='${pageContext.request.contextPath}/course/courseUpdate?id=${bean.courseId}'"
												value='修改課程資訊' />
										<td><input style='float: right;' class='btn btn-default btn-secondary btn-sm'
												type='button'
												onclick="javascript:location.href='${pageContext.request.contextPath}/course/courseDelete?id=${bean.courseId}'"
												value='刪除課程' />

											<%-- 							<input type='hidden' name='${order.orderId}' --%>
											<%-- 								value='${order.orderId}' /> --%>
								</c:forEach>

							</tbody>
						</table>
					</div>
					<!-- 課程列表 --End -->
				</div>
				<!-- Begin Page Content --End -->
			</div>
			</div>
			</div>
			<!-- Main Content --End-->
		</div>
		<!-- Content Wrapper --End-->
	</div>
	<!-- Page Wrapper --End-->

	<!-- Bootstrap core JavaScript-->
	<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
	<script src="${pageContext.request.contextPath}/js/demo/chart-pie-demo.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>

</body>

</html>