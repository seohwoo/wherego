<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>어디 Go</title>
</head>

<body>
	<jsp:include page="/views/main/nav.jsp" />	

	<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="/wherego/image/wherego1.jpg" class="d-block w-100" height="500px;">
	      <!-- 텍스트 추가 -->
	      <div class="text-overlay">
	        <div class="text-center">
	          <h1>어디 Go</h1>
	        </div>
	      </div>
	    </div>
	    <div class="carousel-item">
	      <img src="/wherego/image/wherego2.jpg" class="d-block w-100" height="500px;">
	      <!-- 텍스트 추가 -->
	      <div class="text-overlay">
	        <div class="text-center">
	          <h1>어디 Go</h1>
	        </div>
	      </div>
	    </div>
	    <div class="carousel-item">
	      <img src="/wherego/image/wherego3.jpg" class="d-block w-100" height="500px;">
	      <!-- 텍스트 추가 -->
	      <div class="text-overlay">
	        <div class="text-center">
	          <h1>어디 Go</h1>
	        </div>
	      </div>
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>
	<br />
		  <!-- main 중반 -->
	<br />
	<div class="d-grid gap-2 col-6 mx-auto">	
			<form action="/wherego/views/search/result.jsp" method="post">
		<div class="input-group mb-3">
			<select class="btn btn-outline-secondary dropdown-toggle" name="searchType">
				<option value="land">명소</option>
				<option value="loc">지역</option>
			</select>
			<input name="searchValue" type="text" class="form-control" placeholder="여행지를 검색해보세요">
			<div class="col-auto">
				<button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
			</div>
		</div>
			</form>
			
		<a href="/wherego/views/locationLand/locationHigh.jsp" class="btn btn-secondary">지역별 여행지 보기</a>
	</div>

<!-- top 8 여행지 -->
	<br/><hr />
		<jsp:include page="/views/main/topArea.jsp" />
	<br/><br />
	<div class="guide">
	<br />
		<h3 align= "center"> <a href="/wherego/views/mag/magList.jsp" class="title" style="color: black; text-decoration-line: none; font-family: 'UhBeeHyeki'">금주 여행 가이드</a></h3><br/>
			<jsp:include page="/views/main/bestMag.jsp" />
		<br/>
	</div>
	<br /><br />
	<h3 align= "center"> 주변둘러보기</h3><br/>
		<div class="d-grid gap-2 col-6 mx-auto">
			<form action="/wherego/views/map/searchMap.jsp" method="get">
			  <div class="input-group mb-3">
			    <input type="text" id="searchInput" name="keyword" class="form-control" placeholder="가고싶은 곳을 검색해보세요">
			    <div class="col-auto">
			      <button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
			    </div>
			  </div>
			</form>
		</div>
	<div class="d-grid gap-2 col-6 mx-auto">
		<jsp:include page="/views/map/currentMap.jsp" />	
	</div>
	<br/>
	<hr />
	<br/>
		<jsp:include page="/views/main/footer.jsp" />	

</body>
<script>
       function search() {
           var keyword = document.getElementById('keyword').value;
           // URL 파라미터 생성
           var url = "검색결과페이지URL?keyword=" + encodeURIComponent(keyword);
           // 검색 결과 페이지로 이동
           window.location.href = url;
       }
</script>
</html>