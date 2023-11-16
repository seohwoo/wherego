<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	
	<style>
		table{
			width:40rem;
			height:12rem;
			margin-left:auto;
			margin-right:auto;
		}
		th{
			font-size : 18px;
		}
	</style>
	<title>어디 Go 사이트맵</title>
</head>
<body>
<%
		String id = (String) session.getAttribute("memId");
	%>
	<!-- nav + 사이트명 -->
	<jsp:include page="/views/main/nav.jsp" />	
	<jsp:include page="/views/main/title.jsp" /><br />
	
		<div class = "text-center">
		  <table align="center">
		    <thead>
		      <tr>
		        <th scope="col">Service<hr /></th>
				<th scope="col">Community<hr /></th>
				<th scope="col">Mypage<hr /></th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		       <td onClick="location.href='/wherego/views/main/main.jsp'" style="cursor: pointer; width: 200px;">여행지 찾기</td>
			   <td onClick="location.href='/wherego/views/board/notice/noticeList.jsp?pageNum=1'" style="cursor: pointer; width: 200px;">공지사항</td>
			   <td onClick="location.href='/wherego/views/mypage/myPage.jsp?id=<%=id %>'" style="cursor: pointer; width: 200px;">내 프로필</td>
		      </tr>
		      <tr>
			  	<td onClick="window.open('/wherego/views/main/topArea.jsp')" style="cursor: pointer; width: 200px;">Hit! 여행지</td>
				<td onClick="location.href='/wherego/views/board/inquire/inquireList.jsp?pageNum=1'" style="cursor: pointer; width: 200px;">문의 게시판</td>
				<td onClick="location.href='/wherego/views/mypage/myPage.jsp?id=<%=id %>'" style="cursor: pointer; width: 200px;">나의 리뷰</td>
			   </tr>
			  <tr>
			    <td onClick="window.open('/wherego/views/locationLand/locationHigh.jsp')" style="cursor: pointer; width: 200px;">지역별 여행지</td>
			   	<td onClick="location.href='/wherego/views/admin/ban/banList.jsp?pageNum=1'" style="cursor: pointer; width: 200px;"> 정지 게시판</td>
			   	<td onClick="location.href='/wherego/views/mypage/myPage.jsp?id=<%=id %>'" style="cursor: pointer; width: 200px;">나의 PICK!</td>
			   </tr>
		    </tbody>
		  </table>
		</div>
	
	<!-- footer -->
	<div style="position: fixed; bottom: 0px; width: 100%;">
		<br /><hr /><br />
			<jsp:include page="/views/main/footer.jsp" />		
	</div>
</body>
</html>