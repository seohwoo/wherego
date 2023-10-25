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
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	<br />
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
	
      %>
      <div align="center">
      <% for(LocationLandDTO dto : list) {%>
	      <div class="card mb-3" style="max-width: 800px;">
			  <div class="row g-0">
			    <div class="col-md-4">
			      <img src="<%=dto.getFirstimage() %>" style="width: 270px; height: 222px;" class="img-fluid rounded-start">
			    </div>
			   
				<button type="button" class="btn btn-outline-dark col-md-8"  onclick="window.location.href='/wherego/views/contentLand/contentRand.jsp?areaCode=<%=areaCode %>&sigunguCode=<%=sigunguCode %>&contentid=<%=dto.getContentid()%>&pageNum=<%=pageNum%>'" >
			      <div class="card-body">
			        <h5 align="left" class="card-title"><%=dto.getTitle() %></h5>
			        <p align="left" class="card-text"><%=dto.getCategory() %></p>
			        <p align="left" class="card-text"><%=dto.getAreacodename() %> > <%=dto.getSigungucodename() %></p>
			        <p align="left" class="card-text"><small >⭐⭐⭐⭐⭐  (5)</small></p>
			        <p align="left" class="card-text"><small >❤  (0)</small></p>
			      </div>
				</button>
			   
			  </div>
			</div>
	      
	      
	      <form action="/wherego/views/locationLand/listLandSavePro.jsp" method="post">
	      	<input type="hidden" name="contentid" value=<%=dto.getContentid() %> />
	      	<input type="hidden" name="areaCode" value=<%=areaCode %> />
	      	<input type="hidden" name="sigunguCode" value=<%=sigunguCode %> />
	      	<input type="hidden" name="pageNum" value=<%=pageNum %> />
	      	<input type="submit" value="저장" />
	      </form> 
	      
	<%} %>
	
	<br />
   <%
    if (pageNum > 0) {
        int pageCount = max ;
       
        int startPage = ((pageNum - 1) / 10) * 10 + 1;
      	int pageBlock = 10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a class="btn btn-outline-primary" href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage - 1 %>">이전</a>
<%      }
        
        for (int i = startPage ; i <= endPage && i <= max; i++) {  %>
        <%} 
        for(int i = startPage ; i <= endPage && i <= max; i++){
        %>
        <a class="btn btn-outline-primary" href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=i%>"><%=i%></a>
        <%}
        if (endPage < pageCount) {  %>
        <a class="btn btn-outline-primary" href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage + 10 %>">다음</a>

       <% }
    }
%>
	</div>
	<br/>
	<hr />
	<br/>
	<jsp:include page="/views/main/footer.jsp" />
</body>
</html>