<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
<style>
	table td {
		text-align: center;
		border: double;
	}
	
	.download {
		background-color: cornflowerblue;
		color: white;
	}
	
	#co_btn {
		background-color: cornflowerblue;
		color: white;
	}
	
	.rep {
		text-align: center;
	}
	#blog h1{
		
	}
	.entry-meta p{
		color : blue;
		font-weight: bold;
		
	}
	.entry-meta a{
		color : red;
	}
	
	.col-md-7 .widget .row *{
		text-align: left;
	}
	
	.col-md-7 .widget.categories {
		max-width: 100%;
		margin : auto;
	}
	.col-md-7 .widget.categories textarea{
		max-width: 100%;
		width:100%;
		margin : auto;
	}
	
	.col-md-5 h1 {
		color: black;
	}
</style>

	
  <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
  <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
  <script type="text/javascript">
	
		//홈페이지에 입력한 글들이 studyBoardWrite로
		$(document).ready(function(){
		map();
		var lat;
		var lng;
			$("#cancel").click(function(){
				location.href="./studyBoardCalendar.do"
			});
			
// 			$("input[type=submit]").click(function(){
			$("#write").click(function(){
				var f = new FormData($("#writeForm")[0]);
				
				$.ajax({
					url : "./studyBoardWrite.do",
					type : "post",
					data : f,
					contentType : false,
					processData : false,
					success : function(result) {
						console.log(lat, lng);
						if (result.code == 200) {
							alert(result.msg);
							location.href="studyBoardCalendar.do"
						} else {
							alert(result.msg);
						}
					}
					
				});
				return false;
				
			});
			
			
			//지도의 첫 번재 주소를 받아온다.
			$("input[name=searchBtn]").click(function() {
				var place = $("input[name=place]").val();
				$.ajax({
					url : "http://maps.googleapis.com/maps/api/geocode/json",
					type : "get",
					data : {"address" : place, "sensor" : "false"},
					success : function(result) {
						var html = "";
						html += "<select>";
						for(var i = 0; i < result.results.length; i++) {
							var address = result.results[i].formatted_address;
							var sLen = result.results[i].address_components.length - 1; 
							var zipcode = result.results[i].address_components[sLen].long_name;
							lat = result.results[i].geometry.location.lat;
							lng = result.results[i].geometry.location.lng;
							html += "<option zipcode=" + zipcode + " lat=" + lat + " lng=" + lng + ">";
							html += address + "</option>";
							$('#lat').val(lat);
							$('#lng').val(lng);
						}
						html += "</select>";
						html += "<input type='button' onclick='fnApply()' id='second' name='second' value='선택' />";
						$("#display").html(html);
						console.log(address, zipcode, lat, lng);
					}
				});
			});
		});
		
		
		//두번째 지도의 확인 작업이 끝나게 되며는 그 것을 지도롤 출력한다.
	      function map() {
    	  $("body").on("click","#second",function() {
    	var t = $("input[name=lat]").val();
		var g = $("input[name=lng]").val();
		var tit = $("input[name=place]").val();
		var tent = $("input[name=content]").val();
        var mapLocation = new google.maps.LatLng(t, g); // 지도에서 가운데로 위치할 위도와 경도
        var markLocation = new google.maps.LatLng(t, g); // 마커가 위치할 위도와 경도
         console.log(t,g);
        var mapOptions = {
          center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
          zoom: 18, // 지도 zoom단계
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map-canvas"), // id: map-canvas, body에 있는 div태그의 id와 같아야 함
            mapOptions);
         
        var size_x = 60; // 마커로 사용할 이미지의 가로 크기
        var size_y = 60; // 마커로 사용할 이미지의 세로 크기
         
        // 마커로 사용할 이미지 주소
        var image = new google.maps.MarkerImage( 'http://www.larva.re.kr/home/img/boximage3.png',
                            new google.maps.Size(size_x, size_y),
                            '',
                            '',
                            new google.maps.Size(size_x, size_y));
         
        var marker;
        marker = new google.maps.Marker({
               position: markLocation, // 마커가 위치할 위도와 경도(변수)
               map: map,
               icon: image, // 마커로 사용할 이미지(변수)
//             info: '말풍선 안에 들어갈 내용',
               title: '(tit)' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
        });
         
//         var content = (tent); // 말풍선 안에 들어갈 내용
         
//         // 마커를 클릭했을 때의 이벤트. 말풍선 뿅~
//         var infowindow = new google.maps.InfoWindow({ content: content});
 
//         google.maps.event.addListener(marker, "click", function() {
//             infowindow.open(map,marker);
//         });
         
 
    	  });
      }
      google.maps.event.addDomListener(window, 'load', map);
		
		//두번재 지도의 결과값을 받아온다.
		function fnApply() {
			var address = $("option:selected").text();
			var zipcode = $("option:selected").attr("zipcode");
			var lat = $("option:selected").attr("lat");
			var lng = $("option:selected").attr("lng");
			
			$("input[name=address]").val(address);
			$("input[name=zipcode]").val(zipcode);
			$("input[name=lat]").val(lat);
			$("input[name=lng]").val(lng);
			console.log(address, zipcode, lat, lng);
		}
	
		
		
	</script>

</head>
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
	<section id="blog" class="container text-center">
		<div class="blog">
			<div class="row">
				<div class="col-md-5">
			        <h1>Write Study Board</h1>
		        	<form id="writeForm" enctype="multipart/form-data">
	        		<div class="login-width-large">
		        		<input type="text" name="subject" placeholder="Topic of Meeting"/><br><br>        	
		        		<input type="text" name="member" placeholder="Number of Member"/><br><br>        	
		        		<input type="date" name="date" placeholder="Meeting Date"/><br><br>        	
		        		<input type="time" name="time" placeholder="Meeting Time"/><br><br>
		        		<textarea name="content" rows="10" cols="50" placeholder="Write the Detail"></textarea><br><br>
		        		<input type="text" name="place" id="place" placeholder="Location"/>
		        		<input type="button" value="Search" name="searchBtn"/><br><br>
		        		<div id="display"></div>
		        		<input type="hidden" name="lat"  id="lat"/><br />
			            <input type="hidden" name="lng"  id="lng"/><br />
<!-- 		        		<div id="map-canvas" style="width: 100%; height: 400px"></div> -->
						       		      	
	<!-- 	        		<textarea name="content" rows="17" cols="50" placeholder="글을 입력해주세요"></textarea><br> -->
						<input type="file" name="attachFile" id="attachFile" value="Select File"  multiple><br>
	        			<input type="hidden" name="pageNum" value="1">
	        		</div>
			        	<a class="btn btn-primary" href="#" id ="write" style="width:100%;">Submit</a>
		        	</form>
						        <input type="hidden" name="address" /><br />
					            <input type="hidden" name="zipcode" /><br />
				</div><!-- col-md-5 -->
				<aside class="col-md-7">
					<div class="widget categories">
						<h2></h2>
						<div class="row">
							<div class="col-sm-12">
								<div id="map-canvas" style="width: 100%; height: 400px"></div>
							</div>
						</div>
					</div>
				</aside><!-- col-md-7 -->
			</div>
		</div>
    </section>
<!--  	검색결과 -->
<!-- 	<br /> -->
<!-- 	<div id="display"> -->
<!-- 	</div> -->
		
<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>