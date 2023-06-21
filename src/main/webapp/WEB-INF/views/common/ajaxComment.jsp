<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	span>i:hover {
		cursor:pointer;
	}
	.comment_content:hover {
		cursor:pointer;
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

<div id="comment_wrapper">
	<c:choose>
		<c:when test="${commentList == null || commentList =='[]'}">
		<div id="noComment">
			댓글이 없습니다.
		</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${commentList}" var="comment">

			<!-- DB co_writedate 값 패턴변경 -->
			<c:set var="writeTime"><fmt:formatDate value="${comment.co_writedate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:set>
				<div class="yesComment">
					<c:choose>
					<c:when test="${comment.m_id ne 'Anonymous'}">
						<span class="col-sm-2">
							<b>${comment.m_name} (${comment.m_ip})</b>
						</span>
					</c:when>
					<c:otherwise>
						<span class="col-sm-2">
							${comment.m_name} (${comment.m_ip})
						</span>
					</c:otherwise>
					</c:choose>
					<!-- comment별 idx값 구하기 -->
					<input hidden="hidden" value="${comment.co_idx}"/>
					<span class="col-sm-8 comment_content" style="margin-left: 5px;">
						${comment.co_content}
					</span>
					<span class="col-sm-2" style="text-align: right">
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
					</span>
				</div>
				<div style="clear:both;"></div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>
<script>
//.comment_content 가 클릭된다면
$(".comment_content").click(function () {
  var comment_idx = $(this).siblings("input").val();
  alert(comment_idx);
});
</script>
