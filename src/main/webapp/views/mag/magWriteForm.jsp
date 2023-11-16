<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>


<html>
<head>
<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	
<title>게시판</title>
<script language="JavaScript" src="script.js"></script>
</head>

<body>
<jsp:include page="/views/main/nav.jsp" />	
<jsp:include page="/views/main/title.jsp" /><br />
<%
  	// 로그인 된 세션 ID
  	String id = (String)session.getAttribute("memId");
	ArrayList<String> contentidList = (ArrayList<String>)session.getAttribute("contentidList");
	if(contentidList == null || contentidList.toString().equals("[]")) {%>
		<script>
            alert("장소를 선택하세요 🤬🤬🤬🤬");
            window.location="/wherego/views/mag/magSearch.jsp";
        </script>
	<%}else{
  	String pageNum = request.getParameter("pageNum");
  	LandDAO landO = LandDAO.getInstance();
  	String src = ""; 
%>
	<h3 align="center"> 매거진 작성을 완료해주세요! </h3> 
	<br>
	
	<div class="d-grid gap-2 col-6 mx-auto">
		<form method="post" name="writeform" action="magWritePro.jsp">
		  <input type="hidden" name="id" value="<%=id%>">
		  <div style="float: right;">
		  	 <a href="magList.jsp" class="btn btn-outline-dark" style="float: right;"> 글목록</a>
		  </div>
		  <div class="mb-3">
			  <label for="exampleFormControlInput1" class="form-label">제목</label>
			  <input type="text" class="form-control" id="exampleFormControlInput1" name="subject" >
			</div>
			<div class="mb-3">
			   <ul> 
				<%for(int i=0; i<contentidList.size(); i++) {
				 // 정보 불러오기
				  HashMap<String,String> DetailrandInfoMap = landO.selectContentRandInfo(contentidList.get(i));
				  System.out.println(DetailrandInfoMap.get("title"));
				%>	
					<li>
					    <a href="/wherego/views/contentLand/contentRand.jsp?contentid=<%=contentidList.get(i)%>&pageNum=1">
					    	<%=DetailrandInfoMap.get("title") %>
					    </a>
					</li>  
				</ul>
			 <%}%>
			</div>
			<div class="mb-3">
			  <label for="exampleFormControlTextarea1" class="form-label">내용</label>
			  <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="content"></textarea>
			</div>
			<div class="text-center">
			  <input type="submit" class="btn btn-secondary" value="글쓰기" >  
			  <input type="reset" class="btn btn-secondary" value="재작성">
   			</div>
		</form> 
	</div>
	<%}%>
<div>
	<br /><hr /><br />
	<jsp:include page="/views/main/footer.jsp" />
</div>    
</body>
</html>      