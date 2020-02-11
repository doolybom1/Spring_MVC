<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

#btn-email-send{
	background-color: #212529;
	color: white;
	padding: 5px 10px;
	border-radius: 3px;
	border-style: none;
}
</style>
<script>
$(function(){
	
	$(".email-list").click(function(){
		document.location.href = "${rootPath}/ems/view/" + $(this).data("seq")
	})
})
</script>
<table class="main-list table-striped table-bordered table-hover">
	<tr class="bg-dark">
		<th>NO</th>
		<th>받는Email</th>
		<th>받는사람</th>
		<th>제목</th>
		<th>작성일자</th>
		<th>작성시각</th>
	</tr>
	<c:choose>
		<c:when test="${empty LIST}">
			<tr>
				<td colspan="6">데이터가 없습니다</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${LIST}" var="VO" varStatus="in">
				<tr data-seq="${VO.ems_seq}" class="email-list">
					<td>${in.index}</td>
					<td>${VO.from_email}</td>
					<td>${VO.from_name}</td>
					<td>${VO.subject}</td>
					<td>${VO.send_date}</td>
					<td>${VO.send_time}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<div style="padding:10px 55px">
	<button id="btn-email-send" 
			onclick="location.href='${rootPath}/ems/input' ">
		메일보내기
	</button>
</div>


