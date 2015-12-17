<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="../apart_head.jsp" %>
	<%@ include file="../apart_body_footer_script.jsp" %>
  
	<script>
	
		$(document).ready(function(){
			console.log('${param}');
			init();
			search();
		});
		
		function init() {
			console.log('${param.pageNum}');
			console.log($("input[name=pageNum]").val);
		}
		
		function search() {
			$("#src_btn").click(function(){
				
				var search = $("#search").val();
				var pageNum = $("#pageNum").val();
				
				$.ajax({
					
					url 	: "./search.do",
					type 	: "post",
					data	: {"search" : search},
					success : function(result) {
						location.href="./searchList.do?search=" + search+ "&pageNum="+ pageNum;
					}
					
				});
			});
			
		}
		
	</script>

	<style>
		#theader {
		    background-color: #0087df;
   			color: white;
		}
	
	
	</style>
</head>
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="../apart_body_header.jsp" %>
	
		<section id="loginForm" class="container text-center">
        <h1>스터디게시판</h1>
       	
        		
        		<div class="search" style="text-align: -webkit-right;">
        			<input type="text" id="search" name="search">
        			<input type="button" id="src_btn" class="btn btn-primary" value="검색">
        		</div>
       	</section>
        		
	        	<form action="studyBoardList.do">
						<input type="hidden" name="atchFileNo" value="${atchFile }">
<!--         			<div class="boardList"> -->
					
					<label><a href="studyBoardWrite.do" style="color: #C52D2F">글쓰기</a></label>
					
					<table border="2" width="700" cellpadding="2" cellspacing="2" > 
						<tr id="theader">
							<th align="center">글번호</th>
							<th align="center">모임주제</th>
							<th align="center">작성자</th>
							<th align="center">모임일자</th>
							<th align="center">장소</th>
						</tr>
						<c:forEach var="article" items="${list }">
						<tr>
							<td>${article.SEQ_NO }</td>
							<td><a href="/studyBoardDetail.do?seqNo=${article.SEQ_NO }" style="color: #C52D2F;
							">${article.STUDY_SUBJECT }</a></td>
							<td>${article.ID }</td>
							<td>${article.STUDY_DATE }</td>
							<td>${article.STUDY_PLACE }</td>
						</tr>
						</c:forEach>
					</table>
					<br><br>
					<input type="hidden" name="pageNum" id="pageNum" value="${param.pageNum }">
						${pagingCode }
<!-- 					</div>					 -->
        	</form>
   

        <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a>
   
 
		
<!-- 	bottom menu INCLUDE	 -->
	<%@ include file="../apart_body_bottom.jsp" %>

<!--  	footer INCLUDE -->
	<%@ include file="../apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>