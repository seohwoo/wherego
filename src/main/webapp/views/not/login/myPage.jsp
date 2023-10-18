<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>

<% if (session.getAttribute("memId") == null) { %>
    <script>
        alert("로그인 후 사용 가능합니다.");
        window.location = "/team02/views/main/main.jsp";
    </script>
<% } %>

<%
String id = (String) session.getAttribute("memId");

MemberDAO manager = MemberDAO.getInstance();
MemberDTO c = manager.getMember(id);

try {
%>

    <title>마이페이지</title>

<body>
    <center>
        <!-- 프로필 이미지 및 닉네임 표시 -->
        <img width="50" src="/team02/views/not/login/DEFAULT/<%= c.getProfile() %>">
        <button>변경</button>
        <%= c.getNic() %> 마이페이지
    </center>

  <p>
  
<center>
    <input type="button" value="수정하기" OnClick="window.location='updateForm.jsp'">
    <input type="button" value="삭제하기" OnClick="window.location='deleteForm.jsp'">
    <input type="button" value="정보보기" OnClick="window.location='view.jsp'">
    <input type="button" value="리뷰확인하기" OnClick="window.location='board.jsp'">
 </center>

<hr>

<%
} catch (Exception e) {
    e.printStackTrace();
}
%>
