<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<c:set var="rootPath" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>□□□ 나의 JSP 페이지 □□□</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<style>
	table{
		width:70%;
		margin:20px auto;
		border-top: 2px solid #252525;
		border-bottom: 1px solid #ccc;
	}
	
	table th {
		text-align : center;
		background-color : #f7f7f7;
		color : #3b3b3b;
	}
	
	table th, table td {
		padding:15px 0 16px 16px;
		border-bottom: 1px solid #ccc;
	}
	
	caption {
		font-size: 25px;
		padding:10px;
		font-weight: bold;
		color: tomato;
	}
	
	div.btn-box {
		width:70%;
		margin:5px auto;
		
		display: flex;
		justify-content: center;
		align-items: center;
	}
	a.btn {
		border-radius: 3px;
		padding:10px;
		color: white;
		display: inline-block;
		background-color: tomato;
		border : 1px solid #56819d;
		vertical-align: middle;
		text-decoration: none;
		margin:10px;
		border-style: none;
		font-weight: bold;
	}
	
	a.btn:hover {
		/* border:1px solid blue; */
		box-shadow: 5px 5px 8px rgba(80,80,80,0.8)
	}
	
	td.m-text {
		white-space: pre-wrap;
	}
</style>
<script>
$(function(){
	
	// 새 페이지를 만들고 페이지 위에 겹치기
	$("#btn-update").on("click",function(){
		document.location.href 
			= "${rootPath}/book/update?id=${bookDTO.b_code}" 
		
	})
	
	// 	현재 페이지를 지우고, 새로운 페이지로 보여주기
	$("#btn-delete").click(function(){
		if(confirm("도서 정보를 삭제합니다!!!")) {
			let query = "${rootPath}/book/delete?id=${bookDTO.b_code}"
			document.location.replace(query)
		}
	})

	$("#btn-read").click(function(){
		document.location.href 
		= "${rootPath}/read/insert?id=${bookDTO.b_code}" 
		
	})
})
</script>

<body>

<table>
	<caption>도서 세부정보</caption>

	<tr>
	<th>BCODE</th><td>${bookDTO.b_code}</td>
	<th>도서명</th><td>${bookDTO.b_name}</td>
	</tr>

	<tr>
	<th>저자</th><td>${bookDTO.b_auther}</td>
	<th>출판사</th><td>${bookDTO.b_comp}</td>
	</tr>

	<tr>
	<th>구입일자</th><td colspan="3">${bookDTO.b_year}</td>
	</tr>
	
	<tr>
	<th>구입가격</th><td colspan="3" class="m-text">${bookDTO.b_iprice}</td>
	</tr>

</table>

<div class="btn-box">
	<a href="javascript:void(0)" 
			class="btn" id="btn-update">수정</a>
	<a href="javascript:void(0)" 
			class="btn" id="btn-delete">삭제</a>
	<a href="javascript:void(0)"
			class="btn" id="btn-read">독서록 작성</a>
</div>


</body>
</html>