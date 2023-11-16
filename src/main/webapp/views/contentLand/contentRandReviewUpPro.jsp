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
	if(session.getAttribute("memId") == null){%>
		<script>
		history.go(-1)
		alert("로그인후 사용가능합니다.")
		</script>
	<%}
	else{
	String id = (String) session.getAttribute("memId");
	String contentid = request.getParameter("contentid");
	String areaCode = request.getParameter("areaCode");
	String sigunguCode = request.getParameter("sigunguCode");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
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
	landO.updateReviewLikes(reviewNum);
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
	}
%>
</body>
</html>