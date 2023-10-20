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
		LandInfoDAO dao  = LandInfoDAO.getInstance();
		
		
 		
		ArrayList<String> list = new ArrayList<String>();
		list = dao.selectContentId("1");
		HashMap<String, String> landInfoMap = new HashMap<String, String>();
		HashMap<String, String> landDetailMap = new HashMap<String, String>();
		
		
		
		for(int i=0; i<list.size(); i++) {
			landInfoMap = api.findRandInfo(list.get(i));
			String[] arLandInfo = new String[2];
			arLandInfo[0] = landInfoMap.get("homepage");
			arLandInfo[1] = landInfoMap.get("overview");
			
			landDetailMap = api.findDetailRandInfo(list.get(i));
			String[] arLandDetail = new String[6];
			arLandDetail[0] = landDetailMap.get("infocenter");
			arLandDetail[1] = landDetailMap.get("restdate");
			arLandDetail[2] = landDetailMap.get("usetime");
			arLandDetail[3] = landDetailMap.get("parking");
			arLandDetail[4] = landDetailMap.get("chkbabycarriage");
			arLandDetail[5] = landDetailMap.get("chkpet");
			
			ArrayList<String> categoryList = new ArrayList<String>();
			categoryList = dao.selectCategory(list.get(i));
			String category = api.findCategory(categoryList.get(0), categoryList.get(1), categoryList.get(2));
			
			dao.updateLand(arLandInfo[0], arLandInfo[1], arLandDetail[0], arLandDetail[1], arLandDetail[2], arLandDetail[3], arLandDetail[4], arLandDetail[5], category, list.get(i));
			
		}
		%>	
</body>
</html>