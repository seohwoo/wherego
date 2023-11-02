<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.mag.MagDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="mag" scope="page" class="team02.mag.MagDTO">
   <jsp:setProperty name="mag" property="*"/>
</jsp:useBean>
 
<%

   String contentid = request.getParameter("contentid");
	MagDAO dbPro = MagDAO.getInstance();
    dbPro.insertMag(mag);

 response.sendRedirect("/wherego/views/mag/magList.jsp");
%>

