$(window).on("load", function () {
  adminCommentLoad();
});

function adminCommentRegister() {
  // 여기서 보낼 게시판 값
  var m_idx = $("#hiddenIdx").val();
  var q_num = $("#hiddenQ_num").val();
  var qo_content = $("#commentContent").val();

  $.ajax({
    type: "post",
    url: "/board/Q&A/adminCommentRegister",
    cache: false,
    data: {
      m_idx: m_idx,
      q_num: q_num,
      qo_content: qo_content,
    },
    success: function (data) {
      if (data == 1) {
        alert("댓글 등록이 완료되었습니다.");
        $("#commentContent").val("");
        adminCommentLoad();
      } else {
        alert("댓글 등록 실패");
      }
    },
    error: function (e) {
      alert("에러발생: " + e);
    },
  });
}

function adminCommentLoad() {
  var m_idx = $("#hiddenIdx").val();
  var q_num = $("#hiddenQ_num").val();
  var m_level = $("#hiddenLevel").val();
  $.ajax({
    type: "get",
    url: "/board/Q&A/adminCommentLoad",
    data: {
      m_idx: m_idx,
      q_num: q_num,
    },
    success: function (data) {
      var html = "";
      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          // Timestamp 날짜변환
          var date = new Date(data[i].qo_writetime);
          var year = date.getFullYear().toString();
          var month = ("0" + (date.getMonth() + 1)).slice(-2);
          var day = ("0" + date.getDate()).slice(-2);
          var hour = ("0" + date.getHours()).slice(-2);
          var minute = ("0" + date.getMinutes()).slice(-2);
          var second = ("0" + date.getSeconds()).slice(-2);

          var returnDate =
            year +
            "." +
            month +
            "." +
            day +
            " " +
            hour +
            ":" +
            minute +
            ":" +
            second;
          html += "<div class='container yesComment'>";
          html += "<span class='col-sm-2'>";
          html += "<div>" + data[i].m_name + "</div>";
          html += "</span>";
          html +=
            "<span class='col-sm-8 comment_content' style='margin-left: 5px;'>";
          html += data[i].qo_content;
          html += "</span>";
          html +=
            "<span class='col-sm-2 commentwriteTime' style='text-align: right'>";
          if (m_level == 0) {
            html +=
              "&nbsp;" +
              returnDate +
              "&nbsp;<i style='cursor:pointer;'class='bi bi-x-square'></i>";
          } else {
            html += "&nbsp;" + returnDate;
          }
          html += "</span>";
          html += "</div>";
          html += "<div style='clear:both;'></div>";
        }
      } else {
        html += "<div id='noComment'>";
        html += "댓글이 없습니다.";
        html += "</div>";
      }

      $("#commentList").html(html);
    },
    error: function (e) {
      alert("에러발생: " + e);
    },
  });
}
$(document).on("click", ".bi-x-square", function () {
  alert("눌렸음");
});
