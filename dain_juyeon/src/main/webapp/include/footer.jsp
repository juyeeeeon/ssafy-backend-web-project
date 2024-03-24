<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 부트스트랩 사용을 위한 코드 --%>
<!-- JavaScript Bundle with Popper -->
<footer class="container py-5 d-flex justify-content-center">
	<small class="d-block mb-3 text-body-secondary ">&copy; 손다인 &
		이주연</small>
</footer>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<!--main.js-->
<script src="./js/main.js"></script>
<!--kakao api-->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87c9546ca7e332f072680d8f464022a2&libraries=services,clusterer,drawing"></script>

<script>
	const loginUser = localStorage.getItem("loginUser");
	if (loginUser != null) {
		const obj = JSON.parse(loginUser);

		document.getElementById("login-form").style.display = "none";
		document.getElementById("info-form").style.display = "block";
		document.getElementById("hello-user").innerHTML = `안녕하세요, ${obj.nickname}님`;
	}
</script>

</html>