<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team02.db.land.API_used" %>    
<%@ page import="team02.db.land.LandInfoDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		//areaCode 순서대로 DB에 넣기
		API_used api = API_used.getInstance();
		String[] beforeAreaCode = {"1", "2", "3", "4", "5", "6", "7", "8", "31", "32", "33", "34", "35", "36", "37", "38", "39"};
		
		
		for(String area : beforeAreaCode) {
			String beforeSigunguCode = api.findSubLocation(area);
			int maxSigunguCode = Integer.parseInt(beforeSigunguCode);
			for(int i=1; i<=maxSigunguCode; i++) {
				String scode = String.valueOf(i);
			
		
				HashMap<String, Integer> totalMap = new HashMap<String, Integer>();		
				//totalMap = api.findTotalCount_NumOfRows(area, scode);
				int totalCount = totalMap.get("totalCount");
				
				
				String p = request.getParameter("pageNum");
			      int pageNum = 1;
			      
			      int max = (totalCount / 20) + 1;
			      ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();  
			      LandInfoDAO dao = LandInfoDAO.getInstance();
			      
			      for(pageNum=1; pageNum<=max; pageNum++) {
			    	  list = api.findFestival(area,scode,pageNum);
			    	  for(HashMap<String, String> festival : list) {
			    		  String contentId = festival.get("contentid");
			    		  String areaCode = festival.get("areacode");
			    		  String sigunguCode = festival.get("sigungucode");
			    		  String title = festival.get("title");
			    		  String addr1 = festival.get("addr1");
			    		  String firstImage = festival.get("firstimage");
			    		  String cat1 = festival.get("cat1");
			    		  String cat2 = festival.get("cat2");
			    		  String cat3 = festival.get("cat3");
			    		  dao.insertFestival(contentId, areaCode, sigunguCode, title, addr1, firstImage, cat1, cat2, cat3);
			    	  }
			      }
			}
		}
	
	%>


</body>
</html>