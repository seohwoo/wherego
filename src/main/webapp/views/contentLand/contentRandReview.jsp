<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String contentid = request.getParameter("contentid");
	String areaCode = request.getParameter("areaCode");
	String sigunguCode = request.getParameter("sigunguCode");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	LandDAO landO = LandDAO.getInstance();
	ArrayList<HashMap<String,String>> reviewList = new ArrayList<HashMap<String,String>>();
	reviewList = landO.selectReviewInfo(contentid);
	HashMap<String, String> reviewInfo = new HashMap<String,String>();
%>

 <hr>
	<h2 align="center">리뷰</h2>
	<%	
	if(reviewList.isEmpty()){%>
	<div class="text-center">
		<h4>등록된 리뷰가 없습니다.</h4>
	</div>
	<%}
	else{
		for(int i = 0; i < reviewList.size(); i++){
			
			
		reviewInfo = reviewList.get(i);
		int reviewNumCount = 0;
		reviewNumCount = landO.getReviewUpCount(Integer.parseInt(reviewInfo.get("reviewnum")));
		String nic = landO.getReviewNic(reviewInfo.get("id"));
		String grade = landO.getReviewGrade(reviewInfo.get("id"));
		String gradeName = landO.getReviewGradeName(grade);
		%>
		<div class="d-grid gap-2 col-6 mx-auto">
			<div class="card border-light mb-3" style="position: relative;">
			<!-- id -->
			<h5>닉네임 : <%=nic%> <br />등급 : <%=gradeName %></h5>
			 <div class="rating">
			        <% int rating = Integer.parseInt(reviewInfo.get("stars"));
			        for (int s = 1; s <= 5; s++) {
			               if (s <= rating) { %>
			                   <span class="star">&#9733;</span> <!-- 채워진 별 -->
			               <% } else if (s - 0.5 <= rating) { %>
			                   <span class="half-star">&#9733;</span> <!-- 반쪽 채워진 별 -->
			               <% } else { %>
			                   <span class="star">&#9734;</span> <!-- 빈 별 -->
			               <% }
			           }
			        %>
			    </div>
			    
			 <!-- 작성날짜 -->
		    <p style="position: absolute; top: 0; right: 0;"><%=reviewInfo.get("reg_date")%></p>
			<%String imgName = "NoImage";
			for (int x = 1 ; x <= 5 ; x++){
				String imgSrc = reviewInfo.get("img"+x);
			if(imgSrc != null && !imgSrc.equals(imgName))  {%>
				<img src="/wherego/image/<%=imgSrc%>">
			<%}
			}%>
				<div class="card-body">
					<!-- 내용 -->
					<h5><%=reviewInfo.get("review")%></h5>
					<form method="post" action = "contentRandReviewUpPro.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&contentid=<%=contentid%>&pageNum=<%=pageNum%>&reviewnum=<%=reviewInfo.get("reviewnum")%>">
						<button class="likeButton" id="likeButton" >👍</button> (<%=reviewNumCount %>)
						<input type = "hidden" value ="<%=reviewInfo.get("reviewnum")%>"/>
					</form>
				</div>
			</div>
		</div>
	<%}
	}
	%>
	<br /><br />
</body>
<style>
    .star {
        color:  #FFA500; 
        font-size: 30px; 
    }
    .half-star {
        color: #FFA500; 
        font-size: 30px; 
    }
    .likeButton {
        background: transparent;
        border: 1px solid transparent;
        border-radius: 20px;
        cursor: pointer;
        font-size: 20px;
    }

    .likeButton:hover {
        border: 3px solid #FFA500;
    }
  hr {
  margin: 12px 0;
  border: 0;
  text-align: center;
  
  &:before {
    content: "\2022 \2022 \2022";
    font-size: 50px;
    color: #4F8BCA;
  }
}

</style>

</html>