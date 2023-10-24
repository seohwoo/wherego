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
		//start form
		LocationLandDAO dao = LocationLandDAO.getInstance();
		ArrayList<LocationLandDTO> list = new ArrayList<LocationLandDTO>();	
	
		list = dao.selectAreaCode();
		
		for(LocationLandDTO dto : list) {%>
			<a href="locationLow.jsp?location=<%=dto.getAreacodename()%>&areaCode=<%=dto.getAreacode()%>"><%=dto.getAreacodename() %></a>
		<%}
	%>
	<jsp:include page="/views/main/footer.jsp" />
</body>
</html>