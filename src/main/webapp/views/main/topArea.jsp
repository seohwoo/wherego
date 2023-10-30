<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.main.use.FavoriteLandDAO"%>
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "team02.content.land.LandDAO"%> 
<%@ page import = "team02.location.land.LocationLandDTO"%>     
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<title>TopArea</title>
</head>
<body>
<!-- 틀만작성 , 수정예정 -->
<div class="container text-center">
		<div class="row row-cols-4">
		<%
			FavoriteLandDAO dao = FavoriteLandDAO.getInstance();
			SaveDAO saveDao = SaveDAO.getInstance();
			LandDAO landO = LandDAO.getInstance();
			
			
			ArrayList<HashMap<String, String>> favoriteLandList = dao.findFavoriteLandList();
			
			for(HashMap<String, String> favoriteLandMap : favoriteLandList) {
			    double avg = landO.avgStar(favoriteLandMap.get("contentid"));
			    int totalSave = saveDao.getSaveCount(favoriteLandMap.get("contentid"));
			    int totalReview = landO.getReviewCount(favoriteLandMap.get("contentid"));
			    LocationLandDTO dto = dao.selectLandToCid(favoriteLandMap.get("contentid"));
			    %>
			    <div class="card" style="width: 20rem;">
			  		<img src="<%=dto.getFirstimage() %>" class="card-img-top" />
			  		<div class="card-body">
			    		<h5 class="card-title"><%=dto.getTitle() %></h5>
			    		<p class="card-text"><%=dto.getAreacodename() %> > <%=dto.getSigungucodename() %></p>
			    		<p class="card-text"><%=dto.getCategory() %></p>
			    		<p class="card-text">별점 : <%=avg %></p>
			    		<p class="card-text">별점개수 : <%=totalReview %></p>
			    		<p class="card-text">저장수 : <%=totalSave %></p>
			    		<p class="card-text">조회수 : <%=favoriteLandMap.get("readcount") %></p>
			    		<a href="/wherego/views/contentLand/contentRand.jsp?areaCode=<%=dto.getAreacode() %>&sigunguCode=<%=dto.getSigunguCode() %>&contentid=<%=favoriteLandMap.get("contentid")%>&pageNum=1" class="btn btn-secondary">Go <%=dto.getTitle() %></a>
			  		</div>
			</div>
			    
			<% }%>
		
		
		
		
		
		
		
		
		
		
		
			
		
		</div>
	</div>
</body>
</html>