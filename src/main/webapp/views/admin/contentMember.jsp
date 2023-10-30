<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.admin.use.AdminMemberDAO"%> 
<%@ page import = "team02.admin.use.AdminMemberDTO"%> 
<%@ page import = "team02.admin.use.AdminReviewDTO"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<% if (session.getAttribute("memId") == null) { %>
	    <script>
	        alert("로그인하세요🤬🤬🤬");
	        window.location = "/wherego/views/main/main.jsp";
	    </script>
	<% } %>
	<jsp:include page="/views/main/nav.jsp" />	
	<%!
   		int pageSize = 10;
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
		SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");	
	%>	
	<%
		String id = request.getParameter("id");
		String admin = (String) session.getAttribute("memId");
		AdminMemberDAO dao = AdminMemberDAO.getInstance();
		AdminMemberDTO dto = dao.userInfo(id);
		AdminMemberDTO adminInfo = dao.userInfo(admin);
		
		String gradeName = dao.findGradeName(dto.getGrade());
		Date birthD = inputFormat.parse(dto.getBirth());
		String birth = outputFormat.format(birthD);
		Date reg_dateD = inputFormat.parse(dto.getReg_date());
		String reg_date = outputFormat.format(reg_dateD);
		
		if (adminInfo.getGrade() != 99) { %>
	    <script>
	        alert("관리자만 접속이 가능합니다🤬🤬🤬");
	        window.location = "/wherego/views/main/main.jsp";
	    </script>
	<% }
	%>
	 <img width="150" src="/wherego/image/<%= dto.getProfile() %>"> <br> 
	 <h3><%=dto.getId() %></h3>
	 <h3><%=dto.getName() %></h3>
	 <h3><%=dto.getNic() %></h3>
	 <h3><%=birth %></h3>
	 <h3><%=dto.getGender() %></h3>
	 <h3><%=dto.getAddress() %></h3>
	 <h3><%=dto.getEmail() %></h3>
	 <h3><%=dto.getPhone() %></h3>
	 <h3><%=reg_date %></h3>
	 <h3><%=gradeName%></h3>
	 <form action="userGradeChangeForm.jsp" method="post">
	 	<input type="hidden" name="id" value="<%=id%>"/>
	 	<input type="submit" name="submit" value="등급변경 >>>"/>
	 </form>
	 <hr />
	 <h3>글수 : <%=dto.getTotal() %></h3>
	 <%
	 	ArrayList<AdminReviewDTO> reviewList = new ArrayList<AdminReviewDTO>();
		reviewList = dao.findUserReviews(id);
	 	if(reviewList.size()==0) {%>
	 		<h3>작성한 글이 없습니다...😪</h3>
	 	<%}else{
	 	for(AdminReviewDTO rDto : reviewList) {
	 		Date reg_date_RD = inputFormat.parse(rDto.getReg_date_R());
			String reg_date_R = outputFormat.format(reg_date_RD);
	 	
	 	%>
	 		<img width="150" src="/wherego/image/<%= dto.getProfile() %>"> <br>
	 		<h5><%=dto.getNic() %></h5>
	 		<img width="150" src="<%= rDto.getFirstimage() %>"> <br>
	 		<h5><%=rDto.getTitle() %></h5>
	 		<h5><%=rDto.getAreacodename() %> > <%=rDto.getSigungucodename() %></h5>
	 		<h5><%=rDto.getCategory() %></h5>
			<%
				if(!rDto.getImg1().equals("NoImage")) {%>
					<img width="150" src="<%= rDto.getImg1() %>">
				<%}
				if(!rDto.getImg2().equals("NoImage")) {%>
					<img width="150" src="<%= rDto.getImg2() %>">
				<%}
				if(!rDto.getImg3().equals("NoImage")) {%>
					<img width="150" src="<%= rDto.getImg3() %>">
				<%}
				if(!rDto.getImg4().equals("NoImage")) {%>
					<img width="150" src="<%= rDto.getImg4() %>">
				<%}
				if(!rDto.getImg5().equals("NoImage")) {%>
					<img width="150" src="<%= rDto.getImg5() %>">
				<%}%>	 		
			<br />
	 		<h5>별점 : <%=rDto.getStars() %></h5>
	 		<h5>내용 : <%=rDto.getReview() %></h5>
	 		<h5>공감 : <%=rDto.getLikes() %></h5>
	 		<h5><%=reg_date_R %></h5>
	 		
	 		
	 	<%}
	 	}%>
	<jsp:include page="/views/main/footer.jsp" />
</body>
</html>