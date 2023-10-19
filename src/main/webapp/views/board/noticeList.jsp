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
    
    session.setAttribute("noticeListUrl", request.getRequestURL());
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
   <%@ include file="/views/main/nav.jsp" %>
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	 <!-- noticeList -->
    <h2 align="center">📢 공지게시판 📢</h2>
    <br />
    <div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='noticeForm.jsp'">✏ 공지 작성 ✏</button>
    </div>
    <br />

    <% if (count == 0) { %>
    <table align="center">
        <tr>
            <td>공지사항이 없습니다.</td>
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
                    <a href="/team02/views/board/noticeContent.jsp?num=<%= dto.getNum() %>&pageNum=<%= currentPage %>">
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

    <div >
	<br/><hr /><br/>
		<%@ include file="/views/main/footer.jsp" %>	
	</div>
</body>
</html>
