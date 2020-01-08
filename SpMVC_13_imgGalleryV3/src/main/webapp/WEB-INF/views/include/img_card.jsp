<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="img_panel img_card" data-file="${img.img_file}" data-seq="${img.img_seq}">

	<c:if test="${empty img.img_file}">	
		<img src="${rootPath}/images/noimage.png" height="80%" width="100%">
	</c:if>
	<c:if test="${!empty img.img_file}">	
		<img src="${rootPath}/images/${img.img_file}" height="80%" width="100%">
	</c:if>
	<div class="img_title">
		<h4>${img.img_title}</h4>		
	</div>
</div>