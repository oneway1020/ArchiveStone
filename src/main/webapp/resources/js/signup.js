// 아이디 중복체크
function checkID() {
  if ($("#id").val() == "") {
    alert("사용하실 아이디를 입력해주세요");
    $("#id").focus();
    return false;
  }

  if ($("#id").val().length < 4) {
    alert("아이디는 4자리 이상으로 해주세요");
    $("#id").focus();
    return false;
  }
  
  if ($("#id").val().length > 20) {
  	alert("아이디는 20자리 이하로 해주세요");
  	$("#id").focus();
    return false;
  }
  
  if ($("#id").val() == "Anonymous") {
  	alert("사용 불가능한 아이디입니다. 다시 입력해주세요");
  	$("#id").focus();
  	return false;
  }

  // 입력한 아이디가 DB에 존재하는지 확인
  $.ajax({
    url: "/accounts/checkID",
    type: "post",
    dataType: "json",
    data: { m_id: $("#id").val() },
    success: function (data) {
      if (data == 1) {
        alert("이미 사용 중인 아이디입니다.");
      } else if (data == 0) {
        alert("사용 가능한 아이디입니다.");
        $("#checked_id").val("y");
		$("#checkid").removeAttr("hidden");
		$("#checkid").css({'color':'green','opacity':'0.5'});
		$("#checkid").text("사용가능한 아이디입니다");
      }
    },
    error: function() {
    	alert("현재 회원가입을 진행할 수 없습니다\n잠시후 다시 시도해주세요");
    },
  });
	
}

// 회원가입
function signUp() {
	let id = $("#id").val();
	let pass = $("#password").val();
	let name = $("#name").val();
	
	if($("#checked_id").val() != "y") {
		alert("아이디 중복체크를 해주세요");
		return false;
	}
	
	if(name.length < 2) {
		alert("닉네임은 2자리 이상으로 해주세요");
		$("#name").focus();
		return false;
	}
	
	if(name.length > 20) {
		alert("닉네임은 20자리 이하로 해주세요");
		$("#name").focus();
		return false;
	}
	
	if(pass.length < 4) {
		alert("비밀번호는 4자리 이상으로 해주세요");
		$("#password").focus();
		return false;
	}
	
	if($("#checked_pass").val() != "y") {
		alert("비밀번호 재확인을 해주세요");
		return false;
	}
	

	$.ajax({
		url: "/accounts/signUp",
		type: "post",
		dataType: "json",
		data: { m_id: id, m_pass: pass, m_name: name},
		success: function(data) {
			if(data == 1) {
				alert("회원가입이 완료되었습니다");
				location.replace("/");
			} else if(data == 0) {
				alert("회원가입에 실패했습니다\n잠시후 다시 시도주세요");
			}
		},
		error: function() {
			alert("에러발생");
		}
	});
}

// 아이디 input값이 변경될 때 실행되는 함수
function changeID() {
  $("#checked_id").val("");
  $("#checkid").attr("hidden",true);
}

// 비밀번호와 비밀번호 재확인이 일치하게 만드는 함수
function checkPass() {
	let realPass = $("#password").val();
	let checkPass = $("#passwordRe").val();
		
	if(realPass != checkPass) {
		$("#passCheck").css({'color':'red','opacity':'0.5'});
		$("#passCheck").text("비밀번호를 일치시켜주세요");
		$("#checked_pass").val("");
	} else {
		$("#passCheck").css('color','green')
		$("#passCheck").text("비밀번호가 일치합니다");
		$("#checked_pass").val("y");
	}
}
