<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team02.inquire.board.InquireDAO" %>
<%@ page import="team02.inquire.board.InquireDTO" %>
    
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" scope="page" class="team02.inquire.board.InquireDTO">
   <jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<% 
	int num = Integer.parseInt(request.getParameter("num"));

	InquireDAO dao = InquireDAO.getInstance();
	dao.deleteInquirePost(num);
%>
<meta http-equiv="Refresh" content="0;url=inquireList.jsp" >    