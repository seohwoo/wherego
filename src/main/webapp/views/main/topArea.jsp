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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
			    int readCnt = landO.getReadCount(favoriteLandMap.get("contentid"));
			    LocationLandDTO dto = dao.selectLandToCid(favoriteLandMap.get("contentid"));
			    %>

			    <div class="card" style="margin: 0px; padding: 0px;">
			  		<img src="<%=dto.getFirstimage() %>" class="card-img-top" width="200" height="200"/>
			  			<div class="card-body">
				    		<h5 class="card-title"><%=dto.getTitle() %></h5>
				    		<p class="card-text"><%=dto.getAreacodename() %> &#10144; <%=dto.getSigungucodename() %> &#12304;<%=dto.getCategory() %>&#12305;</p>

				    		<p><small style="align-items: center;">
				    		<% for (int i = 1; i <= 5; i++) { %>
							    <% if (i <= avg) { %>
							      <i class="fas fa-star" style="color: #ffc83d;"></i>
							    <% } else if (i - 0.5 <= avg) { %>
							      <i class="fas fa-star-half-alt" style="color: #ffc83d;"></i>
							    <% } else { %>
							      <i class="far fa-star" style="color: #ffc83d;"></i>
							    <% } 
				        }%> <%=avg %> (<%=totalReview %>) &nbsp; ❤ (<%=totalSave %>) &nbsp; 🔎 (<%=readCnt %>)</small></p>

				    		<a href="/wherego/views/contentLand/contentRand.jsp?areaCode=<%=dto.getAreacode() %>&sigunguCode=<%=dto.getSigunguCode() %>&contentid=<%=favoriteLandMap.get("contentid")%>&pageNum=1" class="btn btn-secondary"> 더보기</a>

			  		</div>
			</div>
			    
			<% }%>
		
		
		
		
		
		
		
		
		
		
		
			
		
		</div>
	</div>
</body>
</html>