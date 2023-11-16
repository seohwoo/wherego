<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.main.use.SearchDAO"%> 
<%@ page import = "team02.location.land.LocationLandDTO"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>어디GO</title>
</head>
<jsp:include page="/views/main/nav.jsp" />		
<%
		String searchType  = request.getParameter("searchType");
		String searchValue  = request.getParameter("searchValue");
		
		
		int pageSize = 10;
	    String pageNum = request.getParameter("pageNum");
	    if (pageNum == null) {
	        pageNum = "1";
	    }
	    int currentPage = Integer.parseInt(pageNum);
	    int start = (currentPage - 1) * pageSize + 1;
	    int end = currentPage * pageSize;
	    int number = 0;
		
		SearchDAO dao = SearchDAO.getInstance();
		
		ArrayList<LocationLandDTO> landList = null;
		int count = dao.totalSearchLand(searchValue, searchType);

		if(count>0) {
			landList = dao.searchLand(searchValue, searchType, start, end);
		}%>
<body>

<div id="map" style="width:100%;height:600px;"></div>

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
</body>
</html>