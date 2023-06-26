// 게시글 등록 버튼
// ckeditor는 v4.21.0 버전이다.
function boardRegisterBtn() {
  let bc_code = $("#bc_code").val();
  let title = $("#title").val();
  let userName = $("#m_name").val();
  let pass = $("#m_pass").val();
  let contentObj = CKEDITOR.instances.ckeditor;
  let content = CKEDITOR.instances.ckeditor.getData();
  let id = $("#m_id").val();

  if (title == "") {
    alert("제목을 입력해주세요");
    return false;
  }

  if (userName.length < 2) {
    alert("닉네임은 2글자 이상으로 해주세요");
    return false;
  }

  if (userName.length > 20) {
    alert("닉네임은 20글자 이하로 해주세요");
    return false;
  }

  if (pass.length < 4) {
    alert("비밀번호는 4글자 이상으로 해주세요");
    return false;
  }
  // 이미지 개수 체크
  if (checkImgLength(contentObj) == false) {
    return false;
  }

  $.ajax({
    url: "/board/boardRegister",
    type: "post",
    dataType: "json",
    data: {
      bc_code: bc_code,
      m_id: id,
      m_name: userName,
      m_pass: pass,
      title: title,
      content: content,
    },
    success: function (data) {
      if (data == 1) {
        alert("게시글이 등록되었습니다.");
        location.replace("/board/record?bc_code=" + bc_code);
      } else {
        alert("게시글 등록에 실패했습니다.\n잠시후 다시 시도해주세요.");
      }
    },
    error: function () {
      alert("현재 에러가 발생했습니다.\n잠시후 다시 시도해주세요.");
    },
  });
}

// 게시글 등록 버튼 (QnA)
function qnaboardRegisterBtn() {
  var id = $("#m_id").val();
  var m_name = $("#m_name").val();
  var title = $("#title").val();
  var content = CKEDITOR.instances.ckeditor.getData();
  var contentObj = CKEDITOR.instances.ckeditor;
  var m_idx = $("#m_idx").val();

  if (title == "") {
    alert("제목을 입력해주세요");
    return false;
  }

  // 이미지 개수 체크
  if (checkImgLength(contentObj) == false) {
    return false;
  }

  $.ajax({
    url: "/board/Q&A/boardRegister",
    type: "post",
    dataType: "json",
    data: {
      m_id: id,
      m_name: m_name,
      title: title,
      content: content,
      m_idx: m_idx,
    },
    success: function (data) {
      if (data == 1) {
        alert("게시글이 등록되었습니다.");
        location.replace("/board/Q&A/record");
      } else {
        alert("게시글 등록에 실패했습니다.\n잠시후 다시 시도해주세요.");
      }
    },
    error: function (e) {
      alert("에러발생: " + e);
    },
  });
}

// 이미지 개수 체크
function checkImgLength(obj) {
  let str = obj.getData();
  let results = str.match(/<img/g);
  let imgCnt = 0;

  if (results != null) {
    imgCnt = results.length;
    alert("이미지 개수: " + imgCnt + "장");
    if (imgCnt > 1) {
      alert("이미지는 1장까지만 업로드할 수 있습니다.");
      return false;
    } else {
      return true;
    }
  }
}
