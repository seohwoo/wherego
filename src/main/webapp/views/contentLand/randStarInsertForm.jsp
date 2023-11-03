<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>평점 주기</title>
</head>
<body>
<%
    String contentid = request.getParameter("contentid");
    String id = (String)session.getAttribute("memId");
    if(id == null){
        %>
        <script>
        alert("로그인후 사용가능합니다.");
        window.close();
        </script>
    <%
    } else {
%>
<form method="post" action="randStarInsertPro.jsp?contentid=<%=contentid%>" enctype="multipart/form-data" OnSubmit="return validateAndSubmit()">
    <div class="stars1">
        <label for="star1" class="star" data-rating="1"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star2" class="star" data-rating="2"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star3" class="star" data-rating="3"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star4" class="star" data-rating="4"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star5" class="star" data-rating="5"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
    </div>

    <div>
        <input type="radio" name="stars" value="1" id="star1" style="display: none;">
        <input type="radio" name="stars" value="2" id="star2" style="display: none;">
        <input type="radio" name="stars" value="3" id="star3" style="display: none;">
        <input type="radio" name="stars" value="4" id="star4" style="display: none;">
        <input type="radio" name="stars" value="5" id="star5" style="display: none;">
    </div>
		
    <br />
    <p style="font-family: 'Pretendard-Regular'">사진을 올려주세요 <small> (선택)</small></p>
    <div style="width:500px;">
        <input type="file" class="form-control" name="img1" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img2" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img3" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img4" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img5" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
    </div>
    <br />
    <p style="font-family: 'Pretendard-Regular'">상세한 후기를 써주세요 </p>
    <textarea name="review" class="form-control" rows="3" cols="50" placeholder="다녀오신 후기를 작성해주시면 방문예정자들에게도 도움이 됩니다."></textarea><br/>
    <input type="submit" class="btn btn-warning" name="confirm" value="등록">
    <input type="button" class="btn btn-light" value="닫기" OnClick="window.close();">
</form>
<%
} %>  
</body>
<script>
const stars = document.querySelectorAll('.stars1 .star');

stars.forEach((star) => {
    star.addEventListener('mouseover', () => {
        // 마우스를 올린 별 아이콘의 data-rating 값을 가져옵니다.
        const rating = star.getAttribute('data-rating');
        
        // 모든 별 아이콘에 대해 반복하며 사용자의 마우스 위치에 따라 색상을 변경합니다.
        stars.forEach((s) => {
            const sRating = s.getAttribute('data-rating');
            if (sRating <= rating) {
                s.innerHTML = '<i class="fas fa-star" style="color: #ffc83d;"></i>';
            } else {
                s.innerHTML = ' <i class="far fa-star" style="color: #ffc83d;"></i>';
            }
        });
    });
    
    star.addEventListener('mouseout', () => {
        // 마우스를 별 아이콘에서 뗀 경우, 별 아이콘을 초기 상태로 되돌립니다.
        stars.forEach((s) => {
            s.innerHTML = ' <i class="far fa-star" style="color: #ffc83d;"></i>';
        });
    });
});
</script>
<style>
.stars1 {
    padding-left: 70px;
    font-size: 30px;
    cursor: pointer;
}
.stars1 .star {
	color: #FFA500;
    transition: color 0.3s;
}
@import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);
       .rate { display: inline-block;border: 0;margin-right: 15px;}
.rate > input {display: none;}
.rate > label {float: right;color: #ddd}
.rate > label:before {display: inline-block;font-size: 1rem;padding: .3rem .2rem;margin: 0;cursor: pointer;font-family: FontAwesome;content: "\f005 ";}
.rate .half:before {content: "\f089 "; position: absolute;padding-right: 0;}
.rate input:checked ~ label, 
.rate label:hover,.rate label:hover ~ label { color: #f73c32 !important;  } 
.rate input:checked + .rate label:hover,
.rate input input:checked ~ label:hover,
.rate input:checked ~ .rate label:hover ~ label,  
.rate label:hover ~ input:checked ~ label { color: #f73c32 !important;  } 
textarea {
    font-family: Pretendard-Regular;
}
</style>
</html>
