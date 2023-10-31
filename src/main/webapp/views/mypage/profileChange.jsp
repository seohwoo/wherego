<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>

<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/mypage/mypage.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>프로필 이미지 변경</title>
</head>
<body>
<%
   String id = (String) session.getAttribute("memId");

   MemberDAO manager = MemberDAO.getInstance();
   MemberDTO c = manager.getMember(id); 
%>    
    <form action="uploadProfile.jsp" method="post" enctype="multipart/form-data">
		<label class="form-label" >프로필 이미지 선택:</label>
		<div class="input-group mb-3">
			<input class="form-control" type="file" id="profile" name="profile">
			<input type="submit" class="btn btn-outline-secondary" value="업로드" >
		</div>
		<input type="button" class="btn btn-outline-danger" value="닫기" onclick="closeWindow()">
    </form>
</body>
<script>
	function closeWindow() {       	
	      window.close();         
	}
</script>
</html>



