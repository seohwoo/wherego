<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디Go Intro</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />	
	<jsp:include page="/views/main/title.jsp" /><br />
	<!-- 사이트 소개 -->
	<h3  style = "text-align: center;">국내 여행지에 대해 알아보세요!</h3> <br />
	

	<br />
	<div class="d-grid gap-2 col-6 mx-auto">
		<div  class="accordion accordion-flush" id="accordionFlushExample">
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
		       # 지역별 여행지 보기
		      </button>
		    </h2>
		    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>시•군•구</strong> 를 선택하여 여행지역을 알아보세요!
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		        # TOP 8 여행지 보기
		      </button>
		    </h2>
		    <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>조회수 TOP!</strong> 여행지를 보고, 내가 가고싶은 여행지를 찾아보아요.
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		        # 다른 사용자의 리뷰를 보고, 내 리스트에 담기
		      </button>
		    </h2>
		    <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>실제 여행객의 리뷰를 참고</strong>하여 <strong>추후 내가 가고싶은 곳</strong>을 결정해보세요!
		      </div>
		    </div>
		  </div>
		</div>
	</div>
	
	<br />
	<div class="text-center">
	  <img  src="/wherego/image/wheregoMap.jpg" class="rounded" width="500" height="600">
	</div>
	<div>
	<br /><hr /><br />
		<jsp:include page="/views/main/footer.jsp" />		
	</div>
</body>
</html>