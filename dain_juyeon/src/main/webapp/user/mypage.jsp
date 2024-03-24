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

	<div class="col-6 mx-auto">
		<div class="display-6 m-5 mb-5 text-center" role="alert">내 정보</div>

		<form onsubmit="return checkForm();" method="post"
			action="${root }/member">

			<input type="hidden" name="action" value="update">

			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="info_id" name="info_id"
					placeholder="ID" value="${user.userId }" readonly /> <label
					for="floatingInput">ID</label>
			</div>

			<div class="form-floating mb-3">
				<input type="email" class="form-control" id="info_email"
					name="info_email" placeholder="E-mail" value="${user.userEmail }" />
				<label for="floatingInput">E-mail</label>
			</div>

			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="info_name"
					name="info_name" placeholder="Name" value="${user.userName }" /> <label
					for="floatingInput">Name</label>
			</div>

			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="info_password"
					name="info_password" placeholder="Password"
					value="${user.userPass }" /> <label for="floatingPassword">Password</label>
			</div>

			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="info_password_check"
					name="info_password_check" placeholder="Password"
					value="${user.userPass }" /> <label for="floatingPassword">Password
					Check</label>
			</div>


			<button class="btn btn-outline-dark w-100 py-2 mb-3" type="submit">수정</button>
			<button class="btn btn-outline-dark w-100 py-2 mb-3" type="button"
				onclick="location.href='../index.jsp'">취소</button>
			<button class="btn btn-outline-danger w-100 py-2 mb-3" type="button"
				onclick="deleteUser()">회원 탈퇴</button>
		</form>
	</div>
	<script>
		function checkForm() {
			var password = document.getElementById("info_password").value;
			var passwordCheck = document.getElementById("info_password_check").value;

			if (password != passwordCheck) {
				alert('비밀번호가 다릅니다!');
				return false;
			} else
				return true;
		}
	</script>
	<script>
		function deleteUser() {
			if (window.confirm("정말 탈퇴하시겠습니까?")) {
				let user_id = document.getElementById("info_id").value;
				let url = "/04_EnjoyTrip_Back/member?action=delete&user_id=" + user_id;

				fetch(url).then(function(response) {
					return response.text();
				}).then(function(data) {
					if(data == "deleted"){
						window.location.href="/04_EnjoyTrip_Back/index.jsp";
						alert("탈퇴되었습니다.")
					}
				});
			} else {

			}
		}
		
	</script>
	<script src="./js/main.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>


	<%@ include file="/include/footer.jsp"%>