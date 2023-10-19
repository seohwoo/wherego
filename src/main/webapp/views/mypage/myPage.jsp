<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import = "java.util.Enumeration" %>



	<% if (session.getAttribute("memId") == null) { %>
	    <script>
	        alert("로그인 후 사용 가능합니다.");
	        window.location = "/team02/views/main/main.jsp";
	    </script>
	<% } %>
	
	<%
		String id = (String) session.getAttribute("memId");
		
		MemberDAO manager = MemberDAO.getInstance();
		MemberDTO c = manager.getMember(id);
	   try {
	%>

	    <title>마이페이지</title>
	
	
	  
	<center>

	<%
		if(id != null) {
	   	if(id.equals("admin") || id.equals(c.getId())) {%>
	   		
	   		<!-- 기본이미지 -->
       	  <img width="150" src="/team02/views/mypage/DEFAULT/<%= c.getProfile() %>"> <br> 
	   		<%= c.getNic() %> 마이페이지<p><br>
	   		
	   		
	        <!-- 프로필 이미지 및 닉네임 표시 -->
	      <img width="150" src="/team02/image/<%= c.getProfile() %>"> <br>         	      	 
	      <button id="changeProfile" onclick="openProfileWindow()">프로필 이미지 변경</button>

  			 <!-- 프로필 변경 버튼 클릭 시 새 창 열기 -->
		   <script>
		        function openProfileWindow() {
		            var profileWindow = window.open("profileChange.jsp", "프로필 변경", "width=400,height=300");
		        }
		   </script>
	   	
	       <input type="button" value="수정하기" OnClick="window.location='updateForm.jsp'">
		   <input type="button" value="삭제하기" OnClick="window.location='deleteForm.jsp'">
		   		  
	<%}else{%>  
		<img width="150" src="/team02/views/mypage/DEFAULT/<%= c.getProfile() %>">
		현재 <%= c.getNic() %> 회원 페이지를 구경하고 있습니다.<p><br>		  
	<%} %>    
  <%} %> 

      
	 </center>
	
	<hr>
	
	<center>
	  <table>
	   <tr>
	    <td>     
		 <%
	       if(id != null) {
	       if(id.equals("admin") ||id.equals(c.getId())) {%>
	         <input type="button" value="magazine" onclick="window.location='/team02/views/mylist/board.jsp'"> 
	         <input type="button" value="myreviews" onclick="window.location='#'">
	         <input type="button" value="mypick" onclick="window.location='/team02/views/mypage/mypick.jsp'">
	     <%} else {%>
	         <input type="button" value="magazine" onclick="window.location='#'"> 
	     <%} %>
	    <%} %> 
	      </td>     
	    </tr>
	  </table>
	</center>
    <%} catch (Exception e) {
	  e.printStackTrace();
   }%>
	
	
	
