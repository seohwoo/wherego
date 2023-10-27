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
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />	
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
				<button type="button" OnClick="window.location='showDirtyMember.jsp?pageNum=1'">탈퇴, 금지 유저 보기 >>></button>
				
				<table border="1" width="700" align="center"> 
			    <tr height="30"> 
			       <td align="center"  width="50"  >id</td> 
			       <td align="center"  width="50"  >닉네임</td> 
			       <td align="center"  width="50"  >성별</td> 
			       <td align="center"  width="50"  >이메일</td> 
			       <td align="center"  width="50"  >휴대폰 번호</td> 
			       <td align="center"  width="50"  >등급</td> 
			       <td align="center"  width="50"  >가입일</td> 
			    </tr>
			    
				<% for(AdminMemberDTO dto : memberList) {
					Date reg_dateD = inputFormat.parse(dto.getReg_date());
					String reg_date = outputFormat.format(reg_dateD);
					String gradeName = dao.findGradeName(dto.getGrade());
				%>
					<tr>
						<td align="center"  width="50"  ><a href="contentMember.jsp?id=<%=dto.getId() %>"><%=dto.getId() %></a></td>
						<td align="center"  width="50"  ><%=dto.getNic() %></td>
						<td align="center"  width="50"  ><%=dto.getGender() %></td>
						<td align="center"  width="50"  ><%=dto.getEmail() %></td>
						<td align="center"  width="50"  ><%=dto.getPhone() %></td>
						<td align="center"  width="50"  ><%=gradeName%></td>
						<td align="center"  width="50"  ><%=reg_date%></td>
					</tr>
				<%}%>
				</table>
				<%
				    if (count > 0) {
				        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
						 
				        int startPage = (int)(currentPage/10)*10+1;
						int pageBlock=10;
				        int endPage = startPage + pageBlock-1;
				        if (endPage > pageCount) endPage = pageCount;
				        
				        if (startPage > 10) {    %>
				        <a href="showCleanMember.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
				<%      }
				        for (int i = startPage ; i <= endPage ; i++) {  %>
				        <a href="showCleanMember.jsp?pageNum=<%= i %>">[<%= i %>]</a>
				<%
				        }
				        if (endPage < pageCount) {  %>
				        <a href="showCleanMember.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
				<%
				        }
				    }
				%>
			<%}
			
		}%>
		<jsp:include page="/views/main/footer.jsp" />		
</body>	
</html>