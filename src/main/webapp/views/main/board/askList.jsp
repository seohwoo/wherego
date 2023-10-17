<%@ page import="team02.askboard.AskboardDAO" %>
<%@ page import="team02.askboard.AskboardDTO" %>
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

    List<AskboardDTO> askList = null;
    AskboardDAO dao = AskboardDAO.getInstance();
    count = dao.getAskCount();
    if (count > 0) {
        askList = dao.getAsk(start, end);
    }
    number = count - (currentPage - 1) * pageSize;
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
	
	 <!-- 문의 리스트 -->
    <h2 align="center">askList</h2>
    <br />
    <div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='askForm.jsp'">✏ 문의하기 ✏</button>
    	<button type="button" class="btn btn-light" OnClick="window.location='myList.jsp'">나의 문의글</button>
    </div>
    <br />

    <% if (count == 0) { %>
    <table>
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
        <% for (int i = 0; i < askList.size(); i++) {
            AskboardDTO dto = askList.get(i); %>
        <tbody>
            <tr height="30">
                <td align="center" width="50"><%= number-- %></td>
                <td align="center" width="250"><%= dto.getWriter() %></td>
                <td align="center" width="250">
                    <a href="/team02/team2/board/content.jsp?num=<%= dto.getNum() %>&pageNum=<%= currentPage %>">
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
