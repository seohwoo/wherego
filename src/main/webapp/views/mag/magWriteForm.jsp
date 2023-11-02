<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>


<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>


<%
  // 로그인 된 세션 ID
  String id = (String)session.getAttribute("memId");
  //가져온 파라미터
  String contentid = request.getParameter("contentid");
  String pageNum = request.getParameter("pageNum");
  
  
  // 정보 불러오기
  LandDAO landO = LandDAO.getInstance();
  HashMap<String,String> DetailrandInfoMap = landO.selectContentRandInfo(contentid);
  
  String src = "";
  
  
  try{  
    
%>

<center><b>글쓰기</b>
<br>
<form method="post" name="writeform" action="magWritePro.jsp?contentid=<%=contentid%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="id" value="<%=contentid%>">






<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
   <tr>
    <td align="right" colspan="2">
	    <a href="magList.jsp"> 글목록</a> 
   </td>
   </tr>



  <tr>
    <td  width="70" align="center">제목</td>
    <td  width="330">
       <input type="text" size="40" maxlength="30" name="subject" ></td>
  </tr>
  
  <tr>
    <td  width="70" align="center" >내 용</td>    
    <td  width="330" >
    
    <ul class="list-group list-group-flush"> 
		    <img src="<%=DetailrandInfoMap.get("firstimage") %>" class="card-img-top" width="200" height="200"/>
		    <li class="list-group-item">카테고리 : <%=DetailrandInfoMap.get("category") %></li>
		    <li class="list-group-item">주소 : <%=DetailrandInfoMap.get("addr1") %></li>
		    <li class="list-group-item">전화번호 : <%=DetailrandInfoMap.get("infocenter") %></li>
		    <li class="list-group-item">영업일 : <%=DetailrandInfoMap.get("restdate") %></li>
		    <li class="list-group-item">이용시간 : <%=DetailrandInfoMap.get("usetime") %></li>
		    <li class="list-group-item">홈페이지 : <%=DetailrandInfoMap.get("homepage") %></li>
		    <li class="list-group-item">주차 : <%=DetailrandInfoMap.get("parking") %></li>
		    <li class="list-group-item">유모차 대여 : <%=DetailrandInfoMap.get("chkbabycarriage") %></li>
		    <li class="list-group-item">반려견 입장 : <%=DetailrandInfoMap.get("chkpet") %></li>
		    <li class="list-group-item">주차 : <%=DetailrandInfoMap.get("parking") %></li>
		  </ul>
     <textarea name="content" rows="13" cols="40"></textarea> </td>
  </tr>

	<tr>      
	 <td colspan=2  align="center"> 
	  <input type="submit" value="글쓰기" >  
	  <input type="reset" value="다시작성">
	</td>
</tr>
</table>    
 <%
  }catch(Exception e){}
%>     
</form>      
</body>
</html>      