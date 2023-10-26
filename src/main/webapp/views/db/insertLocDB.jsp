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
<title>어디고</title>
</head>
<body>
	<%
		API_used api = API_used.getInstance();
      	String[] realAreaCode = {"1", "2", "3", "4", "5", "6", "7", "8", "31","32","33","34","35","36","37","38","39"};
     	LandInfoDAO dao  = LandInfoDAO.getInstance();
   
      
      String areaCode = realAreaCode[0];
      int realSigunguCode = Integer.parseInt(api.findSubLocation(areaCode));
      for(int i=1; i<=realSigunguCode; i++) {
         String sigunguCode = String.valueOf(i);
         ArrayList<String> ConentidList = new ArrayList<String>();
         ConentidList = dao.selectContentId(areaCode, sigunguCode);
         
         
         for(String contentid : ConentidList) {
        	HashMap<String, String> xyMap = new HashMap<String, String>();
        	xyMap = api.findXY(contentid);
            dao.insertXY(contentid, xyMap.get("mapx"), xyMap.get("mapy"), areaCode, sigunguCode);
         }
      }
      %>
</body>
</html>