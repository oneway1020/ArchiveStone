<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 목록</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	
	<main class="container">
	<c:choose>
		<c:when test="${empty boardList}">
			<p>정보가 없습니다.</p>
		</c:when>
		<c:otherwise>
			<p>${boardList}</p>
		</c:otherwise>
	</c:choose>
	</main>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>