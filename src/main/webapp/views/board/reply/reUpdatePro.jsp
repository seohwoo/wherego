<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.askReply.ReplyDAO" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" scope="page" class="team02.askReply.ReplyDTO">
   <jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<% 
	int num = Integer.parseInt(request.getParameter("num"));

	ReplyDAO dao = ReplyDAO.getInstance();
	dao.UpdateReply(num);
	
	 response.sendRedirect("/wherego/views/board/ask/askList.jsp");
%>