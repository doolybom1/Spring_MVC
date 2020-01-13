<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>
$(function() {
	
	function idcheck() {
		let top = 500
		let left = 600

		// alert("Enter 입력")
		let m_id = $("#m_id").val()
		let status = "toolbar=no,"
		status += "scrollbars=yes,"
		status += "resizable=no,"
		status += "top=300,"
		status += "left=450,"
		status += "width=400,"
		status += "height=200 "

		if (m_id == "") {
			alert("ID를 입력한 후 Enter")
			return false
		}

		openWin = window.open("${rootPath}/member/idcheck?m_id=" + m_id,
				"_blank", status)
		// openWin.moveTo(left,top)

	}

	$("#m_id").keypress(function(e) {
		if (e.keyCode == 13) {
			// 표준, 일반적으로 함수를 호출하는 방법
			idcheck()
		}
	})

	$("#id_check").click(idcheck)
	
	$("#btn-save").click(function() {
	
		let id_pass = $("#m_id").val()
		if (id_pass == "") {
			alert("아이디를 입력하세요")
			$("#m_id").focus()
			return false
		}
		
		let pass = $("#m_password").val()
		if (pass == "") {
			alert("비밀번호를 입력하세요")
			$("#m_password").focus()
			return false
		}
	
		let re_pass = $("#m_re_password").val()
		if (re_pass == "") {
			alert("비밀번호를 한번 더 입력해 주세요")
			$("#m_re_password").focus()
			return false
		}
	
		if (pass != re_pass) {
			alert("비밀번호와 비밀번호확인이 일치하지 않습니다\n" + "다시 입력해 주세요")
			$("#m_password").val("")
			$("#m_re_password").val("")
			$("#m_password").focus()
			return false
		}
	})
})
</script>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.join-form {
	width: 400px;
	padding: 40px;
	background: black;
	text-align: center;
	z-index: 10;
	border-radius: 20px;
	box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, 0.2);
	margin: 20px auto;
}

.join-form h2 {
	color: white;
	font-weight: 500;
}

.join-form h3 {
	color: white;
	font-weight: 300;
	background-color: red;
	border-radius: 20px;
}

.join-form input {
	background: none;
	margin: 20px auto;
	text-align: center;
	border: 2px solid #3498db;
	padding: 14px 10px;
	width: 200px;
	outline: none;
	color: white;
	border-radius: 25px;
	transition: 0.2s;
}

.join-form input:focus {
	width: 280px;
	border-color: #2ECC71;
}

.join-form button {
	border: 2px solid #2ECC71;
	padding: 14px 40px;
	background: none;
	display: block;
	margin: 20px auto;
	padding: 14px 40px;
	outline: none;
	color: white;
	border-radius: 25px;
	cursor: pointer;
}

.join-form button:hover {
	background-color: #2ECC71;
}
</style>

<form method="POST" action="${rootPath}/member/join" class="join-form">
	<h2>회원가입</h2>
	<input type="text" name="m_id" id="m_id" placeholder="사용자 ID"> 
	<input type="password" name="m_password" id="m_password" placeholder="비밀번호">
	<input type="password" name="m_re_password" id="m_re_password" placeholder="비밀번호확인">
	<button id="btn-save">회원가입</button>
</form>

