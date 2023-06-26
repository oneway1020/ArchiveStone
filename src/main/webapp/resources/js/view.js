$(function () {
  commentLoad();
});

// 수정할 경우
function modifyRecord(bc_code, b_num) {
  location.href = "/board/modify?bc_code=" + bc_code + "&b_num=" + b_num;
}

// 삭제할 경우
function deleteRecord(bc_code, b_num) {
  location.href = "/board/delete?bc_code=" + bc_code + "&b_num=" + b_num;
}

// 추천버튼을 눌렀을 경우
function goodBtn(bc_code, b_num) {
  let good = 1;
  let good_bc_code = bc_code;
  let good_b_num = b_num;

  $.ajax({
    type: "POST",
    url: "/board/goodBadCheck",
    cache: false,
    data: {
      good: good,
      bc_code: good_bc_code,
      b_num: good_b_num,
    },
    success: function (data) {
      if (data == "") {
        alert("해당 아이피에서 이미 추천했습니다.");
      } else {
        alert("추천을 눌렀습니다.");
        $("#good_p").text(data.goodCount);
      }
    },
    error: function () {
      alert("에러발생");
    },
  });
}

// 비추버튼을 눌렀을 경우
function badBtn(bc_code, b_num) {
  let bad = 1;
  let bad_bc_code = bc_code;
  let bad_b_num = b_num;

  $.ajax({
    type: "POST",
    url: "/board/goodBadCheck",
    cache: false,
    data: {
      bad: bad,
      bc_code: bad_bc_code,
      b_num: bad_b_num,
    },
    success: function (data) {
      if (data == "") {
        alert("해당 아이피에서 이미 비추천했습니다.");
      } else {
        alert("비추천을 눌렀습니다.");
        $("#bad_p").text(data.badCount);
      }
    },
    error: function () {
      alert("에러발생");
    },
  });
}

// 댓글 리로딩 함수
function commentLoad() {
  var bc_code = $("#hiddenBc_code").val();
  var b_num = $("#hiddenB_num").val();

  $.ajax({
    type: "get",
    url: "/comment/commentLoad",
    cache: false,
    data: {
      bc_code: bc_code,
      b_num: b_num,
    },
    success: function (data) {
      $("#commentList").html(data);
    },
    error: function (e) {
      alert("error: " + e);
    },
  });
}

// 댓글 등록
function commentRegister() {
  var bc_code = $("#hiddenBc_code").val();
  var b_num = $("#hiddenB_num").val();
  var m_id = $("#m_id").val();
  var m_name = $("#commentNameInput").val();
  var m_pass = $("#commentPass").val();
  var co_content = $("#commentContent").val();

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
      bc_code: bc_code,
      b_num: b_num,
      m_id: m_id,
      m_name: m_name,
      m_pass: m_pass,
      co_content: co_content,
      co_depth: 0,
    },
    success: function (data) {
      if (data == 1) {
        alert("댓글 등록이 완료되었습니다.");
        $("#commentContent").val("");
        commentLoad();
      } else {
        alert("댓글 등록에 실패하였습니다.\n\n잠시후 다시 시도해주세요.");
      }
    },
    error: function (e) {
      alert("error: " + e);
    },
  });
}
