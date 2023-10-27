<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDAO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.io.File" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="land" class="team02.content.land.LandDTO">
	<jsp:setProperty name="land" property="*"/>
	</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	try{
   String path = request.getRealPath("image");
   int max = 1024*1024*10;
   String enc = "UTF-8";
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
   MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
   Enumeration enu = mr.getFileNames();
   ArrayList<String> fileNames = new ArrayList<String>();
   for (int i = 1; i <= 5; i++) {
       String fieldName = "img" + i;
       File uploadedFile = mr.getFile(fieldName);
       if (uploadedFile != null) {
    	   String fileName = uploadedFile.getName();
           fileNames.add(fileName);
       }
       else{
    	   fileNames.add("NoImage");
       }
   }
   String[] fileNamesArray = fileNames.toArray(new String[0]);
   
   
%>
<%

	String review = mr.getParameter("review");
	String starsParam = mr.getParameter("stars");
	int stars = 0;
	if (starsParam != null) {
    	try {
     	   stars = Integer.parseInt(starsParam);
    	} catch (NumberFormatException e) {
    	}
	}
	String contentid = request.getParameter("contentid");
	String id = (String)session.getAttribute("memId");
	land.setImg1(fileNamesArray[0]);
	land.setImg2(fileNamesArray[1]);
	land.setImg3(fileNamesArray[2]);
	land.setImg4(fileNamesArray[3]);
	land.setImg5(fileNamesArray[4]);
	land.setReview(review);
	land.setStars(stars);
	land.setId(id);
	LandDAO landO = LandDAO.getInstance();
	landO.insertStar(land);
	landO.updateReviewCount(id);
	}
catch(Exception e){
	e.printStackTrace();
}

%>

   <script>
	function closeAndRefresh() {
    window.close(); // 현재 창을 닫음
    window.opener.location.reload(); // 원래 창을 새로고침
	}
	</script>

평점이 등록되었습니다.
<input type = "button" value = "닫기" OnClick = "closeAndRefresh();">

</body>
</html>