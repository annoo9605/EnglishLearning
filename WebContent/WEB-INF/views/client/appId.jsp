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
	});
	
	
	
</script>


</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
 
    <section id="loginForm" class="container text-center">
        <h1>님의 아이디는 ${sessionScope.findId} 입니다</h1><br><br>
        	<a href="loginForm.do" style="color: #C52D2F;">로그인 하기</a>&nbsp;&nbsp;&nbsp;
        	<a href="findPw.do" style="color: #C52D2F;">비밀번호 찾기</a><br><br>
        	
        	
        	
        <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a>
    </section><!--/#error-->
 

<!-- 	bottom menu INCLUDE	 -->
	<%@ include file="apart_body_bottom.jsp" %>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>