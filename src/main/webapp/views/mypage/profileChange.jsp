<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>

    <title>프로필 이미지 변경</title>
    
<%
   String id = (String) session.getAttribute("memId");

   MemberDAO manager = MemberDAO.getInstance();
   MemberDTO c = manager.getMember(id); 
%>

<body>
    <h1>프로필 이미지 변경</h1>
    
    <form action="uploadProfile.jsp" method="post" enctype="multipart/form-data">

		<label class="form-label" >프로필 이미지 선택</label>
		<div class="input-group mb-3">
			<input class="form-control" type="file" id="profile" name="profile">
			<input type="submit" class="btn btn-outline-secondary" value="업로드" >
		</div>
		<input type="button" class="btn btn-outline-danger" value="닫기" onclick="closeWindow()">

    </form>
    
    <script>
        // 새 창을 닫는 함수
        function closeWindow() {       	
              window.close();         
        }
    </script>
    
</body>
</html>



