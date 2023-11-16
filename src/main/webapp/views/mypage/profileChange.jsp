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
<%
   String id = (String) session.getAttribute("memId");

   MemberDAO manager = MemberDAO.getInstance();
   MemberDTO c = manager.getMember(id); 
%>

<body>
    <form action="uploadProfile.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

		<label class="form-label" >프로필 이미지 선택</label>
		<div class="input-group mb-3">
			<input class="form-control" type="file" id="profile" name="profile">
			<input type="submit" class="btn btn-outline-secondary" value="업로드" >
		</div>
		<input type="button" class="btn btn-outline-danger" value="닫기" onclick="closeWindow()" style="float: right;">

    </form>
    
    <script>
        // 새 창을 닫는 함수
        function closeWindow() {       	
              window.close();         
        }

        // 폼 유효성 검사 함수
        function validateForm() {
            var fileInput = document.getElementById('profile');
            if (fileInput.files.length === 0) {
                alert('파일을 추가하세요.'); // 파일을 추가하지 않았을 때 알림 메시지 표시
                return false; // 폼 제출을 중지
            }
            return true; // 파일이 첨부되었을 때 폼 제출 허용
        }
    </script>
    
</body>
</html>



