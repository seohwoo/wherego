<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/views/login/color.jsp"%>
<%@ page import = "team02.mylist.MyListDAO" %>
<%@ page import = "team02.mylist.MyListDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<title>제목 클릭 후 리뷰 보기</title>

<%
      int num = Integer.parseInt(request.getParameter("num"));
      String pageNum = request.getParameter("pageNum");
      String id = (String)session.getAttribute("memId");

      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");

   MyListDAO dbPro = MyListDAO.getInstance();
   MyListDTO article =  dbPro.getArticle(num);
   String ids = dbPro.getId(num);
%>


 <h3>글내용 보기</h3>
 
   <%//if( id.equals("admin1") || id.equals(ids)) { %>
   
   <form>
   <table width="500" border="1" cellspacing="0" cellpadding="0"  bgcolor="<%=bodyback_c%>" align="center">  
    
     <tr height="30">
     
       <td align="center" width="125" bgcolor="<%=value_c%>">글번호</td>
       <td align="center" width="125" align="center">
           <%=article.getNum()%></td>
       <td align="center" width="125" bgcolor="<%=value_c%>">조회수</td>
       <td align="center" width="125" align="center">
           <%=article.getCount()%></td>
     </tr>
     
     
     <tr height="30">
       <td align="center" width="125" bgcolor="<%=value_c%>">작성자</td>
       <td align="center" width="125" align="center">
           <%=article.getId()%></td>
       <td align="center" width="125" bgcolor="<%=value_c%>" >작성일</td>
       <td align="center" width="125" align="center">
           <%=article.getReg_date()%></td>
     </tr>
     
     
     
     <tr height="30">
       <td align="center" width="125" bgcolor="<%=value_c%>">글제목</td>
       <td align="center" width="375" align="center" colspan="3">
           <%=article.getContent()%></td>
     </tr>
     
     
     
     <tr>
       <td align="center" width="125" bgcolor="<%=value_c%>">글내용</td>
       <td align="center" width="375" colspan="3"><pre><%=article.getSubject()%></pre></td>
     </tr>
     <tr height="30">      
       <td colspan="4" bgcolor="<%=value_c%>" align="right" >
       
       
       
       <%
          if(id != null) {
             if(id.equals(article.getId())) {%>
               <input type="button" value="글수정" 
                onclick="document.location.href='boardUpdateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
               &nbsp;&nbsp;&nbsp;&nbsp;
             <%}
            if(id.equals(article.getId()) || id.equals("admin1")) {%>   
               <input type="button" value="글삭제" 
                onclick="document.location.href='boardDeleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
               &nbsp;&nbsp;&nbsp;&nbsp;
             <%}
           
         }%>
          <input type="button" value="글목록" 
          onclick="document.location.href='board.jsp?pageNum=<%=pageNum%>'">
          &nbsp;&nbsp;&nbsp;&nbsp;
       </td>
     </tr>
   </table>
   </form>
   <br />
         <%//}%>
   