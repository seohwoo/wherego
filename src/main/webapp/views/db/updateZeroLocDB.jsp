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
     	LandInfoDAO dao  = LandInfoDAO.getInstance();
   
      
      	ArrayList<String> ConentidList = dao.selectNullXY();
      
      
      for(String contentid : ConentidList) {
      	HashMap<String, String> xyMap = api.findXY(contentid);
      	dao.updateXY(contentid, xyMap.get("mapx"), xyMap.get("mapy"), xyMap.get("areacode"), xyMap.get("sigungucode"));
      }
      
      %>
</body>
</html>