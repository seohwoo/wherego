<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "team02.main.use.SearchDAO"%> 
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<%
	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");

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
		Date reg_dateD = inputFormat.parse(reviewInfo.get("reg_date"));
		String reg_date = outputFormat.format(reg_dateD);
		int reviewNumCount = 0;
		reviewNumCount = landO.getReviewUpCount(Integer.parseInt(reviewInfo.get("reviewnum")));
		String nic = landO.getReviewNic(reviewInfo.get("id"));
		String grade = landO.getReviewGrade(reviewInfo.get("id"));
		String gradeName = landO.getReviewGradeName(grade);
		%>
		<div class="d-grid gap-2 col-6 mx-auto">
			<div class="card border-light mb-3" style="position: relative;">
			<!-- id -->
			<h5><a href="/wherego/views/mypage/myPage.jsp?id=<%=reviewInfo.get("id")%>" style="color: black;"><%=nic%></a> «<small><%=gradeName %></small>»</h5>
			 <div class="rating">
			        <% int rating = Integer.parseInt(reviewInfo.get("stars"));
			        for (int s = 1; s <= 5; s++) {
			               if (s <= rating) { %>
			                    <i class="fas fa-star" style="color: #ffc83d;"></i> <!-- 채워진 별 -->
			               <% } else { %>
			                    <i class="far fa-star" style="color: #ffc83d;"></i>
			               <% }
			           }
			        %>
			</div>
			    
			 <!-- 작성날짜 -->
		    <p style="position: absolute; top: 10; right: 0;"><%=reg_date%></p>
			 <%
					String id = "";
					if(session.getAttribute("memId") != null) {
						id = (String) session.getAttribute("memId");
					}
					SearchDAO sdao = SearchDAO.getInstance();
					int gradeInt = sdao.isAdmin(id);
					if(id.equals(reviewInfo.get("id")) || gradeInt == 99){
				%>
					<button type="button" value="삭제하기" onclick="openDeletereviewWindow('<%= reviewInfo.get("reviewnum")%>')" 
                       			style="border: none; background-color: white;  position: absolute; top: 0; right: 0; margin-top: 30px;">❌</button>
			<%} %>
			<br />
			<div style="display: flex; align-items: center;">
				<%String imgName = "NoImage";
				for (int x = 1 ; x <= 5 ; x++){
					String imgSrc = reviewInfo.get("img"+x);
				if(imgSrc != null && !imgSrc.equals(imgName))  {%>
				<a href = "/wherego/image/<%=imgSrc%>" onclick="window.open('/wherego/image/<%=imgSrc%>', '_blank', 'width=500,height=500'); return false;">	<img src="/wherego/image/<%=imgSrc%>" style="width:190px; height: 190px;"></a>
				<%}
				}%>
			</div>
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
<script type="text/javascript">
function openDeletereviewWindow(num) {
    var profileWindow = window.open("/wherego/views/mypage/reviewdelete.jsp?num=" + num, "리뷰삭제", "width=400,height=300");
}
</script>

<style>
    .star {
        color:  #FFA500; 
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
small{
	font-family: Pretendard-Regular', sans-serif;
}

</style>

</html>