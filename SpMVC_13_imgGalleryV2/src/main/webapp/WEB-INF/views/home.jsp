<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 갤러리</title>

<style type="text/css">
* {
	box-sizing: border-box;
	margin: 0px;
	padding: 0px;
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

section {
	width: 90%;
	margin: 10px auto;
}

#img_box {
	border: 1px solid gray;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	margin: 10px auto;
}

.img_panel {
	padding: 0.001rem 16px;
	margin-top: 16px;
	margin-bottom: 16px;
}

.img_card {
	width: 200px;
	height: 200px;
	margin: 10px;
	overflow: hidden;
	display: flex;
	justify-content: center;
	flex-flow: column;
	box-shadow: 0 4px 10px 0 rgba(0, 0, 0, 0.16), 0 4px 20px 0
		rgba(0, 0, 0, 0.19)
}

.img_card .img_title {
	padding: 0.5rem;
	text-align: center;
}

.bz-button {
	border: none;
	display: inline-block;
	padding: 8px 16px;
	margin: 5px;
	vertical-align: middle;
	text-decoration: none;
	color: white;
	background-color: #41D3BD;
	text-align: center;
	cursor: pointer;
	white-space: nowrap;
	outline: none;
	font-weight: bold;
}

a {
	text-decoration: none;
	color: inherit;
}

.bz-button:hover {
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2), 0 6px 20px rgba(0, 0, 0, 0.2)
}

div.input_box {
	width: 90%;
	margin: 5px auto;
}

input[type="text"] {
	padding: 8px;
	display: block;
	border: 1px solid #ccc;
	border-radius: 5px;
	width: 100%;
	margin: 8px auto;
}

#d_d_box {
	width: 100%;
	height: 300px;
	color: #aaa;
	border: 1px solid gray;
	display: flex;
	justify-content: center;
	align-items: center;
}

#img_view {
	display: none;
}

.img_list {
	display: flex;
	flex-wrap: wrap;
}

.img_view img {
	width: 200px;
	margin: 5px;
}
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="${rootPath}/javascript/summernote-ko-KR.js" type="text/javascript"></script>

<!-- Jquery ContextMenu -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.0/jquery.contextMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.0/jquery.ui.position.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.0/jquery.contextMenu.min.css"  rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

<script>
	var rootPath = "${rootPath}"
</script>

<script src="${rootPath}/javascript/image_upload.js"></script>
<script src="${rootPath}/javascript/images_upload.js"></script>

