<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	td>i:hover {
		cursor:pointer;
	}
</style>

<table class="table">
	<tbody >
		<c:choose>
			<c:when test="${commentList == null || commentList =='[]'}">
			<tr>
				<td valign="middle" align="center" height="100px;">댓글이 없습니다.</td>
			<tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${commentList}" var="comment">
				<!-- DB co_writedate 값 패턴변경 -->
				<c:set var="writeTime"><fmt:formatDate value="${comment.co_writedate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:set>
					<tr>
						<c:choose>
						<c:when test="${comment.m_id ne 'Anonymous'}">
							<td class="col-sm-1"align="left">
								<b>${comment.m_name} ${comment.m_ip}</b>
							</td>
						</c:when>
						<c:otherwise>
							<td class="col-sm-1"align="left">
								${comment.m_name} ${comment.m_ip}
							</td>
						</c:otherwise>
						</c:choose>
						<td class="col-sm-4" align="left">
							${comment.co_content}
						</td>
						<td class="col-sm-1" align="right">
							&nbsp;<c:out value="${writeTime}"/>
							<c:choose>
								<c:when test="${comment.m_id ne 'Anonymous' }">
									<c:if test="${user.m_id eq comment.m_id }">
										&nbsp;<i class="bi bi-x"></i>
									</c:if>
								</c:when>
								<c:otherwise>
									&nbsp;<i class="bi bi-x"></i>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>

<!-- 페이징 버튼 -->
<%--
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
 --%>		