// 검색버튼을 눌렀을 시 발생하는 함수
function searchgall() {
  let searchForm = document.getElementById('searchForm');
  searchForm.setAttribute("charset", "UTF-8");
  searchForm.action = "/board/search";
  searchForm.method = "GET";
  searchForm.submit();
}

// 엔터키를 눌렀을 시 발생하는 함수
function fnEnterkey() {
  if (event.keyCode == 13) {
    searchgall();
  }
}