<script type="text/javascript">
	$(function(){
		
		$("#btn_img_up").click(function(){
			
			document.location.href = "${rootPath}/image/upload";
			
		})
		
		$("#d_d_box").on('dragover',function(e){
			
			$("#d_d_box h3").text("파일을 내려 놓으세요")
			return false;
			
		})

		/*
			file 1개를 Drag and Drop으로 업로드 수행하기
		*/
		$("#d_d_box").on('drop',function(e){
			$("#d_d_box h3").text("파일 업로드 중")
			
			// drop한 파일 리스트 추출
			let files = e.originalEvent.dataTransfer.files
			
			
		//	if(files.length > 1 ) {
				let formData = new FormData()
				for(let i = 0; i < files.length ; i ++){
					formData.append('files',files[i])
				}
				
				files_up(formData)
				
				return false
				
			/*	
			} else{
				// 리스트에서 첫번째 파일만 추출
				let file = files[0]
				
				// 추출된 파일정보를 서버에 먼저 업로드
				
				// js FormData 클래스를 사용해서 서버에 파일 업로드 준비
				let formData = new FormData()
				formData.append('file',file)
				
				file_up(formData)
			}			
			return false;
			*/
		})
		
		var toolbar = [
			['style',['bold','italic','underline']],
			['fontsize',['fontsize']],
			['fontstyle',['fontname']],
			['color',['color']],
			['para',['ul','ol','paragraph']],
			['height',['height']],
			['table',['table']],
			['insert',['link','hr']],
			['view',['fullscreen','codeview']]
		]
		
		
		$("#img_text").summernote({
			
			lang:'ko-KR',
			palceholder:'본문을 입력하세요',
			width:'100%',
			toolbar:toolbar,
			height:'200px',
			disableDragAndDrop : true
		})
		
		/*
			jquery 응용
			마우스를 제어 해서 context menu (오른쪽마우스 클릭 메뉴 )
			를 만들어주는 tool
		*/
		
		var contextCallBack = function(key, options){
			
			if(key == 'edit'){
				let img_seq = $(this).attr("data-seq");
				// alert("수정 클릭 ")
				
				document.location.href = "${rootPath}/image/update/"+img_seq
			}
			
			if(key == 'delete') {
				if(confirm("이미지를 삭제할까요?")) {
					let img_seq = $(this).attr("data-seq");
					
					$.ajax({
						url : "${rootPath}/image/delete",
						// data : img_seq
						// data : 'img_seq' = 3 이런 식으로 넘어간다.
						// 앞에 꺼는 컨트롤러에서 받는 변수, 뒤에꺼는 실제 담긴 값
						data : {img_seq : img_seq},
						type : 'POST',
						success : function() {
							if(result < 1)
								alert("삭제도중 문제 발생")
						},
						error : function() {
							alert("서버 통신오류")
						}
					})
					
					document.location.href = "${rootPath}/"
					// document.location.replace("${rootPath}/")
					
					// 이벤트 버블링 금지
					return false;
					// document.location.href = "${rootPath}/image/delete/" + img_seq
				}
			}
			
		}
		
		$.contextMenu({
			
			selector:'.img_card',		// 어떤 범위에서 오른쪽마우스를 클릭했을때 반응하는가?
			items : {					// 오른쪽 마우스를 클릭했을때 나오는 메뉴들
				
				'edit' : {name:"수정",icon:'edit'},
				'delete' : {name:"삭제",icon:'delete'},
				
			},
			callback : contextCallBack
			
		})

		var img_context = function(key,option) {
			let id = $(this).attr("data-id")
			if(key == "delete"){
				if(confirm(id + "이미지를 삭제할까요")){
					$.post("${rootPath}/rest/img_delete",
							{img_id: id},
							function (result) {
								if(result == "OK"){
									//document.location.replace("${rootPath}/")
									document.location.replace(document.location.href)
								}else{
									alert("파일을 삭제할 수 없음")
									// 현재화면을 새로고침하세요
									document.location.replace(document.location.href)
								}
							
							})
							
				}
			}else if(key == "copy"){
				
			}else if(key == "loading"){
				let file = $(this).find("img").attr("src")
				window.open(file,"target=_new")
			}
		}		
		
		$.contextMenu({
			
			selector:'.img_view',		// 어떤 범위에서 오른쪽마우스를 클릭했을때 반응하는가?
			items : {					// 오른쪽 마우스를 클릭했을때 나오는 메뉴들
				
				'loading' : {name:"확대보기",icon:'loading'},
				'copy' : {name:"다운로드",icon:'copy'},
				'delete' : {name:"삭제",icon:'delete'},
				'search' : {name:"검색",icon:'fas fa-search'},
				
			},
			callback : img_context
			
		})
		
	})
</script>

</head>
<body>
	<header>
		<h3>이미지 갤러리</h3>
	</header>
	
		<c:choose>
			<c:when test="${BODY=='UPLOAD'}">
				<section>
					<%@ include file="/WEB-INF/views/body/img_upload.jsp" %>
				</section>
			</c:when>
			<c:otherwise>
				<section id="img_box">
					<c:forEach items="${imgList}" var="img">
						<%@ include file="/WEB-INF/views/include/img_card.jsp"%>
					</c:forEach>
				</section>
			</c:otherwise>
		</c:choose>
	
	<section>
		<button class="bz-button" id="btn_img_up">이미지 올리기</button>
	</section>

</body>
</html>