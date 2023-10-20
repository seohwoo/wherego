<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import = "java.util.Enumeration" %>

<title>마이페이지</title>

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
  
	<center>

	<%
		if(id != null) {
	   	if(id.equals("admin") || id.equals(c.getId())) {%>
	   		
	   		
       	  <img width="150" src="/team02/image/<%= c.getProfile() %>"> <p>   
       	  <button id="changeProfile" onclick="openProfileWindow()">프로필 이미지 변경</button><br>   
	   		"<%= c.getNic() %>" 회원님 마이페이지<p><br>
	
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
		   <input type="button" value="전체 메거진 바로가기"  onclick="#"> 
           <input type="button" value="전체 리뷰 보기"  onclick="#">         
		</center>
	<hr>
   
   <center>
     <table>
      <tr>
       <td>     
       <%
          if(id != null) {
          if(id.equals("admin") ||id.equals(c.getId())) {%>
            <input type="button" value="magazine"  onclick="magazine_open()"> 
            <input type="button" value="myreviews"  onclick="myreviews_open()">
            <input type="button" value="mypick"  onclick="mypick_open()">
        <%} else {%>
            <input type="button" value="magazine" onclick="window.location='/team02/views/mylist/board.jsp?id=test'"> 
            <input type="button" value="myreviews" onclick="window.location='#'">
        <%} %>
       <%} %> 
         </td>     
       </tr>
     </table>   
   </center>
   
   
   <div style="display:flex; width:100%; text-align: center; height: 200px;">
      <div id="magazine" style="width:100%; background-color: pink;">
	      매거진
	      <ul>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	      </ul>
	  </div>
	      
	  <div id="myreviews" style="width:100%;  background-color: #b9ffec; display:none;">
	      내리뷰
	      <ul>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	      </ul>
	  </div>
	  
	  <div id="mypick" style="width:100%;background-color: gray; display:none; ">
	      찜하기
	      <ul>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	         <li>게시글</li>
	      </ul>
      </div>   
      
   </div>



    <%} catch (Exception e) {
     e.printStackTrace();
   }%>
   
   
    <script>
            
           function magazine_open() {
               let magazine = document.getElementById('magazine').style.display = "";
               let myreviews = document.getElementById('myreviews').style.display = "none";
               let mypick = document.getElementById('mypick').style.display = "none";
               console.log(magazine);
           }
           
           function myreviews_open() {
               let myreviews = document.getElementById('myreviews').style.display = "";
               let magazine = document.getElementById('magazine').style.display = "none";
               let mypick = document.getElementById('mypick').style.display = "none";
               console.log(myreviews);
           }
           
           function mypick_open() {
               let mypick = document.getElementById('mypick').style.display = "";
               let myreviews = document.getElementById('myreviews').style.display = "none";
               let magazine = document.getElementById('magazine').style.display = "none";
               console.log(magazine);
           }
              
     </script>
	
	
	
