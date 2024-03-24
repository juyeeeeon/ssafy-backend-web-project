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

	<%-- 페이지만의 내용 --%>
	<div class="container" id="index">
		<!-- section -->
		<div class="container-fluid pt-3">
			<div class="row justify-content-around">
				<!-- 메인 좌측 (여행지 선택) -->
				<div
					class="col-6 position-relative overflow-hidden p-3 m-1 text-center">
					<div class="col-md-8 mx-auto my-5">
						<h1>여행을 떠나볼까요?</h1>
						<div class="mt-5 text-center">
							<img style="width: 300px" src="assets/img/traveler.png" alt="" />
						</div>
						<form action="" method="post">
							<input type="hidden" value="indexToMap" />
							<!-- 지역 선택 -->
							<div class="input-group m-3" style="min-width: 200px">
								<span class="input-group-text"
									style="width: 50px; background-color: #001e3d"> 
									<i class="bi bi-map-fill m-auto" style="color: white"></i>
								</span> <select name="index-search-area" id="index-search-area"
									class="form-select me-2" aria-label="Default select example"
									style="background-color: #e6e6e6">
									<option value="0" selected>어디로 떠날까요?</option>
								</select>
							</div>

							<!-- 관광지 유형 선택 -->
							<div class="input-group m-3" style="min-width: 200px">
								<span class="input-group-text"
									style="width: 50px; background-color: #001e3d"> 
									<i class="bi bi-binoculars-fill m-auto" style="color: white"></i>
								</span> <select name="index-search-content"
									id="index-search-content-id" class="form-select me-2"
									style="background-color: #e6e6e6">
									<option value="0" selected>어떤 것을 할까요?</option>
									<option value="12" title="관광지">관광지</option>
									<option value="14">문화시설</option>
									<option value="15">축제공연행사</option>
									<option value="25">여행코스</option>
									<option value="28">레포츠</option>
									<option value="32">숙박</option>
									<option value="38">쇼핑</option>
									<option value="39">음식점</option>
								</select>
							</div>

							<!-- 검색어 입력-->
							<div class="input-group m-3" style="min-width: 200px">
								<span class="input-group-text"
									style="width: 50px; background-color: #001e3d"> 
									<i class="bi bi-question-lg m-auto" style="color: white"></i>
								</span> <input name="index-search-keyword" id="index-search-keyword"
									class="form-control me-2" style="background-color: #e6e6e6"
									type="search" placeholder="무엇이 궁금한가요?" aria-label="검색어" />
							</div>

							<button class="btn btn-outline-dark mx-auto mt-3" style="background-color: #001e3d; color: white;" type="button"
								id="index-search-btn">
								<i class="bi bi-search"></i> 검색
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		document.querySelector("#index-search-btn").addEventListener("click", () =>{
				let area = document.getElementById("index-search-area").value;
				let content = document.getElementById("index-search-content-id");
				let contentId = content.value;
				let contentName = content.options[content.selectedIndex].text;
				let keyword = document.getElementById("index-search-keyword").value;
				
				const map = {
			    	area: area,
			    	contentId: contentId,
			    	contentName: contentName,
			    	keyword: keyword,
			  	};

			  	// user 객체 문자열로 바꿔서 로컬스토리지에 저장
				window.localStorage.setItem("map", JSON.stringify(map));

				location.href = "./enjoyTrip?action=map";
			});

		fetch("/04_EnjoyTrip_Back/region?action=sido", {
			method : "GET"
		}).then(function(response) {
			return response.json()
		}).then(function(data) {
			makeOption(data)
		});

		function makeOption(data) {
			console.log("data");
			console.log("in make option");
			let areas = data;
			let sel = document.getElementById("index-search-area");
			areas.forEach(function(area) {
				let opt = document.createElement("option");
				opt.setAttribute("value", area["sidoCode"]);
				opt.appendChild(document.createTextNode(area["sidoName"]));
				sel.appendChild(opt);
			});
		}
		
	</script>
	<%@ include file="/include/footer.jsp"%>