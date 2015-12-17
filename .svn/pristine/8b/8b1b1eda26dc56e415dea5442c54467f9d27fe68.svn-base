<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
<script>
	$(document).ready(function(){
		loginCheck();
		login();
	});
	
	function loginCheck(){
		$.ajax({
			url			: "loginCheck.do",
			type		: "get",
			success		: function(result){
				if(result.status == 200){
					alert("로그인 상태입니다.");
					history.back();
				}
			}
		});
		return false;
	}
	
	function login(){
		$("input[type=submit]").click(function(){
//			ajax를 쓰면 새로고침 했을때
// 			다시 실행되는 것을 막아준다.

// 			글쓰기를 예로들면
// 			글쓰기 폼페이지로 이동해서 
// 			글쓰기 기능을 시행하는데
// 			이때 포워드를 사용하느냐 리다이렉트를 사용하느냐 따라
// 			포워드 사용하면 주소 그대로
// 			포워드 사용하면 새로고침 했을때 기능을 그대로 유지
// 			리다이렉트 사용하면 주소 달라진다.
// 			리다이렉트 사용하면 기능또한 싹 사라진다.
			
			$.ajax({
				url			: "./login.do",
				type		: "post",
				data		: $("form").serialize(),
				success		: function(result) {
					if(result.code==200){
						alert(result.msg);
						location.href = "./index.do";
					} else if(result.code==300){
						alert(result.msg);
					} else if(result.code==300){
						alert(result.msg);
					}
				}
			});
			return false;			
		});
	}
</script>


</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
 
    <section id="loginForm" class="container text-center">
        <h1>LOGIN</h1>
        	<form method="post">
        		<div class="login-width-large">
	        		<label >I      D  :</label><input type="text" name="id" placeholder="USERID"/><br>        	
	        		<label >PASSWORD  :</label><input type="password" name="pw" placeholder="USERPASSWORD"/><br>        	
        		</div>
					<input type="submit" value="LOGIN"/>
        	</form>
   
        <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a>
    </section><!--/#error-->
 

<!-- 	bottom menu INCLUDE	 -->
	<%@ include file="apart_body_bottom.jsp" %>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>