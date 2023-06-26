<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	<main class="container" style="margin-top: 100px;">
		<input id="userM_id" hidden="hidden" value="${user.m_id}"/>
		<div id="passBox">
			<div id="wrapper">
				<div id="nowspanWrapper">
					<span>비밀번호를 입력해주세요</span>
				</div>
				<div id="nowinputWrapper">
					<input id="checkPass" type="password" oninput="bibunbakkum();"/>
					<button type="button" onclick="checkPassForRemoveID();">비밀번호 확인</button>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script src="/resources/js/myInfo.js"></script>
</html>