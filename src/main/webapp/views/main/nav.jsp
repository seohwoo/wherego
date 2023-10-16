<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <div class="collapse navbar-collapse" id="navbarNavDropdown">
	      <ul class="navbar-nav">
	        <li class="nav-item">
          		<a class="nav-link active" aria-current="page" href="/team02/views/main/main.jsp">Home</a>
       		 </li>
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle"  href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            Area
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">서울</a></li>
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">인천</a></li>
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">경기도</a></li>
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">강원도</a></li>
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">충청도</a></li>
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">전라도</a></li>
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">경상도</a></li>
	            <li><a class="dropdown-item" href="/team02/views/main/listRand.jsp">제주도</a></li>
	          </ul>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="/team02/views/main/listGuide.jsp"> Guide </a>
	        </li>
	      </ul>
	      <div class = "collapse navbar-collapse justify-content-end">
		      <ul class="navbar-nav">
		      	<li class="nav-item">
		      		<%@ include file = "/views/login/loginForm.jsp" %>
	       		 </li>
	       		 <li class="nav-item">
	          		<!-- signup -->
	          	</li>
	          </ul>
	      </div>
	    </div>
	  </div>
	</nav>


</body>
</html>