<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>AREA</title>
</head>
<body>
	<%@ include file="nav.jsp" %>
	
	<br />
	<div class="text-center">
		<h2>어디 Go</h2>
	</div>
	<br />
	<hr />
	
	<!--  반복문  -->
	
	<!--  카드 형식 -->
	<div class="container text-center">
		<div class="row row-cols-3">
			<div class="card-group">
			  	<div class="card" >
				    <img src="..." class="card-img-top" alt="...">
				    <div class="card-body">
				      <h5 class="card-title">여행지</h5>
				      <p class="card-text">주소</p>
				    </div>
				    <div class="card-footer">
				      <small class="text-body-secondary"> 게시일 </small>
				    </div>
		  		</div>
			</div>
		</div>
	</div>


	
	<div class="fixed-bottom">
	<hr />
		<%@ include file="footer.jsp" %>	
	</div>

</body>
</html>