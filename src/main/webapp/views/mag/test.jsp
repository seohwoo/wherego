<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/views/main/nav.jsp" />	

			<form action="/wherego/views/search/adminResult.jsp" method="post">
				<div class="input-group mb-3">
						<select class="btn btn-outline-secondary dropdown-toggle" name="searchType">
							<option value="land">명소</option>
							<option value="loc">지역</option>
						</select>
					<input name="searchValue" type="text" class="form-control" placeholder="여행지를 검색해보세요">
					<div class="col-auto">
						<button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
					</div>
				</div>
			</form>




</body>
</html>