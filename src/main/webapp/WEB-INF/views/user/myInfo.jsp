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
	#recordListforEachWrapper, #commentListforEachWrapper {
		border-top: 3px solid #1E90FF;
		padding-top: 10px;
		padding-bottom: 10px;
		margin-bottom: 20px;
	}
	.recordWrapper, .commentWrapper {
		border-bottom: 1px groove #808080;
		margin-bottom: 10px;
	}
	.commentWrapper p:nth-child(2) {
		margin-bottom:4px;
	}
	#recordListTitle, #commentListTitle, .recordWrapper, .commentWrapper {
		cursor: pointer;
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
			<a id="userRemove" style="cursor: pointer;">회원탈퇴</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a id="userPassCheck"style="cursor: pointer;">비밀번호 변경</a>
			<div style="clear:both;"></div>
			</div>
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<h2 id="recordListTitle">게시글목록 전체보기</h2>
				<div id="recordListforEachWrapper">
					<c:choose>
						<c:when test="${recordList.size() == 0 }">
							<div style="height: 200px; display:flex; align-items: center; justify-content: center; border-bottom: 3px solid #1E90FF;">
								등록하신 게시글이 없습니다.
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${recordList}" var="record" varStatus="i">
								<c:set var="recordWriteTime_YMD"><fmt:formatDate value="${record.writetime}" pattern="yyyy.MM.dd"/></c:set>
								<div id="${record.b_idx}"class="recordWrapper"<c:if test="${i.last}">style="border-bottom: 3px solid #1E90FF;"</c:if>>
									<p><b>${record.title}</b></p>
									<p>${record.bc_name}&nbsp;|&nbsp;<c:out value="${recordWriteTime_YMD}"/></p>
									<input hidden="hidden" id="recordBc_code_${record.b_idx}" value="${record.bc_code}"/>
									<input hidden="hidden" id="recordB_num_${record.b_idx}" value="${record.b_num}"/>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<h2 id="commentListTitle">댓글목록 전체보기</h2>
				<div id="commentListforEachWrapper">
					<c:choose>
						<c:when test="${commentList.size() == 0 }">
							<div style="height: 200px; display:flex; align-items: center; justify-content: center; border-bottom: 3px solid #1E90FF;">
								등록하신 댓글이 없습니다.
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${commentList}" var="comment" varStatus="i">
								<c:set var="commentWriteTime_YMD"><fmt:formatDate value="${comment.co_writedate}" pattern="yyyy.MM.dd"/></c:set>
								<div id="${comment.co_idx}" class="commentWrapper"<c:if test="${i.last}">style="border-bottom: 3px solid #1E90FF;"</c:if>>
									<p><b>${comment.co_content}</b></p>
									<p>${comment.bc_name}&nbsp;|&nbsp;<c:out value="${commentWriteTime_YMD}"/></p>
									<p><span style="background-color: rgba(80, 80, 80, 0.2);">${comment.title}</span></p>
									<input hidden="hidden" class="commentBc_code_${comment.co_idx}" value="${comment.bc_code}"/>
									<input hidden="hidden" class="commentB_num_${comment.co_idx}" value="${comment.b_num}"/>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</main>

	
	<jsp:include page="../common/footer.jsp" flush="false"/>	
</body>
<script src="/resources/js/myInfo.js"></script>

</html>