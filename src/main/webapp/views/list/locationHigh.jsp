<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team02.list.API_used" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디Go</title>
</head>
<body>
	<%
		//start form
		API_used api = API_used.getInstance();
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();	
	
		list = api.findLocation("");
		
		for(HashMap<String, String> area : list) {%>
			<a href="locationLow.jsp?location=<%=area.get("name")%>&areaCode=<%=area.get("code")%>"><%=area.get("name") %></a>
		<%}
	%>
</body>
</html>