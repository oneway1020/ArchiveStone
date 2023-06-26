<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="false"/>
	<main class="container">
		<!-- 유저 목록 정보 -->
		<!-- 검색버튼 -->
		<div style="float:right;">
			<div class="col-sm-offset-3"style="display: flex; justify-content: center; align-items: center;">
				<label>검색 아이디</label>
				<input style="margin-right:10px; margin-left:10px;" type='text' id='searchKeyword' value="${pageMaker.cri.keyword}" onkeypress="if( event.keyCode == 13 ){searchUserInfo();}">
				<button class="btn btn-primary" type="button" id='searchBtn' onclick="searchUserInfo();">검색</button> 
			</div>	
		</div>
		<div style="clear:both;"></div>	
		<form id="recordList" class="form-horizontal">
			<table class="table">
				<thead>
					<tr>
						<th class="col-sm-3 text-center">유저아이디</th>
						<th class="col-sm-3 text-center">유저닉네임</th>
						<th class="col-sm-3 text-center">가입아이피</th>
						<th class="col-sm-2 text-center">가입일</th>
						<th class="text-center"></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${userList.size() == 0 }">
							<td valign="middle" align="center" height="200" colspan="5">가입한 유저 정보가 없습니다.</td>
						</c:when>
						<c:otherwise>
								<c:forEach var="user" items="${userList}">
									<c:set var="join_day"><fmt:formatDate value="${user.j_time}" pattern="yyyy.MM.dd"/></c:set>							
									<tr>
										<td id="m_id_${user.m_idx}"align="center">${user.m_id}</td>
										<td id="m_name_${user.m_idx}" align="center">${user.m_name}</td>
										<td align="center">${user.j_ip}</td>
										<td align="center">${join_day}</td>
										<td align="right"><i id="${user.m_idx}" style="cursor:pointer;"class="bi bi-x-square-fill"></i></td>
									</tr>
								</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</form>
		
		<!-- 검색버튼 -->
		<div style="float:right;">
			<div class="col-sm-offset-3"style="display: flex; justify-content: center; align-items: center;">
				<label>검색 아이디</label>
				<input style="margin-right:10px; margin-left:10px;" type='text' id='searchKeyword' value="${pageMaker.cri.keyword}" onkeypress="if( event.keyCode == 13 ){searchUserInfo();}">
				<button class="btn btn-primary" type="button" id='searchBtn' onclick="searchUserInfo();">검색</button> 
			</div>
		</div>
		<div style="clear:both;"></div>
		<!-- 검색데이터 넣어놓는 hidden input -->
		<form id="formList" action="/admin/userInfo" method="get">
			<input type="hidden" name="keyword"/>
		</form>
	</main>	
	<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
<script>
	function searchUserInfo() {
		var searchKeyword = $("#searchKeyword").val();
		var	formObj = $("#formList");
		formObj.find("[name='keyword']").val(searchKeyword);
		formObj.submit();
	}
	$(".bi-x-square-fill").click(function() {
		var m_idx	= $(this).attr("id");
		var m_id	= $(this).parent().siblings("#m_id_" + m_idx).text();
		var m_name	= $(this).parent().siblings("#m_name_" + m_idx).text();
		alert(m_idx);
		if(confirm("해당회원을 탈퇴시키겠습니까?\n\n아이디: " + m_id + "\n\n닉네임: " + m_name)) {
			$.ajax({
				type:	"post",
				url:	"/admin/deleteUser",
				cache:	false,
				data:	{
					m_idx:	m_idx
				},
				success: function(data) {
					if(data == 1) {
						alert("회원이 삭제되었습니다.");
						location.reload(true);
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