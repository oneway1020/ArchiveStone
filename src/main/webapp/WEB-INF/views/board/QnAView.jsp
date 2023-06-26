<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 현재 날짜 구하기 -->
<c:set var="today"	value="<%=new java.util.Date() %>"/>
<c:set var="today_date"><fmt:formatDate value="${today}" pattern="yyyy.MM.dd HH:mm:ss"/></c:set>
<!-- 오늘 일 -->
<c:set var="today_day"><fmt:formatDate value="${today}" pattern="dd"/></c:set>

<!-- DB writetime 값 패턴변경 -->
<c:set var="writeTime"><fmt:formatDate value="${recordOne.writetime}" pattern="yyyy.MM.dd HH:mm:ss"/></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${recordOne.title}</title>
</head>
<style>
	.postTypeBtnWrapper {
		float: left;
	}
	.postTypeBtnWrapper button {
		margin-right: 3px;
	}
	.writeBtnWrapper {
		float: right;
	}
	#recordList {
		margin-top: 20px;
	}
	.title_a:hover {
		cursor: pointer;
	}
	.title_a {
		text-decoration: none;
		color: black;
	}
	
	#title_subject {
		font-size: 22px;
		font-weight: 500;
	}
	#title_cnt_good_reply_wrapper span, #title_id_writetime_wrapper span {
		font-size: 16px;
	}
	#title_top {
		border-top: 3px groove #808080;
		border-bottom: 1px groove #808080;
		height: 80px;
	}
	#editor_content {
		margin-top: 80px;
		margin-bottom: 80px;
	}

	#commentList {
		border-top: 2px solid orange;
	}
	#commentInput {
		border-top: 3px solid orange;
		border-bottom: 3px solid orange;
		height: 150px;
		display: flex;
		justify-content: center;
	}
	#commentUserInput {
		float: left;
		margin-right: 10px;
		margin-top: 10px;
	}
	#commentTextInput {
		margin-top: 10px;
	}
	.loginUserCommentName {
		background-color: rgba(230, 230, 230, 0.5);
		border:none;
		pointer-events: none;
	}
	/* 본문 */
	#recordOne {
		margin-bottom: 16px;
	}
	#noComment {
		display: flex; justify-content: center; align-items: center; height:100px;
	}
	.yesComment {
		min-height:60px; 
		display:flex; 
		align-items:center; 
		border-bottom: 1px solid rgba(80, 80, 80, .2);
	}
