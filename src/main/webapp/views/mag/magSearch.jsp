<%@ page import = "java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어디GO</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	
</head>
<body>
<jsp:include page="/views/main/nav.jsp" />	
<jsp:include page="/views/main/title.jsp" /><br />

	<h3 align="center"> 추천하고자 하는 여행지를 선택하세요</h3> <br />
	<%
		String contentid  = request.getParameter("contentid");
	
	    // 세션에 접근하고, 세션이 이미 존재하는지 확인
	    ArrayList<String> contentidList = null;
	    MagDAO dao = MagDAO.getInstance();
	
	    if (session.getAttribute("contentidList") == null) {
	        // 세션이 존재하지 않을 경우, ArrayList를 생성하고 세션에 저장
	        contentidList = new ArrayList<String>();
	        session.setAttribute("contentidList", contentidList);
	    }else{
	    	contentidList = (ArrayList<String>) session.getAttribute("contentidList");
	    }
	    
	    
	    
	    if(contentid != null) {
		    contentidList.add(contentid);
	    }
	%>
	<div class="d-grid gap-2 col-6 mx-auto">
	<form action="/wherego/views/search/adminResult.jsp?pageNum=1" method="post">
		<div class="input-group mb-3">
				<select class="btn btn-outline-secondary dropdown-toggle" name="searchType">
					<option value="loc">지역</option>
					<option value="land">명소</option>
				</select>
			<input name="searchValue" type="text" class="form-control" placeholder="여행지를 검색해보세요">
			<div class="col-auto">
				<button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
			</div>
		</div>
	</form>
	</div>
	<div class="input-group mb-3" style="justify-content: center;">
			&nbsp;&nbsp;&nbsp;
			<%for(String cid: contentidList){
				String title = dao.getMagTitle(cid);
				%>
				<p style="font-family: 'Pretendard-Regular', sans-serif;"><%=title %>&nbsp;&nbsp;&nbsp;</p>
			<%} %>
	</div>
		<form action="magWriteForm.jsp" method="post">
			<div class="d-grid gap-2 col-6 mx-auto">
	        <input type="submit" class="btn btn-secondary" value="매거진 작성" />
	        </div>
	    </form>

<div style="position: fixed; width: 100%; bottom: 0px;">
	<br /><hr /><br />
	<jsp:include page="/views/main/footer.jsp" />
</div>     
</body>
</html>