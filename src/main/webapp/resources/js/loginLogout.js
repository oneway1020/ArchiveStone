function login() {

  let loginForm = document.getElementById("loginForm");
  loginForm.setAttribute("charset", "UTF-8");
  loginForm.setAttribute("method", "post");
  loginForm.setAttribute("action", "/accounts/login");

  loginForm.submit();
}

function logout() {
  let logoutForm = document.getElementById("logoutForm");
  logoutForm.setAttribute("charset", "UTF-8");
  logoutForm.setAttribute("method", "post");
  logoutForm.setAttribute("action", "/accounts/logout");

  logoutForm.submit();
}
