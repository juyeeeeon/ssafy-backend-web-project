<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp"%>
<link href="https://webfontworld.github.io/goodchoice/Jalnan.css" rel="stylesheet">
</head>
<style>
body {
      font-family: 'Jalnan';
      background-size: cover;
      background-image: url(assets/img/vecteezy_early-morning-sky-or-heaven-and-water-surface_16263127.jpg);
    }

    .bi {
      vertical-align: -0.125em;
      fill: currentColor;
    }
</style>
<body>
	<%@ include file="/include/nav.jsp"%>
	<%
		Cookie[] cookies = request.getCookies();
		String userId = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("ssafy_id".equals(cookie.getName())) {
					userId = cookie.getValue();
					break;
				}
			}
		}
	%>

	<%-- 페이지만의 내용 --%>
	<!-- 회원 정보 (로그인 전) -->
	<div class="col-6 mx-auto">
		<div class="display-6 m-5 mb-5 text-center" role="alert">로그인</div>
		<form method="post" action="/04_EnjoyTrip_Back/member">
			<input type="hidden" name="action" value="login">

			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="login_id"
					name="login_id" value="<%=userId != null ? userId : ""%>"
					placeholder="ID" /> <label for="floatingInput">ID</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="login_password"
					name="login_password" placeholder="Password" /> <label
					for="floatingPassword">Password</label>
			</div>

			<div class="form-check text-start my-3">
				<input class="form-check-input" type="checkbox" value="remember"
					id="remember_id" name="remember_id"
					<%=userId != null ? "checked" : ""%> /> <label
					class="form-check-label" for="flexCheckDefault"> Remember
					me </label>
			</div>

			<button class="btn btn-outline-dark w-100 py-2 mb-3" type="submit">로그인</button>

			<button type="button" class="btn btn-outline-dark w-100 py-2 mb-3"
				data-bs-toggle="modal" data-bs-target="#signUp"
				data-bs-whatever="@mdo">회원가입</button>

			<button type="button" class="btn btn-outline-dark w-100 py-2"
				data-bs-toggle="modal" data-bs-target="#findPW"
				data-bs-whatever="@mdo">비밀번호 찾기</button>
		</form>
	</div>


	<div class="row p-5 m-2">
		<!-- 회원가입 모달창 -->
		<div class="modal fade" id="signUp" tabindex="-1"
			aria-labelledby="signUpLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="signUpLabel">회원가입</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<form onsubmit="return checkForm();" method="post"
						action="${root }/member">

						<input type="hidden" name="action" value="regist">
						<div class="modal-body">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="id" name="id"
									placeholder="ID" required /> <label for="floatingInput">ID</label>
							</div>

							<div class="form-floating mb-3">
								<input type="email" class="form-control" id="email" name="email"
									placeholder="E-mail" required /> <label for="floatingInput">E-mail</label>
							</div>

							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="Name" required /> <label for="floatingInput">Name</label>
							</div>

							<div class="form-floating mb-3">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="Password" required /> <label
									for="floatingPassword">Password</label>
							</div>

							<div class="form-floating mb-3">
								<input type="password" class="form-control" id="password_check"
									name="password_check" placeholder="Password Check" required />
								<label for="floatingPassword">Password Check</label>
							</div>


						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary"
								onclick="checkForm()">Join</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- 비밀번호 수정 -->
		<div class="modal fade" id="findPW" tabindex="-1"
			aria-labelledby="findPWLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="findPWLabel">비밀번호 찾기</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form method="post" action="${root }/member">
							<input type="hidden" name="action" value="findPassword">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="find_id"
									name="find_id" placeholder="ID" required /> <label
									for="floatingInput">ID</label>
							</div>
							<div class="form-floating mb-3">
								<input type="email" class="form-control" id="find_email"
									name="find_email" placeholder="E-mail" required /> <label
									for="floatingInput">E-mail</label>
							</div>
						</form>
					</div>
					<div id="find_btn" class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" onclick="findPW()">입력</button>
					</div>

				</div>
			</div>
		</div>
		</form>
	</div>
	<hr />
	</div>

	<!-- 회원 정보 (로그인 후) -->
	<div id="info-form"
		class="col-2 position-relative overflow-hidden text-center pt-3 m-1"
		style="min-width: 500px; display: none">
		<div class="row p-5 m-2">
			<h3 class="mb-3 fw-normal" id="hello-user"></h3>
			<button class="btn btn-outline-dark w-100 py-2 mb-3"
				onClick="location.href='mypage.html'">내 정보</button>

			<button type="button" class="btn btn-outline-dark w-100 py-2"
				data-bs-toggle="modal" data-bs-target="#exampleModal"
				data-bs-whatever="@mdo" onclick="logout()">로그아웃</button>
		</div>
		<hr />
	</div>
	<script>
		function checkForm() {
			var password = document.getElementById("password").value;
			var passwordCheck = document.getElementById("password_check").value;

			if (password != passwordCheck) {
				alert('비밀번호가 다릅니다!');
				return false;
			} else
				return true;
		}

		function findPW() {
			let find_id = document.getElementById("find_id").value;
			let find_email = document.getElementById("find_email").value;
			let url = "/04_EnjoyTrip_Back/member?action=findPassword&find_id="
					+ find_id + "&find_email=" + find_email;

			fetch(url).then(function(response) {
				return response.text();
			}).then(function(data) {
				console.log("in findPW return");
				console.log("data is " + data);
				if (data != "no") {
					alert("비밀번호: " + data);
				} else {
					alert("존재하지 않는 회원입니다.");
				}
			});
		}
	</script>

	<%@ include file="/include/footer.jsp"%>