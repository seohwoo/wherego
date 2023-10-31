<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team02.inquire.board.InquireDAO" %>
<%@ page import="team02.inquire.board.InquireDTO" %>
    
<%
    int pageSize = 10;
	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");

    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);
    int start = (currentPage - 1) * pageSize + 1;
    int end = currentPage * pageSize;
    int count = 0;
    int number = 0;

    ArrayList<InquireDTO> inquireList = null;
    InquireDAO dao = InquireDAO.getInstance();
    count = dao.getInquireCount();
    if (count > 0) {
    	inquireList = dao.findInquireList(start, end);
    }
    number = count - (currentPage - 1) * pageSize;
    
    session.setAttribute("banListUrl", request.getRequestURL());
%>
<!DOCTYPE html>
<html>
<head>
	<title>어디 Go</title>
</head>
<body>
   <jsp:include page="/views/main/nav.jsp" />
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	 <!-- 문의 리스트 -->
    <h2 align="center">❓ 문의게시판 ❓</h2>
    <br />
    <div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='inquireForm.jsp'">✏ 문의하기 ✏</button>
    	<button type="button" class="btn btn-light" OnClick="window.location='inquireMyList.jsp?pageNum=1'">나의 문의글</button>
    </div>
    <br />

    <% if (count == 0) { %>
    <table align="center">
        <tr>
            <td>문의 글이 없습니다.</td>
        </tr>
    </table>
    <% } else { %>
    <table width="700" cellpadding="0" cellspacing="0" align="center">
        <thead>
            <tr>
                <td align="center" width="50"><b>#</b></td>
                <td align="center" width="250"><b>작성자</b></td>
                <td align="center" width="250"><b>제목</b></td>
                <td align="center" width="200"><b>날짜</b></td>
                <td align="center" width="150"><b>조회수</b></td>
            </tr>
        </thead>
        <% for (InquireDTO dto : inquireList) {
        	Date reg_dateD = inputFormat.parse(dto.getReg_date());
			String reg_date = outputFormat.format(reg_dateD);
            %>
        <tbody>
            <tr height="30">
                <td align="center" width="50"><%= number-- %></td>
                <td align="center" width="250"><%= dto.getWriter() %></td>
                <td align="center" width="250">
                    <a href="/wherego/views/board/inquire/inquireContent.jsp?num=<%= dto.getNum() %>&pageNum=<%= currentPage %>">
                        <%= dto.getTitle() %>
                    </a>
                </td>
                <td align="center" width="200"><%= reg_date %></td>
                <td align="center" width="150"><%= dto.getReadcount() %></td>
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
	          <a class="page-link" href="banList.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
	            <span aria-hidden="true">&laquo; 이전</span>
	          </a>
	        </li>
	        <% }
	        
	        for (int i = startPage; i <= endPage; i++) { %>
	        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
	          <a class="page-link" href="banList.jsp?pageNum=<%= i %>"><%= i %></a>
	        </li>
	        <% }
	        
	        if (endPage < pageCount) { %>
	        <li class="page-item">
	          <a class="page-link" href="banList.jsp?pageNum=<%= startPage + 10 %>" aria-label="Next">
	            <span aria-hidden="true">다음 &raquo;</span>
	          </a>
	        </li>
	        <% } 
	    } %>
	  </ul>
	</nav>	

	
    <div >
	<br/><hr /><br/>
		<jsp:include page="/views/main/footer.jsp" />	
	</div>
</body>
</html>