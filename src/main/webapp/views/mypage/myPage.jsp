<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 지환 마이페이지 -->
<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import = "java.util.Enumeration" %>

<!-- 선민 리뷰 -->

<!-- 형우 찜하기 -->
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "team02.user.save.SaveDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import = "java.util.List" %>
<%@page import = "java.util.HashMap" %>



<% request.setCharacterEncoding("UTF-8");%>

<%  int pageSize = 10;
	String user = request.getParameter("id");
%>
<%
	//찜목록 리스트화 시키기
    SaveDAO pick = SaveDAO.getInstance();
    ArrayList<String> p = pick.getMyPickContentIdList(user);
    String contentid ="";
    
    //찜목록 카운트
    int point = 0;     
    List getmypickpoint = null;     
    SaveDAO dbmypick = SaveDAO.getInstance();   
    point = dbmypick.getmypickpoint(user);  
%>


<%
	//리뷰 리스트화 시키기
	SaveDAO review = SaveDAO.getInstance();
	ArrayList<String> r = review.getMyreviewContentIdList(user);
	String reviewContentid = "";

	
	//리뷰 갯수
	int count = 0; 
	List getReviewCount = null;
	SaveDAO reviewC = SaveDAO.getInstance();
	count = reviewC.getReviewCount(user);
