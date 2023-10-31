<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.askboard.AskboardDAO" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="ask" scope="page" class="team02.askboard.AskboardDTO">
   <jsp:setProperty name="ask" property="*"/>
</jsp:useBean>

<% 
	AskboardDAO dao = AskboardDAO.getInstance();
	dao.insertAsk(ask);
	
	response.sendRedirect("askList.jsp");
%>