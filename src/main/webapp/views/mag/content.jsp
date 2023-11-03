<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>

<html>
<head>
<title>이번주 추천 여행지 보기</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
	 
	  String id = "";
	  if(session.getAttribute("memId")!=null) {
     	id = (String) session.getAttribute("memId");  		
	  }

      int num = Integer.parseInt(request.getParameter("num"));  
      String pageNum = request.getParameter("pageNum");
      
	
      MagDAO dbPro = MagDAO.getInstance();
      MagDTO mag = dbPro.getmag(num);  // 번호에 맞는 내용
      
      
      // 정보 불러오기
       LandDAO landO = LandDAO.getInstance();
	   HashMap<String,String> DetailrandInfoMap = landO.selectContentRandInfo(mag.getContentid());      
       String src = "";

      try{   	  	  
      
%>


<jsp:include page="/views/main/nav.jsp" />	

<center>
   <h3>메거진 내용 보기</h3>
   
   <%if(id != null) { %>
   <form>
   <table width="500" border="1" cellspacing="0" cellpadding="0"  align="center">
     
     <tr height="30">
       <td align="center" width="125">글번호</td>
       <td align="center" width="125" align="center">
           <%=mag.getNum()%></td>  
           <td align="center" width="125" >작성일</td>
       <td align="center" width="125" align="center">
           <%=mag.getReg_date() %></td>    
     </tr>   
     
     
     <tr height="30">
       <td align="center" width="125" >작성자</td>
       <td align="center" width="125" align="center" colspan="3">
           여기어때 </td>       
     </tr>
     
     <tr height="30">
       <td align="center" width="125" >상세정보 확인</td>
       <td align="center" width="125" align="center" colspan="3">
           <a href = '/wherego/views/contentLand/contentRand.jsp?areaCode=<%=DetailrandInfoMap.get("areacode") %>&sigunguCode=<%=DetailrandInfoMap.get("sigungucode")%>&contentid=<%=mag.getContentid() %>&pageNum=1'>클릭해서 리뷰보기~!</a></td>       
     </tr>
     
     <tr height="30">
       <td align="center" width="125" >글제목</td>
       <td align="center" width="375" align="center" colspan="3">
           <%=mag.getSubject()%></td>
     </tr>
     
     <tr height="30">
       <td align="center" width="125" >장소</td>
       <td align="center" width="125" align="center" colspan="3">
           <%=DetailrandInfoMap.get("areacodename")%> > <%=DetailrandInfoMap.get("sigungucodename")%> </td>       
     </tr>
     
     
     <tr>
       <td align="center" width="125">사진</td>
       <td align="left" width="375" colspan="3"><pre><img src="<%=DetailrandInfoMap.get("firstimage") %>" class="card-img-top" width="200" height="200"/></pre></td>
     </tr>

     <tr>
       <td align="center" width="125">글내용</td>       
       <td align="left" width="375" colspan="3"><pre>
	       
       <%=mag.getContent()%></pre></td>
     </tr>   
     
     <tr height="30">      
       <td colspan="4"  align="right" > 
       <%
          if(id != null) {
            if(id.equals("admin")) {%>
            <input type="button" value="글수정" 
            onclick="document.location.href='magUpdateForm.jsp?num=<%=mag.getNum()%>&pageNum=<%=pageNum%>'">
            &nbsp;&nbsp;&nbsp;&nbsp;       
         <%}%>
      
        <input type="button" value="글목록" 
        onclick="document.location.href='magList.jsp?pageNum=<%=pageNum%>'">
        &nbsp;&nbsp;&nbsp;&nbsp;
     </td>      
     <%}%>      
    </tr>   
   <%}%>      
     
   </table>
   <%
  }catch(Exception e){}
%>     
   </form>
   </body>
</html>  