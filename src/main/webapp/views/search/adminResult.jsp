<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.location.land.LocationLandDTO"%> 
<%@ page import = "team02.main.use.SearchDAO"%>
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "team02.content.land.LandDAO"%>     
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
	<jsp:include page="/views/main/title.jsp" /><br />
	<%
		String searchType  = request.getParameter("searchType");
		String searchValue  = request.getParameter("searchValue");
		
		
		int pageSize = 20;
	    String pageNum = request.getParameter("pageNum");
	    if (pageNum == null) {
	        pageNum = "1";
	    }
	    int currentPage = Integer.parseInt(pageNum);
	    int start = (currentPage - 1) * pageSize + 1;
	    int end = currentPage * pageSize;
	    int number = 0;
		
		SearchDAO dao = SearchDAO.getInstance();
		SaveDAO saveDao = SaveDAO.getInstance();
		LandDAO landO = LandDAO.getInstance();
		
		ArrayList<LocationLandDTO> landList = null;
		int count = dao.totalSearchLand(searchValue, searchType);

		if(count>0) {
			landList = dao.searchLand(searchValue, searchType, start, end);
		
		%>
	<div class="d-grid gap-2 col-6 mx-auto">
		<%for(LocationLandDTO dto : landList) {
		      double avg = landO.avgStar(dto.getContentid());
		      int readCount = landO.getReadCount(dto.getContentid());
			  int totalSave = saveDao.getSaveCount(dto.getContentid());
			  int totalReview = landO.getReviewCount(dto.getContentid());
	%>
		<div class="card mb-3" style="max-width: 800px;">
			  <div class="row g-0">
			    <div class="col-md-4">
					<img src="<%=dto.getFirstimage() %>" style="width: 270px; height: 146px;" class="img-fluid rounded-start">
			    </div>  
				<button type="button" class="btn btn-outline-dark col-md-8"  onclick="window.location.href='/wherego/views/mag/magSearch.jsp?contentid=<%=dto.getContentid() %>&PageNum=<%=pageNum %>'" >
			      <div class="card-body">
			        <h5 align="left" class="card-title"><%=dto.getTitle() %></h5>
			        <p align="left" class="card-text"><%=dto.getAreacodename() %> &#10144; <%=dto.getSigungucodename() %> &#12304;<%=dto.getCategory() %>&#12305;</p>
			         <p align="left" class="card-text"><small >
			        <% for (int i = 1; i <= 5; i++) { %>
					    <% if (i <= avg) { %>
					      <i class="fas fa-star" style="color: #ffc83d;"></i>
					    <% } else if (i - 0.5 <= avg) { %>
					      <i class="fas fa-star-half-alt" style="color: #ffc83d;"></i>
					    <% } else { %>
					      <i class="far fa-star" style="color: #ffc83d;"></i>
					    <% } %>
			        <%}%><%=avg %> (<%=totalReview %>) &nbsp; ❤ (<%=totalSave %>) &nbsp; 🔎 (<%=readCount %>)</small></p>
			      </div>
				</button>
			   
			  </div>
			</div>
			<%} %>
			</div>
			<br />
  		<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <% if (count > 0) {
	        int pageCount = count / pageSize + ((count % pageSize == 0) ? 0 : 1);
	        int startPage = (int)(currentPage / 10) * 10 + 1;
	        int pageBlock = 10;
	        int endPage = startPage + pageBlock - 1;
	        if (endPage > pageCount) endPage = pageCount;
	        
	        if (startPage > 10) { %>
	        <li class="page-item">
	          <a class="page-link" href="adminResult.jsp?pageNum=<%= startPage - 10 %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>" aria-label="Previous">
	            <span aria-hidden="true">&laquo; 이전</span>
	          </a>
	        </li>
	        <% }
	        
	        for (int i = startPage; i <= endPage; i++) { %>
	        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
	          <a class="page-link" href="adminResult.jsp?pageNum=<%= i %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%= i %></a>
	        </li>
	        <% }
	        
	        if (endPage < pageCount) { %>
	        <li class="page-item">
	          <a class="page-link" href="adminResult.jsp?pageNum=<%= startPage + 10 %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>" aria-label="Next">
	            <span aria-hidden="true">다음 &raquo;</span>
	          </a>
	        </li>
	        <% } 
	    } %>
	    
	  </ul>
	</nav>
	<%}else{%>
			<table align="center">
		        <tr>
		            <td>문의 글이 없습니다.</td>
		        </tr>
    		</table>
		    <button type="button" class="btn btn-light" OnClick="window.location='/wherego/views/main/main.jsp'">✏ 문의하기 ✏</button>
			
		<%}%>
		<br /><hr /><br />
	<jsp:include page="/views/main/footer.jsp" />	
</body>
</html>