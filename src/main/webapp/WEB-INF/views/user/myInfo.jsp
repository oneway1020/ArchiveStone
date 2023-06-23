<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
</head>
<style>
	#main_title {
		margin-bottom: 50px;
	}
</style>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	<main class="container" style="margin-top: 30px;">
		<div id="main_title">
			<h3>내정보 페이지</h3>
		</div>		
		<div class="row">
			<div class="col-sm-2">
				<table class="table">
					<thead>
						<tr>
							<th class="col-sm-1 text-center">아이디(id)</th>
							<th class="col-sm-1 text-center">닉네임</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td align="center">${user.m_id}</td>
							<td align="center">${user.m_name }</td>
						</tr>
					</tbody>
				</table>
			<a id="userPassCheck"style="cursor: pointer; float:right;">비밀번호 변경</a>
			<div style="clear:both;"></div>
			</div>
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<h2>게시글목록</h2>
				<c:forEach var="recordList" items="${recordList}">
					${recordList.title}&nbsp;|&nbsp;
				</c:forEach>
				<hr/>
				<h2>댓글목록</h2>
				<c:forEach var="commentList" items="${commentList}">
					${commentList.co_content}&nbsp;|&nbsp;
				</c:forEach>
			</div>
		</div>
		
		
	</main>

	
	<jsp:include page="../common/footer.jsp" flush="false"/>	
</body>
<script src="/resources/js/myInfo.js"></script>
</html>