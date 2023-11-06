<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
<jsp:include page="/views/main/nav.jsp" />	
	<%
		String contentid  = request.getParameter("contentid");
	
	    // 세션에 접근하고, 세션이 이미 존재하는지 확인
	    ArrayList<String> contentidList = (ArrayList<String>) session.getAttribute("contentidList");
	
	    if (contentidList == null) {
	        // 세션이 존재하지 않을 경우, ArrayList를 생성하고 세션에 저장
	        contentidList = new ArrayList<String>();
	        session.setAttribute("contentidList", contentidList);
	    }
	    if(contentid != null) {
		    contentidList.add(contentid);
	    }
	%>
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
	<form action="magWriteForm.jsp" method="post">
        <input type="submit" value="매거진 작성" />
    </form>



</body>
</html>