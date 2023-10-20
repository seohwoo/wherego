<%@ page import="team02.askreply.AskreplyDAO" %>
<%@ page import="team02.askreply.AskreplyDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    int pageSize = 10;
    SimpleDateFormat sdfreply = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    String pageNumre = request.getParameter("pageNumre");
    if (pageNumre == null) {
        pageNumre = "1";
    }
    int currentPage = Integer.parseInt(pageNumre);
    int start = (currentPage - 1) * pageSize + 1;
    int end = currentPage * pageSize;
    int count = 0;
    int number = 0;

    List<AskreplyDTO> askreList = null;
    AskreplyDAO replydao = AskreplyDAO.getInstance();
    count = replydao.getReplyCount();
    if (count > 0) {
        askreList = replydao.getReply(start, end);
    }
    number = count - (currentPage - 1) * pageSize;
    
    session.setAttribute("askListUrl", request.getRequestURL());
%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
	
	 <!-- 문의 리스트 -->
	<br />
	<div class="d-grid gap-2 col-6 mx-auto">
	<div class="card">
		<div class="card-body">
		    <h4 align="center">💭 답변 💭</h4>
		    <br />
		
		
		    <% if (count == 0) { %>
		    <table align="center">
		        <tr>
		            <td>댓글이 없습니다.</td>
		        </tr>
		    </table>
		    <% } else { %>
		    <table width="700" cellpadding="0" cellspacing="0" align="center">
		        <thread>
		            <tr>
		                <td align="center" width="50"><b>#</b></td>
		                <td align="center" width="250"><b>작성자</b></td>
		                <td align="center" width="250"><b>제목</b></td>
		                <td align="center" width="200"><b>날짜</b></td>
		            </tr>
		        </thread>
		        <% for (int i = 0; i < askreList.size(); i++) {
		        	AskreplyDTO replydto = askreList.get(i); %>
		        <tbody>
		            <tr height="30">
		                <td align="center" width="50"><%= number-- %></td>
		                <td align="center" width="250"><%= replydto.getWriter() %></td>
		                <td align="center" width="250"> <%= replydto.getContent() %> </td>
		                <td align="center" width="200"><%= sdfreply.format(replydto.getReg_date()) %></td>
		     
		            </tr>
		        </tbody>
		        <% } %>
		    </table>
		    <% } %>
		
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
			          <a class="page-link" href="askreList.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
			            <span aria-hidden="true">&laquo; 이전</span>
			          </a>
			        </li>
			        <% }
			        
			        for (int i = startPage; i <= endPage; i++) { %>
			        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
			          <a class="page-link" href="askreList.jsp?pageNum=<%= i %>"><%= i %></a>
			        </li>
			        <% }
			        
			        if (endPage < pageCount) { %>
			        <li class="page-item">
			          <a class="page-link" href="askreList.jsp?pageNum=<%= startPage + 10 %>" aria-label="Next">
			            <span aria-hidden="true">다음 &raquo;</span>
			          </a>
			        </li>
			        <% } 
			    } %>
			  </ul>
			</nav>	
		</div>
	</div>
	</div>
</body>
</html>
