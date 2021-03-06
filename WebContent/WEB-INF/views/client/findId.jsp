<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="views/client/apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
<script>
	$(document).ready(function(){
		
		findIdCode();
		findId();
		
	});
	
	
	
	function findIdCode() {
		
		$("input[type=submit]").click(function(){
			
			$.ajax({
				url : "./findCode.do",
				data : $("form").serialize(),
				type : "post",
				success : function(data) {
					alert("인증번호 발송했습니다" );
					
// 					if(data.code==200) {
// 						alert("id = : " + ${ID})
// 					} else {
// 						alert("실패");
// 					} //end if

				} // end success
				
			}); // end ajax
			
			return false;
		});		
	}
	
	function findId() {
		
		$("#approveBtn").click(function(){
			
			var code = $("#confirmCode").val();
			var surName = $("#surName").val();
			var givenName = $("#giveName").val();
			var email = $("#email").val();
			
// 			alert(code);
			
			
			$.ajax({
				
				url : "./approveId.do",
				type : "post",
				data : {"val_code" : code,
						"surName" : surName,
						"givenName" : givenName,
						"email" : email },
				success : function(result) {
					
					if(result.code == 200) {
						
						alert("인증번호가 일치하였습니다");
						location.href="./appId.do";
						
					} else {
						alert("인증번호가 일치하지 않습니다");
					}
// 					console.dir(result);
// 					console.log(result.code);
					
// 					alert("님의 아이디는"+result.info.ID+"입니다");
					
					
				}// end success
				
			});// end ajax
			
			return false;
			
		});
	}
	
</script>


</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
 
    <section id="loginForm" class="container text-center">
        <h1>아이디 찾기</h1><br><br>
        	<form>
        		<div class="login-width-large">
<!-- 	        		<label >I      D  :</label><input type="text" name="id" placeholder="아이디 입력"/><br>        	 -->
<!-- 	        		<label >PASSWORD  :</label><input type="password" name="pw" placeholder="패스워드 입력"/><br><br>        	 -->
	        		<input type="text" name="surName" id="surName" placeholder="가입회원 성 입력"/><br>        	
	        		<input type="text" name="givenName" id="givenName" placeholder="가입회원 이름 입력"/><br>        	
	        		<input type="text" name="email" id="email" placeholder="가입시 입력한 이메일 주소 입력"/>
        		</div>
        		<div>
					<input type="submit" value="인증번호 받기" id ="test"/><br><br>
				</div> 
        	</form>
			<input type="text" name="appCode" id="confirmCode" placeholder="인증번호 숫자입력" ><br><br>
   			<input type="button" id="approveBtn" name="approveBtn" value="다음 단계로" ><br><br>

        <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a>
    </section><!--/#error-->
 

<!-- 	bottom menu INCLUDE	 -->
	<%@ include file="apart_body_bottom.jsp" %>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>