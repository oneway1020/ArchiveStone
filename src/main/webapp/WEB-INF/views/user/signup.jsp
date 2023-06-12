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
<title>회원가입</title>
</head>
	<style>
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	@import url("//fonts.googleapis.com/earlyaccess/nanumgothic.css");
			
			input[type=password]{
				font-family:"Nanum Gothic", sans-serif !important;
			}
			input[type=password]::placeholder {
				font-family: 'Jeju Gothic', sans-serif; 
			}
			input[type=text]{
				font-family: 'Jeju Gothic', sans-serif; 
			}
			input[type=text]::placeholder {
				font-family: 'Jeju Gothic', sans-serif; 
			}	
			input[type=number]{
				font-family: 'Jeju Gothic', sans-serif; 
			}
			input[type=number]::placeholder {
				font-family: 'Jeju Gothic', sans-serif; 
			}				
			input[type=email]{
				font-family: 'Jeju Gothic', sans-serif; 
			}
			input[type=email]::placeholder {
				font-family: 'Jeju Gothic', sans-serif; 
			}	
			button[type=button]{
				font-family: 'Jeju Gothic', sans-serif; 
				font-size: 14px;
			}			
			button[type=submit]{
				font-family: 'Jeju Gothic', sans-serif;
				font-size: 13px;
			}			
			main {
				min-width: 600px;
				margin-top: 50px;
			}
			#memberForm, #memberForm div{
				max-width: 500px;
				min-width: 300px;
			}
			#memberForm {
				border: 3px solid rgba(220, 220, 220, 1); 
				padding: 20px 20px;
				margin: 0px auto;
			}
			#memberForm input{
				height: 50px;
			}
			#memberForm > .input-group:first-child {
				margin-top: 10px
			}
			#memberForm > .input-group {
				margin-bottom: 15px
			}
			#memberForm > .form-group {
				margin-top: 30px;
				text-align: center;
			}
			#passCheck, #checkid {
				float:right;
				margin-top:5px;
			}
	</style>
	<script src="/resources/js/signup.js"></script>
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
	<main class="container">
		<div>
			<form class="form-horizontal"  id="memberForm">
				<div class="input-group">
					<span class="input-group-text">
						<i class="bi bi-person fs-5"></i>
					</span>
					<input type="text" class="form-control" id="id" name="m_id" oninput="changeID();" placeholder="아이디"/>					
					<button class="idCheck btn btn-outline-success" type="button" id="idCheck" onclick="checkID();">중복확인
					</button>
				</div>
				<p id="checkid"></p>
				<input type="hidden" id="checked_id" value="">
				<div class="input-group">
					<span class="input-group-text">
						<i class="bi bi-lock fs-5"></i>
					</span>
					<input type="password" class="form-control" id="password" name="m_pass" placeholder="비밀번호(4자리 이상)"/>
				</div>
				<p id="passCheck"></p>
				<div class="input-group">
					<span class="input-group-text">
						<i class="bi bi-lock-fill fs-5"></i>
					</span>
					<input type="password" class="form-control" id="passwordRe" name="passwordRe" oninput="checkPass();" placeholder="비밀번호 재확인"/>
				</div>
				<div class="input-group">
					<span class="input-group-text">
						<i class="bi bi-person-circle fs-5"></i>
					</span>
					<input type="text" class="form-control" id="name" name="m_name" placeholder="닉네임"/>
				</div>
				<div class="form-group btn-group-lg">
					<button class="btn btn-secondary cancel" type="button" style="width:75px; height:38px;" onclick="location.href='/'">취소</button>
					<button id="button" class="btn btn-success ms-1" type="button" style="width:85px; height:38px;" onclick="signUp();">회원가입</button>
				</div>
			</form>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>