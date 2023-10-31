<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.mag.MagDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="mag" scope="page" class="team02.mag.MagDTO">
   <jsp:setProperty name="mag" property="*"/>
</jsp:useBean>
 
<%
	MagDAO dbPro = MagDAO.getInstance();
    dbPro.insertArticle(mag);

    response.sendRedirect("magList.jsp");
%>