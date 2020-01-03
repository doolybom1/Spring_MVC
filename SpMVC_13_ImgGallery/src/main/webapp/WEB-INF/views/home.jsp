<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 갤러리</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="${rootPath}/javascript/summernote-ko-KR.js" type="text/javascript">

</script>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	width: 100%;
}

header {
	background-color: #41D3BD;
	margin: 0;
	padding: 1rem;
	color: white;
}

#img_box {
	border: 1px solid green;
	display: flex;
	flex-wrap: wrap;
}

.img_panel {
	padding: 0.01rem 16px;
	margin-top: 16px;
	margin-bottom: 16px;
}

.img_card {
	width: 200px;
	height: 200px;
	margin: 10px;
	box-shadow: 0 4px 10px 0 rgba(0, 0, 0, 0.16), 0 4px 20px 0
		rgba(0, 0, 0, 0.19)
}

.bz-button{
	border: none;
	display: inline-block;
	padding: 8px 16px;
	vertical-align: middle;
	text-decoration: none;
	color: inherit;
	background-color: #ddd;
	text-align: center;
	cursor: pointer;
	white-space: nowrap;
	margin:5px;
}

.bz-button:hover{
	box-shadow: 0 8px 16px rgba(0,0,0,0.2),
				0 6px 20px 0 rgba(0,0,0,0.2);
}

div.input_box{
	width:90%;
	margin:5px auto;
}

input[type="text"]{
	padding: 8px;
	display: block;
	border: none;
	border: 1px solid #ccc;
	border-radius:5px;
	width: 100%;
	margin: 8px auto;
}

#d_d_box{
	width: 100%;
	height: 300px;
	color: #aaa;
	border: 1px solid green;
	display: flex;
	justify-content: center;
	align-items: center;
}

</style>
<script>
$(function() {
	var toolbar = [
		['style',['bold','italic','underline']],
		['fontsize',['fontsize']],
		['font Style',['fontname']],
		['color',['color']],
		['para',['ul','ol','paragraph']],
		['height',['height']],
		['table',['table']],
		['insert',['link','hr','picture']],
		['view', ['fullscrenn', 'codeview']]
	]
	
	 $('#img_text').summernote({
			lang:'ko-KR',
			placeholder:'본문을 입력하세요',
			width: '100%',
			toolbar:toolbar,
			height:'200px'
			
	})
	
	$("#btn_img_up").click(function() {
		document.location.href = "${rootPath}/image/upload"
	})
	
	$("#d_d_box").on('dragover', function(e) {
		$("#d_d_box h3").text("파일을 내려 놓으세요!!!")
		return false
	})

	
	/*
		file 1개를 drag and drop 으로 업로드 수행하기
	*/
	$("#d_d_box").on('drop', function(e) {
		$("#d_d_box h3").text("파일 업로드 중!!!")
		
		return false
	})
})
</script>

</head>
<body>
	<header>
		<h3>이미지 갤러리</h3>
	</header>
	<section>
		<c:if test="${BODY == 'UPLOAD'}">
			<%@ include file="/WEB-INF/views/body/img_upload.jsp" %>
		</c:if>
	
	
	</section>


	<section id="img_box">
		<c:forEach begin="1" end="10">
			<%@ include file="/WEB-INF/views/include/img_card.jsp"%>
		</c:forEach>
	</section>
	<section>
		<button id="btn_img_up" class="bz-button">이미지 올리기</button>
	</section>
</body>
</html>