<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 지환 마이페이지 -->
<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import = "java.util.Enumeration" %>

<!-- 선민 리뷰 -->
 


<!-- 형우 찜하기 -->
<%@ page import = "team02.location.land.LocationLandDAO"%>  
<%@ page import = "team02.location.land.LocationLandDTO"%>  
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "team02.user.save.SaveDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import = "java.util.List" %>

<% request.setCharacterEncoding("UTF-8");%>
<%!
    int pageSize = 10;  // 게시판 첫페이지에 보여줄 글 개수    
%>

<%
	String vid = (String)session.getAttribute("memId");
	SaveDAO pick =SaveDAO.getInstance();
	SaveDTO p = pick.sss(vid);
%>

<%
   String sid = (String)session.getAttribute("memId");

   String pagepoint = request.getParameter("pagepoint");
   if (pagepoint == null) {
      pagepoint = "1";
   }
   
   int cPage = Integer.parseInt(pagepoint);
    int stRow = (cPage - 1) * pageSize + 1;
    int edRow = cPage * pageSize;
   int point = 0; 
   int pnumber=0;
    

   List mypicklist = null;     
   LocationLandDAO dbpick = LocationLandDAO.getInstance();
   point = dbpick.getmypickpoint(sid);
    if (point > 0) {
       mypicklist = dbpick.getmypick(stRow, edRow, sid);
       }
      pnumber=point-(cPage-1)*pageSize;     
     

     /* 요건 글이 나오는지 찍어본거 */
     LocationLandDAO  save = LocationLandDAO .getInstance();
     LocationLandDTO s = save.mySaveList(sid);    
%>
<!-- 찜하기 여기까지 -->


<jsp:include page="/views/main/nav.jsp" />

<title>마이페이지</title>

<% if(session.getAttribute("memId") == null){%>
   <script>
    alert("로그인 후 사용 가능합니다.");
    window.location = "/wherego/views/main/main.jsp";
   </script>
<%}%>
   
<%
   String id = (String) session.getAttribute("memId");
      
   MemberDAO manager = MemberDAO.getInstance();
   MemberDTO c = manager.getMember(id);
   
   try{
%>
 
 <!-- 여기는 프로필 --> 
<center> 
<%
   if(id != null){
     if(id.equals("admin") || id.equals(c.getId())){%>
          
      <!-- 프로필 이미지 및 닉네임 표시 -->
       <img width="150" src="/wherego/image/<%= c.getProfile() %>"><br>         
       <%= c.getNic() %> 마이페이지<p><br>
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
   
<!--  위로는 프로필 -->
        
<hr>  

<!-- 아래는 글보기 -->
 
   <center>
    <table>
      <tr>
       <td>     
	       <%
	         if(id != null){
		         if(id.equals("admin") ||id.equals(c.getId())){%>                                     
		         <input type="button" value="myreviews" onclick="myreviews_open()">
		         <input type="button" value="mypick" onclick="mypick_open()">
		       <%} else {%>          
		         <input type="button" value="myreviews" onclick="myreviews_open()">
		       <%} %>
	       <%} %> 
       </td>     
      </tr>
     </table>   
   </center>
   
 <hr>
       
<div style="display:flex; width:100%; text-align: center; height: 200px;"> 

<!-- 아래는 리뷰리스트 -->
       
	<div id="myreviews" style="width:100%;  background-color: #b9ffec; display:none;">
     <p><%=c.getNic()%>님이 작성한 리뷰 리스트 입니다.</p> 
        <b>글목록(전체 글:<%=point%>)</b>

    <%
     if (point == 0) {
    %>
      <table width="700" border="1" cellpadding="0" cellspacing="0">
         <tr>
           <td align="center">
             게시판에 저장된 글이 없습니다.
            </td>
          </tr>
      </table>
     <%}%>
   </div>
   

<!-- 여기아래는 찜한 목록 뽑는곳 -->

<div id="mypick" style="width:100%; background-color: #DAD9FF; display:none; ">
  
   <p><%=c.getNic()%>님의 찜한 여행지 리스트입니다.</p>
   <b>내가 찜한목록(전체 글:<%=point%>)</b>
     
    <table border="1" width="700" cellpadding="10" cellspacing="10" align="center"> 
      <tr  height="30" > 
         <td align="center"  width="100"  >순서</td>              
         <td align="center"  width="200"  >이미지</td> 
         <td align="center"  width="200" >카테고리</td> 
         <td align="center"  width="200"  >지역</td> 
         <td align="center"  width="200" >타이틀</td>             
         <td align="center"  width="200" >찜한 사람 수</td>                   
      </tr>
      <%  
       for(int i = 0 ; i < point ; i++){
         LocationLandDTO mypicks = (LocationLandDTO)mypicklist.get(i);
      %>      
      <tr height="30">    
         <td align="center"  width="100" ><%=i+1%></td>      <!-- 순서 -->             
         <td img align="center" width="200"><img src="<%= mypicks.getFirstimage() %>" width="100" height="100"/></td>
         <td align="center"  width="200" ><%=mypicks.getCategory()%></td> <!-- 카테고리 -->
         <td align="center"  width="200" ><%=mypicks.getAreacodename()%> > <%=mypicks.getSigungucodename()%></td> <!-- 지역>지역 -->
         <td align="center"  width="200" ><%=mypicks.getTitle()%></td> <!-- 지역>지역 -->
         <td align="center"  width="200" >찜한사람수</td> <!-- 지역>지역 -->
      </tr>
      <%}%>
    </table>
    
  	<%
      if(point > 0){
       int pageCount = point / pageSize + ( point % pageSize == 0 ? 0 : 1);
             
       int stPage = (int)(cPage/10)*10+1;
       int pageBlock=10;
       int edPage = stPage + pageBlock-1;
       if (edPage > pageCount) edPage = pageCount;             
      
       if (stPage > 10){%>
         <a <%= stPage - 10 %>">[이전]</a>
       <%}
       
       for (int i = stPage ; i <= edPage ; i++) {  %>
         <a>[<%= i %>]</a>
       <%}
          
       if(edPage < pageCount){%>
         <a <%= stPage + 10 %>">[다음]</a>
       <%}
     }%>    
   </div>
  </div>       
  


<%} catch (Exception e){
   e.printStackTrace();
}%>
   
   
   
   
   <!-- 아래는 스크립트페이지 -->
   
    <script>
          
           function myreviews_open() {
               let myreviews = document.getElementById('myreviews').style.display = "";             
               let mypick = document.getElementById('mypick').style.display = "none";
               console.log(myreviews);
           }
           
           function mypick_open() {
               let mypick = document.getElementById('mypick').style.display = "";
               let myreviews = document.getElementById('myreviews').style.display = "none";              
               console.log(magazine);
           }
              
     </script>
   
   
   