
// 수정버튼
function recordUpdateBtn() {
  let bc_code = $("#bc_code").val();
  let b_num = $("#b_num").val();
  let title = $("#title").val();
  let userName = $("#m_name").val();
  let content = CKEDITOR.instances.ckeditor.getData();

  if (title == "") {
    alert("제목을 입력해주세요");
    return false;
  }

  if (userName.length < 2) {
    alert("이름은 2글자 이상으로 해주세요");
    return false;
  }

  $.ajax({
    type: "POST",
    url: "/board/recordUpdate",
    data: {
      title: title,
      m_name: userName,
      content: content,
      bc_code: bc_code,
      b_num: b_num,
    },
    success: function (data) {
      if (data == 1) {
        alert("수정이 완료되었습니다.");
        location.replace("/board/record?bc_code=" + bc_code);
      }
    },
    error: function () {
      alert("에러발생");
    },
  });
}

// 비밀번호 확인
function passBtnClick() {
	let bc_code = $("#bc_code").val();
	let b_num = $("#b_num").val();
	let m_pass = $("#pass").val();
	
	$.ajax({
		type:	"POST",
		url:	"/board/checkModifyPass",
		cache: false,
		data:	{
			m_pass: m_pass,
			b_num: b_num,
  			bc_code: bc_code
		},
		success: function (data) {
			if( data == "") {
				alert("비밀번호가 틀렸습니다.");
			} else {
				alert("비밀번호 맞음");
				goNonMemberUpdate(data);
			}
		},
		error: function() {
			alert("에러발생");
		}
	});

}

// 비회원 수정페이지 가는 함수
function goNonMemberUpdate(data) {
	let form = document.createElement("form");
	form.setAttribute("charset","UTF-8");
	form.setAttribute("method","POST");
	form.setAttribute("action","/board/nonMemberModify");
	
	let hiddenBc_code = document.createElement("input");
	hiddenBc_code.setAttribute("type", "hidden");
	hiddenBc_code.setAttribute("name", "bc_code");
	hiddenBc_code.setAttribute("value", data.bc_code);
	form.appendChild(hiddenBc_code);
	
	let hiddenB_num = document.createElement("input");
	hiddenB_num.setAttribute("type", "hidden");
	hiddenB_num.setAttribute("name", "b_num");
	hiddenB_num.setAttribute("value", data.b_num);
	form.appendChild(hiddenB_num);
	
	let hiddenM_pass = document.createElement("input");
	hiddenM_pass.setAttribute("type", "hidden");
	hiddenM_pass.setAttribute("name", "m_pass");
	hiddenM_pass.setAttribute("value", data.m_pass);
	form.appendChild(hiddenM_pass);
	
	document.body.appendChild(form);
	form.submit();
	
}