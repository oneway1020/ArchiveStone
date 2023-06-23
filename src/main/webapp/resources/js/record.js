
// 전체글 버튼
function total(code) {
  // 현재 url 경로만(파일이름만) 반환   ex) /board/record
  let url = window.location.pathname;

  // 현재 페이지의 모든 정보 반환         ex) http://localhost:8080/board/record?bc_code=reading
  let uri = window.location.href;

  // window.location.hostname; - 웹 호스트의 도메인 네임 반환 ex) localhost

  // window.location.protocol - 사용하는 웹 프로토콜 반환 (http:// 혹은 https://)
  location.href="/board/record?bc_code=" + code;
  
}

// 인기글 버튼
function recommend(code) {
	location.href="/board/record?bc_code=" + code + "&recommend=y";
}


// 글쓰기 버튼
function recordRegister(code) {

	location.href="/board/register?bc_code=" + code;
}

// 게시글 클릭했을때
function goRecordDetail(code, number) {
	location.href="/board/view?bc_code=" + code + "&b_num=" + number + "&page=1";
}

// 게시글 검색
function searchRecord() {

	
	let formObj = $("#formList");
	
	let typeStr = $("#searchType").find(":selected").val();

	if(typeStr == "typeofSearch") {
		alert("검색할 부분을 입력해주세요");
		return;
	}
	
	let searchKeyword = $("#searchKeyword").val();
	
	formObj.find("[name='searchType']").val(typeStr);
	formObj.find("[name='keyword']").val(searchKeyword);
	formObj.find("[name='page']").val("1");
	
	formObj.submit();
}