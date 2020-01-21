<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
$(function() {
	$("#btn-list").click(function() {
		document.location.href = "${rootPath}/ems/list"
	})

	$("#btn-update").click(function() {
		document.location.href = "${rootPath}/ems/update/${ems_seq}"
	})
	
	$("#btn-delete").click(function() {
		document.location.href = "${rootPath}/ems/delete/${ems_seq}"
	})
	
	
})

</script>
<style>
	.input-box {
		display: flex;
		width: 80%;
		margin: 5px auto;
	}
	
	.input-box input {
		color:black;
		border: none;
		border-bottom: 1px solid rgb(52,152,219);
		display:block;
		width: 100%;
		padding: 8px;
	}
	
	#rb_bcode {
		width:50%;
		margin-right: 5px;
	}
	
	article {
		display: flex;
		flex-flow: wrap;
	}
	
	div{
		display: inline-block;
		width: 70%;
		padding: 5px 16px;
		margin: 5px;
		background-color: #eee;
	}
	
	div.title-box{
		width: 25%;
		background-color: #ccc;
		text-align: right;
	}
	
	span.star-box{
		width: 100px;
		
	}
	
	span.star-box, span.star-red{
		display: inline-block;
		height: 20px;
		overflow: hidden;
		
		background : url("${rootPath}/image/star.png") no-repeat;
		background-size: 100px 40px;
	}
	
	span.star-red{
		background-position: left bottom;
		line-height: 0;
		vertical-align: top;
		width: 50%;
	}
	
	div.text-box{
		width: 100%;
		
	}
	
	#btn-update:hover, #btn-delete:hover, #btn-list:hover{
		cursor: pointer;
	}
	
	button{
		margin: 5px 10px;
	}
</style>
</head>
<body>
<section>
	<article>
		<div class="title-box">
			받는email
		</div>
		<div>
			${emailVO.fromEmail}
		</div>
		<div class="title-box">
			받는사람
		</div>
		<div>
			${emailVO.fromName} 
		</div>
		<div class="title-box">
			제목
		</div>
		<div>
			${emailVO.subject} 
		</div>
		<div class="title-box">
			작성일자
		</div>
		<div>
			${emailVO.sendDate} 
		</div>
		<div class="title-box">
			작성시각
		</div>
		<div>
			${emailVO.sendTime} 
		</div>
	
	</article>
	
	<article>
		<button id="btn-update" type="button" class="flex-right biz-blue">수정</button>
		<button id="btn-delete" type="button" class="biz-red">삭제</button>
		<button id="btn-list" type="button" class="biz-orange">리스트보기</button>
	</article>
</section>

</body>
</html>