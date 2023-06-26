<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#commentListforEachWrapper {
		border-top: 3px solid #1E90FF;
		padding-top: 10px;
		padding-bottom: 10px;
		margin-bottom: 20px;
	}
	.commentWrapper {
		border-bottom: 1px groove #808080;
		margin-bottom: 10px;
	}
	.commentWrapper p:nth-child(2) {
		margin-bottom:4px;
	}
	#commentListTitle, .commentWrapper {
		cursor: pointer;
	}
</style>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>

	<main class="container" style="margin-top: 100px;">
	
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

		<!-- 페이징 버튼 -->
		<div style="display: flex; justify-content: center; align-items: center; margin-top: 20px;">
			<ul class="btn-group pagination">
			    <c:if test="${pageMaker.prev}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/accounts/myInfo/commentList?searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.startPage-1}"/>'><i class="bi bi-chevron-double-left"></i></a>
				    </li>
			    </c:if>
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
			    	<c:choose>
			    		<c:when test="${pageNum == 1 && empty param.page}">
						    <li>
						        <a class="btn btn-secondary disabled"><i>${pageNum}</i></a>
						    </li>		    		
			    		</c:when>
			    		<c:when test="${param.page eq pageNum}">
						    <li>
						        <a class="btn btn-secondary disabled"><i>${pageNum}</i></a>
						    </li>
						</c:when>
						<c:otherwise>
							<li>
						        <a class="btn btn-outline-secondary" href='<c:url value="/accounts/myInfo/commentList?searchType=${param.searchType}&keyword=${param.keyword}&page=${pageNum}"/>'><i>${pageNum}</i></a>
						    </li>
						</c:otherwise>
					</c:choose>
			    </c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/accounts/myInfo/commentList?searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.endPage+1}"/>'><i class="bi bi-chevron-double-right"></i></a>
				    </li>
			    </c:if>
			</ul>
		</div>
		
		
		
		
		<!-- 검색버튼 -->
		<div class="col-sm-offset-3"style="display: flex; justify-content: center; align-items: center;">
			<label>댓글 내용</label>
			<input style="margin-right:10px; margin-left:10px;" type='text' id='searchKeyword' value="${pageMaker.cri.keyword}" onkeypress="if( event.keyCode == 13 ){searchUserComment();}">
			<button class="btn btn-primary" type="button" id='searchBtn' onclick="searchUserComment();">검색</button> 
		</div>
		<!-- 검색데이터 넣어놓는 hidden input -->
		<form id="formList" action="/accounts/myInfo/commentList" method="get">
			<input type="hidden" name="page"/>
			<input type="hidden" name="searchType" value="comment"/>
			<input type="hidden" name="keyword"/>
		</form>
	</main>
	
	<jsp:include page="../common/footer.jsp" flush="false"/>	
</body>
<script src="/resources/js/myInfo.js"></script>
</html>