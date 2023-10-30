<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.admin.use.AdminBanDAO" %>
<%@ page import="team02.admin.use.AdminBanDTO" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" scope="page" class="team02.admin.use.AdminBanDTO">
   <jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<% 
	AdminBanDAO dao = AdminBanDAO.getInstance();
	dao.updateBanPost(dto);
%>
<meta http-equiv="Refresh" content="0;url=banContent.jsp?num=<%=dto.getNum()%>" >