<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 제작</title>
</head>
<body>
	<jsp:include page="../common/adminHeader.jsp" flush="false"/>
	
	<main class="container" style="margin-top: 100px;">
		<h1>게시판 만들자!</h1>
		<input id="bc_code" name="bc_code"/>
		<input id="bc_name" name="bc_name"/>
	</main>
	
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>