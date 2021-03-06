<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		.form-control, .custom-select{
		margin: 10px;
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

	<!-- 	抓時間用的API -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.js"></script>
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
				<div class="col-sm-10">
					<div class='card card-success'>
						<div class="card-header">
							<h3 class="card-title">修改課程資訊</h3>
						</div>
						<div class="card-body">
					<!-- 標頭 -->
					<!-- 標頭 End -->
					<!-- 					新增商品表格 -->
					<form method="post" action="${pageContext.request.contextPath}/course/courseUpdateFinal"
						enctype="multipart/form-data">
						<table>
							<tr>
								<td colspan="2" style="width: 150px;">課程名稱
								<td colspan="2"><input type="text" class="form-control" name="courseName" value='${courseBean.courseName}'>
							<tr>	
								<td colspan="2">課程類別
								<td colspan="2">
									<select class="custom-select" style="height: 35px; width: 200px;"
										name="courseCategory">
										<option value="${courseBean.courseCategory}">${courseBean.courseCategory}
										</option>
										<option value='親子同樂'>親子同樂</option>
										<option value='質感生活'>質感生活</option>
										<option value='世界味蕾'>世界味蕾</option>
										<option value='聰明料理'>聰明料理</option>
									</select>
							</tr>
							</tr>
<!-- 							<tr> -->
<!-- 								<td colspan="2">上課教室 -->
<!-- 								<td colspan="2"> -->
<!-- 									<select class="custom-select" style="height: 35px; width: 200px;"  -->
<!-- 									name="roomNo" id="roomNo" onchange="roomJson123()" > -->
<%-- 										<option value="${courseBean.roomNo}">${courseBean.roomNo}</option> --%>
<!-- 										<option value='201'>201</option> -->
<!-- 										<option value='202'>202</option> -->
<!-- 										<option value='203'>203</option> -->
<!-- 										<option value='204'>204</option> -->
<!-- 										<option value='205'>205</option> -->
<!-- 									</select> -->
<!-- 							</tr> -->
							<tr>
								<div class="form-group col-md-4">
									<label class="btn btn-info">
										<input name="courseImage" onchange="readURL(this)" style="display: none;"
											id="courseImage" type="file" accept="image/jpg" /> <i class="fa fa-photo"></i> 上傳封面圖片
									</label>
									<div id="upload_img">
										<img src="<c:url value='/getPic/${courseBean.courseId}' />" alt=" "
											class="img-responsive" style="width:70%;"/>
									</div>
								</div>
							</tr>
							
							<tr>
								<td colspan="2">課程價格
								<td colspan="2"><p style="margin: 6px 0px 0 12px;"> ${courseBean.coursePrice}</p>
							</tr>
							</tr>
								<td colspan="2">課程優惠
								<td colspan="2">
									<select class="custom-select" style="height: 35px; width: 200px;"
										name="courseDiscount">
										<option value="1">無折扣</option>
										<option value='0.95'>95折</option>
										<option value='0.9'>9折</option>
										<option value='0.85'>85折</option>
										<option value='0.8'>8折</option>
										<option value='0.75'>75折</option>
										<option value='0.7'>7折</option>
									</select>

							</tr>
							<tr>
								<!-- 								拿掉課程負責人 -->
								<td colspan="2">主辦單位名稱
								<td colspan="2"><input type="text" class="form-control" name="hostName" value='${courseBean.hostName}'>

							</tr>
<!-- 上課時間先屏掉 -->
<!-- 							<tr> -->
<!-- 								<td colspan="2">上課時間 -->
<!-- 								<td colspan="2"><input type="date" name="courseStartDate" -->
<%-- 										value='${courseBean.courseStartDate}'> --%>
<!-- 								<td colspan="2"><input type="date" name="courseEndDate" -->
<%-- 										value='${courseBean.courseEndDate}'> --%>
<!-- 							</tr> -->
							<tr>
								<td colspan="2">課程描述
								<td colspan="6"><textarea name="courseIntrod"  class="form-control"
													style="width: 500px; height: 180px;" value='${courseBean.courseIntrod}'>${courseBean.courseIntrod}</textarea>
							</tr>


							<tr>
								<td><input type="hidden" name="roomNo" value='${courseBean.roomNo}'>
								<td><input type="hidden" name="coursePrice" value='${courseBean.coursePrice}'>
								<td><input type="hidden" name="courseTime" value='${courseBean.courseTime}'>
								<td><input type="hidden" name="courseHour" value='${courseBean.courseHour}'>
								<td><input type="hidden" name="courseStartDate" value='${courseBean.courseStartDate}'>
								<td><input type="hidden" name="id" value="${courseBean.courseId}">
								<td><input class="btn btn-secondary" type="submit" value="送出">
								<td><input class="btn btn-secondary" type="reset" value="重置">
							</tr>

						</table>
					</form>
					<div id="calendar"></div>

					</div>
					</div>
				</div>
				<!-- Begin Page Content --End -->
			</div>
			<!-- Main Content --End-->
		</div>
		<!-- Content Wrapper --End-->
	</div>
	<!-- Page Wrapper --End-->

	<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				var html = "";
				html += "<img width='320px' height='200px' src='"+e.target.result+"'>";
				$("#upload_img").html(html);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	</script>
<!-- 	自己寫的JS -->
	<script src="${pageContext.request.contextPath}/js/courseJs.js"></script>
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