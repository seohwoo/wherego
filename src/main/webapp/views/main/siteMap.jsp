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
	<title>siteMap</title>
</head>
<body>
	<!-- nav + 사이트명 -->
	<%@ include file="nav.jsp" %>
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>	
	</div>
	<br />
	<hr />
	
	
	<div class = "text-center">
	  <table>
	    <thead>
	      <tr>
	        <th scope="col">Service<hr /></th>
			<th scope="col">Community<hr /></th>
			<th scope="col">Mypage<hr /></th>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
	       <td onClick="location.href='/wherego/views/main/listRand.jsp'" >여행지 찾기</a></td>
		   <td onClick="location.href='/wherego/views/board/noticeList.jsp'">공지사항</td>
		   <td onClick="location.href='#'">내가 쓴 매거진</td>
	      </tr>
	      <tr>
		  	<td onClick="location.href='#'">Hit! 여행지</td>
			<td onClick="location.href='/wherego/views/board/askList.jsp'">문의 게시판</td>
			<td onClick="location.href='#'">매거진 작성</td>
		   </tr>
		   <tr>
		   	<td onClick="location.href='#'"> Hit! 매거진</td>
		   	<td> </td>
		   	<td onClick="location.href='#'">나의 여행 계획</td>
		   </tr>
		   <tr>
		   	<td onClick="location.href='#'"> 예약 사이트</td>
		   	<td> </td>
		   	<td> </td>
		   </tr>
	    </tbody>
	  </table>
	</div>
	
	<!-- footer -->
	<div class="fixed-bottom">
	<hr />
		<%@ include file="footer.jsp" %>	
	</div>

</body>
</html>