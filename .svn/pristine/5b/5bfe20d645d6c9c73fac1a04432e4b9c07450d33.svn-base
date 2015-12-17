<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
  
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
		    background-color: #0971B2;
   			color: white;
		}
	
	    tr:nth-child(odd){
	    	background-color: rgba(20, 133, 204, 0.19);
	    }
	    
	    table {
	    	border : none;
	    	max-width: 100%;
		    background-color: transparent;
		    width: 700px;
		    height: 300px;
		    text-align: center;
	    }
	    
	</style>
</head>
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
		<section id="loginForm" class="container text-center">
        <h1>Free Board</h1>
       	</section>
        		
        	<form action="freeBoardList.do" style="margin-top:-50px;">
					<input type="hidden" name="atchFileNo" value="${atchFile }">
<!--       			<div class="boardList"> -->
				
				<label><a href="freeBoardWrite.do" style="color: #C52D2F">Write</a></label>
				
				<div style="width:700px">
					<div class="search" style="text-align: -webkit-right;">
	        			<input type="text" id="search" name="search">
	        			<input type="button" id="src_btn" class="btn btn-primary" value="Search" style="margin-bottom:11px;">
      					</div>
				</div>
				<table  width="700" cellpadding="0" cellspacing="0" style="margin-top:-5px;"> 
					<tbody>
					<tr id="theader">
						<th align="center">No</th>
						<th align="center">Title</th>
						<th align="center">Writer</th>
						<th align="center">Date</th>
						<th align="center">Hit</th>
					</tr>
					<c:forEach var="article" items="${list }">
					<tr>
						<td>${article.SEQ_NO }</td>
						<td><a href="/freeBoardDetail.do?seqNo=${article.SEQ_NO }" style="color: #C52D2F;
						">${article.BOARD_TITLE }</a></td>
						<td>${article.ID }</td>
						<td>${article.BOARD_CRE_DATE }</td>
						<td>${article.BOARD_HIT }</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
				<input type="hidden" name="pageNum" id="pageNum" value="${param.pageNum }">${pagingCode }
<!-- 				</div>					 -->
       	</form>
   

<!--         <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a> -->
   
 
		
<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>