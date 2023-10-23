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
		//start form
		LocationLandDAO dao = LocationLandDAO.getInstance();
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();	
	
		list = dao.selectAreaCode();
		
		for(HashMap<String, String> area : list) {%>
			<a href="locationLow.jsp?location=<%=area.get("name")%>&areaCode=<%=area.get("code")%>"><%=area.get("name") %></a>
		<%}
	%>
</body>
</html>