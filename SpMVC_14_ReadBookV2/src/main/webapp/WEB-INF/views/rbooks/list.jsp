<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<script>
$(function(){
	//$("#btn-write").click(function() {
	$("#btn-write").click( ()=> {
		document.location.href="${rootPath}/rbook/insert"
	})
	
	$("#main-table tbody tr").click(function(){
		
		let rb_seq = $(this).attr("data-id")
		document.location.href = "${rootPath}/rbook/view/" + rb_seq
	
	})
	
})
</script>
</head>
<body>
<header>
	<h2>MY READ BOOK</h2>
</header>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
<%@ include file="/WEB-INF/views/rbooks/list-body.jsp" %>


</body>
</html>