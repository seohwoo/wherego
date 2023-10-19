<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<%
 try{
   if(session.getAttribute("memId")==null){
   //로그인이 안되었을 때 (null)
 %>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <div class="collapse navbar-collapse" id="navbarNavDropdown">
	      <ul class="navbar-nav">
	        <li class="nav-item">
          		<a class="nav-link active" aria-current="page" href="/team02/views/main/main.jsp">Home</a>
       		 </li>
	        <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="/team02/views/main/listRand.jsp"> Area </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="/team02/views/main/listGuide.jsp"> Guide </a>
	        </li>
	         <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="team02/views/board/board.jsp" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            Community
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="#">Notice</a></li>
	            <li><a class="dropdown-item" href="/team2/board/askList.jsp">Q & A</a></li>
	          </ul>
	        </li>
	      </ul>
	      <div class = "collapse navbar-collapse justify-content-end">
		      <ul class="navbar-nav">
		      	<li class="nav-item">
		      		<%@ include file = "/views/login/loginForm.jsp" %>
	       		 </li>&nbsp;
	       		 <li class="nav-item">
	          		<button type="button" class="btn btn-secondary" OnClick="window.location='/team02/views/login/inputForm.jsp'">Sign-up</button>
	          	</li>
	          </ul>
	      </div>
	    </div>
	  </div>
	</nav>
<%}else{
     //로그인이 되었을 때
     %>
     <nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <div class="collapse navbar-collapse" id="navbarNavDropdown">
	      <ul class="navbar-nav">
	        <li class="nav-item">
          		<a class="nav-link active" aria-current="page" href="/team2/main/main.jsp">Home</a>
       		 </li>
	        <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="/team2/main/listRand.jsp"> Area </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="/team2/main/listGuide.jsp"> Guide </a>
	        </li>
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="/team2/board/board.jsp" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            Community
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="#">Notice</a></li>
	            <li><a class="dropdown-item" href="/team2/board/askList.jsp">Q & A</a></li>
	          </ul>
	        </li>
	      </ul>
	      <div class = "collapse navbar-collapse justify-content-end">
		      <ul class="navbar-nav">
		      	<li class="nav-item">
		      		<button type="button" class="btn btn-outline-secondary" OnClick="window.location='/team02/views/login/logout.jsp'">logout</button>
	       		 </li>&nbsp;
	       		 <li class="nav-item">
	          		<button type="button" class="btn btn-outline-secondary" OnClick="window.location='/team02/views/mypage/myPage.jsp'">mypage</button>
	          	</li>
	          </ul>
	      </div>
	    </div>
	  </div>
	</nav>
 <%}
 }catch(NullPointerException e){}
 %>
</body>
</html>