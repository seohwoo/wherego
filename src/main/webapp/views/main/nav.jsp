<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.main.use.SearchDAO"%>
<%@ page import="java.util.Stack" %>
<%@ page import="java.util.EmptyStackException" %>
    
<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<body>
	<% request.setCharacterEncoding("UTF-8");%>
	
	<%
		String id = "";
		if(session.getAttribute("memId")!=null ) {
			id = (String) session.getAttribute("memId");
		}
	%>
	<nav class="navbar navbar-expand bg-body-tertiary">
	  <div class="container-fluid">
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="/wherego/views/main/main.jsp">Home</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/wherego/views/locationLand/locationHigh.jsp">Area</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/wherego/views/mag/magList.jsp">Magazine</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/wherego/views/board/inquire/inquireList.jsp">Q & A</a>
	        </li>
	        <%
	        	SearchDAO dao = SearchDAO.getInstance();
	        	int grade = dao.isAdmin(id);
	        	if(grade==99) {
	        %>
	        <li class="nav-item">
	          <a class="nav-link" href="/wherego/views/admin/showCleanMember.jsp?pageNum=1">admin</a>
	        </li>
	         <li class="nav-item">
	          <a class="nav-link" href="/wherego/views/admin/ban/banList.jsp?pageNum=1">ban</a>
	        </li>
	        <%} %>
	      </ul>
	    </div>
	  </div>
	      <%
		   if(session.getAttribute("memId")==null){//로그인이 안되었을 때 (null)
		 %>
	      <div class = "collapse navbar-collapse justify-content-end" >
		      <ul class="navbar-nav">
		      	<li class="nav-item">
		      		<jsp:include page="/views/login/loginForm.jsp"/>
	       		 </li>&nbsp;
	       		 <li class="nav-item">
	          		<button type="button" class="btn btn-secondary" OnClick="window.location='/wherego/views/login/inputForm.jsp'">SignUp</button>
	          	</li>
	          </ul>
	         </div>

	<%}else{//로그인이 되었을 때
	     %>
	      <div class = "collapse navbar-collapse justify-content-end">
		      <ul class="navbar-nav">
		      	<li class="nav-item">
		      		<button type="button" class="btn btn-outline-secondary" OnClick="window.location='/wherego/views/login/logout.jsp'">logout</button>
	       		 </li>&nbsp;
	       		 <li class="nav-item">
	          		<button type="button" class="btn btn-outline-secondary" OnClick="window.location='/wherego/views/mypage/myPage.jsp?id=<%=id%>'">mypage</button>
	          	</li>
	          </ul> 
	    </div>
	    <%}%>
	  
	</nav>
</body>
</html>