<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String contentid = request.getParameter("contentid");
	String areaCode = request.getParameter("areaCode");
	String sigunguCode = request.getParameter("sigunguCode");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	LandDAO landO = LandDAO.getInstance();
	ArrayList<HashMap<String,String>> reviewList = new ArrayList<HashMap<String,String>>();
	reviewList = landO.selectReviewInfo(contentid);
	HashMap<String, String> reviewInfo = new HashMap<String,String>();
%>
<h1>리뷰</h1>
<%	
if(reviewList.isEmpty()){%>
<h4>등록된 리뷰가 없습니다.</h4>
<%}
else{
	for(int i = 0; i < reviewList.size(); i++){
		
		
	reviewInfo = reviewList.get(i);
	int reviewNumCount = 0;
	reviewNumCount = landO.getReviewUpCount(Integer.parseInt(reviewInfo.get("reviewnum")));%>
	<h5>id : <%=reviewInfo.get("id")%></h5>
	<h5>평점 : <%=reviewInfo.get("stars")%></h5>
	<h5>평가 : <%=reviewInfo.get("review")%></h5>
<%

String imgName = "NoImage";
for (int x = 1 ; x <= 5 ; x++){
	String imgSrc = reviewInfo.get("img"+x);
if(imgSrc != null && !imgSrc.equals(imgName))  {%>
<img src="/wherego/image/<%=imgSrc%>">
<%}
}%>
<h5>개시일 : <%=reviewInfo.get("reg_date")%></h5>
<form method="post" action = "contentRandReviewUpPro.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&contentid=<%=contentid%>&pageNum=<%=pageNum%>&reviewnum=<%=reviewInfo.get("reviewnum")%>">
<button>👍UP👍</button> <h5><%=reviewNumCount %>명이 UP을 했습니다.</h5>
<input type = "hidden" value ="<%=reviewInfo.get("reviewnum")%>"/>
</form>
<hr/>
<%}
}
%>

</body>
</html>