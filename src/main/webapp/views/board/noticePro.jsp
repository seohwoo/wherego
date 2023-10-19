<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.notice.NoticeDAO" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="notice" scope="page" class="team02.notice.NoticeDTO">
   <jsp:setProperty name="notice" property="*"/>
</jsp:useBean>

<% 
	NoticeDAO dao = NoticeDAO.getInstance();
	dao.insertNotice(notice);
	
	response.sendRedirect("noticeList.jsp");
%>