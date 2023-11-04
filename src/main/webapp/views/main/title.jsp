<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="/wherego/image/wherego1.jpg" class="d-block w-100" height="300px;">
	      <!-- 텍스트 추가 -->
	      <div class="text-overlay">
	        <div class="text-center">
	          <h1><a href="/wherego/views/main/main.jsp" class="title">어디 Go</a></h1>
	        </div>
	      </div>
	    </div>
	    <div class="carousel-item">
	      <img src="/wherego/image/wherego2.jpg" class="d-block w-100" height="300px;">
	      <!-- 텍스트 추가 -->
	      <div class="text-overlay">
	        <div class="text-center">
	          <h1><a href="/wherego/views/main/main.jsp" class="title">어디 Go</a></h1>
	        </div>
	      </div>
	    </div>
	    <div class="carousel-item">
	      <img src="/wherego/image/wherego3.jpg" class="d-block w-100" height="300px;">
	      <!-- 텍스트 추가 -->
	      <div class="text-overlay">
	        <div class="text-center">
	          <h1><a href="/wherego/views/main/main.jsp" class="title">어디 Go</a></h1>
	        </div>
	      </div>
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>
</body>
<style>
@font-face {
    font-family: 'Giants-Inline';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-1@1.1/Giants-Inline.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
	}
.title {
    font-family: 'Giants-Inline', sans-serif;
    text-decoration: none;
    color:white;
}
 .image-text {
    position: relative;
  }

  .image-text::before {
    content: "";
    background: url('/wherego/image/wherego1.jpg') no-repeat center center fixed;
    background-size: cover;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
  }

  .text-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    background: rgba(0, 0, 0, 0.5); /* 텍스트 위에 배경을 추가하려면 필요한 스타일입니다. */
  }

  .text-center h1 {
    color: white;
  }
</style>
</html>