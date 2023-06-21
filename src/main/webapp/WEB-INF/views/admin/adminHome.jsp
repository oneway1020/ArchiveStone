<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 홈</title>
</head>
<style>
	main {
		height: 500px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	#category {
		font-size: 50px;
		line-height: 2em;
		text-align: center;
	}
	#category li {
		font-size: 50px;
		display:inline-block;
		margin-left: 20px;
		margin-right: 20px;
	}
	#category li a {
		color: black;
		text-decoration: none;
	}
</style>
<body>
	
	<jsp:include page="../common/adminHeader.jsp" flush="false"/>
	
	
	<main class="container">
		<nav style="padding: 10px 0; border: 3px solid rgba(220, 220, 220, 1); border-left: none; border-right: none">
			<div id="ul_wrapper">
				<ul id="category">
					<li>
						<a href="/admin/userInfo">회원정보</a>
					</li>
					<li>
						<a href="/board/Q&A">Q&A응답</a>
					</li>
					<c:if test="${user.m_level == 0}">
						<li>
							<a href="/admin/createBoard">게시판제작</a>
						</li>
					</c:if>
				</ul>
			</div>
		</nav>
	</main>

	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>