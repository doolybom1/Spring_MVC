<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="rootPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 홈페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
	*{
		margin: 0;
		paddin:0;
	}
	.list{
		border-collapse: collapse;
		margin: auto;
		overflow : auto;
	}
	
	.content-body td{
		padding: 5px;
	}
	.content-body:hover{
		cursor: pointer;
	}

	header h2{
		text-align: center;
		margin :2rem;
	}
	.list-box th{
		background-color: #ccc;
	} 

	#book_insert{
		display:block;
		margin: 10px auto;
		text-align: center;
	}
	#book_insert button:hover{
		cursor: pointer;
	}
	section{
		margin: 5px 25.6%;
	}
	#search{
		padding: 0.5rem;
		width: 450px;
	}

</style>	
<script>
$(function() {
	$(".content-body").click(function(){
		let id = $(this).attr("data-id")

		document.location.href = "${rootPath}/book/view?id=" + id
	})
})

</script>
</head>
<body>	
<header>
	<h2>도서 정보</h2>
</header>
		<!-- 
		<section>
			<input id="search" type="text" placeholder="검색어를 입력하시오">
		</section>
		 -->
		<table class="list" border="1">
			<tr class="list-box">
				<th>도서코드</th>
				<th>도서명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>구입일자</th>
				<th>구입가격</th>
			</tr>
			<c:choose>
			<c:when test="${empty BOOK_LIST}">
				<tr><td colspan="6"></td>
			</c:when>
			<c:otherwise>
					<c:forEach items="${BOOK_LIST}" var="book" varStatus="index">
								<tr class="content-body" data-id="${book.b_code}" data-auth="${book.b_auther}" >
									<td>${book.b_code}</td>
									<td>${book.b_name}</td>
									<td>${book.b_auther}</td>
									<td>${book.b_comp}</td>
									<td>${book.b_year}</td>
									<td>${book.b_iprice}</td>
								</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div id="book_insert">
			<a href="${rootPath}/book/insert"><button>도서등록</button></a>
		</div>
</body>
</html>