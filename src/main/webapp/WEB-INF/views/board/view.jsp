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
	#good_bad_box {
		position: absolute;
		width: 300px;
		height: 150px;
		left: 50%;
		margin-left: -150px;
		border: 1px groove #808080;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	#good_bad_icon {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	#good_bad_icon p {
		margin-bottom: 0;
	}

	.bi-hand-thumbs-up-fill, .bi-hand-thumbs-down-fill {
		font-size: 40px;
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
</style>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	
	<main class="container" style="margin-top: 20px;">
	
	<h3 style="margin-bottom: 20px;"><a style="color: black; text-decoration: none;" href='<c:url value="/board/record?bc_code=${pageMaker.cri.bc_code}"/>'>${recordList[0].bc_name} 게시판</a></h3>
	<input hidden="hidden" id="hiddenBc_code" value="${recordOne.bc_code}"/>
	<input hidden="hidden" id="hiddenB_num" value="${recordOne.b_num}"/>
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
					<span>조회수 ${recordOne.b_cnt }&nbsp;|</span>
					<span>추천수 ${recordOne.b_good }&nbsp;|</span>
					<span>댓글 ${recordOne.b_reply }</span>
				</div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<!-- 글 본문 -->
		<div id="editor_content">
			<div>${recordOne.content}</div>
		</div>
		<div id="good_bad_box_wrapper" style="height:200px;">
			<div id="good_bad_box">
				<div id="good_bad_icon">
						<div id="good_p_wrapper">
							<p align="center">추천수</p>
							<p id="good_p" align="center">${recordOne.good}</p>
						</div>
						<div id="good_bad_btn">
							<button type="button" class="btn btn-light" onclick="goodBtn('${recordOne.bc_code}', '${recordOne.b_num}');"><i class="bi bi-hand-thumbs-up-fill"></i></button>
							<button type="button" class="btn btn-light" onclick="badBtn('${recordOne.bc_code}', '${recordOne.b_num}');"><i class="bi bi-hand-thumbs-down-fill"></i></button>
						</div>
						<div id="bad_p_wrapper">
							<p align="center">비추수</p>
							<p id="bad_p" align="center">${recordOne.bad}</p>
						</div>
				</div>
			</div>
		</div>

		<div id="commentList">
		</div>
		
		<div id="commentInput">
			<div id="commentUserInput">
				<c:choose>
					<c:when test="${user != null }">
						<input id="commentNameInput" class="loginUserCommentName" value="${user.m_name}"/>
						<input hidden="hidden" id="m_id" name="m_id" value="${user.m_id}"/>
					</c:when>
					<c:otherwise>
						<div>
							<input style="margin-bottom: 5px;" id="commentNameInput" placeholder="닉네임"/>
						</div>
						<div>
							<input id="commentPass" type="password" placeholder="비밀번호"/>
						</div>
						<input hidden="hidden" id="m_id" name="m_id" value="Anonymous"/>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="commentTextInput">
				<textarea id="commentContent" rows="3" cols="95" style="resize: none;"></textarea>
				<div style="clear:both;"></div>
				<button style="float: right;" type="button" class="btn btn-primary" onclick="commentRegister();">등록</button>
			</div>
			<div style="clear:both;"></div>
		</div>
	</div>	
	
		<div class="postTypeBtnWrapper">
			<button class="btn btn-primary" type="button" onclick="total('${recordOne.bc_code}');">전체글</button>
			<button class="btn btn-secondary" type="button" onclick="recommend('${recordOne.bc_code}');">인기글</button>
		</div>
		<div class="writeBtnWrapper">
			<c:choose>
				<c:when test="${recordOne.m_id != null && recordOne.m_id != 'Anonymous' }">
					<c:if test="${recordOne.m_id == user.m_id }">
						<button class="btn btn-secondary" type="button" onclick="modifyRecord('${recordOne.bc_code}', '${recordOne.b_num}');">수정</button>
						<button class="btn btn-secondary" type="button" onclick="deleteRecord('${recordOne.bc_code}', '${recordOne.b_num}');">삭제</button>
					</c:if>
				</c:when>
				<c:otherwise>
					<button class="btn btn-secondary" type="button" onclick="modifyRecord('${recordOne.bc_code}', '${recordOne.b_num}')">수정</button>
					<button class="btn btn-secondary" type="button" onclick="deleteRecord('${recordOne.bc_code}', '${recordOne.b_num}')">삭제</button>
				</c:otherwise>
			</c:choose>
			<button class="btn btn-light" type="button" onclick="recordRegister('${recordOne.bc_code}');">글쓰기</button>
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
						<th class="col-sm-1 text-center">조회수</th>
						<th class="col-sm-1 text-center">추천수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${recordList == null || recordList =='[]'}">
							<td valign="middle" align="center" height="200" colspan="6">게시글이 없습니다.</td>
						</c:when>
						<c:otherwise>
								<c:forEach var="recordList" items="${recordList}">
								<!-- writetime에서 시간만 꺼내기 -->
								<c:set var="writeTime_TIME"><fmt:formatDate value="${recordList.writetime}" pattern="HH:mm"/></c:set>
								<!-- writetime에서 일 만 꺼내기 -->
								<c:set var="writeTime_DAY"><fmt:formatDate value="${recordList.writetime}" pattern="dd"/></c:set>
								<!-- writetime에서 월 일 꺼내기 -->
								<c:set var="writeTime_MONTH_DAY"><fmt:formatDate value="${recordList.writetime}" pattern="MM.dd"/></c:set>
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
										<td align="center">${recordList.b_num}</td>
										<td><a class="title_a" onclick="goRecordDetail('${recordOne.bc_code}', '${recordList.b_num}');">${recordList.title}</a></td>
										<c:choose>
											<c:when test="${recordList.m_id ne null and recordList.m_id ne 'Anonymous'}">
												<td align="right"><b>${recordList.m_name} (${recordList.m_ip})</b></td>
											</c:when>
											<c:otherwise>
												<td align="right">${recordList.m_name} (${recordList.m_ip})</td>
											</c:otherwise>
										</c:choose>
										<td align="right">${day_comparison}</td>
										<td align="right">${recordList.b_cnt}</td>
										<td align="right">${recordList.b_good}</td>
									</tr>
								</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</form>


		<div class="postTypeBtnWrapper">
			<button class="btn btn-primary" type="button" onclick="total('${recordOne.bc_code}');">전체글</button>
			<button class="btn btn-secondary" type="button" onclick="recommend('${recordOne.bc_code}');">인기글</button>
		</div>
		<div class="writeBtnWrapper">
			<button class="btn btn-light" type="button" onclick="recordRegister('${recordOne.bc_code}');">글쓰기</button>
		</div>
		<div style="clear:both;"></div>
			
			
			
				
		<!-- 페이징 버튼 -->
		<div style="display: flex; justify-content: center; align-items: center; margin-top: 20px;">
			<ul class="btn-group pagination">
			    <c:if test="${pageMaker.prev}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/board/record?bc_code=${recordOne.bc_code}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.startPage-1}"/>'><i class="bi bi-chevron-double-left"></i></a>
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
						        <a class="btn btn-outline-secondary" href='<c:url value="/board/record?bc_code=${recordOne.bc_code}&searchType=${param.searchType}&keyword=${param.keyword}&page=${pageNum}"/>'><i>${pageNum}</i></a>
						    </li>
						</c:otherwise>
					</c:choose>
			    </c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    <li>
				        <a class="btn btn-outline-secondary" href='<c:url value="/board/record?bc_code=${recordOne.bc_code}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}&page=${pageMaker.endPage+1}"/>'><i class="bi bi-chevron-double-right"></i></a>
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
				<option value="u" <c:if test="${pageMaker.cri.searchType == 'u'}">selected</c:if>>글쓴이</option>
			</select>
			<input type='text' id='searchKeyword' value="${pageMaker.cri.keyword}" onkeypress="if( event.keyCode == 13 ){searchRecord();}">
			<button class="btn btn-primary" type="button" id='searchBtn' onclick="searchRecord();">검색</button> 
		</div>
		<!-- 검색데이터 넣어놓는 hidden input -->
		<form id="formList" action="/board/record" method="get">
			<input type="hidden" name="page"/>
			<input type="hidden" name="searchType"/>
			<input type="hidden" name="keyword"/>
			<input type="hidden" name="bc_code" value="${pageMaker.cri.bc_code}"/>
		</form>

	</main>
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script src="/resources/js/record.js"></script>
<script src="/resources/js/view.js"></script>
</html>