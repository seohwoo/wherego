<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>AREA GUIDE</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />	
	
	<br />
	<div class="text-center">
		<h2>어디 Go</h2>
	</div>
	<br />
	<hr />
	
	<!--  반복문  -->
	
	<div class="card mb-3" style="max-width: 540px;">
	  <div class="row g-0">
	    <div class="col-md-4">
	      <img src="..." class="img-fluid rounded-start" alt="...">
	    </div>
	    <div class="col-md-8">
	      <div class="card-body">
	        <h4 class="card-title">제목</h5>
	        <a href="#" class="card-text"> 작성자 </a>
	        <!-- a태그로 작성자가 쓴 글 모두보기 연결 -->
	        <p class="card-text"> 내용 </p>
	        <p class="card-text"><small class="text-body-secondary">게시일</small></p>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="fixed-bottom">
	<hr />
		<jsp:include page="/views/main/footer.jsp" />		
	</div>

</body>
</html>