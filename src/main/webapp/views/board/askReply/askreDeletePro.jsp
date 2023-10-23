<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.askreply.AskreplyDAO" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="askre" scope="page" class="team02.askreply.AskreplyDTO">
   <jsp:setProperty name="notice" property="*"/>
</jsp:useBean>

<% 
	int num = Integer.parseInt(request.getParameter("num"));

	AskreplyDAO dao = AskreplyDAO.getInstance();
	dao.deleteReply(num);
%>
<meta http-equiv="Refresh" content="0;url=askList.jsp" >