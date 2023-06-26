<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 제작</title>
</head>
<style>
	#formWrapper {
		display:flex;
		justify-content: center;
		align-items: center;
	}
	form {
		height: 200px;
		width:	400px;
		border:	2px solid rgba(80,80,80,0.5);
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
<body>
	<jsp:include page="../common/adminHeader.jsp" flush="false"/>
	
	<main class="container" style="margin-top: 100px;">
		<h1>게시판 만들자!</h1>
		<div id="formWrapper">
			<form>
				<div>
					<div>
						<span>게시판 코드: </span><input id="bc_code" name="bc_code"/>
					</div>
					<div>
						<span>게시판 이름: </span><input id="bc_name" name="bc_name"/>
					</div>
					<button id="createBoard" style="float:right; margin-top: 10px;" type="button" class="btn btn-primary">게시판 생성</button>
				</div>
			</form>
		</div>
	</main>
	
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script>
	$("#createBoard").click(function(){
		// 자바스크립트 정규식: 띄어쓰기 체크
		var reg = /\s/g;
		if($("#bc_code").val().length < 4) {
			alert("게시판 코드는 4자리 이상이어야 합니다.");
			$("#bc_code").focus();
			return false;
		}
		if($("#bc_code").val().match(reg)) {
			alert("게시판 코드에는 띄어쓰기가 없어야 합니다.");
			$("#bc_code").focus();
			return false;
		}
		
		
		if($("#bc_name").val().length < 2) {
			alert("게시판 이름은 2자리 이상이어야 합니다.");
			$("#bc_name").focus();
			return false;
		}
		if($("#bc_name").val().match(reg)) {
			alert("게시판 이름에는 띄어쓰기가 없어야 합니다.");
			$("#bc_name").focus();
			return false;
		}
		
		if(confirm("해당 게시판을 생성하시겠습니까?")) {
			$.ajax({
				url: "/admin/createResponse",
				type: "post",
				data: {
					bc_code: $("#bc_code").val(),
					bc_name: $("#bc_name").val(),
				},
				success: function (data) {
					if(data == 1) {
						alert("게시판 등록이 완료되었습니다.");
						location.replace("/");
					} else {
						alert("게시판 등록에 실패하였습니다.\n\n잠시후 다시 시도해주세요.");
					}
				},
				error: function(e) {
					alert("에러발생: " + e);
				}
			});
		}
	});
</script>
</html>