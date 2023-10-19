<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.mylist.MyListDAO" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

  MyListDAO dbPro = MyListDAO.getInstance();
  int check = dbPro.deleteArticle(num);

  response.sendRedirect("board.jsp");
 %>