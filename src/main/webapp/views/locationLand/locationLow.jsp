<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.location.land.LocationLandDAO"%>    
<%@ page import = "team02.location.land.LocationLandDTO"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디Go</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
	<%
		String location = request.getParameter("location");
		String areaCode = request.getParameter("areaCode");	
	%>
	<h1><%=location %></h1>
	<%
		LocationLandDAO dao = LocationLandDAO.getInstance();
		ArrayList<LocationLandDTO> list = new ArrayList<LocationLandDTO>();	
		list = dao.selectSigunguCode(areaCode);
		for(LocationLandDTO dto : list) {%>
		<a href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=dto.getSigunguCode()%>&pageNum=1"><%=dto.getSigungucodename() %></a>
	<%}
	%>
	<jsp:include page="/views/main/footer.jsp" />
</body>
</html>