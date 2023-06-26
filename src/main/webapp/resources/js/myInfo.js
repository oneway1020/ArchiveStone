// 비밀번호 변경하기 누르면
$("#userPassCheck").click(function () {
  location.href = `/accounts/myInfo/changePass`;
});

// 현재 비밀번호 입력창이 바뀌면
function bibunbakkum() {
  $("#checkOK").val("");
}
// 회원탈퇴를 누르면
$("#userRemove").click(function () {
  location.href = `/accounts/myInfo/removeIDPassCheck`;
});
function checkPassForRemoveID() {
  var checkPass = $("#checkPass").val();
  $.ajax({
    url: "/accounts/myInfo/PassCheck",
    type: "post",
    data: { m_pass: checkPass },
    success: function (data) {
      if (data == 1) {
        alert("비밀번호가 일치합니다.");
        if (
          confirm(
            "아이디를 삭제한 뒤에는 게시글을 삭제하실 수 없습니다.\n\n정말 삭제하시겠습니까?"
          )
        ) {
          $.ajax({
            url: "/accounts/myInfo/removeID",
            type: "get",
            success: function (data) {
              if (data == 1) {
                alert("아이디가 삭제되었습니다.");
                location.replace("/");
              } else {
                alert(
                  "아이디 삭제에 실패하였습니다.\n\n잠시후 다시 시도해주세요."
                );
              }
            },
            error: function (e) {
              alert("아이디 삭제 에러: " + e);
            },
          });
        }
      } else {
        alert("비밀번호를 틀리셨습니다.");
        return false;
      }
    },
    error: function (e) {
      alert("비밀번호 확인 에러: " + e);
    },
  });
}
// 비밀번호 맞는지 체크 (수정용)
function checkPassForModify() {
  var checkPass = $("#checkPass").val();

  // 입력한 비밀번호와 아이디가 일치하는지 확인
  $.ajax({
    url: "/accounts/myInfo/PassCheck",
    type: "post",
    data: { m_pass: checkPass },
    success: function (data) {
      if (data == 1) {
        alert("비밀번호가 일치합니다.");
        $("#checkOK").val("y");
      } else {
        alert("비밀번호를 틀리셨습니다.");
        return false;
      }
    },
  });
}

// 바꿀 비밀번호 입력하고 변경하기 눌렀을때
$("#changePassBtn").click(function () {
  var changeCheckPass = $("#changeCheckPass").val();
  var userM_id = $("#userM_id").val();

  if ($("#checkOK").val() != "y") {
    alert("현재 비밀번호 확인을 완료해주세요");
    return false;
  }

  $.ajax({
    url: "/accounts/myInfo/PassChange",
    type: "post",
    data: { m_pass: changeCheckPass },
    success: function (data) {
      if (data == 1) {
        alert("비밀번호 변경이 완료되었습니다..");
        location.replace(`/accounts/myInfo/${userM_id}`);
      } else {
        alert("비밀번호 변경에 실패했습니다.");
      }
    },
    error: function (e) {
      alert("에러: " + e);
    },
  });
});

// 게시글 누르면
$(".recordWrapper").click(function () {
  var record_b_Idx = $(this).attr("id");
  // 선택한 게시글의 bc_code값
  var bc_code = $(this)
    .find("#recordBc_code_" + record_b_Idx)
    .val();
  // 선택한 게시글의 b_num값
  var b_num = $(this)
    .find("#recordB_num_" + record_b_Idx)
    .val();
  location.href = "/board/view?bc_code=" + bc_code + "&b_num=" + b_num;
});

// 댓글 누르면
$(".commentWrapper").click(function () {
  var comment_co_idx = $(this).attr("id");
  // 선택한 댓글의 bc_code값
  var bc_code = $(this)
    .find(".commentBc_code_" + comment_co_idx)
    .val();
  // 선택한 댓글의 b_num값
  var b_num = $(this)
    .find(".commentB_num_" + comment_co_idx)
    .val();
  location.href = "/board/view?bc_code=" + bc_code + "&b_num=" + b_num;
});

// 게시글 목록 제목을 누르면
$("#recordListTitle").click(function () {
  location.href = "/accounts/myInfo/recordList";
});

// 댓글 목록 제목을 누르면
$("#commentListTitle").click(function () {
  location.href = "/accounts/myInfo/commentList";
});

// recordListForm에서 검색폼 전송
function searchUserRecord() {
	var	formObj = $("#formList");
	var	searchKeyword	= $("#searchKeyword").val();
	
	formObj.find("[name='keyword']").val(searchKeyword);
	formObj.find("[name='page']").val("1");
	
	formObj.submit();
}
// commentListForm에서 검색폼 전송
function searchUserComment() {
	var	formObj = $("#formList");
	var	searchKeyword	= $("#searchKeyword").val();
	
	formObj.find("[name='keyword']").val(searchKeyword);
	formObj.find("[name='page']").val("1");
	
	formObj.submit();
}