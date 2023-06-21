// 비밀번호 확인
function passBtnClick() {
  let delete_bc_code = $("#bc_code").val();
  let delete_b_num = $("#b_num").val();
  let delete_m_pass = $("#pass").val();

  $.ajax({
    type: "POST",
    url: "/board/checkDeletePass",
    cache: false,
    data: {
      m_pass: delete_m_pass,
      b_num: delete_b_num,
      bc_code: delete_bc_code,
    },
    success: function (data) {
      if (data == "") {
        alert("비밀번호가 틀렸습니다.");
      } else {
        if (
          confirm(
            "정말로 삭제하시겠습니까?\n\n삭제한 게시글은 복구되지 않습니다."
          ) == true
        ) {
          deleteData(data);
        }
      }
    },
    error: function () {
      alert("에러발생");
    },
  });
}

function deleteData(data) {
  let delete_b_num = data.b_num;
  let delete_bc_code = data.bc_code;

  $.ajax({
    type: "POST",
    url: "/board/deleteData",
    cache: false,
    data: {
      b_num: delete_b_num,
      bc_code: delete_bc_code,
    },
    success: function (data) {
      if (data == 0) {
        alert("삭제가 진행되지 않았습니다.\n\n잠시후 다시 시도해주세요.");
      } else {
        alert("삭제되었습니다.");
        location.replace("/board/record?bc_code=" + delete_bc_code);
      }
    },
    error: function () {
      alert("에러발생");
    },
  });
}

function deleteDataForLoginUser() {
  let userDeleteNum = $("#b_num").val();
  let userDeleteBc_code = $("#bc_code").val();
  if (
    confirm("정말로 삭제하시겠습니까?\n\n삭제한 게시글은 복구되지 않습니다.") ==
    true
  ) {
    $.ajax({
      type: "POST",
      url: "/board/deleteData",
      cache: false,
      data: {
        b_num: userDeleteNum,
        bc_code: userDeleteBc_code,
      },
      success: function (data) {
        if (data == 0) {
          alert("삭제가 진행되지 않았습니다.\n\n잠시후 다시 시도해주세요.");
        } else {
          alert("삭제되었습니다.");
          location.replace("/board/record?bc_code=" + userDeleteBc_code);
        }
      },
      error: function () {
        alert("에러발생");
      },
    });
  }
}
