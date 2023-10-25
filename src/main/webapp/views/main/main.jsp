<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>어디 Go</title>
</head>

<body>
	<jsp:include page="/views/main/nav.jsp" />	

	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	<br />
	<jsp:include page="/views/board/notice/newNotice.jsp" />	
		  <!-- main 중반 -->
	<br />
	<div class="d-grid gap-2 col-6 mx-auto">	
		<div class="input-group mb-3">
			<input type="text" class="form-control" placeholder="여행지를 검색해보세요">
			<div class="col-auto">
				<button class="btn btn-outline-secondary" type="button" id="button-addon2" onClick="#">검색</button>
			</div>
		</div>
			
		<a href="/wherego/views/locationLand/locationHigh.jsp" class="btn btn-secondary">지역별 여행지 보기</a>
		<a href="#" class="btn btn-secondary">나의 여행 계획 짜기</a>
	</div>

	<br/><hr /><br/>
	<h3 align= "center"> Top 8 여행지</h3><br/>
		<jsp:include page="/views/main/topArea.jsp" />
	<br/>
	<hr/>
	<br/>
	<h3 align= "center"> 금주 여행 가이드</h3><br/>
		<jsp:include page="/views/main/bestMag.jsp" />
	<br/>
	<hr />
	<h3 align= "center"> Best Plan!</h3><br/>
		
	<br/>
	<hr />
	<br/>
		<jsp:include page="/views/main/footer.jsp" />	

</body>
</html>