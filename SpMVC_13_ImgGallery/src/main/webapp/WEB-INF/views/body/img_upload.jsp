<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<form:form modelAttribute="imageVO">
	<fieldset>
		<legend>이미지 갤러리 작성</legend>
		<div class="input_box">
			<form:input type="text" path="img_title" placeholder="제목을 입력하세요" />		
		</div>
		<div class="input_box">
			<form:textarea type="text" path="img_text" placeholder="제목을 입력하세요" />		
		</div>
		<div class="input_box">
			<div id="d_d_box">
				<h3>이미지를 올려놓으세요</h3>			
			</div>
		</div>
		<div class="input_box">
			<button class="bz-button">저장</button>		
		</div>
	</fieldset>
</form:form>