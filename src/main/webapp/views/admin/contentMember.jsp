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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

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
	<jsp:include page="/views/main/title.jsp" /><br />
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
		
		int reviewCnt = dao.reviewCnt(dto.getId());
		
		if (adminInfo.getGrade() != 99) { %>
	    <script>
	        alert("관리자만 접속이 가능합니다🤬🤬🤬");
	        window.location = "/wherego/views/main/main.jsp";
	    </script>
	<% }
	%>
	<div class="d-grid gap-2 col-6 mx-auto">
		<table class="table">
		<tr>
			<td align="center" width="300"><b>프로필</b></td>
		</tr>
		<tr>
			<td align="center"><img width="150" src="/wherego/image/<%= dto.getProfile() %>"> </td>
		</tr>
		<tr> 
	       <td align="center"  width="300"  ><b>id</b></td> 
	       <td align="center"  width="300"  ><b>이름</b></td>
	       <td align="center"  width="400"  ><b>닉네임</b></td>
	       <td align="center"  width="300"  ><b>생년월일</b></td>
	       <td align="center"  width="200"  ><b>성별</b></td>
       </tr>                                 
		<tr>
		 <td align="center"  width="300"><%=dto.getId() %></td>
		 <td align="center"  width="300"><%=dto.getName() %></td>
		 <td align="center"  width="400"><%=dto.getNic() %></td>
		 <td align="center"  width="300"><%=birth %></td>
		 <td align="center"  width="200"><%=dto.getGender() %></td>
	 </tr>
	 <tr>                                    
	       <td align="center"  width="500"  ><b>주소</b></td>
	       <td align="center"  width="300"  ><b>이메일</b></td> 
	       <td align="center"  width="200"  ><b>휴대전화</b></td> 
	       <td align="center"  width="200"  ><b>가입일</b></td>
	       <td align="center"  width="100"  ><b>등급</b></td> 
	                                         
	    </tr>                                
       <tr>
		 <td align="center"  width="500"><%=dto.getAddress() %></td>
		 <td align="center"  width="300"><%=dto.getEmail() %></td>
		 <td align="center"  width="200"><%=dto.getPhone() %></td>
		 <td align="center"  width="200"><%=reg_date %></td>
		 <td align="center"  width="100"><%=gradeName%></td>
		 </tr>
		 </table>
	 </div>

	 <div class="text-center">
	    <button class="btn btn-secondary" onclick="openGradeChangeForm('<%= id %>')">등급변경</button>
	</div>
	 <br />
	 
	 <div class="text-center">
	 <h3>글수 : <%=reviewCnt %></h3>

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

		 	<div class="row justify-content-center">
			 	<div class="card" style="width: 18rem; justify-content: center;">
			 	<%if(dto.getProfile() != null){ %>
			 		<img class ="card-img-top" width="150" src="/wherego/image/<%= dto.getProfile() %>">
			 		<%} %>
			 		<div class="card-body">
			 		<h5>닉네임 : <%=dto.getNic() %></h5>
			 		<hr />
			 		<p> <%=rDto.getAreacodename() %> > <%=rDto.getSigungucodename() %></p>
			 		<p><%=rDto.getCategory() %></p>
			 		<img width="150" src="<%= rDto.getFirstimage() %>">
			 		<p><%=rDto.getTitle() %></p>
			 		</div>
			 		<ul class="list-group list-group flush">
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
			 		<li class="list-group list-group-flush">별점 : <%=rDto.getStars() %> 공감 : <%=rDto.getLikes() %></li>
			 		<li class="list-group list-group-flush">내용 : <%=rDto.getReview() %></li>
			 		<li class="list-group list-group-flush"><small><%=reg_date_R %></small></li>
			 		</ul>
			 		</div>
		 		</div>
	 		</div>
	 		

	 	<%}
	 	}%>
	 	
	 	<br /><hr /><br />
	<jsp:include page="/views/main/footer.jsp" />
	<script type="text/javascript">
		function openDeletereviewWindow(contentid, id) {
		    var profileWindow = window.open("adminReviewdelete.jsp?contentid=" + contentid + "&id=" + id, "reviewDelete", "width=400,height=300");
		}
		   function openGradeChangeForm(userId) {
		        var popupWindow = window.open("userGradeChangeForm.jsp?id=" + userId, "GradeChangeForm", "width=450,height=500");
		    }
	</script>
</body>
</html>