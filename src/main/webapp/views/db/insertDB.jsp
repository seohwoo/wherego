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
<title>어디GO</title>
</head>
<body>

	<%
		API_used api = API_used.getInstance();
		String[] beforeAreaCode1 = {"1", "2", "3", "4", "5", "6", "7", "8", "31"};
		String[] beforeAreaCode = {"37"};
		
		for(String area : beforeAreaCode) {
			int beforeSigunguCode = Integer.parseInt(api.findSubLocation(area));
			for(int i=1; i<=beforeSigunguCode; i++) {
				String scode = String.valueOf(i);
			
		
				HashMap<String, String> totalMap = new HashMap<String, String>();		
				totalMap = api.findTotalCount_NumOfRows(area, scode);
				int totalCount = Integer.parseInt(totalMap.get("totalCount"));
				
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