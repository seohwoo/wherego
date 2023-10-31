<%@page import="java.awt.Window"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="article" scope="page" class="team02.mag.MagDTO">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
 
    String pageNum = request.getParameter("pageNum");

	MagDAO dbPro = MagDAO.getInstance();
	dbPro.updateArticle(article);   
	
	
 %> 
 <meta http-equiv="Refresh" content="0;url=magList.jsp?pageNum=<%=pageNum%>" >