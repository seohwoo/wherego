<%@ page language="java" contentType="text/html; charset=UTF-8"   
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "team02.main.use.SearchDAO"%>
<%@ page import = "java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>
<!DOCTYPE html>
<html>
<head>
<title>이번주 추천 여행지 보기</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
	 
	  String id = "";
	  if(session.getAttribute("memId")!=null) {
     	id = (String) session.getAttribute("memId");  		
	  }

      int num = Integer.parseInt(request.getParameter("num"));  
      String pageNum = request.getParameter("pageNum");
      
      SearchDAO dao = SearchDAO.getInstance();
      LandDAO landO = LandDAO.getInstance();
      MagDAO dbPro = MagDAO.getInstance();
      MagDTO mag = dbPro.getmag(num);  // 번호에 맞는 내용
      
      String[] arContetid = mag.getContentid().split(",");
      
      
%>


<jsp:include page="/views/main/nav.jsp" />	
<jsp:include page="/views/main/title.jsp" /> <br />
   
   <%if(id != null) { %>
   <form>
   <h3 align="center"><%=mag.getSubject()%></h3> <br />
   <table align="center">
       <tr>      
       <td> 
       <%
          if(id != null) {
            if(id.equals("admin")) {%>
            <input type="button" class="btn btn-outline-dark" value="매거진 삭제" 
            onclick="document.location.href='magDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" style="float: right;">
            &nbsp;&nbsp;&nbsp;&nbsp;       
         <%}%>
      
        <input type="button" class="btn btn-outline-dark" value="매거진 목록" 
        onclick="document.location.href='magList.jsp?pageNum=<%=pageNum%>'" style="float: right;">
        &nbsp;&nbsp;&nbsp;&nbsp;
     </td>      
     <%}%>      
    </tr>   
   <%}%>  
     <tr>
       <td>
       <div class="text-center">
      	 <pre style="font-family: 'Pretendard-Regular', sans-serif;"><%=mag.getContent()%></pre>
       </div>
       <br />
       <p align="center" style="font-family: 'Pretendard-Regular', sans-serif;">⏬ 자세한 주소와 정보 ⏬ </p>
       
       <div class="container text-center">
	    <div class="row"> <!-- 새로운 row를 시작 -->
	        <%
	            int cardCount = 0; // 현재 출력된 카드 수를 추적
	            for(String contentid : arContetid) { 
	                // 정보 불러오기
	                HashMap<String, String> DetailrandInfoMap = landO.selectContentRandInfo(contentid);      
	                String src = "";
	        %>
	        <div class="col-md-4"> <!-- 각 카드는 4개의 칼럼을 차지 (3개까지 출력) -->
	            <ul class="list-group list-group-flush">
	                <div class="card">
	                    <img src="<%=DetailrandInfoMap.get("firstimage") %>" class="card-img-top" width="200" height="200"/>
	                    <div class="card-body">
	                        <li class="list-group-item">
	                            <a href="/wherego/views/contentLand/contentRand.jsp?contentid=<%=contentid%>&pageNum=1">
	                                <%=DetailrandInfoMap.get("title") %>
	                            </a>
	                        </li>
	                        <li class="list-group-item"><%=DetailrandInfoMap.get("category") %></li>
	                        <li class="list-group-item"><%=DetailrandInfoMap.get("areacodename") %> > <%=DetailrandInfoMap.get("sigungucodename") %></li>
	                    </div>
	                </div>
	            </ul>
	        </div>
	        <%
	            cardCount++;
	            if (cardCount % 3 == 0) { // 3개 카드마다 새로운 row를 시작
	        %>
	    </div>
	    <div class="row"> <!-- 새로운 row를 시작 -->
	        <%
	            }
	        } // 반복문 종료
	        %>
	    </div>
	</div>
	<br />
	<p align="center" style="font-family: 'Pretendard-Regular', sans-serif;">⏬ 지도에서 보기 ⏬ </p>
 <div class="container text-center" id="map" style="width:980px; height:400px; border-radius: 15px;"></div>
       	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4a9d59c81d3321fd7e3b885e4c1f6fcc"></script>
		<script>
		var positions = [];
		<%	
			double x=0.0, y=0.0, fistX=0.0, fistY=0.0;
			int cnt=1;
			for(String contentid : arContetid) {
				HashMap<String, String> xyMap = dao.selectMapXY(contentid);
				HashMap<String,String> DetailrandInfo = landO.selectContentRandInfo(contentid);
				y = Double.parseDouble(xyMap.get("mapx"));
				x = Double.parseDouble(xyMap.get("mapy"));
				if(cnt==1) {
					fistX = x;
					fistY = y;
					cnt++;
				}
			%>
			var newPosition = {
					title: ' <%=DetailrandInfo.get("title")%> ',
					latlng: new kakao.maps.LatLng(<%=x%>, <%=y%>),
					contentid: '<%=contentid%>',
					areacode: '<%=DetailrandInfo.get("areacode")%>',
					sigungucode: '<%=DetailrandInfo.get("sigungucode")%>',
					pageNum: '<%=pageNum%>',
					firstimage: '<%=DetailrandInfo.get("firstimage")%>'
			};
			positions.push(newPosition);
		<%}%>
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = { 
		    center: new kakao.maps.LatLng(<%=fistX%>, <%=fistY%>), // 지도의 중심좌표
		    level: 10 // 지도의 확대 레벨
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
		        image : markerImage
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
       
		</td>       
     </tr>   
     
   </table>
   </form>
   
   <br/><hr /><br/>
		<jsp:include page="/views/main/footer.jsp" />
   </body>
</html>  