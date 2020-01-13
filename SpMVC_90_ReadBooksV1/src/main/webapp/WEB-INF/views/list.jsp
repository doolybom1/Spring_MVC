<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="rootPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 홈페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
	*{
		margin: 0;
		paddin:0;
	}
	.list{
		border-collapse: collapse;
		margin: auto;
		overflow : auto;
	}
	
	.content-body td{
		padding: 5px;
	}
	.content-body:hover{
		cursor: pointer;
		border:4px solid tomato;
	}

	header h2{
		text-align: center;
		margin :1rem;
		color: tomato;
	}
	.list-box th{
		background-color: #ccc;
	} 

	#book_insert{
		display:block;
		margin: 10px auto;
		text-align: center;
	}
	
	#book_insert button{
		padding: 10px;
		background-color: tomato;
		color:white;
		border-style: none;
		font-weight: bold;
	}
	#book_insert button:hover{
		cursor: pointer;
	}
	section{
		margin: 5px 25.6%;
	}
	#search{
		padding: 0.5rem;
		width: 450px;
	}
	nav{
		display: flex;
	}
	
	.login{
		margin-left: auto;
	}
	.join{
		margin-right: 450px;
	}
	
	#login, #join{
		padding: 5px;
		color: white;
		background-color: tomato;
		border: none;
	}
	
	#login:hover, #join:hover{
		cursor: pointer;
	}
	
	nav>div{
		margin: 0px 5px;
		margin-bottom: 10px;
	}
	
	#login_modal form{
		
		position: relative;
		padding: 10px;
		margin: 0 auto;
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
	
	
	#lid{
		text-decoration: none;
	}
	
	#lid-location{
		margin-left: 480px;
	}
	
	<!-- -->
	.tooltip {
			position: relative;
			display: inline-block;
			margin: auto;
		}
		.tooltip .tooltip-content {
			visibility: hidden;
			width: 220px;
			background-color: tomato;
			padding: 10px;
			color: white;
			text-align: center;
			position: absolute;
          	border-radius: 3px;
			z-index: 1;
			bottom: 180%;
			left: 70%;
		}
		.tooltip .tooltip-content::after {
			content: " ";
			position: absolute;
			top: 100%;
			left: 50%;
			margin-left: -10px;
			border-width: 10px;
			border-style: solid;
			border-color: tomato transparent transparent transparent;
		}
		.tooltip:hover .tooltip-content { visibility: visible; }
</style>	
<script>
$(function() {
	
		// 리스트 목록을 클릭시 상세페이지로 이동
		$(".content-body").click(function(){
			
			if("${MEMBER}" != ""){
				let id = $(this).attr("data-id")
	
				document.location.href = "${rootPath}/book/view?id=" + id
				}else{
					document.location.href = "${rootPath}/member/login"
			}
		})
})

</script>


</head>
<body>	
<header>
	<h2>도서 정보</h2>
	
		<div class="tooltip">
			<span><p id="lid-location"><a id="lid" href="${rootPath}/member/logout">${MEMBER.m_id}</a></p></span>
			<div class="tooltip-content">
				<p>클릭시에 로그아웃이 됩니다</p>
			</div>
		</div>
</header>
		<!-- 
		<section>
			<input id="search" type="text" placeholder="검색어를 입력하시오">
		</section>
		 -->
		 <nav>
			 <div class="login">
			 	<a href="${rootPath}/member/login"><button id="login">로그인</button></a>
			 </div>
			 
			 <div class="join">
			 	<a href="${rootPath}/member/join"><button id="join">회원가입</button></a>
			 </div>
		 </nav>
		 
		 
		<table class="list" border="1">
			<tr class="list-box">
				<th>도서코드</th>
				<th>도서명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>구입일자</th>
				<th>구입가격</th>
			</tr>
			<c:choose>
			<c:when test="${empty BOOK_LIST}">
				<tr><td colspan="6"></td>
			</c:when>
			<c:otherwise>
					<c:forEach items="${BOOK_LIST}" var="book" varStatus="index">
								<tr class="content-body" data-id="${book.b_code}" data-auth="${book.b_auther}" >
									<td>${book.b_code}</td>
									<td>${book.b_name}</td>
									<td>${book.b_auther}</td>
									<td>${book.b_comp}</td>
									<td>${book.b_year}</td>
									<td>${book.b_iprice}</td>
								</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div id="book_insert">
			<a href="${rootPath}/book/insert"><button >도서등록</button></a>
			<a href="${rootPath}/read/list"><button>독서록 리스트</button></a>
		</div>
</body>
</html>