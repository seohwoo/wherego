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
	        alert("관리자만 접근 가능합니다🤬🤬🤬");
	        window.location = "/wherego/views/main/main.jsp";
	    </script>
	<% } %>
	<jsp:include page="/views/main/nav.jsp" />	
	<jsp:include page="/views/main/title.jsp" /><br />
	<%!
   		int pageSize = 10;
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
		SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");	
	%>	
	<%
		String id = request.getParameter("id");
		AdminMemberDAO dao = AdminMemberDAO.getInstance();
		AdminMemberDTO dto = dao.userInfo(id);
		
		String gradeName = dao.findGradeName(dto.getGrade());
		Date birthD = inputFormat.parse(dto.getBirth());
		String birth = outputFormat.format(birthD);
		Date reg_dateD = inputFormat.parse(dto.getReg_date());
		String reg_date = outputFormat.format(reg_dateD);
		
		
	%>
	<div align="center">
	 <img width="150" src="/wherego/image/<%= dto.getProfile() %>"> <br> 
	 <h5>아이디 : <%=dto.getId() %></h5>
	 <h5>이름 : <%=dto.getName() %></h5>
	 <h5>닉네임 : <%=dto.getNic() %></h5>
	 <h5>생년월일 : <%=birth %></h5>
	 <h5>성별 : <%=dto.getGender() %></h5>
	 <h5>주소 : <%=dto.getAddress() %></h5>
	 <h5>이메일 : <%=dto.getEmail() %></h5>
	 <h5>전화번호 : <%=dto.getPhone() %></h5>
	 <h5>가입일자 : <%=reg_date %></h5>
	 <h5>등급 : <%=gradeName%></h5>
	 <br />
	 <form action="userGradeChangeForm.jsp" method="post">
	 	<input type="hidden" name="id" value="<%=id%>"/>
	 	<input type="submit" class="btn btn-outline-primary" name="submit" value="등급변경 ⏩⏩"/>
	 </form>
	 </div>
	 <hr />
	 <div class="d-grid gap-2 col-6 mx-auto">
	 <div align="center">
	 <div class ="card text-center">
	 	<div class="card-header">
			 <h3>총 리뷰 : <%=dto.getTotal() %>개</h3>
		 </div>
	 
	 <%
	 	ArrayList<AdminReviewDTO> reviewList = new ArrayList<AdminReviewDTO>();
		reviewList = dao.findUserReviews(id);
	 	if(reviewList.size()==0) {%>
	 		<h5>작성한 글이 없습니다...😪</h5>
	 	<%}else{
	 	for(AdminReviewDTO rDto : reviewList) {
	 		Date reg_date_RD = inputFormat.parse(rDto.getReg_date_R());
			String reg_date_R = outputFormat.format(reg_date_RD);
	 	%>
	 	 <div class="card-body">
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
	 	</div>
	 	</div>
	 	</div>
	 	</div>
	 	<br /><hr /><br />
	<jsp:include page="/views/main/footer.jsp" />
</body>
</html>