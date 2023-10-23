<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import = "java.util.Enumeration" %>


<%@ page import = "team02.mylist.MyListDAO" %> 
<%@ page import = "team02.mylist.MyListDTO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>

<!-- 정룡이가준거 -->
<% request.setCharacterEncoding("UTF-8");%>
<%!
    int pageSize = 10;  // 게시판 첫페이지에 보여줄 글 개수  
    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
    
%>
<%
	String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;
    String myid = "";
    
    String ck = request.getParameter("id");
    
    if(ck != (String)session.getAttribute("memId")){
    	 myid = request.getParameter("id");
    }else{
    	 myid = (String)session.getAttribute("memId");
    };
       
    List articleList = null;
    MyListDAO dbPro = MyListDAO.getInstance();
    count = dbPro.getmyArticleCount(myid);
    if (count > 0) {
        articleList = dbPro.getmyArticles(startRow, endRow, myid);
    }
	number=count-(currentPage-1)*pageSize;	
%>
<!-- 정룡이가준거여기까지 -->

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
  
	<center>
	<%
	if(id != null){
	  if(id.equals("admin") || id.equals(c.getId())){%>
	   	<%-- <!-- 기본이미지 -->
       	<img width="150" src="/wherego/views/mypage/DEFAULT/<%= c.getProfile() %>"> <br>  --%>
	   		
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
	
<hr>

	<center>	
		<input type="button" value="전체 메거진 바로가기"  OnClick="window.location='/wherego/views/mylist/board.jsp'"> 	
        <input type="button" value="전체 리뷰 보기"  onclick="#">         
	</center>
<hr>
   
   <center>
     <table>
      <tr>
       <td>     
       <%
          if(id != null){
          if(id.equals("admin") ||id.equals(c.getId())){%>
            <input type="button" value="mymagazine" onclick="magazine_open()">            
            <input type="button" value="mymagazine1" onclick="window.location='/wherego/views/mylist/myWrite.jsp?id=<%=c.getId()%>'">            
            <input type="button" value="myreviews" onclick="myreviews_open()">
            <input type="button" value="mypick" onclick="mypick_open()">
          <%} else {%>
            <input type="button" value="mymagazine" onclick="window.location='/team02/views/mylist/board.jsp?id=test'"> 
            <input type="button" value="myreviews" onclick="window.location='#'">
          <%} %>
       <%} %> 
       </td>     
      </tr>
     </table>   
   </center>
   
   
   <div style="display:flex; width:100%; text-align: center; height: 200px;">
      <div id="mymagazine" style="width:100%; background-color: pink;">
	    
	      <ul>
	     
	     <!-- 정룡이가준거 -->
	      
	        <center><p><%=c.getNic()%>님이 작성한 게시글 목록입니다.</p> 

	<center><b>글목록(전체 글:<%=count%>)</b>


	<%
	   if (count == 0) {
	%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
			  <td align="center">
			    게시판에 저장된 글이 없습니다.
		      </td>
		    </tr>
		</table>
	
	<%}else{%>
		<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
		    <tr height="30" > 
			    <td align="center"  width="100"  >글번호</td> 
			    <td align="center"  width="100"  >닉네임</td> 
			    <td align="center"  width="100" >제목</td> 
			    <td align="center"  width="100" >내용</td>
			    <td align="center"  width="150" >조회수</td> 
			    <td align="center"  width="150" >사진</td> 
			    <td align="center"  width="150" >지역</td> 
			    <td align="center"  width="100" >작성일</td>      
		    </tr>
	 <%  
	   for(int i = 0 ; i < articleList.size() ; i++){
	      MyListDTO article = (MyListDTO)articleList.get(i);
	%>   
		   <tr height="30">    
		    <td align="center"  width="100" > <%=number--%></td>
		    <td align="center"  width="100" >
		    <a href="myWrite.jsp?id=<%=article.getId()%>">
		     <%=article.getId()%></a></td>
		    <td align="center"  width="150"><%=article.getContent()%></td>
	   		<td align="center"  width="100"> 
	   		<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
	           <%=article.getSubject()%></a> 
		    <td align="center"  width="150"><%=article.getCount()%></td>
		    <td align="center"  width="150"><%=article.getImage()%></td>
		    <td align="center"  width="50"><%=article.getZone()%></td>
		    <td align="center"  width="50"><%=article.getReg_date()%></td>    
	  		</tr>
	    <%}%>
		</table>
	<%}%>
		      
	<%
	   if(count > 0){
		 int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
				 
		 int startPage = (int)(currentPage/10)*10+1;
		 int pageBlock=10;
		 int endPage = startPage + pageBlock-1;
		 if (endPage > pageCount) endPage = pageCount;
		        
		 if (startPage > 10){%>
		   <a href="board.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
		 <%}
		 
		 for (int i = startPage ; i <= endPage ; i++) {  %>
		   <a href="board.jsp?pageNum=<%= i %>">[<%= i %>]</a>
		 <%}
		    
		 if(endPage < pageCount){%>
		   <a href="board.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
		 <%}
	  }%>
	
	</center>	      
	
	<!-- 정룡이가준거 여기까지 -->      
	      
	  </div>
	      
	  <div id="myreviews" style="width:100%;  background-color: #b9ffec; display:none;">
	      <center><p><%=c.getNic()%>님이 작성한 리뷰 리스트 입니다.</p> 
	      

	<center><b>글목록(전체 글:<%=count%>)</b>


	<%
	   if (count == 0) {
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
	  
	  <div id="mypick" style="width:100%;background-color: gray; display:none; ">
	      <center><p><%=c.getNic()%>님의 찜한 여행지 리스트입니다.</p> 
	      <center><b>아구찜목록(전체 글:<%=count%>)</b>


	<%
	   if (count == 0) {
	%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
			  <td align="center">
			    갈비찜이 없습니다.
		      </td>
		    </tr>
		</table>
		<%}%>
	  </div>
      </div>   
      
   </div>


	
<%} catch (Exception e){
   e.printStackTrace();
}%>
   
   
    <script>
            
           function magazine_open() {
               let magazine = document.getElementById('mymagazine').style.display = "";
               let myreviews = document.getElementById('myreviews').style.display = "none";
               let mypick = document.getElementById('mypick').style.display = "none";
               console.log(magazine);
           }
           
           function myreviews_open() {
               let myreviews = document.getElementById('myreviews').style.display = "";
               let magazine = document.getElementById('mymagazine').style.display = "none";
               let mypick = document.getElementById('mypick').style.display = "none";
               console.log(myreviews);
           }
           
           function mypick_open() {
               let mypick = document.getElementById('mypick').style.display = "";
               let myreviews = document.getElementById('myreviews').style.display = "none";
               let magazine = document.getElementById('mymagazine').style.display = "none";
               console.log(magazine);
           }
              
     </script>
	
	
	
