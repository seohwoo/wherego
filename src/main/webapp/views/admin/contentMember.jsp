<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
	%>
	<h1><%=id %></h1>
</body>
</html>