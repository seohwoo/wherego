<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO" %>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>

<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>어디 Go</title>
</head>

<jsp:useBean id="member" class="team02.member.MemberDTO">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>


<%
	String id=(String)session.getAttribute("memId");
	member.setId(id);
	String user = request.getParameter("id");
	
	MemberDAO manager = MemberDAO.getInstance();
	manager.rejoinMember(member);  
%>

<link href="style.css" rel="stylesheet" type="text/css">

<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">

  <tr> 
    <td height="39"  align="center">
	  <h4>회원 재등록이 되었습니다.</h4>
  </tr>
  
  
  <tr>
    <td align="center"> 
      <p>입력하신 내용대로 재등록이 완료되었습니다.</p>
    </td>
  </tr>
  
   <tr>
    <td align="center"> 
      <form style="font-family: 'Pretendard-Regular', sans-serif;">
	    <input type="button"  class="btn btn-light" value="마이 페이지" onclick="window.location='/wherego/views/main/main.jsp?id=<%=id%>'">
      </form>
      5초후에 메인으로 이동합니다.<meta http-equiv="Refresh" content="5;url=/wherego/views/main/main.jsp?id=<%=id%>" >
    </td>
  </tr>
  
</table>
</body>
</html>
  