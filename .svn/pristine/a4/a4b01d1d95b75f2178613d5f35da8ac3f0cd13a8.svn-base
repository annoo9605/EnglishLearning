<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
  
	<script>
	
		$(document).ready(function(){
			
			$("#cancel").click(function(){
				location.href="./freeBoardList.do?pageNum=1"
			});
			
			$("input[type=submit]").click(function(){
				var f = new FormData($("#writeForm")[0]);
				
				$.ajax({
					url : "./freeBoardWrite.do",
					type : "post",
					data : f,
					contentType : false,
					processData : false,
					success : function(result) {
						if (result.code == 200) {
							alert(result.msg);
							location.href="freeBoardList.do?pageNum=1"
						} else {
							alert(result.msg);
						}
					}
					
				});
				return false;
				
			});
		});
		
	</script>

</head>
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
		<section id="loginForm" class="container text-center">
        <h1>Write Free Board</h1>
        
        	<form id="writeForm" enctype="multipart/form-data">
        		
        			
        		<div class="login-width-large">
	        		<input type="text" name="title" placeholder="Title"/><br><br>        	
	        		<textarea name="content" rows="17" cols="50" placeholder="Type Here"></textarea><br>
					<input type="file" name="attachFile" id="attachFile" value="파일첨부"  multiple><br>
        			<input type="hidden" name="pageNum" value="1">
        			<input type="hidden" name="codeNo" value="104">
        		</div>
					<input type="button" value="Preview" id ="preview"/>
					<input type="submit" value="Submit" id ="write"/>
					<input type="button" value="Cancel" id ="cancel" style="text-align:right"/><br><br>
        	</form>
   
   

<!--         <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a> -->
    </section>
 
		
<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>