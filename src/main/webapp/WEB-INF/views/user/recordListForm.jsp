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
	#recordListforEachWrapper {
		border-top: 3px solid #1E90FF;
		padding-top: 10px;
		padding-bottom: 10px;
		margin-bottom: 20px;
	}
	.recordWrapper {
		border-bottom: 1px groove #808080;
		margin-bottom: 10px;
	}
	#recordListTitle, .recordWrapper {
		cursor: pointer;
	}
</style>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>

	<main class="container" style="margin-top: 100px;">
	
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

		<!-- 페이징 버튼 -->
		<div style="display: flex; justify-content: center; align-items: center; margin-top: 20px;">
			<ul class="btn-group pagination">
			    <c:if test="${pageMaker.prev}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/accounts/myInfo/recordList?searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.startPage-1}"/>'><i class="bi bi-chevron-double-left"></i></a>
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
						        <a class="btn btn-outline-secondary" href='<c:url value="/accounts/myInfo/recordList?searchType=${param.searchType}&keyword=${param.keyword}&page=${pageNum}"/>'><i>${pageNum}</i></a>
						    </li>
						</c:otherwise>
					</c:choose>
			    </c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/accounts/myInfo/recordList?searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.endPage+1}"/>'><i class="bi bi-chevron-double-right"></i></a>
				    </li>
			    </c:if>
			</ul>
		</div>
		
		
		
		
		<!-- 검색버튼 -->
		<div class="col-sm-offset-3"style="display: flex; justify-content: center; align-items: center;">
			<label>게시글 제목</label>
			<input style="margin-right:10px; margin-left:10px;" type='text' id='searchKeyword' value="${pageMaker.cri.keyword}" onkeypress="if( event.keyCode == 13 ){searchUserRecord();}">
			<button class="btn btn-primary" type="button" id='searchBtn' onclick="searchUserRecord();">검색</button> 
		</div>
		<!-- 검색데이터 넣어놓는 hidden input -->
		<form id="formList" action="/accounts/myInfo/recordList" method="get">
			<input type="hidden" name="page"/>
			<input type="hidden" name="searchType" value="record"/>
			<input type="hidden" name="keyword"/>
		</form>
	</main>
	
	<jsp:include page="../common/footer.jsp" flush="false"/>	
</body>
<script src="/resources/js/myInfo.js"></script>
</html>