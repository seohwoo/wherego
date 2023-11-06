

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


<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link href="/wherego/views/mypage/mypage.css" rel="stylesheet" type="text/css" />
	<title>어디Go 마이페이지</title>
</head>
<body>
<jsp:include page="/views/main/nav.jsp" />
<jsp:include page="/views/main/title.jsp" /> <br />

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


<% if(session.getAttribute("memId") == null){%>
   <script>
    alert("로그인 후 사용 가능합니다.");
    window.location = "/wherego/views/main/main.jsp";
   </script>
<%}
   String id = (String) session.getAttribute("memId");
   
   MemberDAO manager = MemberDAO.getInstance();
   MemberDTO c = manager.getMember(id);
   MemberDTO userDtO = manager.getMember(user);
   
   try{%>
 
 <!-- 여기는 프로필 --> 
<div class="text-center">
<%
   if((userDtO.getGradeName()).equals("일반") || (userDtO.getGradeName()).equals("관리자") || (userDtO.getGradeName()).equals("우수") ){%>
      <!-- 프로필 이미지 및 닉네임 표시 -->
       <img width="150" src="/wherego/image/<%= c.getProfile() %>">         
       <h5 class="text"><%= userDtO.getNic() %> 마이페이지</h5>
       <h5 class="text"><%= userDtO.getGradeName()%>등급의 회원입니다.</h5> 
       <button id="changeProfile" class = "button" onclick="openProfileWindow()">프로필 이미지 변경</button>           
          <input type="button" class = "button"  value="수정하기" OnClick="window.location='updateForm.jsp'">
          <input type="button" class = "button"  value="탈퇴하기" Onclick="openDeleteWindow()">                
     <%}else{%>  
      <img width="150" src="/team02/views/mypage/DEFAULT/<%= userDtO.getProfile() %>">
      현재 <%= userDtO.getNic() %> 회원 페이지입니다.<br />        
      <%= userDtO.getGradeName() %>등급의 회원입니다.<br />         
     <%} %>    
</div>
<div class="d-grid gap-2 col-6 mx-auto">
<hr class="hr-19" />
</div>
<!-- 글보기 -->
 
   <div class="text-center">
      <%
        if(id.equals(user) ){%>  
        	<button class="button" style="width: 400px;" id="myreviews-button" onclick="myreviews_open()">MyReview</button>
			<button class="button" style="width: 400px;" id="mypick-button" onclick="mypick_open()">MyPick</button> 
         <%} else {%>          
           <button class="button" style="width: 400px;" id="myreviews-button" onclick="myreviews_open()">MyReview</button>
         <%} %> 
   </div>
       
<!-- 아래는 리뷰리스트 -->
       
   <div id="myreviews" class="text-center" style="display:none;">
		<div class="d-grid gap-2 col-6 mx-auto">
			<br />
			<h5 class="text">[<%=userDtO.getNic()%>님이 작성한 리뷰 리스트 입니다]</h5>
			<b style="color: black;">글목록(전체 글:<%=count%>)</b>
    <% if (count == 0) { %>
		     <table class="table table-hover">
		        <tr>
		            <td>문의 글이 없습니다.</td>
		        </tr>
		    </table>
		    <%}else{%>
		     <table class="table table-hover">
		     <thead>
			      <tr>                      
			         <td align="center"><b>여행지</b></td> 
			         <td align="center"><b>내용</b></td> 
			         <td align="center"><b>별점</b></td>                                                                                
			         <td align="center"><b>작성일</b></td>                                        
			      </tr>
		      </thead>
 <%   
	ArrayList<HashMap<String, String>> myReviewList = new ArrayList<HashMap<String, String>>();
	HashMap<String,String> myReviewMap = new HashMap<String,String>();
	HashMap<String,String> myReviewTitleMap = new HashMap<String,String>();
	myReviewList = review.myReviewList(user);
	for(int i = 0 ; i < myReviewList.size(); i++){
	   myReviewMap = myReviewList.get(i);
	   myReviewTitleMap = review.selectReviewTitle(myReviewMap.get("contentid"));
 %>   
		 	<tbody>
			      <tr>             
			         <td><%=myReviewTitleMap.get("title")%></td>
			         <td><%=myReviewMap.get("review")%></td>
			         <td>
			         <% 
					int rating = Integer.parseInt(myReviewMap.get("stars"));
					for (int stars = 1; stars <= 5; stars++) {
					    if (stars <= rating) { %>
					        <i class="fas fa-star" style="color: #ffc83d;"></i>
					    <% } else { %>
					        <i class="far fa-star" style="color: #ffc83d;"></i>
					    <% }
					}%>
			         </td>
			         <td><%=myReviewMap.get("reg_date")%></td>
			      </tr>
		      </tbody>  
		     <%}%>
		  </table>
	    <%
	    }%>
		</div> 
	</div>
   

<!-- 찜 목록 -->
<div id="mypick" class="text-center" style="display:none;">
   <div class="d-grid gap-2 col-6 mx-auto">
	   <br />
	   <h5 class="text">[<%=userDtO.getNic()%>님의 찜한 여행지 리스트입니다]</h5>
	   <b style="color: black;">내가 찜한목록(전체 글:<%=point%>)</b>
   <% if (point == 0 ) {  %>
      <table class="table table-hover">
         <tr>
           <td>
             게시판에 저장된 글이 없습니다.
            </td>
          </tr>
      </table>
   <%}else{%>  
	    <table class="table table-hover"> 
	      <thead>
	      	<tr>
	         <td align="center"><b>주소</b></td> 
	         <td align="center" ><b>장소</b></td> 
	         <td align="center"><b>사진</b></td>             
	         <td align="center"><b>카테고리</b></td>                   
	         <td align="center"><b>평균별점</b></td>                   
	         <td align="center"><b>조회수</b></td>  
	         </tr>                 
	      </thead>
	      
	<%
	   HashMap<String,String> myPickMap = new HashMap<String,String>();
	   for(int i = 0 ; i < p.size(); i++){
	      contentid = p.get(i);
	      myPickMap = pick.myPick(contentid);      
	%>
			<tbody>
			    <tr> 
			      <td> <%=myPickMap.get("addr1")%></td>
			      <td> <%=myPickMap.get("title")%></td>      
			      <td> <img width="150" height="150"  src="<%=myPickMap.get("firstimage")%>"></td>
			      <td><%=myPickMap.get("category") %></td>
			      <td><%=myPickMap.get("stars") %></td>
			      <td><%=myPickMap.get("readcount") %></td>      
			    </tr> 
		    </tbody>
			<%}%>
	    </table> 
	  <%}%>      
		</div>
	</div>       
<%}catch (Exception e){
   e.printStackTrace();
}%>
</body>
<script>
function openProfileWindow() {
    var profileWindow = window.open("profileChange.jsp", "프로필 변경", "width=400,height=300");                    
    }
function openDeleteWindow() {
    var profileWindow = window.open("deleteForm.jsp", "회원탈퇴", "width=400,height=300");                    
    }
    
function myreviews_open() {
    let myreviews = document.getElementById('myreviews');
    let mypick = document.getElementById('mypick');
    let myreviewsButton = document.getElementById('myreviews-button');
    let mypickButton = document.getElementById('mypick-button');

    myreviews.style.display = "block";
    mypick.style.display = "none";

    myreviewsButton.style.backgroundColor = "gray";
    mypickButton.style.backgroundColor = "#003366";
}

function mypick_open() {
    let mypick = document.getElementById('mypick');
    let myreviews = document.getElementById('myreviews');
    let myreviewsButton = document.getElementById('myreviews-button');
    let mypickButton = document.getElementById('mypick-button');

    mypick.style.display = "block";
    myreviews.style.display = "none";

    myreviewsButton.style.backgroundColor = "#003366";
    mypickButton.style.backgroundColor = "gray";
}

</script>

</html>