<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<title>□□□ 도서정보 입력 □□□</title>
<style>
 fieldset {
 	width:70%;
 	margin:20px auto;
 	border:1px solid green;
 	border-radius: 10px;
 }
 
 legend {
 	font-weight: bold;
 	font-size:20px;
 }
 
 input {
 	display: inline-block;
 	width:90%;
 	padding:8px;
 	margin:5px;
 }
 
 input:focus{
 	border:2px solid blue;
 	outline: none;
 }
 .book-form{
 	text-align: center;
 }
 
 button:hover{
 	cursor: pointer;
 }

</style>

<script>
$(function() {
	$("#btn-store").click(function() {
		let b_code = $("#b_code").val()
		if(b_code == ""){
			alert("도서 코드는 반드시 입력하세요");
			return false;
		}
		
		let b_name = $("#b_name").val()
		if(b_name == ""){
			alert("도서명은 반드시 입력하세요");
			return false;
		}
		
		let b_comp = $("#b_comp").val()
		if(b_comp == ""){
			alert("출판사는 반드시 입력하세요");
			return false;
		}
	})
})
</script>
</head>
<body>
<%
  // form:form post로 controller로 넘김
%>
<fieldset>
	<legend> 도서 정보 입력</legend>
	<form:form modelAttribute="bookDTO"  autocomplete="on"  class="book-form">
			
		<form:input path="b_code" id="b_code"
				class="in-box" placeholder="도서코드"  /><br/>
		<form:input path="b_name" id="b_name"
				class="in-box" placeholder="도서명"  /><br/>
		<form:input path="b_comp" id="b_comp"
				class="in-box" placeholder="출판사"  /><br/>
		<form:input path="b_auther" id="b_auther"
				class="in-box" placeholder="저자"  /><br/>
		<form:input path="b_year" id="b_year" value="${serverTime}"
				class="in-box" placeholder="구입일자"  /><br/>
		<form:input path="b_iprice" id="b_iprices"
				class="in-box" placeholder="구입가격"  /><br/>

		<button id="btn-store">저장</button>
		<button type="reset">초기화</button>
	
	</form:form>
		
</fieldset>

</body>
</html>