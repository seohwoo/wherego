<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import = "team02.mylist.MyListDAO" %>
<% request.setCharacterEncoding("UTF-8");%>


<jsp:useBean id="article" scope="page" class="team02.mylist.MyListDTO">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>




<%
 	
    String pageNum = request.getParameter("pageNum");

	MyListDAO dbPro = MyListDAO.getInstance();
	int check = dbPro.updateArticle(article);
    
    
    response.sendRedirect("board.jsp");
	
 %>  