%>

  


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
   MemberDTO userDtO = manager.getMember(user);
   
   try{
%>

<input type="button" value="magWriteForm" onclick="window.location='/wherego/views/mag/magWriteForm.jsp'">
 
 <!-- 여기는 프로필 --> 
<center> 
<%
	if(id.equals(user) || id.equals("admin")){%>
      <!-- 프로필 이미지 및 닉네임 표시 -->
       <img width="150" src="/wherego/image/<%= c.getProfile() %>"><br>         
       <%= c.getNic() %> 마이페이지<br>
       
       <%= c.getGrade() %>등급의 회원입니다.<br />  
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
      <img width="150" src="/team02/views/mypage/DEFAULT/<%= userDtO.getProfile() %>">
      현재 <%= userDtO.getNic() %> 회원 페이지를 구경하고 있습니다.<br />        
      <%= userDtO.getGrade() %>등급의 회원입니다.<br />        
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
	         if(id.equals(user) || id.equals("admin")){%>		                                            
		         <input type="button" value="myreviews" onclick="myreviews_open()">
		         <input type="button" value="mypick" onclick="mypick_open()">
		       <%} else {%>          
		         <input type="button" value="myreviews" onclick="myreviews_open()">
		       <%} %>
	       
       </td>     
      </tr>
     </table>   
   </center>
   
 <hr>
       
<div style="display:flex; width:100%; text-align: center; height: 200px;"> 

<!-- 아래는 리뷰리스트 -->
       
	<div id="myreviews" style="width:100%;   display:none;">
     <p><%=userDtO.getNic()%>님이 작성한 리뷰 리스트 입니다.</p> 
        <b>글목록(전체 글:<%=count%>)</b>

    <%
     if (count == 0) {
    %>
     <center>
      <table width="700" border="1" cellpadding="0" cellspacing="0">
         <tr>
           <td align="center">
             게시판에 저장된 글이 없습니다.
            </td>
          </tr>
      </table>
     </center>
    <%}else{%>
     <table border="1" width="1500" cellpadding="10" cellspacing="10" align="center">
     
      <tr  height="30">                      
         <td align="center"  width="200"  >여행지</td> 
         <td align="center"  width="150"  >장소사진</td> 
         <td align="center"  width="350"  >리뷰내용</td> 
         <td align="center"  width="200" >별점</td>          
         <td align="center"  width="150" >사진1</td> 
         <td align="center"  width="150"  >사진2</td> 
         <td align="center"  width="150" >사진3</td>             
         <td align="center"  width="150" >사진4</td>             
         <td align="center"  width="150" >사진5</td>                                                                         
         <td align="center"  width="200" >리뷰날짜</td>                                        
      </tr>
 <%
	 HashMap<String,String> myReviewMap = new HashMap<String,String>();
	 for(int i = 0 ; i < r.size(); i++){
		   reviewContentid = r.get(i);
		   myReviewMap = review.myReviewList(reviewContentid, user);
 %>    
	   <tr height="30" >   		    
			<td><%=myReviewMap.get("title")%></td>
			<td> <img width="100" height="100"  src="<%=myReviewMap.get("firstimage")%>"></td>
			<td><%=myReviewMap.get("review")%></td>
			<td><%=myReviewMap.get("stars")%></td>
			<td><%String img1 = myReviewMap.get("img1");
			if (img1 != null && !img1.isEmpty() && !img1.equals("NoImage")){
        	%><img width="100" height="100" src="<%= img1 %>">
        	<%}else{%>이미지가 없습니다.<%}%>
   			</td>			    
			<td><%String img2 = myReviewMap.get("img2");
			if (img2 != null && !img2.isEmpty() && !img2.equals("NoImage")){
        	%><img width="100" height="100" src="<%= img1 %>">
        	<%}else{%>이미지가 없습니다.<%}%>
   			</td>			    
			<td><%String img3 = myReviewMap.get("img3");
			if (img3 != null && !img3.isEmpty() && !img3.equals("NoImage")){
        	%><img width="100" height="100" src="<%= img3 %>">
        	<%}else{%>이미지가 없습니다.<%}%>
   			</td>			    
			<td><%String img4 = myReviewMap.get("img4");
			if (img4 != null && !img4.isEmpty() && !img4.equals("NoImage")){
        	%><img width="100" height="100" src="<%= img4 %>">
        	<%}else{%>이미지가 없습니다.<%}%>
   			</td>			    
			<td><%String img5 = myReviewMap.get("img5");
			if (img5 != null && !img5.isEmpty() && !img5.equals("NoImage")){
        	%><img width="100" height="100" src="<%= img5 %>">
        	<%}else{%>이미지가 없습니다.<%}%>
   			</td>			    											
			<td><%=myReviewMap.get("reg_date")%></td>
	   </tr>    
     <%}%>
  </table>
    <%}%>	    
   </div>
   

<!-- 여기아래는 찜한 목록 뽑는곳 -->

<div id="mypick" style="width:100%;  display:none; ">
  
   <p><%=c.getNic()%>님의 찜한 여행지 리스트입니다.</p>
   <b>내가 찜한목록(전체 글:<%=point%>)</b>
   
   <%
      if (point == 0 ) {
   %>
     <center>
      <table width="700" border="1" cellpadding="0" cellspacing="0">
         <tr>
           <td align="center">
             게시판에 저장된 글이 없습니다.
            </td>
          </tr>
      </table>
     </center>
   <%}else{%>  
    <table border="1" width="1100" cellpadding="10" cellspacing="10" align="center"> 
      <tr  height="30" > 
         <td align="center"  width="100"  >지역명</td>              
         <td align="center"  width="150"  >시/구/군</td> 
         <td align="center"  width="300"  >주소</td> 
         <td align="center"  width="200" >명소 이름</td> 
         <td align="center"  width="150" >사진</td>             
         <td align="center"  width="200" >카테고리</td>                   
         <td align="center"  width="200" >평균별점</td>                   
         <td align="center"  width="200" >조회수</td>                   
      </tr>
      
<%
       HashMap<String,String> myPickMap = new HashMap<String,String>();
   for(int i = 0 ; i < p.size(); i++){
	   contentid = p.get(i);
	   myPickMap = pick.myPick(contentid);	   
%>

	 <tr  height="30" > 
	   <td> <%=myPickMap.get("areacodename")%></td> 
	   <td><%=myPickMap.get("sigungucodename")%></td>
	   <td> <%=myPickMap.get("addr1")%></td>
	   <td> <%=myPickMap.get("title")%></td>	   
	   <td> <img width="150" height="150"  src="<%=myPickMap.get("firstimage")%>"></td>
	   <td><%=myPickMap.get("category") %></td>
	   <td><%=myPickMap.get("stars") %></td>
	   <td><%=myPickMap.get("readcount") %></td>	   
	 </tr> 
	   
	<%}%>
    </table> 
  <%}%>	   
   </div>
  </div>       
<%}catch (Exception e){
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
   
   
   