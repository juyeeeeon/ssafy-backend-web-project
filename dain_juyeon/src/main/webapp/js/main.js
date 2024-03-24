function regist() {
	// 문서에서 id 로 input data 가져오기
	let id = document.getElementById("id").value;
	let password = document.getElementById("password").value;
	let passwordCheck = document.getElementById("password-check").value;
	let nickname = document.getElementById("nickname").value;
	let email = document.getElementById("email").value;

	// 입력값 검증
	if (!id || !password || !nickname || !email) {
		alert("빈칸이 없도록 입력해주세요.");
		return;
	} else if (password != passwordCheck) {
		alert("비밀번호가 다릅니다.");
		return;
	} else {
		// input data로 user 만들기
		const user = {
			id : id,
			password : password,
			nickname : nickname,
			email : email,
		};

		// user 객체 문자열로 바꿔서 로컬스토리지에 저장
		window.localStorage.setItem("user", JSON.stringify(user));
		alert("사용자 등록 성공!");
		// 로그인 화면으로 돌아가기
		window.location.replace("index.html");
	}
}

function login() {
	// 문서에서 id로 input data 가져오기
	let id = document.getElementById("login-id").value;
	let password = document.getElementById("login-password").value;

	// 로컬스토리지에 "user" 키로 저장된 item 가져와서 json 객체로 만들기
	const user = JSON.parse(window.localStorage.getItem("user"));

	// 입력값 검증
	if (!id) {
		alert("아이디를 입력하세요");
	} else if (!password) {
		alert("비밀번호를 입력하세요");
	} else if (user != null && user.id == id && user.password == password) {
		alert("로그인 성공 !");

		const loginUser = {
			id : user.id,
			nickname : user.nickname,
			email : user.email
		};

		// user 객체 문자열로 바꿔서 로컬스토리지에 저장
		localStorage.setItem("loginUser", JSON.stringify(loginUser));

		// 로그인 성공하면 index 페이지로 이동.
		document.getElementById("login-form").style.display = "none";
		document.getElementById("info-form").style.display = "block";
		document.getElementById("hello-user").innerHTML = `안녕하세요, ${user.nickname}님`;
	} else {
		alert("로그인 실패 !");
	}
}

function logout() {
	window.localStorage.removeItem("loginUser");
	document.getElementById("login-form").style.display = "block";
	document.getElementById("info-form").style.display = "none";
	window.location.replace("index.html");
}

function update() {
	let id = document.getElementById("info-id").value;
	let password = document.getElementById("info-password").value;
	let passwordCheck = document.getElementById("info-password-check").value;
	let nickname = document.getElementById("info-nickname").value;
	let email = document.getElementById("info-email").value;
	if (!password || !passwordCheck || !nickname || !email) {
		alert("빈칸이 없도록 입력해주세요.");
		return;
	} else if (password != passwordCheck) {
		alert("비밀번호가 다릅니다.");
		return;
	} else {
		const user = {
			id : id,
			password : password,
			nickname : nickname,
			email : email,
		};

		window.localStorage.setItem("user", JSON.stringify(user));
		alert("정보 수정 성공!");

		window.location.replace("index.html");
	}
}

function updatePW() {
	let password = document.getElementById("update-password").value;
	let passwordCheck = document.getElementById("update-password-check").value;

	const localuser = JSON.parse(window.localStorage.getItem("user"));

	if (password != passwordCheck) {
		alert("비밀번호가 다릅니다.");
		return;
	} else {
		const user = {
			id : localuser.id,
			password : password,
			nickname : localuser.nickname,
			email : localuser.email,
		};

		window.localStorage.setItem("user", JSON.stringify(user));
		alert("정보 수정 성공!");

		window.location.replace("index.html");
	}
}

function findPW() {
	let id = document.getElementById("find_id").value;
	let email = document.getElementById("find_email").value;
	console.log(id);
	console.log(password);
	const user = JSON.parse(window.localStorage.getItem("user"));
	console.log(user);
	if (user != null && user.id == id && user.email == email) {
		let find_btn = document.getElementById("find_btn");
		find_btn;
		document.getElementById("find_btn").style.display = "none";
		document.getElementById("updateID").style.display = "block";
	}
}

function search() {
	// 문서에서 id로 input data 가져오기
	let area = document.getElementById("index-search-area").value;
	let content = document.getElementById("index-search-content-id");
	let contentId = content.value;
	let contentName = content.options[content.selectedIndex].text;
	let keyword = document.getElementById("index-search-keyword").value;
	console.log(contentName);
	const map = {
		area : area,
		contentId : contentId,
		contentName : contentName,
		keyword : keyword,
	};

	// user 객체 문자열로 바꿔서 로컬스토리지에 저장
	window.localStorage.setItem("map", JSON.stringify(map));
	window.location.replace("map.html");
}
