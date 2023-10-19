<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.db.land.API_used"%> 
<%@page import="java.util.ArrayList"%>
<%@page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>어디Go</title>
</head>
<body>

<%
      String areaCode = request.getParameter("areaCode");

      String sigunguCode = request.getParameter("sigunguCode");

      API_used api = API_used.getInstance();
      HashMap<String, Integer> totalMap = new HashMap<String, Integer>();
      totalMap = api.findTotalCount_NumOfRows(areaCode,sigunguCode);
      int totalCount = totalMap.get("totalCount");
      
      String p = request.getParameter("pageNum");
      int pageNum = 1;
      if(p != null){
         pageNum = Integer.parseInt(p);
      }
      int pageSize = 20;
   
      
      int max = (totalCount / 20) + 1;
      ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();  
 
      list = api.findFestival(areaCode,sigunguCode,pageNum);

      String src = "";   
       for(HashMap<String, String> festival : list) {%>
       
         <a href="/team02/views/contentLand/contentRand.jsp?areaCode=<%=areaCode %>&sigunguCode=<%=sigunguCode %>&contentid=<%=festival.get("contentid")%>&pageNum=<%=pageNum%>" >
          <% src = festival.get("firstimage");
          if(!src.equals("")){%>
          <img src="<%=festival.get("firstimage") %>" width="200" height="200"/>
          
       <%}else if(src.equals("")){%>
            <img src = "/team02/image/image.jpg" width="200" height="200"/>        
      <% }%>
            <h3><%=festival.get("title") %></h3> 
            </a>        
      		<% String category = api.findCategory(festival.get("cat1"), festival.get("cat2"), festival.get("cat3"));%>
      		<span>종류 : <%=category %></span>
      		<br />
            <span>주소 : <%=festival.get("addr1") %></span> 
            <hr/>
<%} %>
   
   
   <%
    if (pageNum > 0) {
        int pageCount = max ;
       
        int startPage = ((pageNum - 1) / 10) * 10 + 1;
      int pageBlock = 10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage - 1 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage && i <= max; i++) {  %>
        <a href="listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%=i%>">[<%=i%>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="listRand.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
   
   
   
   
</body>
</html>