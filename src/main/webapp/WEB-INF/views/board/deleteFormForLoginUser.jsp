<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제하기</title>
</head>
<style>
	#passBox {
	margin: 0 auto;
	width: 400px;
	height: 200px;
	min-width: 400px;
	min-height: 200px;
	display:flex;
	justify-content: center;
	align-items: center;
	border: 2px solid #808080;
	}
	
	#pass {
		width:185px; height: 30px; margin: 5px 30px 5px 30px;
		background-color: rgba(230, 230, 230, 0.5);
		border:none;
	}
	
	#pass:hover {
		cursor:default;
	}
	
	#pass:focus {
		outline:none;
	}
	
	#spanWrapper span {
		width:185px; height: 30px; margin: 5px 30px 5px 30px;
	}
	
	#btnWrapper {
		margin-top: 5px; margin-left: 30px;
	}
	#btnWrapper button {
		width: 90px; height: 40px;
	}
</style>
<body>

	<jsp:include page="../common/header.jsp" flush="false"/>
	
	
	
	<main class="container" style="margin-top: 100px;">
	<input hidden="hidden" id="bc_code"	value="${recordOne.bc_code}"/>
	<input hidden="hidden" id="b_num"	value="${recordOne.b_num}"/>
			<div id="passBox">
				<div id="wrapper">
				<div id="spanWrapper">
					<span>삭제하시겠습니까?</span>
				</div>
				<div id="btnWrapper">
					<button type="button" id="passBtn" class="btn btn-primary" onclick="deleteDataForLoginUser();">확인</button>
					<button type="button" id="goBackBtn" class="btn btn-secondary" onclick="history.back(); return false;">취소</button>
				</div>
				</div>
			</div>
	</main>
	
	
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script src="/resources/js/delete.js"></script>
</html>