</style>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	
	<main class="container" style="margin-top: 20px;">
	
	<h3 style="margin-bottom: 20px;"><a style="color: black; text-decoration: none;" href='<c:url value="/board/Q&A/record"/>'>Q&amp;A 게시판</a></h3>
	<input hidden="hidden" id="hiddenQ_num" value="${recordOne.q_num}"/>
	<input hidden="hidden" id="hiddenIdx" value="${recordOne.m_idx}"/>
	<input hidden="hidden" id="hiddenLevel" value="${user.m_level}"/>
	<!-- view 내용 -->
	<div id="recordOne">
		<!-- 제목부분 -->
		<!-- content 에디터로 저장된 기본 p태그 font-size 는 16px -->
		<div id="title_top">
			<div id="title_subject_wrapper" style="margin-top:5px;">
				<span id="title_subject">${recordOne.title}</span>
			</div>
			<div id="title_sub_wrapper" style="margin-bottom:5px;">
				<div id="title_id_writetime_wrapper" style="float:left;">
					<span>${recordOne.m_name } (${recordOne.m_ip })&nbsp;|&nbsp;<c:out value="${writeTime}"/></span>
				</div>
				<div id="title_cnt_good_reply_wrapper" style="float:right;">
					<span>댓글 ${recordOne.q_reply }</span>
				</div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<!-- 글 본문 -->
		<div id="editor_content">
			<div>${recordOne.content}</div>
		</div>
		<p>전체 댓글: <b>${recordOne.q_reply}</b>개</p>
		<div id="commentList">
		</div>
		
		<div id="commentInput">
			<c:choose>
				<c:when test="${user.m_level != 0 }">
					<div style="height: 100px; display:flex; justify-content: center; align-items: center;">
						이 게시판에선 댓글을 다실 수 없습니다.
					</div>
				</c:when>
				<c:otherwise>
					<div id="commentUserInput">
						<div>
							<input id="commentNameInput" class="loginUserCommentName" value="${user.m_name}"/>
						</div>
					</div>
					<div id="commentTextInput">
						<textarea id="commentContent" rows="3" cols="95" style="resize: none;"></textarea>
						<div style="clear:both;"></div>
						<button style="float: right;" type="button" class="btn btn-primary" onclick="adminCommentRegister();">등록</button>
					</div>
				</c:otherwise>
			</c:choose>
			<div style="clear:both;"></div>
		</div>
	</div>	
	
		<div class="postTypeBtnWrapper">
			<button class="btn btn-primary totalRecord" type="button">전체글</button>
		</div>
		<div class="writeBtnWrapper">
			<button class="btn btn-light" type="button" onclick="qnaRecordRegister();">글쓰기</button>
		</div>
		<div style="clear:both;"></div>
		
		
		
		<!-- 게시글 목록 -->
		<form id="recordList" class="form-horizontal">
			<table class="table">
				<thead>
					<tr>
						<th class="col-sm-1 text-center">번호</th>
						<th class="col-sm-4 text-center">제목</th>
						<th class="col-sm-1 text-center">글쓴이</th>
						<th class="col-sm-1 text-center">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${recordList == null || recordList =='[]'}">
							<td valign="middle" align="center" height="200" colspan="5">게시글이 없습니다.</td>
						</c:when>
						<c:otherwise>
								<c:forEach var="record" items="${recordList}">
								<!-- writetime에서 시간만 꺼내기 -->
								<c:set var="writeTime_TIME"><fmt:formatDate value="${record.writetime}" pattern="HH:mm"/></c:set>
								<!-- writetime에서 일 만 꺼내기 -->
								<c:set var="writeTime_DAY"><fmt:formatDate value="${record.writetime}" pattern="dd"/></c:set>
								<!-- writetime에서 월 일 꺼내기 -->
								<c:set var="writeTime_MONTH_DAY"><fmt:formatDate value="${record.writetime}" pattern="MM.dd"/></c:set>
								<!-- 현재날짜와 DB입력 날짜 비교해서 하루 후면 날짜만 표시 -->
								<c:set var="day_comparison">
									<c:if test="${today_day - writeTime_DAY > 0 || today_day - writeTime_DAY < 0}">
										<c:out value="${writeTime_MONTH_DAY}"/>
									</c:if>
									<c:if test="${today_day - writeTime_DAY == 0}">
										<c:out value="${writeTime_TIME}"/>
									</c:if>
								</c:set>								
									<tr>
										<td align="center">${record.q_num}</td>
										<td><a class="title_a" onclick="goQnARecordDetail('${record.m_idx}','${record.q_num}');">${record.title} [${record.q_reply}]</a></td>
										<td align="right"><b>${record.m_name} (${record.m_ip})</b></td>
										<td align="right">${day_comparison}</td>
									</tr>
								</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</form>


		<div class="postTypeBtnWrapper">
			<button class="btn btn-primary totalRecord" type="button">전체글</button>
		</div>
		<div class="writeBtnWrapper">
			<button class="btn btn-light" type="button" onclick="qnaRecordRegister();">글쓰기</button>
		</div>
		<div style="clear:both;"></div>			
		
			
		<!-- 페이징 버튼 -->
		<div style="display: flex; justify-content: center; align-items: center; margin-top: 20px;">
			<ul class="btn-group pagination">
			    <c:if test="${pageMaker.prev}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/board/Q&A/record?searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.startPage-1}"/>'><i class="bi bi-chevron-double-left"></i></a>
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
						        <a class="btn btn-outline-secondary" href='<c:url value="/board/Q&A/record?searchType=${param.searchType}&keyword=${param.keyword}&page=${pageNum}"/>'><i>${pageNum}</i></a>
						    </li>
						</c:otherwise>
					</c:choose>
			    </c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/board/Q&A/record?searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.endPage+1}"/>'><i class="bi bi-chevron-double-right"></i></a>
				    </li>
			    </c:if>
			</ul>
		</div>
		
		
		
		
		<!-- 검색버튼 -->
		<div class="col-sm-offset-3">
			<select id='searchType'>
				<option value="typeofSearch">검색종류</option>
				<option value="t" <c:if test="${pageMaker.cri.searchType == 't'}">selected</c:if>>제목</option>
				<option value="c" <c:if test="${pageMaker.cri.searchType == 'c'}">selected</c:if>>내용</option>
				<option value="tc" <c:if test="${pageMaker.cri.searchType == 'tc'}">selected</c:if>>제목+내용</option>
			</select>
			<input type='text' id='searchKeyword' value="${pageMaker.cri.keyword}" onkeypress="if( event.keyCode == 13 ){searchRecord();}">
			<button class="btn btn-primary" type="button" id='searchBtn' onclick="searchRecord();">검색</button> 
		</div>
		<!-- 검색데이터 넣어놓는 hidden input -->
		<form id="formList" action="/board/Q&A/record" method="get">
			<input type="hidden" name="page"/>
			<input type="hidden" name="searchType"/>
			<input type="hidden" name="keyword"/>
		</form>

	</main>
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script src="/resources/js/record.js"></script>
<script src="/resources/js/qnaView.js"></script>
</html>