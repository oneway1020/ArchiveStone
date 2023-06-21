<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>

<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	
	<input id="bc_code" hidden="hidden" value="${bc_code}"/>
	<main style="margin-top: 20px;">
		<div class="container">
			<!-- action을 안쓰고 form정보 이동 -->
			<form class="form-horizontal" id="boardRegisterForm">
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-5">
						<h2 align="center">게시글 등록</h2>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">제  목</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="title" name="title" maxlength="200" placeholder="제목"/>
					</div>
				</div>
				<div class="form-group">
					<c:choose>
						<c:when test="${user != null}">
							<label class="col-sm-2 control-label">작 성 자</label>
							<div class="col-sm-4" style="user-select: none">
								<input style="font-weight: bold; cursor: default;" type="text" class="form-control" id="m_name" name="m_name" maxlength="20" value="${user.m_name}" disabled/>
							</div>
							<input hidden="hidden" type="password" id="m_pass" name="m_pass" value="${user.m_pass}"/>
							<input hidden="hidden" type="text" id="m_id" name="m_id" value="${user.m_id}"/>
						</c:when>
						<c:otherwise>
							<div style="float:left;">
								<label class="control-label">작 성 자</label>
								<div>
									<input type="text" class="form-control" id="m_name" name="m_name" maxlength="10" placeholder="글쓴이"/>
								</div>
								<div style="margin-top: 3px;">
									<input type="password" class="form-control" id="m_pass" name="m_pass" maxlength="10" placeholder="비밀번호"/>
								</div>
								<input hidden="hidden" type="text" id="m_id" name="m_id" value="Anonymous"/>
							</div>
							<div style="clear:both;"></div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">내  용</label>
					<div class="col-sm-8">
						<textarea style="resize: none;" rows="12" class="form-control"
						id="ckeditor" name="content" maxlength="1000"></textarea>
					</div>
					<script>
					CKEDITOR.replace('ckeditor', {			// 해당 이름으로 된 textarea에 에디터를 적용
						width:'100%',
						height:'400px',
						filebrowserUploadUrl: "/board/fileupload"	// 컨트롤러와 연결해줄 코드
					});
					</script>
				</div>
				<div class="form-group" style="margin-top: 20px;">
					<div class="col-sm-8">
						<button style="float:right;"type="button" class="btn btn-primary" onclick="boardRegisterBtn();">게시글 등록</button>
					</div>
					<div style="clear:both;"></div>
				</div>
			</form>
		</div>
	</main>
	
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script src="/resources/js/boardRegister.js"></script>
</html>