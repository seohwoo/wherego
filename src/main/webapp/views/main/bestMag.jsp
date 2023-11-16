<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %> 
<%@ page import = "team02.main.use.FavoriteLandDAO" %>   
<%@ page import = "team02.location.land.LocationLandDTO" %>   
    
<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>BestMagazine</title>
</head>
<body>

<%
	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	MagDAO dao = MagDAO.getInstance();
	MagDTO dto = dao.getRecentMag();
	String[] arContentid = dto.getContentid().split(",");
	
	FavoriteLandDAO daoF = FavoriteLandDAO.getInstance();
	
	Date reg_dateD = inputFormat.parse(dto.getReg_date());
	String reg_date = outputFormat.format(reg_dateD);
%>



<div class="container text-center">
	<div class="card mb-3">
		<div style="display: flex; align-items: center;">
		  <%for(String contentid : arContentid) {
			  LocationLandDTO dtoF = daoF.selectLandToCid(contentid);
		  %>
		  	<img src="<%=dtoF.getFirstimage() %>" class="card-img-top" style="height: 150px;" />
		  <%} %>
	  	</div>
	  <div class="card-body">
	    <h4 class="card-title"><%=dto.getSubject() %></h4>
	    <pre class="card-text" style="font-family: 'Pretendard-Regular', sans-serif;"><%=dto.getContent() %></pre>
	    <p class="card-text"><small class="text-body-secondary"><%=reg_date %></small></p>
	    <a href="/wherego/views/mag/content.jsp?num=<%=dto.getNum() %>&pageNum=1" class="btn btn-secondary"> 매거진 더보기</a>
	  </div>
	</div>
</div>
</body>
</html>