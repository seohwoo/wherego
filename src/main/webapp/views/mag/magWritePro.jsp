<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.mag.MagDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="mag" scope="page" class="team02.mag.MagDTO">
   <jsp:setProperty name="mag" property="*"/>
</jsp:useBean>
 
<%

	ArrayList<String> contentidList = (ArrayList<String>)session.getAttribute("contentidList");
	String contentid = "";
	for(String cid : contentidList) {
		contentid += cid +",";
	}
	mag.setContentid(contentid);
	MagDAO dbPro = MagDAO.getInstance();
    dbPro.insertMag(mag);

	session.removeAttribute("contentidList");
	response.sendRedirect("/wherego/views/mag/magList.jsp");
%>

