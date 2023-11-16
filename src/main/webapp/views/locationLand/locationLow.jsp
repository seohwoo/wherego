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
	<jsp:include page="/views/main/title.jsp" />

	<br />
	<%
		String location = request.getParameter("location");
		String areaCode = request.getParameter("areaCode");	
	%>
	<h3 align="center"><mark><%=location %></mark></h3> <br />
	<%
		LocationLandDAO dao = LocationLandDAO.getInstance();
		ArrayList<LocationLandDTO> list = new ArrayList<LocationLandDTO>();	
		list = dao.selectSigunguCode(areaCode);%>
		<div class="d-grid gap-2 col-6 mx-auto">
		<%for(LocationLandDTO dto : list) {%>
		<a class="btn btn-outline-primary" href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=dto.getSigunguCode()%>&pageNum=1"><%=dto.getSigungucodename() %></a>
	<%}%>
	</div>
	
	<br/>
	<hr />
	<br/>
	<jsp:include page="/views/main/footer.jsp" />
</body>

</html>