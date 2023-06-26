<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>

<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	<main class="container" style="margin-top: 100px;">
		<input id="userM_id" hidden="hidden" value="${user.m_id}"/>
		<div id="passBox">
			<div id="wrapper">
			<div id="nowspanWrapper">
				<span>현재 비밀번호를 입력해주세요</span>
			</div>
			<div id="nowinputWrapper">
				<input id="checkPass" type="password" oninput="bibunbakkum();"/>
				<button type="button" onclick="checkPassForModify();">비밀번호 확인</button>
				<input hidden="hidden" id="checkOK" value="">
			</div>
			<div id="changespanWrapper">
				<span>바꿀 비밀번호를 입력해주세요</span>
			</div>
			<div id="changeinputWrapper">
				<input id="changeCheckPass" type="password"/>
			</div>
			<div id="btnWrapper">
				<button type="button" id="changePassBtn" class="btn btn-primary">비밀번호 변경하기</button>
				<button type="button" id="goBackBtn" class="btn btn-secondary" onclick="history.back(); return false;">취소</button>
			</div>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script src="/resources/js/myInfo.js"></script>
</html>