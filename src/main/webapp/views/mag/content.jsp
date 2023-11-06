<%@ page language="java" contentType="text/html; charset=UTF-8"   
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "team02.main.use.SearchDAO"%>
<%@ page import = "java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>

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

<center>
   <h3>메거진 내용 보기</h3>
   
   <%if(id != null) { %>
   <form>
   <table border="1"  align="center">
     
     <tr>
       <td align="center" ">글번호</td>
       <td align="center"  align="center">
           <%=mag.getNum()%></td>  
           <td align="center" width="125" >작성일</td>
       <td align="center"  align="center">
           <%=mag.getReg_date() %></td>    
     </tr>   
     
     
     <tr height="30">
       <td align="center"  >작성자</td>
       <td align="center"  align="center" >
           여기어때 </td>       
     </tr>
     <tr height="30">
       <td align="center"  >글제목</td>
       <td align="center"  align="center" >
           <%=mag.getSubject()%></td>
     </tr>
     <tr>
       <td align="center" >글내용</td>       
       <td align="left"  >
       <div id="map" style="width:500px;height:400px;"></div>
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
		<br />
       <pre><%=mag.getContent()%></pre>
       <br />
		<%
			for(String contentid : arContetid) { 
			// 정보 불러오기
			
		  	HashMap<String,String> DetailrandInfoMap = landO.selectContentRandInfo(contentid);      
			String src = "";
		%>
		<ul class="list-group list-group-flush"> 
			    <img src="<%=DetailrandInfoMap.get("firstimage") %>" class="card-img-top" width="200" height="200"/>
			    <li class="list-group-item">
			    	<a href="/wherego/views/contentLand/contentRand.jsp?contentid=<%=contentid%>&pageNum=1">
			    		<%=DetailrandInfoMap.get("title") %>
			    	</a>
			    </li>
			    <li class="list-group-item"><%=DetailrandInfoMap.get("category") %></li>
			    <li class="list-group-item"><%=DetailrandInfoMap.get("areacodename") %> > <%=DetailrandInfoMap.get("sigungucodename") %></li>
		</ul>
		<%} %>
		</td>       
     </tr>   
     
     <tr >      
       <td align="right" > 
       <%
          if(id != null) {
            if(id.equals("admin")) {%>
            <input type="button" value="글수정" 
            onclick="document.location.href='magUpdateForm.jsp?num=<%=mag.getNum()%>&pageNum=<%=pageNum%>'">
            &nbsp;&nbsp;&nbsp;&nbsp;       
         <%}%>
      
        <input type="button" value="글목록" 
        onclick="document.location.href='magList.jsp?pageNum=<%=pageNum%>'">
        &nbsp;&nbsp;&nbsp;&nbsp;
     </td>      
     <%}%>      
    </tr>   
   <%}%>      
     
   </table>
   </form>
   </body>
</html>  