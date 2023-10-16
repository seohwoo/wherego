<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.login.MemberShipDAO" %>
<%@ page import = "java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="member" class="team02.login.MemberShipDTO">
	<jsp:setProperty name="member" property="*"/>
</jsp:useBean>


<%

	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	MemberShipDAO manager = MemberShipDAO.getInstance();
	manager.insertMember(member);
	response.sendRedirect("loginForm.jsp");
%>