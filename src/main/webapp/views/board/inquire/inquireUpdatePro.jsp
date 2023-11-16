<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team02.inquire.board.InquireDAO" %>
<%@ page import="team02.inquire.board.InquireDTO" %>     

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" scope="page" class="team02.inquire.board.InquireDTO">
   <jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<% 
	InquireDAO dao = InquireDAO.getInstance();
	dao.updateInquirePost(dto);
%>
<meta http-equiv="Refresh" content="0;url=inquireList.jsp" >