<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    }</style>
<body>
	<%@ include file="/include/nav.jsp"%>

	<%-- 페이지만의 내용 --%>
	<!-- 중앙 center content end -->
	<div class="col-8 mx-auto">
		<div class="display-6 m-5 mb-5 text-center" role="alert">전국 관광지
			정보</div>

		<!-- 관광지 검색 start -->
		<form class="ms-5 me-5 d-flex" onsubmit="return false;" role="search">
			<select id="search-area" class="form-select me-2"
				aria-label="Default select example">
				<option value="0" selected>검색 할 지역 선택</option>
			</select> <input id="search-keyword" class="form-control me-2" type="search"
				placeholder="검색어" aria-label="검색어" />
			<button id="btn_search" class="btn btn-outline-dark text-nowrap" type="button"
        style="background-color: #001e3d; color: white;">검색</button>
		</form>


		<!-- kakao map start -->
		 <div class="row justify-content-center">
      <div class = "col-12">
        <div class="btn-group d-flex flex-wrap" role="group" style="margin-top: 10px;">
            <input type="checkbox" class="btn-check" id="search-1" value="12" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-1">관광지</label>
            <input type="checkbox" class="btn-check" id="search-2" value="14" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-2">문화시설</label>
            <input type="checkbox" class="btn-check" id="search-3" value="15" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-3">축제공연행사</label>
            <input type="checkbox" class="btn-check" id="search-4" value="25" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-4">여행코스</label>
            <input type="checkbox" class="btn-check" id="search-5" value="28" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-5">레포츠</label>
            <input type="checkbox" class="btn-check" id="search-6" value="32" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-6">숙박</label>
            <input type="checkbox" class="btn-check" id="search-7" value="38" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-7">쇼핑</label>
            <input type="checkbox" class="btn-check" id="search-8" value="39" onchange="checkBox(this)">
            <label class="btn btn-outline-dark" for="search-8">음식점</label>
          </div>
        </div>
      </div>
      <div id="map" class="col-10 mx-auto mt-3 rounded-3" style="height: 500px;"></div>
		<!-- kakao map end -->

		<div class="row">
			<table class="table table-striped m-3 mx-auto" style="display: none;">
				<thead>
					<tr>
						<th>대표이미지</th>
						<th>관광지명</th>
						<th>주소</th>
						<th>위도</th>
						<th>경도</th>
					</tr>
				</thead>
				<tbody id="trip_list">
					<c:forEach items="${tripList}" var="area">
						<tr onclick="moveCenter(${area.mapy}, ${area.mapx});">
							<td><img src="${area.firstimage}" width="100px"></td>
							<td>${area.title}</td>
							<td>${area.addr1}${area.addr2}</td>
							<td>${Number(area.mapy).toFixed(3)}</td>
							<td>${Number(area.mapx).toFixed(3)}</td>
						</tr>
					</c:forEach>

				</tbody>
				<!-- 				<tbody id="trip_list">
				

				</tbody> -->
			</table>
			<!-- 관광지 검색 end -->
		</div>
	</div>
	<%@ include file="/include/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
	<script src="./js/map.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bf4175c7edc823e48a143d011d870bbc&libraries=services,clusterer,drawing"></script>
	<script>
	
		var contentList = [];
		// 지역 선택 옵션
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
			let sel = document.getElementById("search-area");
			areas.forEach(function(area) {
				let opt = document.createElement("option");
				opt.setAttribute("value", area["sidoCode"]);
				opt.appendChild(document.createTextNode(area["sidoName"]));
				sel.appendChild(opt);
			});
	
			// 로컬 스토리지에 값이 있으면
			// 지도 띄우기
			const searchInfo = localStorage.getItem("map");
			if (searchInfo != null) {
				const obj = JSON.parse(searchInfo);
	
				let areaCode = document.getElementById("search-area");
				let contentTypeId = document.querySelectorAll(".btn-check");
				let keyword = document.getElementById("search-keyword");
	
				let areaCodeVal;
				let keywordVal;
				let contentTypeIdVal;
	
				for (var i = 0; i < areaCode.length; i++) {
					option = areaCode.options[i];
					if (option.value == obj.area) {
						option.selected = true;
						areaCodeNo = option.value;
						break;
					}
				}
	
				for (var i = 0; i < contentTypeId.length; i++) {
					if (contentTypeId[i].value == obj.contentId) {
						document.getElementById(contentTypeId[i].id).checked = true;
						contentList.push(obj.contentId);
						break;
					}
				}
	
				keyword.value = obj.keyword;
				keywordVal = keyword.value;
				
				setData();
				window.localStorage.removeItem("map");
			}
		}

		// 관광지 유형 체크 박스
		function checkBox(checked) {
	        var value = checked.getAttribute("value");
	        if (checked.checked == true) {
	          contentList.push(value);
	          console.log(contentList + "체크");
	        } else {
	          let filtered = contentList.filter((element) => element !== value);
	          contentList = filtered;
	          console.log(contentList);
	        }
	        setData();
		}

		// 검색 버튼 클릭 이벤트
	      document.getElementById("btn_search").addEventListener("click", function() {
 	    	  document.getElementById("trip_list").innerHTML = "";
 	    	  setData();
	      });
	      
	      
	   // 데이터 받아오기
	      function setData(){
	    	  var areaCode = document.getElementById("search-area").value;
	    	  var contentTypeId = contentList;
	    	  var keyword = document.getElementById("search-keyword").value;

	    	  console.log(str);
			  for (var i = 0; i < contentTypeId.length; i++) {
		    	  var str = JSON.stringify({
			    	  areaCode: areaCode,
			    	  contentTypeId: contentTypeId[i],
			    	  keyword : keyword
			    	  });
		    	  
		    	  fetch("/04_EnjoyTrip_Back/enjoyTrip", {
			    	  method : "POST",
			    	  body: str,
		    	  }). then(function(response) {
			    	  return response.json()
		    	  }).then(function(data) {
			    	  console.log("데이터 받아옴");
			    	  var tableList = makeList(data);
			    	  
			    	  return makeList(data);
		    	  }).then(function(tableList){
		    		  document.querySelector("table").setAttribute("style", "display: ; border-radius: 6px; overflow: hidden;");
		    		  document.getElementById("trip_list").innerHTML += tableList;
		    	  });
			  }
	      }
	      
	      
	   // 읽어온 데이터 화면에 뿌림
	      let positions = [];
	      function makeList(data) {
	    		console.log(data);
	    		let tripList = "";

	    		if(data.length == 0){
	    			document.getElementById("trip_list").innerHTML = "<div>데이터가 없습니다.</div>";
	    			return "";
	    		}
	    		
	    		
	    		for (var i = 0; i < Math.min(data.length, 10); i++) {
	    			var firstimage;
	    			if (data[i].firstimage == '')
	    				firstimage = "../images/basic.png";
	    			else
	    				firstimage = data[i].firstImage;
	    			
	    			tripList += "<tr onclick='moveCenter(${area.mapy}, ${area.mapx});'> "
	    			+ "<td><img src='" + firstimage + "' width='100px'></td> "
	    			+ "<td>"+ data[i].title + "</td> "
	    			+ "<td>"+ data[i].addr1 + " " + data[i].addr2 + "</td> "
	    			+ "<td>" + Number(data[i].latitude).toFixed(3) + "</td> "
	    			+ "<td>" + Number(data[i].longitude).toFixed(3) + "</td> " + "</tr>";
	    			
	    			
	    			let markerInfo = {
	    				title : data[i].title,
	    				latlng : new kakao.maps.LatLng(data[i].latitude, data[i].longitude),
	    			};
	    			positions.push(markerInfo);
	    		}
	    		
	    		displayMarker();
	    		return tripList;
	    	}
	      
	      // 카카오지도
	      var mapContainer = document.getElementById("map"), // 지도를 표시할 div
	        mapOption = {
	          center: new kakao.maps.LatLng(37.500613, 127.036431), // 지도의 중심좌표
	          level: 5, // 지도의 확대 레벨
	        };

	      // 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
	      var map = new kakao.maps.Map(mapContainer, mapOption);

	      function displayMarker() {
	        // 마커 이미지의 이미지 주소입니다
	        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

	        for (var i = 0; i < positions.length; i++) {
	          // 마커 이미지의 이미지 크기 입니다
	          var imageSize = new kakao.maps.Size(24, 35);

	          // 마커 이미지를 생성합니다
	          var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

	          // 마커를 생성합니다
	          var marker = new kakao.maps.Marker({
	            map: map, // 마커를 표시할 지도
	            position: positions[i].latlng, // 마커를 표시할 위치
	            title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	            image: markerImage, // 마커 이미지
	          });
	        }

	        // 첫번째 검색 정보를 이용하여 지도 중심을 이동 시킵니다
	        map.setCenter(positions[0].latlng);
	      }
		</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>