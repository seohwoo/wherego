
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import = "java.util.Enumeration" %>

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
    ArrayList<String> p = pick.getMyPickContentIdList(user); //찜목록 테이블에서 유저의 컨텐트아이디를 리스트화한것
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
   ArrayList<String> r = review.getMyreviewContentIdList(user); // 리뷰 테이블에서 유저가 쓴 글을 리스트로만듬
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

<div class="text-center">
	<%if(session.getAttribute("memId") != null) {
    // 로그인한 경우
		if(session.getAttribute("memId").equals(user)) { // 본인의 페이지인 경우
	   %>      
	     <img width="150" src="/wherego/image/<%= userDtO.getProfile() %>">
	     <h5 class="text" style="color: black;"><%= userDtO.getNic() %> 마이페이지</h5>
	     <h5 class="text" style="color: black;"><%= userDtO.getGradeName() %> 등급의 회원입니다.</h5>
	     <button id="changeProfile" class="button" onclick="openProfileWindow()">프로필 이미지 변경</button>
	     <input type="button" class="button" value="수정하기" OnClick="window.location='updateForm.jsp'">
	     <input type="button" class="button" value="탈퇴하기" Onclick="openDeleteWindow()">
	  <%
	    }else{
	        // 본인의 페이지가 아닌 경우
		%>
	     <img width="150" src="/wherego/image/<%= c.getProfile() %>">
	     <h5 class="text" style="color: black;">현재 <%= userDtO.getNic() %> 회원 페이지입니다.</h5>
	     <span style="color: black;"><%= userDtO.getGradeName() %> 등급의 회원입니다.</span>
		<%
	    }
	}
	%>
</div>
<div class="d-grid gap-2 col-6 mx-auto">
<hr class="hr-19" />
</div>


 	<h1></h1>
   <div class="text-center">
    <%
    if(id.equals(user)){%>
        <button class="button" style="width: 400px;" id="myreviews-button" onclick="myreviews_open()">MyReview</button>
        <button class="button" style="width: 400px;" id="mypick-button" onclick="mypick_open()">MyPick</button>
    <%
    } else {%>
        <button class="button" style="width: 400px;" id="myreviews-button" onclick="myreviews_open()">MyReview</button>
        <!-- mypick-button를 숨김 -->
        <script>
            document.getElementById("mypick-button").style.display = "none";
        </script>
    <%
    }%>
