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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
	<jsp:include page="/views/main/title.jsp" />	
	<br />	
	<div style="width:80%; margin: auto;">
	<div class="total-container" style="width:100%; height:800px;">
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
			        <% for (int i = 1; i <= 5; i++) { %>
					    <% if (i <= avg) { %>
					      <i class="fas fa-star" style="color: #ffc83d;"></i>
					    <% } else if (i - 0.5 <= avg) { %>
					      <i class="fas fa-star-half-alt" style="color: #ffc83d;"></i>
					    <% } else { %>
					      <i class="far fa-star" style="color: #ffc83d;"></i>
					    <% } %>
			        <%}%><%=avg %> (<%=totalReview %>) &nbsp; ❤ (<%=totalSave %>) &nbsp; 🔎 (<%=readCount %>)</small></p>
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
	</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b2ea861437e36479577f200cdf49db21"></script>
<script>

 
var positions = [];
<%	
	double x=0.0, y=0.0, fistX=0.0, fistY=0.0;
	int cnt=1;
	for(LocationLandDTO dto : landList) {
		HashMap<String, String> xyMap = dao.selectMapXY(dto.getContentid());
		y = Double.parseDouble(xyMap.get("mapx"));
		x = Double.parseDouble(xyMap.get("mapy"));
		if(cnt==1) {
			fistX = x;
			fistY = y;
			cnt++;
		}
	%>
	var newPosition = {
		title: ' <%= dto.getTitle()%> ',
		latlng: new kakao.maps.LatLng(<%=x%>, <%=y%>),
		contentid: '<%=dto.getContentid()%>',
		areacode: '<%=dto.getAreacode()%>',
		sigungucode: '<%=dto.getSigunguCode()%>',
		pageNum: '<%=pageNum%>',
		firstimage: '<%=dto.getFirstimage()%>'
	};
	positions.push(newPosition);
<%}%>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
mapOption = { 
    center: new kakao.maps.LatLng(<%=fistX%>, <%=fistY%>+0.25), // 지도의 중심좌표
    level: 9 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });


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
    
    
    
    (function(marker, contentid, areacode, sigungucode, pageNum, title, firstimage) {
        kakao.maps.event.addListener(marker, 'click', function() {
            // 마커를 클릭했을 때 contentid를 사용하여 페이지 이동
            window.location.href = '/wherego/views/contentLand/contentRand.jsp?areaCode='+areacode+'&sigunguCode='+sigungucode+'&contentid='+contentid+'&pageNum='+pageNum; // 페이지 URL을 적절히 수정
        });
        
        kakao.maps.event.addListener(marker, 'mouseover', function(){
        	infowindow.setContent('<div class="custom-infowindow">' + title + '<br><img src="'+firstimage+'" width="250" height="150">');
        	infowindow.open(map, marker);});
        kakao.maps.event.addListener(marker, 'mouseout', function(){infowindow.close();});
        
    })(marker, positions[i].contentid, positions[i].areacode, positions[i].sigungucode, positions[i].pageNum, positions[i].title, positions[i].firstimage);
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
		<div class="text-align">
			<h3>검색이 불가합니다.</h3>
			<div id="countdown">5</div>
		</div>
    	 <script type="text/javascript">
        var countdownElement = document.getElementById("countdown");
        var countdownValue = 5; // 시작 카운트 값

        function updateCountdown() {
            countdownValue--;
            countdownElement.innerText = countdownValue;

            if (countdownValue <= 0) {
                window.location.href = "/wherego/views/main/main.jsp"; // 메인 페이지의 URL로 변경하세요
            } else {
                setTimeout(updateCountdown, 1000); // 1초마다 업데이트
            }
        }

        setTimeout(updateCountdown, 1000); // 초기화 및 시작
    </script>
	<%}%>
	<br/>
	<hr />
	<br/>
	<jsp:include page="/views/main/footer.jsp" />	
</body>

<style>
.custom-infowindow {
  max-width: 300px;
  background: none;
  border: 10px; /* 테두리를 완전히 제거합니다 */
  padding: 10px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  /* 다른 스타일 속성 설정 */
  }
  .total-container {
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