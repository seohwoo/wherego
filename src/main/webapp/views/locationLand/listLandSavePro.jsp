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
	              window.location = "/wherego/views/locationLand/listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=pageNum%>"; 
	          </script>
	    <%}else{
		SaveDAO dao = SaveDAO.getInstance();
		if(dao.isSave(contentid, id)==0) {
			dao.insertSave(contentid, id);
		}else{
			dao.deleteSave(contentid, id);
		}
		
		response.sendRedirect("/wherego/views/locationLand/listRand.jsp?areaCode=" + areaCode + "&sigunguCode="+ sigunguCode +"&pageNum="+ pageNum);
	    }
	%>
	
</body>
</html>