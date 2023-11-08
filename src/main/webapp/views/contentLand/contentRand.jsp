<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.db.land.LastAPI_Used"%> 
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	
<meta charset="UTF-8">
<title>어디Go</title>
</head>
<body>

	<jsp:include page="/views/main/nav.jsp" />
	<jsp:include page="/views/main/title.jsp" />
	
	<br />
	<%	
		String contentid = request.getParameter("contentid");
		String areaCode = request.getParameter("areaCode");
		String sigunguCode = request.getParameter("sigunguCode");
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String id = (String)session.getAttribute("memId");
		
		LandDAO landO = LandDAO.getInstance();
		HashMap<String,String> DetailrandInfoMap = landO.selectContentRandInfo(contentid);
		int chkResult = landO.contentIdChk(contentid);
		if(chkResult == -1){
			landO.insertReadCountNewContentId(contentid);
		}
		landO.updateReadCount(contentid);
		
		int readCount = landO.getReadCount(contentid);
		if(DetailrandInfoMap.get("homepage") == null) {
			DetailrandInfoMap.put("homepage", "없음");
		}
		if(DetailrandInfoMap.get("overview") == null) {
			DetailrandInfoMap.put("overview", "없음");
		}
		
		String src = "";
	%>
	<%
	  	SaveDAO saveDao = SaveDAO.getInstance();
		 int issave = saveDao.isSave(contentid, id);
	%>
	<div class="container text-center col-6 col-md-4">
	<div class="card mb-3">
		<div style="position: relative; display: inline-block;">
			<form action="/wherego/views/contentLand/contentLandSavePro.jsp" method="post" style="position:absolute;">
			    <input type="hidden" name="contentid" value="<%=contentid %>" />
			    <input type="hidden" name="areaCode" value="<%=areaCode %>" />
			    <input type="hidden" name="sigunguCode" value="<%=sigunguCode %>" />
			    <input type="hidden" name="pageNum" value="<%=pageNum %>" />
			    <button type="submit" style="border: none; background: none; cursor: pointer;">
			        <% if(issave == 0){ %><i class="far fa-heart" style="color: #ff0000; font-size: 30px; margin: 10px;"></i>
			        <%}else{%>
			        	<i class="fas fa-heart" style="color: #ff0000; font-size: 30px; margin: 10px;"></i>
			        <%} %>
			    </button>
			</form>
		<% src = DetailrandInfoMap.get("firstimage");
          if(!src.equals("")){%>
          <img src="<%=DetailrandInfoMap.get("firstimage") %>" class="card-img-top" width="200" height="200"/>
          
       <%}else if(src.equals("")){%>
            <img src = "/wherego/image/image.jpg" class="card-img-top" width="200" height="200"/>        
      <% }%>
      </div>
       <div class="card-body">
      	 <h2><%=DetailrandInfoMap.get("title")%></h2>
      	 <h5><strong><%=DetailrandInfoMap.get("addr1") %></strong></h5>
      	<br />
      		<div class="card-body">
				🌐 <%=DetailrandInfoMap.get("homepage") %>	
			</div><br />
		<div class="card-body">
		<h5>⚠ <%=DetailrandInfoMap.get("overview") %></h5> 
		</div><br />
		<%
				if(DetailrandInfoMap.get("restdate") == null) {
					
					DetailrandInfoMap.put("restdate", "연중무휴");
					}
				if(DetailrandInfoMap.get("usetime") == null) {
					DetailrandInfoMap.put("usetime", "09:00~22:00");
					}
				if(DetailrandInfoMap.get("parking") == null){
					DetailrandInfoMap.put("parking", "불가");
					}
				if(DetailrandInfoMap.get("category") == null){
					DetailrandInfoMap.put("category", "없음");
					}
				if(DetailrandInfoMap.get("chkbabycarriage") == null){
					DetailrandInfoMap.put("chkbabycarriage", "불가");
					}
				if(DetailrandInfoMap.get("chkpet") == null){
					DetailrandInfoMap.put("chkpet", "불가");
					}
		%>
		
	<script language="JavaScript">
		function insertStar(contentid) {
   		 // url과 사용자 입력 id를 조합합니다.
    	url = "randStarInsertForm.jsp?contentid="+contentid;
    
   		 // 새로운 윈도우를 엽니다.
   		 open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=700, height=400");
}
	</script>
		<%
		double avg = landO.avgStar(contentid);
		%>
		
		<ul class="list-group list-group-flush">
		    <li class="list-group-item">카테고리 : <%=DetailrandInfoMap.get("category") %></li>
		    <li class="list-group-item">전화번호 : <%=DetailrandInfoMap.get("infocenter") %></li>
		    <li class="list-group-item">영업일 : <%=DetailrandInfoMap.get("restdate") %></li>
		    <li class="list-group-item">이용시간 : <%=DetailrandInfoMap.get("usetime") %></li>
		    <li class="list-group-item">주차 : <%=DetailrandInfoMap.get("parking") %></li>
		    <li class="list-group-item">유모차 대여 : <%=DetailrandInfoMap.get("chkbabycarriage") %></li>
		    <li class="list-group-item">반려견 입장 : <%=DetailrandInfoMap.get("chkpet") %></li>
		    <li class="list-group-item">주차 : <%=DetailrandInfoMap.get("parking") %></li>
		  </ul>
	  	<div class="card-body">
		<h5>리뷰: <%=avg%>/5 
		<input class="btn btn-outline-secondary" type="button" value="작성" OnClick="insertStar(<%=contentid%>)"></h5>
		<form action="putLandPro.jsp" method="post" onsubmit="return changeButtonColor()">
        	<input class="btn btn-outline-secondary" type="submit" value="담기" name="putLand" id="putLand">
   	 	</form>
   	 	</div>
   	 	</div>
   	 	</div>
   	 	</div>
   	 	<jsp:include page="/views/contentLand/contentRandReview.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&contentid=<%=contentid%>&pageNum=<%=pageNum%>" />
   	 	
</body>
<script>
var buttonClicked = false; // 초기에 버튼이 클릭되지 않았음을 나타내는 변수

function changeButtonColor() {
    const button = document.getElementById("putLand");

    if (!buttonClicked) {
        // 버튼의 색상을 빨간색으로 변경합니다.
        button.style.backgroundColor = "#d06058";
        buttonClicked = true;
    } else {
        // 버튼이 이미 클릭되었을 때, 다시 클릭하면 원래 색상으로 변경합니다.
        button.style.backgroundColor = ""; // 빈 문자열로 설정하여 원래 스타일로 돌아갑니다.
        buttonClicked = false;
    }
    return true; // 폼을 서버로 제출합니다.
}
</script>
<style>
	.content {
  max-width:600px;
  margin:0 auto;
  padding:0 10px 80px;
  
}
</style>
</html>