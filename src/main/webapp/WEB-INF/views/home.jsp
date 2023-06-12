<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>아카이브스톤</title>
</head>
<style>
	#loginBox {
		width: 260px;
		height: 120px;
		display:block;
		float:right;
		border-style: solid;
		border-width: 2px;
		border-color: #808080;
	}
	#loginBox a:hover {
		color: #808080;
	}
	
	#id {
		width: 145px; height: 37px; margin: 10px 10px; 
		background-color: rgba(230, 230, 230, 0.5);
		border:none;
	}
	
	#pass {
		width:145px; height: 37px; margin: 10px 10px;
		background-color: rgba(230, 230, 230, 0.5);
		border:none;
	}
	
	#loginName {
		width:240px; height: 37px; margin: 10px 10px;
		background-color: rgba(230, 230, 230, 0.5);
		border:none;
		pointer-events: none;
		word-break:break-all;
		text-align: center;
		line-height: 37px;
	}
	
	#id::placeholder, #pass::placeholder {
		color: #585858;
	}
	
	#id:focus::placeholder, #pass:focus::placeholder {
		color:transparent;
	}
	
	#id:hover, #pass:hover {
		cursor: default;
	}
	
	#id:focus, #pass:focus {
		outline:none;
	}
	

	#loginBtn {
		width:80px; height: 37px; float:right; margin-top: 10px; margin-right: 10px;
	}
	#logoutBtn {
		width:100px; height: 37px; float:right; margin-top: 10px; margin-right: 10px;
	}
	
	main {
		margin-top: 20px;
	}
</style>
<%-- 홈화면에서는 container를 작게 모아주는 형태로 보여준다. 참조한 header.jsp에 부트스트랩 불러오기가 있어서 밑에다가 css파일 참조했음 --%>


<body>
	<jsp:include page="./common/header.jsp" flush="false"/>
	<link rel="stylesheet" href="/resources/css/customContainerForHome.css">	
	
	<main class="container">
		<c:choose>
			<c:when test="${user != null }"> 
				<form id="logoutForm">
					<div id="loginBox">
						<div id="loginName">
							${user.m_name}님
						</div>
						<button id="logoutBtn"class="btn btn-secondary" onclick="logout();">로그아웃</button>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<form id="loginForm">
					<div id="loginBox">
						<input id="id" name="m_id" placeholder=" 아이디"/>
						<div>
							<input id="pass" name="m_pass" placeholder=" 비밀번호"/>
							<button id="loginBtn"class="btn btn-primary" onclick="login();">로그인</button>
						</div>
						<a style="float:right; cursor:pointer; margin-top:5px;"onclick="location.href='/accounts/signUpForm';"><b>회원가입</b></a>
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	<h1>
		Hello world!  
	</h1>
	<P>  The time on the server is ${serverTime}. </P>
	<P>  Your IP address = ${ip}</P>
	</main>
	
	<jsp:include page="./common/footer.jsp" flush="false"/>
</body>
<script src="/resources/js/loginLogout.js"></script>


</html>
