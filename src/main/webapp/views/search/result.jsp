<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.location.land.LocationLandDTO"%> 
<%@ page import = "team02.main.use.SearchDAO"%>
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "team02.content.land.LandDAO"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />	
	<br />	
	<div class="container">
  		<div class="card-container">
	<%
		String searchType  = request.getParameter("searchType");
		String searchValue  = request.getParameter("searchValue");
		
		
		int pageSize = 5;
	    String pageNum = request.getParameter("pageNum");
	    if (pageNum == null) {
	        pageNum = "1";
	    }
	    int currentPage = Integer.parseInt(pageNum);
	    int start = (currentPage - 1) * pageSize + 1;
	    int end = currentPage * pageSize;
	    int number = 0;
		
		SearchDAO dao = SearchDAO.getInstance();
		SaveDAO saveDao = SaveDAO.getInstance();
		LandDAO landO = LandDAO.getInstance();
		
		ArrayList<LocationLandDTO> landList = null;
		int count = dao.totalSearchLand(searchValue, searchType);

		if(count>0) {
			landList = dao.searchLand(searchValue, searchType, start, end);
		
		
		for(LocationLandDTO dto : landList) {
		      double avg = landO.avgStar(dto.getContentid());
		      int readCount = landO.getReadCount(dto.getContentid());
			  int totalSave = saveDao.getSaveCount(dto.getContentid());
			  int totalReview = landO.getReviewCount(dto.getContentid());
	%>
		<div class="card mb-3" style="max-width: 800px;">
			  <div class="row g-0">
			    <div class="col-md-4">
					<img src="<%=dto.getFirstimage() %>" style="width: 270px; height: 146px;" class="img-fluid rounded-start">
			    </div>  
				<button type="button" class="btn btn-outline-dark col-md-8"  onclick="window.location.href='/wherego/views/contentLand/contentRand.jsp?areaCode=<%=dto.getAreacode() %>&sigunguCode=<%=dto.getSigunguCode() %>&contentid=<%=dto.getContentid()%>&pageNum=<%=pageNum%>'" >
			      <div class="card-body">
			        <h5 align="left" class="card-title"><%=dto.getTitle() %></h5>
			        <p align="left" class="card-text"><%=dto.getAreacodename() %> &#10144; <%=dto.getSigungucodename() %> &#12304;<%=dto.getCategory() %>&#12305;</p>
			         <p align="left" class="card-text"><small >
			         <%
			        for(int i = 1; i <= (int)avg; i++){%>
			        	&#11088;
			        <% }
			        if(avg % 1 != 0){%>
			        &#x2606;
			        <%}%><%=avg %> (<%=totalReview %>) &nbsp; ❤ : <%=totalSave %> (0) &nbsp; 🔎 : <%=readCount %></small></p>
			      </div>
				</button>
			   
			  </div>
			</div> 
			<%} %>
			</div>
			

			<br />
			<div class="map-container">
				<div id="map" style="width:100%; height:800px;"></div>
			</div>
	</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4a9d59c81d3321fd7e3b885e4c1f6fcc"></script>
<script>

 
var positions = [];
var x, y;

<%	
	for(LocationLandDTO dto : landList) {
	HashMap<String, String> xyMap = dao.selectMapXY(dto.getContentid());
	double x = Double.parseDouble(xyMap.get("mapx"));
	double y = Double.parseDouble(xyMap.get("mapy"));
	%>
	x = <%=y%>;
	y = <%=x%>;
	var newPosition = {
		title: ' <%= dto.getTitle()%> ',
		latlng: new kakao.maps.LatLng(x, y)
	};
	positions.push(newPosition);
<%}%>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
mapOption = { 
    center: new kakao.maps.LatLng(x, y), // 지도의 중심좌표
    level: 8 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커를 표시할 위치와 title 객체 배열입니다 
/* var positions = [
    {
        title: '카카오', 
        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
    },
    {
        title: '생태연못', 
        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
    },
    {
        title: '텃밭', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        title: '근린공원',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
]; */

// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
}
</script>
	<br />
  	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <% if (count > 0) {
	        int pageCount = count / pageSize + ((count % pageSize == 0) ? 0 : 1);
	        int startPage = (int)(currentPage / 10) * 10 + 1;
	        int pageBlock = 10;
	        int endPage = startPage + pageBlock - 1;
	        if (endPage > pageCount) endPage = pageCount;
	        
	        if (startPage > 10) { %>
	        <li class="page-item">
	          <a class="page-link" href="result.jsp?pageNum=<%= startPage - 10 %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>" aria-label="Previous">
	            <span aria-hidden="true">&laquo; 이전</span>
	          </a>
	        </li>
	        <% }
	        
	        for (int i = startPage; i <= endPage; i++) { %>
	        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
	          <a class="page-link" href="result.jsp?pageNum=<%= i %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%= i %></a>
	        </li>
	        <% }
	        
	        if (endPage < pageCount) { %>
	        <li class="page-item">
	          <a class="page-link" href="result.jsp?pageNum=<%= startPage + 10 %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>" aria-label="Next">
	            <span aria-hidden="true">다음 &raquo;</span>
	          </a>
	        </li>
	        <% } 
	    } %>
	    
	  </ul>
	</nav>
	<%}else{%>
		<table align="center">
			<tr>
				<td>문의 글이 없습니다.</td>
			</tr>
    	</table>
		<button type="button" class="btn btn-light" OnClick="window.location='/wherego/views/main/main.jsp'">✏ 문의하기 ✏</button>
			
	<%}%>
	<br/>
	<hr />
	<br/>
	<jsp:include page="/views/main/footer.jsp" />	
</body>

<style>
  .container {
    display: flex;
  }
  .card-container {
    width: 50%; /* Adjust the width as needed */
    padding: 10px;
  }
  .map-container {
    width: 50%; /* Adjust the width as needed */
    height: 600px;
    padding: 10px;
  }
</style>
</html>