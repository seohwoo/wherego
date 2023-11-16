<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.user.save.SaveDAO"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디Go</title>
</head>
<body>
	
	<%	
		String contentid = request.getParameter("contentid");
		String areaCode = request.getParameter("areaCode");
		String sigunguCode = request.getParameter("sigunguCode");
		String pageNum = request.getParameter("pageNum");
		String id = (String)session.getAttribute("memId");
	
	
	    if (id == null) {%>
	          <script>
	              alert("로그인 후 사용 가능!");
	              window.location = "/wherego/views/contentLand/contentRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=pageNum%>&contentid=<%=contentid%>"; 
	          </script>
	    <%}else{
		SaveDAO dao = SaveDAO.getInstance();
		int isSave = dao.isSave(contentid, id);
		if(isSave==0) {
			dao.insertSave(contentid, id);
		%>
		<script>
		    alert("저장 완료..!!");
		    window.location = "/wherego/views/contentLand/contentRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=pageNum%>&contentid=<%=contentid%>";
		</script>	
		<% }else{
			dao.deleteSave(contentid, id);
		%>
			<script>
		    alert("취소되었습니다");
		    window.location = "/wherego/views/contentLand/contentRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=pageNum%>&contentid=<%=contentid%>";
			</script>
		<%	
			}
	    }
		%>
	
	
</body>
</html>