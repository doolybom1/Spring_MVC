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
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<script>
$(function(){
	
	$("#btn-write").click(function() {
	
		if($("#rb_bcode").val() == ""){
			alert("도서코드는 반드시 입력해야 합니다.") 
			$("#rb_bcode").focus()
			return false;
		}
		
		if(parseInt($("#rb_rtime").val()) < 1){
			alert("독서 시간은 반드시 입력해야 합니다.")
			$("#rb_rtime").focus()
			return false;
		}
		
		if($("#rb_subject").val() ==""){
			alert("한줄평은 반드시 입력해야 합니다.")
			$("#rb_subejct").focus()
			return false;
		}
		
		// 버튼을 클릭하면 submit
		$("form").submit();
		
	})

	$("#rb_bname, #rb_rtime, #rb_bcode, #rb_subject").focus(function(){
		$(this).select()
	})
	
	$("#rb_bname").keypress(function(event){

		// enter키를 눌렀을때
		if(event.keyCode == 13){
			
			var strText = $(this).val()

			if(strText==""){
				alert("도서이름을 입력한 후 Enter를 눌러주세요")
				return false;
			}
			
			$("#modal-box").css("display","block");
			$.post("${rootPath}/book/search",{strText:strText}, function(result){
				
				$("#modal-content").html(result)
				
			})
		}
	})
	
	$(".modal-header span").click(function(){
		$("#modal-box").css("display","none");
	})
	
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
	
	$("#rb_text").summernote({
		
		lang:'ko-KR',
		placeholder: '본문을 입력하세요',
		width:'100%',
		toolbar:toolbar,
		height:'200px',
		disableDragAndDrop: true
		
	})
	
	$("#rb_star").change(function(){
		
		let star = $(this).val()
		star = star * 10
		
		$("span.star-red").css("width",star + "%")
		
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
	
	#rb_star{
		width: 60%;
	}
	
	span.star-box{
		width: 100px;
		margin-left: 20px;
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
		width: 10%;
	}
	
</style>
</head>
<body>
<header>
	<h2>MY READ BOOK</h2>
</header>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
<%
/*
	글쓰기를 시작할 때
	controller get로 path를 받았을 때, 현재 view를 보여주고
	input box에 데이터를 입력한 후 submit 버튼을 클릭하면
	controller post로 데이터가 전송된다.
	
	path는
	view를 열 때, 사용했던 path가 그대로 적용된다.
	
	그렇게 사용하지 않을 경우에는 별도로 action을 지정해야 한다.
	
	/rbooks/book/insert path를 실행하면
	Controller의 GET method가 이를 수신하여 현재 input.jsp를 보여주고
	
	데이터를 입력한 후 저장 button을 클릭하면
	/rbooks/book/insert path의 POST method로 데이터가 전송된다.

*/
 %>
<section id="main-writer">
	<article>
		<form:form modelAttribute="rBookVO">
			<div class="input-box">
				<form:input type="text" path="rb_bcode" placeholder="도서 코드"/>
				<form:input path="rb_bname" placeholder="도서이름을 입력한 후 Enter..."/>
			</div>
			<div class="input-box">
				<form:input type="date" path="rb_date" placeholder="독서일자"/>
			</div>
			<div class="input-box">
				<form:input type="time" path="rb_stime" placeholder="독서시작시간"/>
			</div>
			<div class="input-box">
				<form:input type="text" path="rb_rtime" placeholder="독서시간"/>
			</div>
			<div class="input-box">
				<form:input type="text" path="rb_subject" placeholder="한줄평"/>
			</div>
			<div class="input-box">
				<form:input type="range" path="rb_star" min="1" max="10" />
			<span class="star-box">
				<span class="star-red"></span>
			</span>
			</div>
			<div class="input-box">
				<form:textarea path="rb_text"/>
			</div>
			<div id="main-button">
				<button id="btn-write" type="button" class="biz-orange flex-right">독서록 저장</button>
				<button id="btn-clear" type="reset" class="biz-red ">새로 작성</button>
				<button id="btn-list" type="button" class="biz-blue ">리스트로 가기</button>
			</div>
		</form:form>
	</article>
</section>

<div id="modal-box">
	<div class="modal-header">
		<span>&times;</span>
	</div>
	<div id="modal-content">
		
	</div>
</div>

</body>
</html>