</div>







       
   <div id="myreviews" class="text-center" style="display:none;">
    <div class="d-grid gap-2 col-6 mx-auto">
	 <br />
	  <h5 class="text">[<%=userDtO.getNic()%>님이 작성한 리뷰 리스트 입니다]</h5>
	  <b style="color: black;">글목록(전체 글:<%=count%>)</b>
    <%if (count == 0) { %>
    	<h4 align="center">리뷰 글이 없습니다.</h4>
	<%}else{%>

	<%
	  if (id.equals(user)) { // 본인의 리뷰인 경우에만 "삭제하기" 표시
	  %>삭제하기
	<%}%>
 <%   
	ArrayList<HashMap<String, String>> myReviewList = new ArrayList<HashMap<String, String>>(); 
	HashMap<String,String> myReviewMap = new HashMap<String,String>();
	HashMap<String,String> myReviewTitleMap = new HashMap<String,String>();
	
	myReviewList = review.myReviewList(user); // 유저가 속한 리뷰 테이블의 내용을 리스트로 만들어 myReviewList에 담기 (myReviewList정리)
	
	for(int i = 0 ; i < myReviewList.size(); i++){ // myReviewList정리된 리뷰갯수(사이즈)만큼 반복
	   myReviewMap = myReviewList.get(i);  //(myReviewList정리 된걸 i번 만큼 반복) =>(myReviewMap 정리)
	   myReviewTitleMap = review.selectReviewTitle(myReviewMap.get("contentid"));  //contentid에 알맞은 대표이지미랑 타이틀 가져오기+(myReviewMap 정리)
 %>   
 		<div class="card">
			<div class="card-body">
			<%
                if (id.equals(user)) { // 본인의 리뷰인 경우에만 삭제 버튼 표시
              %>
                <button type="button" value="삭제하기" onclick="openDeletereviewWindow('<%= myReviewMap.get("contentid") %>')" 
                			style="border: none; background-color: white; position: absolute; top: 0; right: 0;">❌</button>
              <%}%> 
		 	<p><b> <%=myReviewTitleMap.get("title")%></b></p>
			<p><%=myReviewMap.get("review")%></p>
			<p>
			         <% int rating = Integer.parseInt(myReviewMap.get("stars"));
			        	for (int s = 1; s <= 5; s++) {
			               if (s <= rating) { %>
			                    <i class="fas fa-star" style="color: #ffc83d;"></i> <!-- 채워진 별 -->
			               <% } else { %>
			                    <i class="far fa-star" style="color: #ffc83d;"></i>
			               <% }
			           }
			        %>
			         </p>
			         <p><small><%=myReviewMap.get("reg_date")%></small></p>
			         
                     
		     <%}%>
		     </div>
		     </div>
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
      <h4 align="center">저장된 글이 없습니다.</h4>
   <%}else{  
	   HashMap<String,String> myPickMap = new HashMap<String,String>();
	   for(int i = 0 ; i < p.size(); i++){  //p에 저장된 리스트 갯수만큼 반복
	      contentid = p.get(i); // 컨텐트 아이디도 반복
	      myPickMap = pick.myPick(contentid);      //컨텐트 아이디에 알맞은 지역정보를  myPickMap에 담음
	%>
			<div class="card" style="">
			<div class="card-body">
			<button type="button" value="찜하기삭제" onclick="openDeletemypickWindow('<%=contentid%>')" style="border: none; background-color: white; position: absolute; top: 0; right: 0;"">❌</button>
			      <p> <b><%=myPickMap.get("title")%></b></p>  
			      <p> <%=myPickMap.get("addr1")%></p>
			      <p> <img width="150" height="150"  src="<%=myPickMap.get("firstimage")%>" class="card-img"></p>
			      <p><%=myPickMap.get("category") %></p>
			      <p>
			      	 <% int ratingR = Integer.parseInt(myPickMap.get("stars"));
			        	for (int s = 1; s <= 5; s++) {
			               if (s <= ratingR) { %>
			                    <i class="fas fa-star" style="color: #ffc83d;"></i> <!-- 채워진 별 -->
			               <% } else { %>
			                    <i class="far fa-star" style="color: #ffc83d;"></i>
			               <% }
			           }
			        %>
			      <p>🔎 (<%=myPickMap.get("readcount") %>)</p>      		       		      

			<%}%>  
	    </div>
	  <%}%>      
		</div>
	</div>
</div>       
<%}catch (Exception e){
   e.printStackTrace();
}%>

<br/><hr /><br />
<jsp:include page="/views/main/footer.jsp" />
</body>
<script>
function openProfileWindow() {
    var profileWindow = window.open("profileChange.jsp", "프로필 변경", "width=400,height=300");                    
    }
    
function openDeleteWindow() {
    var profileWindow = window.open("deleteForm.jsp", "회원탈퇴", "width=400,height=300");                    
    }
    
function openDeletereviewWindow(contentid) {
    var profileWindow = window.open("reviewdelete.jsp?contentid=" + contentid, "리뷰삭제", "width=400,height=300");
}

function openDeletemypickWindow(contentid) {
    var profileWindow = window.open("mypickdelete.jsp?contentid=" + contentid, "찜하기삭제", "width=400,height=300");
}
    
function myreviews_open() {  //마이리뷰 보기
    let myreviews = document.getElementById('myreviews');
    let mypick = document.getElementById('mypick');
    let myreviewsButton = document.getElementById('myreviews-button');
    let mypickButton = document.getElementById('mypick-button');

    myreviews.style.display = "block";
    mypick.style.display = "none";

    myreviewsButton.style.backgroundColor = "gray";
    mypickButton.style.backgroundColor = "#003366";
}

function mypick_open() {  //찜하기 보기
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