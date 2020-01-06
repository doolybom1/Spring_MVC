<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>이미지 갤러리</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 

<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>

<script src="${rootPath}/javascript/summernote-ko-KR.js"></script>

<link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.0/jquery.contextMenu.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.0/jquery.contextMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.0/jquery.ui.position.min.js"></script>

<style>
	* {
		box-sizing: border-box;
		margin:0px;
		padding:0px;
	}
	
	body {
		width:100%;
	}
	
	header {
		background-color: #41D3BD;
		margin:0;
		padding:1rem;
		color:white;	
	}
	
	section {
		width:90%;
		margin:10px auto;
	}
	
	#img_box {
		margin:10px auto;
		border: 1px solid green;
		display: flex;
		flex-wrap: wrap;
	}

	.img_panel {
		padding:0.01rem 16px;
		margin-top:16px;
		margin-bottom:16px;
	}
	
	.img_card {
		width:200px;
		height:200px;
		margin:10px;
		/* 이미지가 card box보다 클때, 이미지 자르기 */
		overflow:hidden;
		
		display:flex;
		justify-content:center;
		flex-flow:column;
		
		box-shadow: 0 4px 10px 0 rgba(0,0,0,0.16),
			0 4px 20px 0 rgba(0,0,0,0.19);
	}
	
	.img_card .img_title {
		padding:0.5rem;
		text-align: center;
	}
	
	.bz_button {
		border:none;
		display: inline-block;
		padding:8px 16px;
		margin:5px;
		vertical-align: middle;
		text-decoration:none;
		color:white;
		background-color: blue;
		text-align: center;
		cursor: pointer;
		white-space: nowrap;
	}
	
	.bz_button:hover {
		box-shadow: 0 8px 16px rgba(0,0,0,0.2)
			0 6px 20px 0 rgba(0,0,0,0.2);
	}
	
	a {
		text-decoration: none;
		color: inherit;
	}
	
	div.input_box {
		width:90%;
		margin:5px auto;
	}
	
	input[type="text"] {
		padding:8px;
		display: block;
		border: 1px solid #ccc;
		border-radius: 5px;
		width:100%;
		margin:8px auto;
	}
	
	#d_d_box {
		width:100%;
		height:300px;
		color: #aaa;
		border:1px solid green;
		display:flex;
		justify-content: center;
		align-items: center;
	}
	
	#img_title {
		margin:10px auto;
	}
	
	#img_view {
		display:none;
	}
</style>
<script>
	var rootPath ="${rootPath}"
</script>
<script src="${rootPath}/javascript/image_upload.js"></script>
<script src="${rootPath}/javascript/images_upload.js"></script>
<script>
	$(function(){
		
		var toolbar = [
			
			['style', ['bold','italic','underline']],
			['fontsize',['fontsize']],
			['font Style',['fontname']],
			['color',['color']],
			['para',['ul','ol','paragraph']],
			['height',['height']],
			['table',['table']],
			['insert',['link','picture','hr']],
			['view',['fullscreen','codeview']]
			
		]
		
		
		$("#img_text").summernote({
			
			lang:'ko-KR',
			placeholder: '본문을 입력하세요',
			height:'100%',
			toolbar:toolbar,
			height:'200px',
			disableDragAndDrop: true
			
		})
		
		$("#btn_img_up").click(function(){
			
			document.location.href = "${rootPath}/image/upload"
			
		})
		
		$("#d_d_box").on('dragover',function(e){
			$("#d_d_box h3").text("파일을 내려 놓으세요!!!")
			return false
		})
		/*
			file 1개를 Drag and Drop으로 업로드 수행하기
			업로드 되면서 e가 그 정보를 담고 있음.
			e.originalEvent.dataTransfer.files : 정보를 뽑아내고
			0번째 위치 값을 뽑아냄
		*/
		$("#d_d_box").on('drop',function(e){
			$("#d_d_box h3").text("파일 업로드 중!!!")
			
			// drop한 파일리스트 추출
			let files = e.originalEvent.dataTransfer.files
			let fileLen = files.length
		
			
			if(fileLen > 1){
				// 파일업로드를 위한 객체만들기
				let formData = new FormData()
				
				// Drop한 파일들을 모두 추가
				for(let i=0; i< files.length; i++){
					formData.append('files',files[i])
				}
				
				files_up(formData)
				return false;
			}else{
			
				// 리스트에서 첫번째 파일만 추출
				let file = files[0]
				alert(file.name)
				
				// 추출된 파일 정보를 서버에 먼저 업로드
				
				// js FormData 클래스를 
				// 사용해서 서버에 파일 업로드 준비
				let formData = new FormData()
				formData.append('file',file)
				file_up(formData);
			}
			return false
		})
		
		
		/* edit나 delete의 변수가 key에 담겨서 옴 */
		var contextCallBack = function(key,options) {
			
			if(key == 'edit') {
				let img_seq = $(this).attr("data-seq");
				// 컨트롤러 @PathVariable 사용하고 나서 변경"${rootPath}/image/update?img_seq="
				document.location.href = "${rootPath}/image/update/" + img_seq
				//alert("수정 클릭" + $(this).attr("data-seq"))
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
							// 현재화면 새로고침하라는 이야기
							if(result < 1)
								alert("삭제도중 문제 발생")
						},
						error : function() {
							alert("서버 통신오류")
						}
					})
					document.location.replace("${rootPath}/")
					
					// 이벤트 버블링 금지
					return false;
					// document.location.href = "${rootPath}/image/delete/" + img_seq
				}
			}
			
		}
		
		/*
		jquery 응용
		마우스를 제어해서 context menu(오른쪽마우스 클릭 메뉴)
		만들어주는 tool
		
		selector는 어떤 태그에서 우클릭 할지를 정하는 코드
		'items에 있는 edit와 delete를 만들겠다'
		
		icon은
		https://github.com/swisnl/jQuery-contextMenu/tree/master/src/icons에 있는
		아이콘들임
		*/
		$.contextMenu({
			selector:'.img_card',
			callback : contextCallBack,
			items : {
				'edit' : {name:'수정',icon:'edit'},
				'delete' : {name:'삭제',icon:'delete'},
			}
		})
	})

</script>
</head>
<body>
<header>
	<h3><a href="${rootPath}/">이미지 갤러리</a></h3>
</header>
<section>
	<c:if test="${BODY == 'UPLOAD'}">
		<%@ include file="/WEB-INF/views/body/img_upload.jsp" %>
	</c:if>
</section>
<section id="img_box">
	<c:forEach items="${imgList}" var="img" begin="1" end="10">
		<%@ include file="/WEB-INF/views/include/img_card.jsp" %>
	</c:forEach>
</section>
<section>
	<button id="btn_img_up" class="bz_button">이미지 올리기</button>
</section>
</body>
</html>