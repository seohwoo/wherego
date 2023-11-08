<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b2ea861437e36479577f200cdf49db21"></script>
</head>
<body>
    <div id="map" style="width: 100%; height: 400px;"></div>
    <script>
        var mapContainer = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.5665, 126.9780), // 초기 지도 중심 위치
            level: 5 // 초기 지도 확대 레벨
        };

        var map = new kakao.maps.Map(mapContainer, options);

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var latitude = position.coords.latitude;
                var longitude = position.coords.longitude;

                var currentPosition = new kakao.maps.LatLng(latitude, longitude);
                map.setCenter(currentPosition); // 현재 위치로 지도 중심 설정
            });
        }
    </script>
</body>
</html>
