<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.location.land.LocationLandDAO"%> 
<%@ page import = "team02.location.land.LocationLandDTO"%> 
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@page import="java.util.ArrayList"%>
<%@page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>어디Go</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
<%
      String areaCode = request.getParameter("areaCode");
      String sigunguCode = request.getParameter("sigunguCode");
 	  String id = (String) session.getAttribute("memId");	
	
      LocationLandDAO dao = LocationLandDAO.getInstance();
      SaveDAO saveDao = SaveDAO.getInstance();
      int totalCount = dao.totalLand(areaCode, sigunguCode);
      
      String p = request.getParameter("pageNum");
      int pageNum = 1;
      if(p != null){
         pageNum = Integer.parseInt(p);
      }
      int pageSize = 20;
   
      int currentPage = pageNum;
      int start = (currentPage - 1) * pageSize + 1;
      int end = currentPage * pageSize;
      
      int max = (totalCount / 20) + 1;
      ArrayList<LocationLandDTO> list = new ArrayList<LocationLandDTO>();  
 
      list = dao.selectLand(areaCode, sigunguCode, start, end);
		
       for(LocationLandDTO dto : list) {%>
	         <img src="<%=dto.getFirstimage() %>" width="200" height="200"/>
	      <a href="/wherego/views/contentLand/contentRand.jsp?areaCode=<%=areaCode %>&sigunguCode=<%=sigunguCode %>&contentid=<%=dto.getContentid()%>&pageNum=<%=pageNum%>" >
	         <h3><%=dto.getTitle() %></h3> 
	      </a>      
	      <span><%=dto.getCategory() %></span>
	      <br />
	      <span><%=dto.getAreacodename() %> > <%=dto.getSigungucodename() %></span>
	      <form action="/wherego/views/locationLand/listLandSavePro.jsp" method="post">
	      	<input type="hidden" name="contentid" value=<%=dto.getContentid() %> />
	      	<input type="hidden" name="areaCode" value=<%=areaCode %> />
	      	<input type="hidden" name="sigunguCode" value=<%=sigunguCode %> />
	      	<input type="hidden" name="pageNum" value=<%=pageNum %> />
	      	<input type="submit" value="저장" />
	      </form> 
	      <hr/>
	      
	<%} %>
	
	
   <%
    if (pageNum > 0) {
        int pageCount = max ;
       
        int startPage = ((pageNum - 1) / 10) * 10 + 1;
      	int pageBlock = 10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage - 1 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage && i <= max; i++) {  %>
        <a href="listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=i%>">[<%=i%>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
	<jsp:include page="/views/main/footer.jsp" />
</body>
</html>