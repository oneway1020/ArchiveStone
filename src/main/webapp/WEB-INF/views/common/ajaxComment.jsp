<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	.commentwriteTime>i:hover {
		cursor:pointer;
	}
	.comment_content:hover {
		cursor:pointer;
	}
	#noComment {
		display: flex; justify-content: center; align-items: center; height:100px;
	}
	.yesComment {
		min-height:60px; 
		display:flex; 
		align-items:center; 
		border-bottom: 1px solid rgba(80, 80, 80, .2);
	}
	.toggleHidden {
		display:none;
	}
	
	#modal {
	  position: fixed;
	  z-index: 1;
	  left: 0;
	  top: 0;
	  width: 100%;
	  height: 100%;
	  overflow: auto;
	  background-color: rgba(0, 0, 0, 0.4);
	  display: none;
	}
	.modal_content {
		background-color: #fefefe;
		margin: 15% auto;
		padding: 20px;
		border: 1px solid #888;
		width: 300px;
		height: 200px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.close {
	  color: #aaa;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	}
	.close:hover,
	.close:focus {
	  color: black;
	  text-decoration: none;
	  cursor: pointer;
	}
	.replyCommentUserInput {
		float: left;
		margin-right: 10px;
		margin-top: 10px;	
	}
	
</style>

<input hidden="hidden" id="replybc_code"	value="${param.bc_code}"/>
<input hidden="hidden" id="replyb_num"		value="${param.b_num}"/>
<input hidden="hidden" id="user_m_id" 		value="${user.m_id }"/>



<div id="modal">
  <div class="modal_content">
	<div id="wrapper">
		<input hidden="hidden" id="modal_co_idx"/>
		<input hidden="hidden" id="modal_m_id"/>
		<div id="spanWrapper">
			<span>비밀번호를 입력해주세요</span>
		</div>
		<div id="inputWrapper">
			<input id="modalPass" name="m_pass" type="password"/>
		</div>
		<div id="btnWrapper" style="margin-top: 5px; float:right;">
			<button type="button" id="deleteComment" class="btn btn-primary">삭제</button>
			<button type="button" id="close_modal" class="btn btn-secondary">닫기</button>
		</div>		
	</div>
  </div>
</div>

<div id="comment_wrapper">
	<c:choose>
		<c:when test="${commentList == null || commentList =='[]'}">
		<div id="noComment">
			댓글이 없습니다.
		</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${commentList}" var="comment">
				<c:choose>
			 		<c:when test="${comment.co_depth == 0 }">			 			
						<!-- DB co_writedate 값 패턴변경 -->
						<c:set var="writeTime"><fmt:formatDate value="${comment.co_writedate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:set>
							<div class="container yesComment">
								<c:choose>
								<c:when test="${comment.m_id ne 'Anonymous'}">
									<span class="col-sm-2">
										<b>${comment.m_name} (${comment.m_ip})</b>
									</span>
								</c:when>
								<c:otherwise>
									<span class="col-sm-2">
										${comment.m_name} (${comment.m_ip})
									</span>
								</c:otherwise>
								</c:choose>
								<!-- comment별 idx값 구하기 -->
								<input hidden="hidden" class="comment_co_idx" value="${comment.co_idx}"/>
								<!-- comment별 m_id값 구하기 -->
								<input hidden="hidden" class="comment_m_id" value="${comment.m_id}"/>
								<span class="col-sm-8 comment_content" style="margin-left: 5px;">
									${comment.co_content}
								</span>
								<span class="col-sm-2 commentwriteTime" style="text-align: right">
									&nbsp;<c:out value="${writeTime}"/>
									<c:choose>
										<c:when test="${comment.m_id ne 'Anonymous' }">
											<c:if test="${user.m_id eq comment.m_id }">
												&nbsp;<i class="bi bi-x-square"></i>
											</c:if>
										</c:when>
										<c:otherwise>
											&nbsp;<i class="bi bi-x-square"></i>
										</c:otherwise>
									</c:choose>
								</span>
							</div>
							<div style="clear:both;"></div>
					</c:when>
					<c:when test="${comment.co_depth == 1 }">
						<c:if test="${comment.msg == 'idDelete' }">
						<div class="container yesComment">
							<span class="col-sm-8" style="margin-left: 5px;">
								댓글 작성자가 삭제한 댓글입니다.
							</span>
						</div>
						</c:if>
						<!-- DB co_writedate 값 패턴변경 -->
						<c:set var="writeTime"><fmt:formatDate value="${comment.co_writedate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:set>
							<div class="container" >
								<div class="container yesComment" style="background-color:rgba(80, 80, 80, 0.2);">
								<c:choose>
								<c:when test="${comment.m_id ne 'Anonymous'}">
									<span class="col-sm-2">
										&nbsp;<i class="bi bi-arrow-return-right"></i>
										<b>${comment.m_name} (${comment.m_ip})</b>
									</span>
								</c:when>
								<c:otherwise>
									<span class="col-sm-2">
										&nbsp;<i class="bi bi-arrow-return-right"></i>
										${comment.m_name} (${comment.m_ip})
									</span>
								</c:otherwise>
								</c:choose>
								<!-- comment별 idx값 구하기 -->
								<input hidden="hidden" class="comment_co_idx" value="${comment.co_idx}"/>
								<!-- comment별 m_id값 구하기 -->
								<input hidden="hidden" class="comment_m_id" value="${comment.m_id}"/>
								<span class="col-sm-8" style="margin-left: 5px; cursor:default;">
									${comment.co_content}
								</span>
								<span class="col-sm-2 commentwriteTime" style="text-align: right">
									&nbsp;<c:out value="${writeTime}"/>
									<c:choose>
										<c:when test="${comment.m_id ne 'Anonymous' }">
											<c:if test="${user.m_id eq comment.m_id }">
												&nbsp;<i class="bi bi-x-square"></i>
											</c:if>
										</c:when>
										<c:otherwise>
											&nbsp;<i class="bi bi-x-square"></i>
										</c:otherwise>
									</c:choose>
								</span>
								</div>
							</div>
							<div style="clear:both;"></div>
					</c:when>
				</c:choose>

							
					<!-- 대댓글 창 -->
					<div id="replyCommentInputWrapper${comment.co_idx}" style="border-bottom: 1px solid rgba(80, 80, 80, .2); display: flex; justify-content: center;">
					<div class="replyCommentInput toggleHidden">
						<div class="replyCommentUserInput">
							<c:choose>
								<c:when test="${user != null }">
									<input id="commentNameInput${comment.co_idx}" class="loginUserCommentName" value="${user.m_name}"/>
									<input hidden="hidden" id="m_id${comment.co_idx}" name="m_id" value="${user.m_id}"/>
								</c:when>
								<c:otherwise>
									<div>
										<input style="margin-bottom: 5px;" id="commentNameInput${comment.co_idx}" placeholder="닉네임"/>
									</div>
									<div>
										<input id="commentPass${comment.co_idx}" type="password" placeholder="비밀번호"/>
									</div>
									<input hidden="hidden" id="m_id${comment.co_idx}" name="m_id" value="Anonymous"/>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="replyCommentTextInput">
							<textarea id="commentContent${comment.co_idx}" rows="3" cols="95" style="resize: none;"></textarea>
							<div style="clear:both;"></div>
							<button class="replyBtn btn btn-primary" style="float: right;" type="button">등록</button>
							<input hidden="hidden" value="${comment.co_idx}"/>
						</div>
						<div style="clear:both;"></div>
					</div>
					</div>
				
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>
<script>





// 흐릿한 배경 클릭하면 모달이 자동으로 none 되도록
function clickBackgroundEvent(event) {
	var modal = document.getElementById("modal");
	
	var target = event.target;
	var modal_content_Target = event.currentTarget.querySelector(".modal_content");
	
	if(target 		== modal_content_Target) { 
		return false;
	}
	
	var spanTags	= event.currentTarget.querySelector(".modal_content").querySelectorAll("span");
	var pTags		= event.currentTarget.querySelector(".modal_content").querySelectorAll("p");
	var inputTags	= event.currentTarget.querySelector(".modal_content").querySelectorAll("input");
	var buttonTags	= event.currentTarget.querySelector(".modal_content").querySelectorAll("button");
	var divTags		= event.currentTarget.querySelector(".modal_content").querySelectorAll("div");
	var AllmodalTags	= event.currentTarget.querySelector(".modal_content").querySelectorAll("span, p, input, button, div");
	
	// modal 내부의 모든 태그설정
	for(var i =0; i < AllmodalTags.length; i++) {
		if(target == AllmodalTags[i]) {
			return false;
		}
	}

	modal.style.display="none";
	$("#modalPass").val("");
	document.body.style.overflow="auto";
	
}

//.comment_content 가 클릭된다면
$(".comment_content").click(function () {
  var comment_idx = $(this).siblings(".comment_co_idx").val();
  $(this)
    .parent()
    .siblings("#replyCommentInputWrapper" + comment_idx)
    .find(".replyCommentInput")
    .toggleClass("toggleHidden");
});

// x아이콘 클릭 (여기서는 댓글, 대댓글)
$(".bi-x-square").click(function() {
	var modal = document.getElementById("modal");
	
	modal.addEventListener("click", clickBackgroundEvent);
	
	var replyBc_code	= $("#replybc_code").val();
	var replyB_num		= $("#replyb_num").val();
	// alert($(this).parent().siblings('input').val());	// 댓글 co_idx값
	$("#modal_co_idx").val($(this).parent().siblings('.comment_co_idx').val());
	$("#modal_m_id").val($(this).parent().siblings('.comment_m_id').val());
	if($("#modal_m_id").val() == "Anonymous") {
		modal.style.display="block";
		document.body.style.overflow="hidden";		
	}
	if($("#user_m_id").val() == $("#modal_m_id").val()) {
		if(confirm("삭제하시겠습니까?")) {

			 $.ajax({
				    type: "post",
				    url: "/comment/commentDelete",
				    cache: false,
				    data: {
				      bc_code:	replyBc_code,
				      b_num:	replyB_num,
				      co_idx:	$("#modal_co_idx").val(),
				    },
				    success: function (data) {
				      if (data == 1) {
				        alert("댓글 삭제가 완료되었습니다.");
				        location.reload();
				      } else {
				        alert("댓글 삭제에 실패하였습니다.\n\n잠시후 다시 시도해주세요.");
				      }
				    },
				    error: function (e) {
				      alert("error: " + e);
				    },
				  });
		} else {
			alert("취소누름");
		}
	}
});
$("#close_modal").click(function() {
	modal.style.display="none";
	$("#modalPass").val("");
	document.body.style.overflow="auto";
});
// 모달에서 삭제를 클릭하면
$("#deleteComment").click(function() {
	var replyBc_code	= $("#replybc_code").val();
	var replyB_num		= $("#replyb_num").val();
	var co_idx			= $("#modal_co_idx").val();
	var modal_pass		= $("#modalPass").val();
	
	$.ajax({
		type:	"POST",
		url:	"/comment/commentPassCheck",
		cache: false,
		data:	{
  			bc_code:	replyBc_code,
			b_num:		replyB_num,
			co_idx:		co_idx,
			m_pass:		modal_pass,
		},
		success: function (data) {
			if( data == "") {
				alert("비밀번호가 틀렸습니다.");
			} else {
				if(confirm("정말로 삭제하시겠습니까?")) {
					$.ajax({
					    type: "post",
					    url: "/comment/commentDelete",
					    cache: false,
					    data: {
					      bc_code:	replyBc_code,
					      b_num:	replyB_num,
					      co_idx:	co_idx,
					    },
					    success: function (data) {
					      if (data == 1) {
					        alert("댓글 삭제가 완료되었습니다.");
					        location.reload();
					      } else {
					        alert("댓글 삭제에 실패하였습니다.\n\n잠시후 다시 시도해주세요.");
					      }
					    },
					    error: function (e) {
					      alert("error: " + e);
					    },
					  });
				} else {
					return;
				}
			}
		},
		error: function(e) {
			alert("에러발생: " + e);
		}
	});
})


// 대댓글 버튼 클릭
$(".replyBtn").click(function() {
	var comment_idx		= $(this).siblings('input').val();
	
	var replyBc_code	= $("#replybc_code").val();
	var replyB_num		= $("#replyb_num").val();
	var replym_id		= $("#m_id" + comment_idx).val();
	var m_name			= $("#commentNameInput" + comment_idx).val();
	var m_pass			= $("#commentPass" + comment_idx).val();
	var co_content		= $("#commentContent" + comment_idx).val();	

	if (m_name.length < 2) {
	    alert("닉네임은 2자리 이상으로 해주세요");
	    return false;
	}
	
	if (m_name.length > 20) {
	    alert("닉네임은 20자리 이하로 해주세요");
	    return false;
	}
	
	if (m_pass < 4) {
	    alert("비밀번호는 4자리 이상으로 해주세요");
	    return false;
	}
	
	$.ajax({
	   type: "post",
	   url: "/comment/commentRegister",
	   cache: false,
	   data: {
	     bc_code:		replyBc_code,
	     b_num:			replyB_num,
	     m_id:			replym_id,
	     m_name:		m_name,
	     m_pass:		m_pass,
	     co_content:	co_content,
	     co_depth:		1,
	     co_group:		comment_idx,
	 },
	 success: function (data) {
	     if (data == 1) {
	       alert("댓글 등록이 완료되었습니다.");
	       $.ajax({
	    	    type: "get",
	    	    url: "/comment/commentLoad",
	    	    cache: false,
	    	    data: {
	    	      bc_code: replyBc_code,
	    	      b_num: replyB_num,
	    	    },
	    	    success: function (data) {
	    	      location.reload();
	    	    },
	    	    error: function (e) {
	    	      alert("error: " + e);
	    	    },
	    	  });
	     } else {
	       alert("댓글 등록에 실패하였습니다.\n\n잠시후 다시 시도해주세요.");
	     }
	 },
	   error: function (e) {
	     alert("error: " + e);
	   },
	 });	
});


</script>
