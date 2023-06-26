<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

   <!-- datepick 사용하기 위해 추가 -->
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
   <!-- end -->
	
	<!-- icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/52943f354a.js" crossorigin="anonymous"></script>

<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
</head>
	<style>
		#loginBox {
			margin: 0 auto;
			width: 754px;
			height: 352px;
			min-width: 754px;
			min-height: 352px;
			display:block;
			border-style: solid;
			border-width: 2px;
			border-color: #808080;
		}
		#id {
			width: 694px; height: 37px; margin: 60px 30px 5px 30px; 
			background-color: rgba(230, 230, 230, 0.5);
			border:none;
		}
		
		#pass {
			width:694px; height: 37px; margin: 5px 30px 5px 30px;
			background-color: rgba(230, 230, 230, 0.5);
			border:none;
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
			width:694px; height: 37px; margin: 5px 30px 30px 30px;
		}
		#signUp {
			float:right; 
			margin-right:30px;
		}
		#loginBox a:hover {
			cursor:pointer;
			color:	#808080;
		}
	</style>
<body>
	<header class="container">
		<div style="padding: 20px 0px 0px 0px; text-align: left;">
			<div id="logo">
				<a href="/" title="logo">
					<img src="/resources/images/ArchiveStone.png"/>
				</a>
			</div>
		</div>
	</header>
	<main class="container" style="margin-top: 100px;">
			<form id="loginForm" action="/accounts/login" method="POST">
				<div id="loginBox">
					<input id="id" name="m_id" placeholder=" 아이디"/>
					<div>
						<input id="pass" name="m_pass" type="password" placeholder=" 비밀번호"/>
						<button id="loginBtn"class="btn btn-primary" type="submit">로그인</button>
					</div>
					<div id="signUp">아이디가 없으신가요?
						<a onclick="location.href='/accounts/signUpForm';"><b>회원가입</b></a>
					</div>
				</div>
			</form>
	</main>
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>