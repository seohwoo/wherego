<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.notice.NoticeDAO" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="notice" scope="page" class="team02.notice.NoticeDTO">
   <jsp:setProperty name="notice" property="*"/>
</jsp:useBean>

<% 
	int num = Integer.parseInt(request.getParameter("num"));

	NoticeDAO dao = NoticeDAO.getInstance();
	dao.deleteNotice(num);
%>
<meta http-equiv="Refresh" content="0;url=noticeList.jsp" >