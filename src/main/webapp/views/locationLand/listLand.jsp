<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.location.land.LocationLandDAO"%> 
<%@ page import = "team02.location.land.LocationLandDTO"%> 
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@page import="java.util.ArrayList"%>
<%@page import = "java.util.List" %>
<%@ page import = "team02.content.land.LandDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<title>어디Go</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
	<jsp:include page="/views/main/title.jsp" />
	
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
      int pageSize = 10;
   
      int currentPage = pageNum;
      int start = (currentPage - 1) * pageSize + 1;
      int end = currentPage * pageSize;
      
      int max = (totalCount / 20) + 1;
      ArrayList<LocationLandDTO> list = new ArrayList<LocationLandDTO>();  
 
      list = dao.selectLand(areaCode, sigunguCode, start, end);
	  LandDAO landO = LandDAO.getInstance();
	  
      %>
      <div align="center">
      <% for(LocationLandDTO dto : list) {
      int issave = saveDao.isSave(dto.getContentid(), id);
      int readCount = landO.getReadCount(dto.getContentid());
      double avg = landO.avgStar(dto.getContentid());
      int landSaveCount = landO.getLandSaveCount(Integer.parseInt(dto.getContentid()));
      %>
	      <div class="card mb-3" style="max-width: 800px;">
			  <div class="row g-0">
			    <div class="col-md-4">
					<div style="position: relative; display: inline-block;">
					    <form action="/wherego/views/locationLand/listLandSavePro.jsp" method="post" style="position:absolute;">
						    <input type="hidden" name="contentid" value="<%=dto.getContentid() %>" />
						    <input type="hidden" name="areaCode" value="<%=areaCode %>" />
						    <input type="hidden" name="sigunguCode" value="<%=sigunguCode %>" />
						    <input type="hidden" name="pageNum" value="<%=pageNum %>" />
						    <button type="submit" style="border: none; background: none; cursor: pointer;">
						        <% if(issave == 0){ %><i class="far fa-heart" style="color: #ff0000; font-size: 30px; margin: 10px;"></i>
						        <%}else{%>
						        	<i class="fas fa-heart" style="color: #ff0000; font-size: 30px; margin: 10px;"></i>
						        <%} %>
						    </button>
						</form>

					    <img src="<%=dto.getFirstimage() %>" style="width: 270px; height: 150px;" class="img-fluid rounded-start">
					</div>
			    </div>  
				<button type="button" class="btn btn-outline-dark col-md-8"  onclick="window.location.href='/wherego/views/contentLand/contentRand.jsp?areaCode=<%=areaCode %>&sigunguCode=<%=sigunguCode %>&contentid=<%=dto.getContentid()%>&pageNum=<%=pageNum%>'" >
			      <div class="card-body">
			        <h5 align="left" class="card-title"><%=dto.getTitle() %> </h5>
			        <p align="left" class="card-text"><%=dto.getAreacodename() %> &#10144; <%=dto.getSigungucodename() %> &#12304;<%=dto.getCategory() %>&#12305;</p>
			        <% int reviewCount = landO.getReviewCount(dto.getContentid());%>
			        <p align="left" class="card-text"><small >
			        <% for (int i = 1; i <= 5; i++) { %>
					    <% if (i <= avg) { %>
					      <i class="fas fa-star" style="color: #ffc83d;"></i>
					    <% } else if (i - 0.5 <= avg) { %>
					      <i class="fas fa-star-half-alt" style="color: #ffc83d;"></i>
					    <% } else { %>
					      <i class="far fa-star" style="color: #ffc83d;"></i>
					      <%} %>
			        <%}%><%=avg %> (<%=reviewCount %>) &nbsp; ❤ (<%=landSaveCount %>) &nbsp; 🔎 (<%=readCount %>)</small></p>
			      </div>
				</button>
			   
			  </div>
			</div> 
	<%} %>
	
<br />
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
   <%
    if (pageNum > 0) {
        int pageCount = max ;
       
        int startPage = ((pageNum - 1) / 10) * 10 + 1;
      	int pageBlock = 10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <li class="page-item">
          <a class="page-link" href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage - 10 %>" aria-label="Previous">
            <span aria-hidden="true">&laquo; 이전</span>
          </a>
        </li>
<%      }
        
        for(int i = startPage ; i <= endPage && i <= max; i++){
        %>
        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
          <a class="page-link" href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=i%>"><%= i %></a>
        </li>
        <%}
        if (endPage < pageCount) {  %>
        <li class="page-item">
          <a class="page-link" href="listLand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage + 10 %>" aria-label="Next">
            <span aria-hidden="true">&laquo; 다음</span>
          </a>
        </li>

       <% }
    }
%>
	</div>
	<br/><hr /><br/>
	<jsp:include page="/views/main/footer.jsp" />
</body>

</html>