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
	ArrayList<String> contentidList = (ArrayList<String>)session.getAttribute("contentidList");
	if(contentidList == null || contentidList.toString().equals("[]")) {%>
		<script>
            alert("장소를 선택하세요 🤬🤬🤬🤬");
            window.location="/wherego/views/mag/test.jsp";
        </script>
	<%}else{
  	String pageNum = request.getParameter("pageNum");
  	LandDAO landO = LandDAO.getInstance();
  	String src = ""; 
%>

	<center><b>글쓰기</b>
	<br>
	<form method="post" name="writeform" action="magWritePro.jsp">
	<input type="hidden" name="id" value="<%=id%>">
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
	    
	    
	    
	<%for(String contentid : contentidList) {
		 // 정보 불러오기
		  HashMap<String,String> DetailrandInfoMap = landO.selectContentRandInfo(contentid);
	%>
	   <ul class="list-group list-group-flush"> 
			    <img src="<%=DetailrandInfoMap.get("firstimage") %>" class="card-img-top" width="200" height="200"/>
			    <li class="list-group-item">
			    	<a href="/wherego/views/contentLand/contentRand.jsp?contentid=<%=contentid%>&pageNum=1">
			    		<%=DetailrandInfoMap.get("title") %>
			    	</a>
			    </li>
			    <li class="list-group-item"><%=DetailrandInfoMap.get("category") %></li>
			    <li class="list-group-item"><%=DetailrandInfoMap.get("areacodename") %> > <%=DetailrandInfoMap.get("sigungucodename") %></li>
		</ul>
	 <%}%>
	     <textarea name="content" rows="13" cols="40"></textarea> </td>
	  </tr>
	
		<tr>      
		 <td colspan=2  align="center"> 
		  <input type="submit" value="글쓰기" >  
		  <input type="reset" value="다시작성">
		</td>
	</tr>
	</table>    
	</form>      
	<%}%>     
	</body>
</html>      