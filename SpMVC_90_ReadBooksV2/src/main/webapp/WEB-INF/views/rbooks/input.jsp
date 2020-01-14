<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 홈페이지</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
	href="${rootPath}/css/rbook-main.css?ver=2020-01-14-001">
<link rel="stylesheet"
	href="${rootPath}/css/main-table.css?ver=2020-01-14-001">
<link rel="stylesheet"
	href="${rootPath}/css/color.css?ver=2020-01-14-001">
<script>
$(function() {
	
	// $("#btn-write").click(function() {})
	$("#btn-write").click( ()=>{
		document.location.href = "${rootPath}/book/write"
	})
})
</script>
</head>
<body>
	<header>
		<h2>MY READ BOOK</h2>
	</header>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

	<section id="main-writer">
		<article>
			<form:form modelAttribute="rBookVO">
				<input type="text" name="rb_bcode" id="rb_bcode" placeholder="도서 코드" />
				<input type="text" name="rb_date" id="rb_date" placeholder="독서일자" />
				<input type="text" name="rb_stime" id="rb_stime" placeholder="독서시간" />
				<input type="text" name="rb_subject" id="rb_subject" placeholder="한줄평" />
				<input type="text" name="rb_star" id="rb_star" placeholder="별점" />

			<div id="main-button">
				<button id="btn-write" class="biz-blue flex-right">독서록 작성</button>
			</div>
			</form:form>
		</article>
	</section>
</body>
</html>