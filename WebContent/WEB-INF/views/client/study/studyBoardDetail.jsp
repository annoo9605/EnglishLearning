<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="../apart_head.jsp" %>
	<%@ include file="../apart_body_footer_script.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세보기</title>

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
	
</style>

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		initialize();
		download();
		goList();
		deleteArticle();
		addComment();
		getComment();
	});
	
	   function initialize() {
		      var mapLocation = new google.maps.LatLng('${detail[0].STUDY_LAT}', '${detail[0].STUDY_LNG}'); // 지도에서 가운데로 위치할 위도와 경도
		      var markLocation = new google.maps.LatLng('${detail[0].STUDY_LAT}', '${detail[0].STUDY_LNG}'); // 마커가 위치할 위도와 경도
		       
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
//		           info: '말풍선 안에 들어갈 내용',
		             title: '${detail[0].STUDY_PLACE}' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
		      });
		       

		    }
		    google.maps.event.addDomListener(window, 'load', initialize);
			
			
//	 		// delete
			
			$(".delete_addBtn").click(function() {
// 				alert("삭제 하시겠습니까?");
				var alarm = confirm("삭제 하시겠습니까?");
					
				if(alarm) {
					var siSeqNo = $(this).attr("siSeqNo");
					var stadiumName = $("input[name=stadiumName]").val();
					alert(siSeqNo);
					alert(stadiumName);
					$.ajax({
						url : "./deleteAdd.do",
						type : "post",
						data : {"siSeqNo" : siSeqNo, "stadiumName" : stadiumName },
						success : function(result){
							if(result.code == 200) {
								alert(result.msg);
								location.assign("./allStadiumList.do");
							}
						}
					});
					return false;
				}
			});	
			
		
	
	
	//다운로드 창입니다.
	function download() {
		$(".download").click(function(){
			var seqNo = ${param.seqNo};
			var atchSeqNo = $(this).parent().attr("atch_seq_no");
			alert(atchSeqNo);
			
			
			location.href="./download.do?seqNo="+seqNo+"&atch_seq_no="+atchSeqNo;
		});
	}
	
	
	function goList() {
		$("#list").click(function(){//목록보기 버튼을 눌르면 실행된다
			location.href="./studyBoardCalendar.do";
		});
		
	}
	
	//글삭제할때
	function deleteArticle() {
		$("#delete").click(function(){

			$.ajax({
				url : "./studyDelete.do", 
				type : "post",
				data : $("form").serialize(),
				success : function(result) {
// 						console.log(result.hashMap.msg);
					if(result.hashMap.code == 200) {
						alert(result.hashMap.msg);
						location.href="./studyBoardList.do?pageNum=1";
					} 
				}
			});
			return false;			
		});
	}
	
	//신청하기 추가합니다.
	function addComment() {
		$("#co_btn").click(function(){
			var commentContent = $('#co_content').val();
			
			console.log(commentContent);
			
			$.ajax({
				
				url 	: "./comment.do",
				type 	: "post",
				data 	: {"seqNo" : "${param.seqNo}", "co_content" : commentContent},
		
				success : function(result) {
					alert(result.msg);
// 					location.reload();
					getComment();
				}
				
			});
			return false;
		});
	}

	
	//댓글 달기
	function getComment() {
			var seqNo = "${param.seqNo}";
		
			$.ajax({
			
			
			url 	: "./getComment.do?seqNo=" + seqNo,
			type 	: "post",
			data 	: {},
			success : function(result) {
				var html = "";
				html += "<ul>";
				for(var i = 0; i < result.comment.length; i++) {
					html += "<li>ID: " + result.comment[i].ID + " [RE]: " + result.comment[i].COMMENT_CONTENT + "</li>";
				}
				html += "</ul>";
				$("#reply div").html(html);
			}
			
		});
	}
	
</script>
</head>
<body>

	<%@ include file="../apart_body_header.jsp" %>

	<h1>글 상세보기</h1>
	<form action="studyBoardDetail.do">
	<input type="hidden" name="seqNo" value="${param.seqNo}"><br><br>
	<table border="2" width="700" cellspacing="2" cellpadding="2">
	<c:forEach var="detail" items="${detail}">
		<tr>
			<td class="left">주최자</td> <td>${detail.ID }</td>
		</tr>
		<tr>
			<td>모임주제</td> <td>${detail.STUDY_SUBJECT }</td>
		</tr>
		<tr>
			<td>모임일시</td> <td>${detail.STUDY_DATE }</td>
		</tr>
		<tr>
			<td>모임시간</td> <td>${detail.STUDY_TIME }</td>
		</tr>
		<tr>
			<td>모임내용</td> <td>${detail.STUDY_CONTENT }</td>
		</tr>
		<tr>
			<td>모임장소</td> <td>${detail.STUDY_PLACE }</td>
		</tr>
		<tr>
			<td>최대인원</td> <td>${detail.MAX_MEMBER }</td>
		</tr>
		<tr>
			<th>찾아오는 길</th> <td><div id="map-canvas" style="width: 100%; height: 400px"></div></td>
		</tr>
			<input type="hidden" name="lat" id="lat" /> 
		<tr>
			<td colspan="4">첨부파일
				<c:forEach var="file" items="${atchFile }">
					<li seqNo="${file.SEQ_NO }" atch_seq_no="${file.FILE_SEQ_NO }">
						<a href="./download.do?seqNo=${file.SEQ_NO }&atch_seq_no=${file.FILE_SEQ_NO}" style="color: #C52D2F;">${file.DSP_FILE_NAME }</a>
						&nbsp;&nbsp;<input type="button" class="download" value="다운로드" ><br>
						
				</c:forEach>
			</td>
			
		</tr>
<!-- 	<div class="btn"> -->
<%-- 		<input type="button" id="update" value="수정하기" class="btn btn-primary" OnClick="location.href='./studyBoardUpdate.do?seqNo=${detail.SEQ_NO}'"> --%>
<!-- 		<input type="button" id="delete" value="삭제하기" class="btn btn-primary"> -->
<!-- 		<input type="button" id="list" value="목록보기" class="btn btn-primary"> -->
<!-- 	</div> -->
	</c:forEach>
	</table><br><br>
	</form>
		<div class="btn">
		<input type="button" id="update" value="수정하기" class="btn btn-primary" >
		<input type="button" id="delete" value="삭제하기" class="btn btn-primary">
		<input type="button" id="list" value="목록보기" class="btn btn-primary">
	</div>
	
	
	
	<div>
		<fieldset id="reply" class="rep">
			<legend>신청하기</legend>
			<div>
			</div>
<!-- 			<ul> -->
<%-- 			<c:forEach var="list" items="${comment }"> --%>
<!-- 				<li> -->
<%-- 					ID: ${list.ID } [RE]: ${list.COMMENT_CONTENT} --%>
<!-- 				</li> -->
<%-- 			</c:forEach> --%>
<!-- 			</ul> -->
			<textarea id="co_content" name="co_content" rows="3" cols="40" placeholder="만나는 시간">
			
			</textarea>
			
			<input type="button" id="co_btn" value="신청하기등록" >
		</fieldset>
	</div>
	<br><br>
	
	<a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a>
	
	<%@ include file="../apart_body_bottom.jsp" %>
	
	<%@ include file="../apart_body_footer.jsp" %>
</body>
</html>