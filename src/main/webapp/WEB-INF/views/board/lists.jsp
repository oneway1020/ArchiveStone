<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판 검색결과</title>
</head>
<style>
	#noInfo {
		height: 200px;
	}
	#noInfo>p {
		text-align: center;
		line-height: 200px;
	}
	.list_ul {
		list-style-type: none;	
	}

	.list_a:hover {
		cursor:pointer;
		color: #2E64FE;
	}
	.list_a, .list_a:visited, .list_a:active {
		color: #2E64FE;
	}
	
	
</style>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	
	<main class="container">
	<c:choose>
		<c:when test="${empty boardConfigList}">
			<div id="noInfo">
				<p>정보가 없습니다.</p>
			</div>
		</c:when>
		<c:otherwise>
			<p style="margin-top: 20px;">게시판 검색결과 <b>${totalCount}</b>건</p>
			<c:forEach var="list" items="${boardConfigList}">
				<ul class="list_ul">
					<li><a class="list_a" onclick="goBoard('${list.bc_code}');">${list.bc_name}</a></li>
				</ul>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</main>
	
	<jsp:include page="../common/footer.jsp"/>
</body>

<script>
	function goBoard(code) {
		alert(code);
		location.href="/board/record?bc_code="+code;
	}
</script>
</html>