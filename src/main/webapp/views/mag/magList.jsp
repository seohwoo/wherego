<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<%@ page import = "java.util.List" %>

<!-- 찜하기 -->
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "team02.user.save.SaveDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import = "java.util.List" %>
<%@page import = "java.util.HashMap" %>

<%
    int pageSize = 10;  // 게시판 첫페이지에 보여줄 글 개수
    String id = "";
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

<%
	if(session.getAttribute("memId")!=null) {
 	  	id = (String) session.getAttribute("memId");
	}

    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    ArrayList<MagDTO> MagList = null;
    MagDAO dbPro =  MagDAO.getInstance();
    count = dbPro.getMagCount();   //  메거진 글 갯수
    if (count > 0) {
    	MagList = dbPro.getMagines(startRow, endRow);  // 메거진 시작과 끝
    } 

   number=count-(currentPage-1)*pageSize;
   int grade = dbPro.isAdmin(id);
%>

<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>어디Go - Magazine</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
   <jsp:include page="/views/main/title.jsp" /><br />



<h2 align="center">🔖 Magazine🔖 </h2>
    <br />
     <%
     if(grade==99){
     %>
    <div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location = 'magSearch.jsp'">✏ 매거진 작성 ✏</button>
    </div>
    <%}%> 
    <br />


<div class="d-grid gap-2 col-6 mx-auto">
<%
    if (count == 0) {
%>
   <table class="table table-hover" width="700" border="1" cellpadding="0" cellspacing="0">
     <tr> 
       <td align="center">
       현재 작성된 메거진 없습니다.
       </td>
      </tr>
   </table>

<%}else{%>
  <table class="table table-hover" width="700" cellpadding="0" cellspacing="0" align="center"> 
  	<thead>
      <tr> 
        <td align="center" width="50" ><b>#</b></td> 
        <td align="center" width = "200"><b>제목</b></td>                           
        <td align="center" width ="100"><b>작성일</b></td>        
      </tr>
     </thead>
<%  
   for (int i = 0 ; i < MagList.size() ; i++) {
      MagDTO mag = MagList.get(i);
      Date reg_dateD = inputFormat.parse(mag.getReg_date());
	  String reg_date = outputFormat.format(reg_dateD);
%>
	<tbody>
	     <tr height="30" OnClick="window.location='content.jsp?num=<%=mag.getNum()%>&pageNum=<%=currentPage%>'" style="cursor: pointer;">
	       <td align="center"  width="50" > <%=number--%></td>      
	       <td align="center"  width="100"> <em><%=mag.getSubject() %> </em></td>      
	       <td align="center"  width="150"><%=reg_date %></td>
	     </tr> 
    </tbody>
   <%}%>
 </table>
<%}%>
</div>

<br />
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
		<%
		    if (count > 0) {
		        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		       
		        int startPage = (int)(currentPage/10)*10+1;
		      	int pageBlock=10;
		        int endPage = startPage + pageBlock-1;
		        if (endPage > pageCount) endPage = pageCount;
		        
		        if (startPage > 10) {    %>
		        <li class="page-item">
		          <a class="page-link" href="magList.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
		            <span aria-hidden="true">&laquo; 이전</span>
		          </a>
		        </li>
		<%      }
		        for (int i = startPage ; i <= endPage ; i++) {  %>
		        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
		          <a class="page-link" href="magList.jsp?pageNum=<%= i %>"><%= i %></a>
		        </li>
		<%
		        }
		        if (endPage < pageCount) {  %>
				<li class="page-item">
		          <a class="page-link" href="magList.jsp?pageNum=<%= startPage + 10 %>" aria-label="Next">
		            <span aria-hidden="true">다음 &raquo;</span>
		          </a>
		        </li>		         
		<%
		        }
		    }
		%>
		</ul>
	</nav>
	
	   <div >
	<br/><hr /><br/>
		<jsp:include page="/views/main/footer.jsp" />	
	</div>
</body>
</html>

