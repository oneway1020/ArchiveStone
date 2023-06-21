<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
</head>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<body>

	<jsp:include page="../common/header.jsp" flush="false"/>


	<main style="margin-top: 20px;">
	<input hidden="hidden" id="bc_code"	value="${param.bc_code}"/>
	<input hidden="hidden" id="b_num"	value="${param.b_num}"/>
		<div class="container">
			<!-- action을 안쓰고 form정보 이동 -->
			<form class="form-horizontal" id="boardRegisterForm">
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-5">
						<h2 align="center">게시글 수정</h2>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">제  목</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="title" name="title" maxlength="200" placeholder="제목" value="${recordOne.title}"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">작 성 자</label>
					<div class="col-sm-4" style="user-select: none">
						<input style="font-weight: bold; cursor: default;" type="text" class="form-control" id="m_name" name="m_name" maxlength="20" value="${user.m_name}" disabled/>
					</div>
					<input hidden="hidden" type="password" id="m_pass" name="m_pass" value="${user.m_pass}"/>
					<input hidden="hidden" type="text" id="m_id" name="m_id" value="${user.m_id}"/>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">내  용</label>
					<div class="col-sm-8">
						<textarea style="resize: none;" rows="12" class="form-control"
						id="ckeditor" name="content" maxlength="1000">${recordOne.content}</textarea>
					</div>
					<script>
					CKEDITOR.replace('ckeditor', {			// 해당 이름으로 된 textarea에 에디터를 적용
						width:'100%',
						height:'400px',
						filebrowserUploadUrl: "fileupload"	// 컨트롤러와 연결해줄 코드
					});
					</script>
				</div>
				<div class="form-group" style="margin-top: 20px;">
					<div class="col-sm-8">
						<button type="button" style="float:right;" class="btn btn-primary" onclick="recordUpdateBtn();">수정완료</button>
					</div>
					<div style="clear:both;"></div>
				</div>
			</form>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
<script src="/resources/js/modify.js"></script>
</html>