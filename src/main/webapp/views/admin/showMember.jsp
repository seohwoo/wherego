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
			    if (pageNum == null) {
			        pageNum = "1";
			    }

			    int currentPage = Integer.parseInt(pageNum);
			    int startRow = (currentPage - 1) * pageSize + 1;
			    int endRow = currentPage * pageSize;
			    int count = 0;
			    int number=0;


				number=count-(currentPage-1)*pageSize;

				AdminMemberDAO dao = AdminMemberDAO.getInstance();
				ArrayList<AdminMemberDTO> memberList  = new ArrayList<AdminMemberDTO>();
				memberList = dao.selectMember();%>
				<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
			    <tr height="30"> 
			       <td align="center"  width="50"  >id</td> 
			       <td align="center"  width="50"  >이름</td> 
			       <td align="center"  width="50"  >닉네임</td> 
			       <td align="center"  width="50"  >생일</td> 
			       <td align="center"  width="50"  >성별</td> 
			       <td align="center"  width="50"  >주소</td> 
			       <td align="center"  width="50"  >이메일</td> 
			       <td align="center"  width="50"  >휴대폰 번호</td> 
			       <td align="center"  width="50"  >프로필</td> 
			       <td align="center"  width="50"  >가입일</td> 
			    </tr>
			    
				<% for(AdminMemberDTO dto : memberList) {
					Date birthD = inputFormat.parse(dto.getBirth());
					Date reg_dateD = inputFormat.parse(dto.getReg_date());
					String birth = outputFormat.format(birthD);
					String reg_date = outputFormat.format(reg_dateD);
					
				%>
					<tr>
						<td align="center"  width="50"  ><a href="contentMember.jsp?id=<%=dto.getId() %>"><%=dto.getId() %></a></td>
						<td align="center"  width="50"  ><%=dto.getName() %></td>
						<td align="center"  width="50"  ><%=dto.getNic() %></td>
						<td align="center"  width="50"  ><%=birth%></td>
						<td align="center"  width="50"  ><%=dto.getGender() %></td>
						<td align="center"  width="50"  ><%=dto.getAddress() %></td>
						<td align="center"  width="50"  ><%=dto.getEmail() %></td>
						<td align="center"  width="50"  ><%=dto.getPhone() %></td>
						<td align="center"  width="50"  ><%=dto.getProfile() %></td>
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
				        <a href="showMember.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
				<%      }
				        for (int i = startPage ; i <= endPage ; i++) {  %>
				        <a href="showMember.jsp?pageNum=<%= i %>">[<%= i %>]</a>
				<%
				        }
				        if (endPage < pageCount) {  %>
				        <a href="showMember.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
				<%
				        }
				    }
				%>
			<%}
		}%>
			
</body>	
</html>