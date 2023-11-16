<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.location.land.LocationLandDAO"%>  
<%@ page import = "team02.location.land.LocationLandDTO"%>  
<!DOCTYPE html>
<html>
<head>
<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
<meta charset="UTF-8">
<title>어디Go</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
	<jsp:include page="/views/main/title.jsp" />
	
	<br />
	<h4 align="center">가고싶은<mark>지역</mark>을 골라보세요!</h4> <br />
	<%
		//start form
		LocationLandDAO dao = LocationLandDAO.getInstance();
		ArrayList<LocationLandDTO> list = new ArrayList<LocationLandDTO>();	
	
		list = dao.selectAreaCode();%>
		<div class="d-grid gap-2 col-6 mx-auto">
		<%for(LocationLandDTO dto : list) {%>
			<a class="btn btn-outline-primary" href="locationLow.jsp?location=<%=dto.getAreacodename()%>&areaCode=<%=dto.getAreacode()%>"><%=dto.getAreacodename() %></a>
		<%}%>
		</div>
		
	<br/>
	<hr />
	<br/>
	<jsp:include page="/views/main/footer.jsp" />
</body>
</html>