<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "team02.member.MemberDAO" %>
<%@ page import = "team02.member.MemberDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/views/login/color.jsp"%>

<%!
    int pageSize = 10; // 페이지당 글 10개
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 매게변수를 년 월 일 시 분 으로 받은 참조변수 생성
%>
<%

    String pageNum = request.getParameter("pageNum"); // 00 
    if (pageNum == null) { // pageNum의 값이 null일 때
        pageNum = "1";     // 문자 1을 대입
    }

    int currentPage = Integer.parseInt(pageNum); // pageNum(문자1)을 숫자 1로 바꿔라
    int startRow = (currentPage - 1) * pageSize + 1; // (1 - 1) * 10 + 1 = 1
    int endRow = currentPage * pageSize; // 1 * 10 = 10
    int count = 0; // 변수 선언
    int number=0; // 변수 선언

    List articleList = null; // 00
    MemberDAO dbPro = MemberDAO.getInstance(); // BoardDAO 클래스의 주소가 dbPro에 있음 
    count = dbPro.getmember2(); // dbPro(BoardDAO클래스) 의 getArticleCount를 count에 대입
    if (count > 0) { // 카운트가 0보다 클 때 
        articleList = dbPro.getArticles(startRow, endRow);
    }

	number=count-(currentPage-1)*pageSize;
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>


<center><b>글목록(전체 글:<%=count%>)</b>
<table width="700">
<tr>

</table>

<%
    if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" > 
       <td align="center"  width="50"  >id</td> 
      <td align="center"  width="250" >pw</td> 
      <td align="center"  width="100" >name</td>
      <td align="center"  width="150" >nic</td> 
      <td align="center"  width="50" >birth</td> 
      <td align="center"  width="100" >gender</td>   
      <td align="center"  width="100" >address</td>   
      <td align="center"  width="100" >email</td>   
      <td align="center"  width="100" >phone</td>   
      <td align="center"  width="100" >grade</td>   
      <td align="center"  width="100" >total</td>   
      <td align="center"  width="100" >profile</td>   
      <td align="center"  width="100" >reg_date</td>   
    </tr>
<%  
        for (int i = 0 ; i < articleList.size() ; i++) {
          MemberDTO article = (MemberDTO)articleList.get(i);
%>
   <tr height="30">
    <td align="center"  width="50" > <%=number--%></td>
    <td  width="250" >


	
           
      
           <%=article.getId()%></a> 
    <td align="center"  width="100"> 
       <td align="center" width = "100"><%=article.getId()%></td>
       <td align="center" width = "100"><%=article.getPw()%></td>
       <td align="center" width = "100"><%=article.getName()%></td>
       <td align="center" width = "100"><%=article.getNic()%></td>
       <td align="center" width = "100"><%=article.getBirth()%></td>
       <td align="center" width = "100"><%=article.getGender()%></td>
       <td align="center" width = "100"><%=article.getAddress()%></td>
       <td align="center" width = "100"><%=article.getEmail()%></td>
       <td align="center" width = "100"><%=article.getPhone()%></td>
       <td align="center" width = "100"><%=article.getGrade()%></td>
       <td align="center" width = "100"><%=article.getTotal()%></td>
       <td align="center" width = "100"><%=article.getProfile()%></td>
       <td align="center" width = "100"><%=article.getReg_date()%></td>
    
  </tr>
  <%}%>
     <%}%>
</table>


<%

    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="practice.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="practice.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="practice.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }

%>
</center>
</body>
</html>