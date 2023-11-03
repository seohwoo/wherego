<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<head>
<link href="/wherego/views/mypage/mypage.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%@ page import="team02.user.save.SaveDAO" %>
<%String contentid = request.getParameter("contentid");%>

<%=contentid %>
<title>찜하기 삭제</title>
</head>


<body >
<form name="myform" action="mypickdeletePro.jsp" method="post">
 <input type="hidden" name="contentid" value="<%= contentid %>">
<table >

 <tr height="30">
    <td colspan="2">
	  <label class="form-label"> 삭제하시겠습니까?</label>
	</td>
<tr height="30">
    <td colspan="2">
    
    
      <input type=submit class="btn btn-outline-danger" value="삭제" >
</table>
</form>
</body>  