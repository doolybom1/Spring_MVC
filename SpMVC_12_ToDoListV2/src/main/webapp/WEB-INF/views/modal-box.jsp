<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	
	.modal{
		display : none;
		position : fixed;
		z-index: 10;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		
		background-color: rgba(0,0,0,0.4);
	}
	
	.modal form {
		position: relative;
		width: 30%;
		padding: 10px;
		border: 1px solid #888;
		margin: 0 auto;
		background-color: #fefefe;
		animation-name : form-ani;	
		animation-duration : 0.9s;
		animation-fill-mode: forwards;
		
		-webkkit-animation-name : form-ani;
		-webkkit-animation-duration : 0.9s;
		-webkkit-animation-fill-mode: forwards;
		
		-moz-animation-name : form-ani;
		-moz-animation-duration : 0.9s;
		-moz-animation-fill-mode: forwards;
		
		-ms-animation-name : form-ani;
		-ms-animation-duration : 0.9s;
		-ms-animation-fill-mode: forwards;
	}
	
	/*
		animation 실행하는 css
	*/
	
	@keyFrames form-ani{
	
		from{
			top: -300px;
			opacity: 0;
		}
		
		to{
			top: 200px;
			opacity: 1;
		}
	
	}
	
	-webkkit-@keyFrames form-ani{
	
		from{
			top: -300px;
			opacity: 0;
		}
		
		to{
			top: 200px;
			opacity: 1;
		}
	
	}
	
	span.modal-close{
		color: white;
		float: right;
		font-size: 30px;
		font-weight: bold;
	}
	
	span.modal-close:hover{
		color:#000;
		cursor: pointer;
	}
	
</style>
<script>
	$(function() {
		$("span.modal-close").click(function() {
			$("#myModal").css("display","none")
		})
	})
</script>

<div id="myModal" class="modal">
	<div>
		<span class="modal-close">&times;</span>
	</div>
	<form action="${rootPath}/member/login" method="POST">
		<div>
			<input type="text" name="user_name" placeholder="사용자 ID">
		</div>
		<div>
			<input type="password" name="password" placeholder="비밀번호">
		</div>
		<div>
			<button id="btn-login">로그인</button>
		</div>
	</form>

</div>