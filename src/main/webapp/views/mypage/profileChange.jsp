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
        <label for="profile">프로필 이미지 선택:</label>
        <input type="file" id="profile" name="profile">
        <input type="submit" value="업로드" >
    </form>
    <script>
        // 새 창을 닫는 함수
        function closeWindow() {
        	
        	
            window.close();
            // 부모 창의 setProfile 함수를 호출하여 이미지를 업데이트
            if (opener && opener.setProfile) {
                opener.setProfile();
            }
        }
    </script>
</body>
</html>



