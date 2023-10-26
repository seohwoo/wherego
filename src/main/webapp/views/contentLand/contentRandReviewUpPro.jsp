<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDAO" %>
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
	String id = (String) session.getAttribute("memId");
	int reviewNum = Integer.parseInt(request.getParameter("reviewnum"));
	ArrayList<String> ReviewUpIdList = new ArrayList<String>();
	LandDAO landO = LandDAO.getInstance();
	ReviewUpIdList = landO.selectReviewUpId(reviewNum);
	String chkId = "";
	int chkIdValue = 0;
	for (int i = 0; i < ReviewUpIdList.size(); i++){
		chkId = ReviewUpIdList.get(i);
		if(chkId == null){
			chkId = "null";
		}
		if (chkId.equals(id)){
			chkIdValue = 1;
		}
	}
	if(chkIdValue == 0){
	landO.insertReviewUp(contentid,id,reviewNum);
	%>
	<script>
	alert("UP 완료!")
	location.href = "/wherego/views/contentLand/contentRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&contentid=<%=contentid%>&pageNum=<%=pageNum%>";
	</script>
	<%}
	else{%>
		<script>
		history.go(-1)
		alert("이미UP을 하셧습니다.")
		</script>
	<%}
%>
</body>
</html>