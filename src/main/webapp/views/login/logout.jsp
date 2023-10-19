<%@ page contentType="text/html; charset=UTF-8"%>

<%
	session.invalidate();
	response.sendRedirect("/team02/views/main/main.jsp");
%>