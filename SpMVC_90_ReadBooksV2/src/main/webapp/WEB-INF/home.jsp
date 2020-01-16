<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<% 
/*
	글쓰기를 시작할때 controller get로 path를 받았을 때 현재 vidw를 보여주고 input box에 데이터를 입력한 후 sumbit 버튼을 클릭하면
	controller post로 데이터가 전송된다
	
	path는 view를 열때 사용했던 path가 그대로 적용된다
	그렇게 사용하지 않을 경우에는 별도로 action을 지정해야 한다
	
	/rbooks/book/insert path를 실행하면 controller GET method가 이를 수신하여 현재 input.jsp를 보여주고
	데이터입력한 후 저장 button을 클릭하면 /rbooks/book/insert path의 POST method로 데이터가 전송된다
	
	특별히 action을 지정하지 않으면 위와 같은 매커니즘으로 사용된다
	기본값으로 사용하지 않을경우 action을  지정하여 사용할 수 있다
	
	spring form tag를 사용활 경우는 기본 method가 POST이고 html form tag는 기본 method가 GET이다
	button은 type을 지정하지 않으면 type="submit" 이 기본값이고 버튼을 클릭하면 form에 입력한 데이터를 서버로 전송하는 기능을 한다
	
	buttion에 특별히 이벤트를 적용하고 싶으면  type="buttion"으로 지정할 수 있다
*/
%> 
<script type="text/javascript">
	$(function(){
		
		$("#btn-write").click(function() {
			
			if($("#rb_bcode").val() == ""){
				alert("도서 코드는 반드시 입력해야 합니다")
				$("#rb_bcode").focus()
				return false
			}

			// parseInt 문자열을 숫자로 바꿔주는 코드
			if(parseInt($("#rb_rtime").val()) < 1){
				alert("독서시간은 반드시 입력해야 합니다")
				$("#rb_rtime").focus()
				return false
			}

			if($("#rb_subject").val() == ""){
				alert("독서시간은 반드시 입력해야 합니다")
				$("#rb_subject").focus()
				return false
			}
			
			$("form").submit()
		})
		
		// input box에 내용이 있을때 focus가 위치하면 내용을 전체 블럭 설정하여 다른 글자를 입력하면
		// 내용이 삭제되는 기능 구현
	
		$("#rb_bname").focus(function() {
			$(this).select()
		})
		
		
		$("#rb_bname").keypress(function(event) {
			if(event.keyCode == 13){
				
				let strText = $(this).val()
				if(strText == ""){
					alert("도서이름을 입력한 후 Enter를 눌러주세요")
					return false
				}
				
				$("#modal-box").css('display', 'block')
				$.post("${rootPath}/book/search", {strText:strText},function(result){
					$("#modal-content").html(result)
				})
			}
		})
		
		$(".modal-header span").click(function() {
			$("#modal-box").css('display', 'none')
			
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
		
		$("#rb_text").summernote({
			
			lang:'ko-KR',
			palceholder:'본문을 입력하세요',
			width:'100%',
			toolbar:toolbar,
			height:'200px',
			disableDragAndDrop : true
		})
		
		
	})
</script>



<style type="text/css">
	.input-box{
		display: flex;
		width: 80%;
		margin:5px auto;
	}
	
	.input-box input{
		color:black;
		border: none;
		border-bottom: 1px solid rgb(52,152,219);
		display: block;
		width: 100%;
		padding: 8px;
	}
	
	#rb_bcode{
		width: 50%;
		margin-right: 10px;
		
	}
	
	button{
		margin:5px;
	}
	
	#btn-list{
		margin-right: 198px;
	}
</style>

</head>
<body>

<header>
	<h2>My Read Book</h2>
</header>

<%@ include file ="/WEB-INF/views/include/include-nav.jspf" %>

<section id="main-writer">
	<article>
		<form:form modelAttribute="rBookVO">
			<div class="input-box">
				<form:input type="text" path="rb_bcode" placeholder="도서코드"></form:input>
				<input id="rb_bname" name="rb_bname" placeholder="도서이름을 입력한 후 Enter...">
			</div>
			<div class="input-box">
				<form:input type="date" path="rb_date" placeholder="독서일자"></form:input>
			</div>
			<div class="input-box">
				<form:input type="time" path="rb_stime" placeholder="독서시작시간"></form:input>
			</div>
			<div class="input-box">
				<form:input type="text" path="rb_rtime" placeholder="독서시간"></form:input>
			</div>
			<div class="input-box">
				<form:input type="text" path="rb_subject" placeholder="한줄평"></form:input>
			</div>
			<div class="input-box">
				<form:input type="number" path="rb_star" placeholder="별점"></form:input>
			</div>
			<div class="input-box">
				<form:textarea type="text" path="rb_text" placeholder="긴줄평"></form:textarea>
			</div>
			<div id="main-button">
				<button type="button" id="btn-write" class="biz-orange flex-right">독서록 저장</button>
				<button type="reset" id="btn-clear" class="biz-red">새로작성</button>
				<button type="button" id="btn-list"  class="biz-blue">리스트로 가기</button>
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