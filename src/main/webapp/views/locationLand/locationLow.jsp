<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.location.land.LocationLandDAO"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디Go</title>
</head>
<body>
	<%
		String location = request.getParameter("location");
		String areaCode = request.getParameter("areaCode");	
	%>
	<h1><%=location %></h1>
	<%
		LocationLandDAO dao = LocationLandDAO.getInstance();
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();	
		list = dao.selectSigunguCode(areaCode);
		for(HashMap<String, String> area : list) {%>
		<a href="listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=area.get("code")%>"><%=area.get("name") %></a>
	<%}
	%>
</body>
</html>