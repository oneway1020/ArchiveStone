// 비밀번호 변경하기 누르면
$("#userPassCheck").click(function () {
  location.href = `/accounts/myInfo/changePass`;
});

// 현재 비밀번호 입력창이 바뀌면
function bibunbakkum() {
  $("#checkOK").val("");
}
// 비밀번호 맞는지 체크
function checkPass() {
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
