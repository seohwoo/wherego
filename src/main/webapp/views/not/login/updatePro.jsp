<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO" %>
<%@ include file="/views/not/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="member" class="team02.member.MemberDTO">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>


<%
	String id=(String)session.getAttribute("memId");
	member.setId(id);
	
	MemberDAO manager = MemberDAO.getInstance();
	manager.updateMember(member);  

%>
<link href="style.css" rel="stylesheet" type="text/css">

<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">

  <tr bgcolor="<%=title_c%>"> 
    <td height="39"  align="center">
	  <font size="+1" ><b>회원정보가 수정되었습니다.</b></font></td>
  </tr>
  
  
  <tr>
    <td bgcolor="<%=value_c%>" align="center"> 
      <p>입력하신 내용대로 수정이 완료되었습니다.</p>
    </td>
  </tr>
  
   <tr>
    <td bgcolor="<%=value_c%>" align="center"> 
      <form>
	    <input type="button" value="마이 페이지" onclick="window.location='/team02/views/not/login/myPage.jsp'">
      </form>
      5초후에 메인으로 이동합니다.<meta http-equiv="Refresh" content="5;url=/team02/views/not/login/myPage.jsp" >
    </td>
  </tr>
  
</table>
</body>
</html>
  