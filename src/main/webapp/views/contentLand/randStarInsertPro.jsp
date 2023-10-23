<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDAO" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="land" class="team02.content.land.LandDTO">
	<jsp:setProperty name="land" property="*"/>
	</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String contentid = request.getParameter("contentid");
	String id = (String)session.getAttribute("memId");
	
	LandDAO landO = LandDAO.getInstance();
	landO.insertStar(land);

%>

   <script>
	function closeAndRefresh() {
    window.close(); // 현재 창을 닫음
    window.opener.location.reload(); // 원래 창을 새로고침
	}
	</script>

평점이 등록되었습니다.
<input type = "button" value = "닫기" OnClick = "closeAndRefresh();">

</body>
</html>