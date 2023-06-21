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
      var commentHTML = "";
      var commentCnt = 0;
      // alert(data); //[object Object],[object Object] ...
      // if (data.length > 0) {
      // commentHTML += "<div style='margin-bottom:10px;'></div>";
      //   for (let i = 0; i < data.length; i++) {
      //     commentHTML += "<div class='mb-2'>";

      //     commentHTML += "<h6><strong>" + data[i].m_name + " (" + data[i].m_ip + ")</strong></h6>";
      //     commentHTML += "<h6><strong>" + data[i].co_content + "</strong></h6>";
      //     commentHTML += "</div>";
      //     commentHTML += "<hr>";
      //   }
      // } else {

      //   commentHTML += "<div class='mb-2' style='height: 100px; display : flex; justify-content : center; align-items : center;'>";
      //   commentHTML += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
      //   commentHTML += "</div>";
      // }
      $("#commentCount").html(commentCnt);
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
	
	if(m_name.length < 2) {
		alert("닉네임은 2자리 이상으로 해주세요");
		return false;
	}
	
	if(m_name.length > 20) {
		alert("닉네임은 20자리 이하로 해주세요");
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
    },
    success: function (data) {
      if (data == 1) {
        alert("게시글 등록이 완료되었습니다.");
        commentLoad();
      } else {
        alert("게시글 등록에 실패하였습니다.\n\n잠시후 다시 시도해주세요.");
      }
    },
    error: function (e) {
      alert("error: " + e);
    },
  });
}
