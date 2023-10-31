<%@ page import="team02.notice.NoticeDAO" %>
<%@ page import="team02.notice.NoticeDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);
    int start = (currentPage - 1) * pageSize + 1;
    int end = currentPage * pageSize;
    int count = 0;
    int number = 0;

    List<NoticeDTO> noticeList = null;
    NoticeDAO dao = NoticeDAO.getInstance();
    count = dao.getNoticeCount();
    if (count > 0) {
        noticeList = dao.getNotice(start, end);
    }
    number = count - (currentPage - 1) * pageSize;
    
    session.setAttribute("askListUrl", request.getRequestURL());
%>
<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
   <jsp:include page="/views/main/nav.jsp" />
   <jsp:include page="/views/main/title.jsp" /><br />
	 <!-- 공지게시판 / noticeList -->
    <h2 align="center">📢 공지사항 📢</h2>
    <br />
	     <% 
		    String memId = (String) session.getAttribute("memId");
		    int grade = dao.getGradeById(memId);
	    	if (grade==99) { %>
	    <div align="center">
	    	<button type="button" class="btn btn-light" OnClick="window.location='noticeForm.jsp'">✏ 공지작성 ✏</button>
	    </div>
    <%}else{ }%>
    <br />

    <% if (count == 0) { %>
    <table align="center">
        <tr>
            <td>문의 글이 없습니다.</td>
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
                <td align="center" width="150"><b>조회수</b></td>
            </tr>
        </thread>
        <% for (int i = 0; i < noticeList.size(); i++) {
            NoticeDTO dto = noticeList.get(i); %>
        <tbody>
            <tr height="30">
                <td align="center" width="50"><%= number-- %></td>
                <td align="center" width="250"><%= dto.getWriter() %></td>
                <td align="center" width="250">
                    <a href="/wherego/views/board/notice/contentNo.jsp?num=<%= dto.getNum() %>&pageNum=<%= currentPage %>">
                        <%= dto.getTitle() %>
                    </a>
                </td>
                <td align="center" width="200"><%= sdf.format(dto.getReg_date()) %></td>
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
	          <a class="page-link" href="noticeList.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
	            <span aria-hidden="true">&laquo; 이전</span>
	          </a>
	        </li>
	        <% }
	        
	        for (int i = startPage; i <= endPage; i++) { %>
	        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
	          <a class="page-link" href="noticeList.jsp?pageNum=<%= i %>"><%= i %></a>
	        </li>
	        <% }
	        
	        if (endPage < pageCount) { %>
	        <li class="page-item">
	          <a class="page-link" href="noticeList.jsp?pageNum=<%= startPage + 10 %>" aria-label="Next">
	            <span aria-hidden="true">다음 &raquo;</span>
	          </a>
	        </li>
	        <% } 
	    }%>
	  </ul>
	</nav>	

	
    <div >
	<br/><hr /><br/>
		<jsp:include page="/views/main/footer.jsp" />	
	</div>
</body>
</html>