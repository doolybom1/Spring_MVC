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

<title>□□□ 도서록 정보 □□□</title>
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
 
 button{
 	padding: 10px;
	background-color: tomato;
	color:white;
	border-style: none;
	font-weight: bold;
 }
 button:hover{
 	cursor: pointer;
 }
 

</style>


</head>
<body>
<%
  // form:form post로 controller의 insert post로 넘김
%>
<fieldset>
	<legend> 독서록 입력</legend>
	<form:form modelAttribute="bookReadDTO"  autocomplete="on"  class="book-form">
			
		<form:input type="hidden" path="rb_seq" id="rb_seq"
				class="in-box" placeholder="SEQ" /><br/>
		<form:input path="rb_bcode" id="rb_bcode"
				class="in-box" placeholder="도서코드" value="${BCODE}" /><br/>
		<form:input path="rb_date" id="rb_date"
				class="in-box" placeholder="독서일자" value="${serverDate}" /><br/>
		<form:input path="rb_stime" id="rb_stime" type="time"
				class="in-box" placeholder="독서시작시각" value="${serverTime}" /><br/>
		<form:input path="rb_rtime" id="rb_rtime" type="number" 
				class="in-box" placeholder="독서시간"  /><br/>
		<form:input path="rb_subject" id="rb_subject"
				class="in-box" placeholder="한줄소감"  /><br/>
		<form:input path="rb_text" id="rb_text"
				class="in-box" placeholder="긴줄소감"  /><br/>
		<form:input path="rb_star" id="rb_star" min="1" max="5" type="range"
				class="in-box" placeholder="별점"  /><br/>

		<button id="btn-store">저장</button>
		<button type="reset">초기화</button>
	
	</form:form>
		
</fieldset>

</body>
</html>