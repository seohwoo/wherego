<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.list.API_used"%>
<%@ page import = "team02.land.LandDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디Go</title>
</head>
<body>

	<%	LandDAO landO = LandDAO.getInstance();
		String contentid = request.getParameter("contentid");
		String areaCode = request.getParameter("areaCode");
		String sigunguCode = request.getParameter("sigunguCode");
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String id = (String)session.getAttribute("memId");
		
		API_used api = API_used.getInstance();
		HashMap<String, String> randInfo = api.findRandInfo(contentid);
		HashMap<String, String> DetailrandInfo = api.findDetailRandInfo(contentid);
		
		if(randInfo.get("homepage").equals("")) {
			randInfo.put("homepage", "없음");
		}
		String src = "";
	%>
		<h1><%=randInfo.get("title")%></h1>
		<% src = randInfo.get("firstimage");
          if(!src.equals("")){%>
          <img src="<%=randInfo.get("firstimage") %>" width="200" height="200"/>
          
       <%}else if(src.equals("")){%>
            <img src = "/team02/image/image.jpg" width="200" height="200"/>        
      <% }%>
      	<br />
		<span>홈페이지 : </span><%=randInfo.get("homepage") %>	</br />
		<h4>주소 : <%=randInfo.get("addr1") %></h4>
		<h4>설명 : </h4>
		<h4><%=randInfo.get("overview") %></h4>
		<%
			String category = api.findCategory(randInfo.get("cat1"), randInfo.get("cat2"), randInfo.get("cat3"));
			
			Set<String> DetailrandInfoKeys = DetailrandInfo.keySet(); 			
		
			for(String key : DetailrandInfoKeys) {
				if(DetailrandInfo.get(key).equals("")) {
					if(key.equals("restdate")) {
						DetailrandInfo.put("restdate", "연중무휴");
					}else if(key.equals("usetime")) {
						DetailrandInfo.put("usetime", "09:00~22:00");
					}else{
						DetailrandInfo.put("parking", "없음");
					}
				}
			}
		%>
		
	<script language="JavaScript">
		function insertStar(areaCode, sigunguCode,contentid,pageNum) {
   		 // url과 사용자 입력 id를 조합합니다.
    	url = "randStarInsertForm.jsp?areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&contentid="+contentid+"&pageNum="+pageNum;
    
   		 // 새로운 윈도우를 엽니다.
   		 open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=400, height=190");
}
	</script>
		<%
		double avg = landO.avgStar(contentid);
		%>
		
		
		<h5>카테고리 : <%=category %></h5>
		<h5>전화번호 : <%=DetailrandInfo.get("infocenter") %></h5>
		<h5>영업일 : <%=DetailrandInfo.get("restdate") %></h5>
		<h5>이용시간 : <%=DetailrandInfo.get("usetime") %></h5>
		<h5>주차 : <%=DetailrandInfo.get("parking") %></h5>
		<h5>유모차 대여 : <%=DetailrandInfo.get("chkbabycarriage") %></h5>
		<h5>반려견 입장 : <%=DetailrandInfo.get("chkpet") %></h5>
		<h5>평점 : <%=avg%>  <input type="button" value="평점주기" OnClick="insertStar(<%=areaCode%>,<%=sigunguCode%>,<%=contentid%>,<%=pageNum%>)"></h5>
</body>
</html>