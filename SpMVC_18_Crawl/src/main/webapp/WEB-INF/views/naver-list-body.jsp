<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="col-xl-2 col-md-4 col-12">
	<div class="card">
		<div class="card-header">${NAVER.m_title}</div>
		<div class="card-body">
			<img src="${NAVER.m_image_url}" width="100%">
		</div>
		<div class="card-footer">
			<a href="${NAVER.m_detail_url}">자세히 보기</a>
		</div>
	</div>
</div>