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
		String[] realAreaCode = {"1", "2", "3", "4", "5", "6", "7", "8", "31","32","33","34","35","36","37","38","39"};
		LandInfoDAO dao  = LandInfoDAO.getInstance();
	
		
		String areaCode = realAreaCode[13];
		int realSigunguCode = Integer.parseInt(api.findSubLocation(areaCode));
		for(int i=1; i<=realSigunguCode; i++) {
			String sigunguCode = String.valueOf(i);
			ArrayList<String> list = new ArrayList<String>();
			list = dao.selectContentId(areaCode, sigunguCode);
			
			HashMap<String, String> landInfoMap = new HashMap<String, String>();
			HashMap<String, String> landDetailMap = new HashMap<String, String>();
			HashMap<String, String> category = new HashMap<String, String>();
			
			for(String contentid : list) {
				landInfoMap = api.findRandInfo(contentid);
				String[] arLandInfo = new String[1];
				arLandInfo[0] = landInfoMap.get("homepage");
				
				landDetailMap = api.findDetailRandInfo(contentid);
				String[] arLandDetail = new String[7];
				arLandDetail[0] = landDetailMap.get("infocenter");
				arLandDetail[1] = landDetailMap.get("restdate");
				arLandDetail[2] = landDetailMap.get("usetime");
				arLandDetail[3] = landDetailMap.get("parking");
				arLandDetail[4] = landDetailMap.get("chkbabycarriage");
				arLandDetail[5] = landDetailMap.get("chkpet");
				arLandDetail[6] = landDetailMap.get("expguide");
				
				ArrayList<String> categoryList = new ArrayList<String>();
				categoryList = dao.selectCategory(contentid);
				category = api.findCategory(categoryList.get(0), categoryList.get(1), categoryList.get(2));
				
				dao.updateLand(arLandInfo[0], arLandDetail[6], arLandDetail[0], arLandDetail[1], arLandDetail[2], arLandDetail[3], arLandDetail[4], arLandDetail[5], category.get("name"), contentid);
				
			}
			
		}
		
		
		
 		
		
		
		%>	
</body>
</html>