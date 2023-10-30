<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.admin.use.AdminMemberDAO"%> 
<%@ page import = "team02.admin.use.AdminMemberDTO"%> 
<!DOCTYPE html>
<html>
<head>
<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />	
	<jsp:include page="/views/main/title.jsp" /><br />
	
	<%!
   		int pageSize = 10;
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
		SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");	
	%>								
	<%
		if(session.getAttribute("memId")==null) {%>
			<script>
	              alert("로그인 후 접속 가능!");
	              window.location = "/wherego/views/main/main.jsp"; 
	       </script>
		<%}else {
			String id = (String)session.getAttribute("memId");
			if(!id.equals("admin")) {%>
				<script>
	              alert("관리자만 접속 가능!");
	              window.location = "/wherego/views/main/main.jsp"; 
	       		</script>
			<%}else{
			    String pageNum = request.getParameter("pageNum");
			    int currentPage = Integer.parseInt(pageNum);
			    int start = (currentPage - 1) * pageSize + 1;
			    int end = currentPage * pageSize;
			    int count = 0;
				AdminMemberDAO dao = AdminMemberDAO.getInstance();
				ArrayList<AdminMemberDTO> memberList  = new ArrayList<AdminMemberDTO>();
				count = dao.cleanMemberCnt();
				if(count>0) {
					memberList = dao.selectCleanMember(start, end);
				}%>
				<div align="center">
				<h3 align="center">일반사용자 </h3> <br />
				<button type="button" class="btn btn-light" OnClick="window.location='showDirtyMember.jsp?pageNum=1'">탈퇴, 정지 사용자 보기 ⏩</button>
				</div> <br />
				
				<div class="d-grid gap-2 col-6 mx-auto">
				<table class="table table-striped-columns"> 
			    <tr height="30"> 
			       <td align="center"><b>아이디</b></td> 
			       <td align="center"><b>닉네임</b></td> 
			       <td align="center"><b>이메일</b></td> 
			       <td align="center"><b>등급</b></td> 
			       <td align="center"><b>가입일</b></td>  
			    </tr>
			    
				<% for(AdminMemberDTO dto : memberList) {
					Date reg_dateD = inputFormat.parse(dto.getReg_date());
					String reg_date = outputFormat.format(reg_dateD);
					String gradeName = dao.findGradeName(dto.getGrade());
				%>
					<tr>
						<td align="center"><a href="contentMember.jsp?id=<%=dto.getId() %>"><%=dto.getId() %></a></td>
						<td align="center"><%=dto.getNic() %></td>
						<td align="center"><%=dto.getEmail() %></td>
						<td align="center"><%=gradeName%></td>
						<td align="center" ><%=reg_date%></td>
					</tr>
				<%}%>
				</table>
				</div>
				<br />
				
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
				<%
				    if (count > 0) {
				        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
						 
				        int startPage = (int)(currentPage/10)*10+1;
						int pageBlock=10;
				        int endPage = startPage + pageBlock-1;
				        if (endPage > pageCount) endPage = pageCount;
				        
				        if (startPage > 10) {    %>
				        <li class="page-item">
				          <a class="page-link" href="showCleanMember.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
				            <span aria-hidden="true">&laquo; 이전</span>
				          </a>
				        </li>
				<%      }
				        for (int i = startPage ; i <= endPage ; i++) {  %>
				        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
				          <a class="page-link" href="showCleanMember.jsp?pageNum=<%= i %>"><%= i %></a>
				        </li>
				<%
				        }
				        if (endPage < pageCount) {  %>
				        <li class="page-item">
				          <a class="page-link" href="showCleanMember.jsp?pageNum=<%= startPage + 10 %>" aria-label="Next">
				            <span aria-hidden="true">다음 &raquo;</span>
				          </a>
				        </li>
				<% }  } %>
				 </ul>
			</nav>	
			<%}
			
		}%>
		<br /><hr /><br />
		<jsp:include page="/views/main/footer.jsp" />		
</body>	
</html>