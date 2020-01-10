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
		border:1px solid black;
		margin: auto;
		overflow : auto;
	}
	
	.content-body td{
		padding: 5px;
	}
	.content-body:hover{
		cursor: pointer;
		border:4px solid tomato;
	}

	header h2{
		text-align: center;
		margin :2rem;
	}
	.list-box th{
		background-color: #ccc;
	} 

	#read_insert{
		display:block;
		margin: 10px auto;
		text-align: center;
	}
	
	#read_insert button{
		padding: 10px;
		background-color: tomato;
		color:white;
		border-style: none;
		font-weight: bold;
	}
	#read_insert button:hover{
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
	
	// 리스트 목록을 클릭시 상세페이지로 이동
	$(".content-body").click(function(){
		let id = $(this).attr("data-id")

		document.location.href = "${rootPath}/read/view?id=" + id
	})
})
</script>
</head>
<body>	
<header>
	<h2>독서록 리스트</h2>
</header>
		<table class="list" >
			<tr class="list-box">
			
				<th>SEQ</th>
				<th>도서코드</th>
				<th>도서명</th>
				<th>독서일자</th>
				<th>한줄소감</th>
				<th>별점</th>
			</tr>
			<c:choose>
			<c:when test="${empty READ_LIST}">
				<tr><td colspan="6"></td>
			</c:when>
			<c:otherwise>
					<c:forEach var="read"  items="${READ_LIST}" varStatus="status">
								<tr class="content-body" >
									<td>${read.rb_seq }</td>
									<td>${read.rb_bcode}</td>
									<td>${read.b_code}</td>
									<td>${read.rb_date}</td>
									<td>${read.rb_subject}</td>
									<td>${read.rb_star}</td>
								</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
</body>
</html>