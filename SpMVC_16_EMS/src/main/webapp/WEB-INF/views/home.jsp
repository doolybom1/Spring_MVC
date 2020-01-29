<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>MY EMS</title>
<link rel="stylesheet" type="text/css" 
		href="${rootPath}/resources/css/main.css?ver=2020-01-20">
<link rel="stylesheet" type="text/css" 
		href="${rootPath}/resources/css/table-list.css?ver=2020-01-20">
<link rel="stylesheet" href="${rootPath}/resources/css/email-write.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-header.jspf" %>
<c:choose>
	<c:when test="${BODY == 'WRITE'}">
		<%@ include file="/WEB-INF/views/body/ems/write.jsp" %>
	</c:when>

	<c:when test="${BODY == 'VIEW'}">
		<%@ include file="/WEB-INF/views/body/ems/view.jsp" %>
	</c:when>
	
	<c:otherwise>
		<%@ include file="/WEB-INF/views/body/ems/list.jsp" %>
	</c:otherwise>
</c:choose>
</body>
</html>