<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
	
	
	<script>
		var id = "";
		var pw = "";
		var confPw = "";
		var idReg1=/^[a-zA-Z]/; 
		var idReg2=/[^a-zA-Z0-9]/; 
		var pwReg1=/[A-Z]/;
		var pwReg2=/[a-z]/;
		var pwReg3=/[0-9]/;
		var pwReg4=/[!@#$%^&]/;
		
		$(document).ready(function(){
			idRedundancyCheck();
			pwCheck();
			confirmPw();
			join();
		});
		
		function idRedundancyCheck(){
			/**************************
			 아이디 체크 정규식
			 1. 영문자시작
			 2. 특수문자, 한글, 빈칸 제외한
			 3. 4~10자리 아이디
			***************************/
			 /***************
				var idReg1=/^[a-zA-Z]/; 		// 영문자로 시작
				var idReg2=/[^a-zA-Z0-9]/; 		// 특수문자, 한글, 빈칸이 들어오는가 본다. 
												// FALSE : 대소영문자, 숫자
												// -TRUE : 특수문자, 한글, 빈칸등등
												
												// if()에서 !idReg2.test(id)
												// TRUE  : 대소영문자, 숫자
												// -FALSE: 특수문자, 한글, 빈칸
												
												//!(idReg1.test(id)&&!idReg2.test(id))
												// FALSE : 대소영문자, 숫자
												// -TRUE : 특수문자, 한글, 빈칸
												
												// ==> alert()창 실행
				var idReg = /^[A-za-z]{5,19}/g; // 영문 대소문자로 시작, 5~19자리, 끝날때 제한 없음
			***************/
			
			$("input[name=id]").on("keyup", function(){
				id = $("input[name=id]").val();
//					if(!idReg1.test(id)||idReg2.test(id)){
				if(!idReg1.test(id)){
// 						alert("아이디는 영문자로 시작하는 4~10자 영문자 또는 숫자이어야 합니다.");
					$("#checkId").text("The first must be a letter").css("color", "orange");
				} else if(idReg2.test(id)) {
					$("#checkId").text("Letters such as !@#$.. are not allowed").css("color", "orange");
				} else if(id.length>10 | id.length<4){
//						alert("아이디는 영문자로 시작하는 4~10자 영문자 또는 숫자이어야 합니다.");
					$("#checkId").text("The id should be between 4 and 10 characters").css("color", "orange");
				} else {
					$("#checkId").text("Available ID").css("color", "yellow");
					
					$.ajax({
						url			: "./retrieveId.do",
						type		: "post",
						data		: {"id" : id},
						success		: function(result){
							if(result.code==200){
								$("#checkId").text(result.msg).css("color", "yellow");
							}else {
								$("#checkId").text(result.msg).css("color", "orange");
							}
						}
						
					});
// 					(function poll(){
// 						$.ajax({
// 							url			: "./retrieveId.do",
// 							type		: "post",
// 							data		: {"id" : id},
// 							success		: function(result){
// 								if(result.code==200){
// 									$("#checkId").text(result.msg).css("color", "yellow");
// 								}else {
// 									$("#checkId").text(result.msg).css("color", "orange");
// 								}
// 							},
// 							complete : poll,
// 							timeout: 10000
// 						});	// 아작스 끝
// 					})();	//	폴링 끝
					return false;
				}
			});
			
			
// 			$("input[name=id]").on("blur", function(){
// 				id = $("input[name=id]").val();
// 				if(id.length<4){
// //						alert("아이디는 영문자로 시작하는 4~10자 영문자 또는 숫자이어야 합니다.");
// 					$("input[name=id]").focus();
// 					return false;
// 				}
				
// 			});
			
			
		}	
			
		
		
		function pwCheck(){
			/***************
			 비밀번호 체크 정규식
			 1. 영대문자 반드시 포함
			 2. 영소문자 반드시 포함
			 3. 숫자 반드시 포함
			 4. 특수문자 포함
			 
			****************/
			

			$("input[name=pw]").on("blur", function(){
				pw = $("input[name=pw]").val();
				if(pw!=null && pw != ""){// 지웠다가 빈칸으로 벗어날때 문제 해결
					if(pw.length<6 || pw.length>13){
						$("#checkPw").text("Password should be between 7 and 12 characters").css("color", "orange");
// 						$("input[name=pw]").focus();	//사용자 편의성 위해 submit에서 처리
// 						alert("비밀번호는 6자리 이상 20자리 이하의 비밀번호를 입력해 주세요.")
					} else if(pwReg1.test(pw)&&pwReg2.test(pw)&&pwReg3.test(pw)&&pwReg4.test(pw)){
						$("#checkPw").text("Available Password").css("color", "yellow");
					} else {
						$("#checkPw").text("Not Available Password").css("color", "orange");
// 						$("input[name=pw]").focus();	//사용자 편의성 위해 submit에서 처리
// 						alert("비밀 번호는 영문 대소문자, 숫자, 특수문자를 반드시 포함해야 합니다.")
					} 
				} else {
					$("#checkPw").text("Please Type the Password").css("color", "orange");
// 					$("input[name=pw]").focus();		//사용자 편의성 위해 submit에서 처리
				}
			});

// 			var pwReg1=/[a-zA-Z]/;
// 			var pwReg2=/[0-9]/;
// 			var pwReg3=/[^a-zA-Z0-9]/;
			
// 			$("input[name=pw]").on("blur", function(){
// 				pw = $("input[name=pw]").val();
// 				if(pw.length<6 || pw.length>21){
// 					$("#checkPw").text("비밀번호는 6자리 이상 20자리 이하여야 합니다").css("color", "orange");
// 				} else {
// 					$("#checkPw").text("사용 가능한 비밀번호 입니다").css("color", "yellow");
// 				} 
// 			});
			
		}
		
		function confirmPw(){
			$("input[name=confirmPw]").on("keyup", function(){
				pw = $("input[name=pw]").val();// 밖에서 값 받아 오면 안되네...
				confPw = $("input[name=confirmPw]").val();
				if(pw==confPw){
					$("#confirmPw").text("Confirmed Password").css("color", "yellow");
				}else {
					$("#confirmPw").text("Not Identical Password").css("color", "orange");
				}
			});
		}
		
		
		
		function join(){
			
			$("input[type=submit]").click(function(){
	// 			------------ 패스워드 체크아이디 체크 ------------
				id = $("input[name=id]").val();
				pw = $("input[name=pw]").val();
				if(pw.length<6 || pw.length>13){
					$("#checkPw").text("Password should be between 7 and 12 characters").css("color", "orange");
						$("input[name=pw]").focus();
						return false;
				} else if(pwReg1.test(pw)&&pwReg2.test(pw)&&pwReg3.test(pw)&&pwReg4.test(pw)){
					$("#checkPw").text("Available Password").css("color", "yellow");
				} else {
					$("#checkPw").text("Not Available Password").css("color", "orange");
						$("input[name=pw]").focus();
						return false;
				} 
				if(id.length<4){
					alert("ID should be between 4 and 10 characters");
					$("input[name=id]").focus();
					return false;
				}
	// 			------------ 패스워드 체크아이디 체크 ------------
				$.ajax({
					url			: "./join.do",
					type 		: "post",
					data 		: $("form").serialize(),
					success 	: function(data) {
						alert(data.msg);
						if(data.code==200){
							location.href = "./loginForm.do";
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
	
 
    <section id="joinForm" class="container text-center">
	 	
	 	
        	<form style="text-align : center;">
			 	<h1>
			 	<a class="navbar-brand floatnone" href="index.do"><img src="${pageContext.request.contextPath}/resources/images/quiz.png" width="300px" alt="logo"></a>
			 	</h1>
        		<div class="center-in-outer" style="margin-left: 10%">
	        		<div class="join-width-mid">
		        		<input type="text" name="id" placeholder="ID starting with alphabet " maxlength="12"/><span id="checkId"></span><br> 
		        		<input type="password" name="pw" placeholder="PW consists of number, special letter(!@#), lower and upper case(7+)"/><span id="checkPw"></span><br>        	
		        		<input type="password" name="confirmPw" placeholder="Confirm Password"/><span id="confirmPw"></span><br>        	
		        		<input type="text" name="surName" placeholder="SurName"/><span></span><br>        	
		        		<input type="text" name="givenName" placeholder="First Name"/><span></span><br>        	
<!-- 		        		<label >I      D  :</label><input type="text" name="id" placeholder="아이디" maxlength="12"/><span id="checkId"></span><br>  -->
<!-- 		        		<label >PASSWORD  :</label><input type="password" name="pw" placeholder="패스워드"/><span id="checkPw"></span><br>        	 -->
<!-- 		        		<label >CONFRIM   :</label><input type="password" name="confirmPw" placeholder="패스워드 확인"/><span id="confirmPw"></span><br>        	 -->
<!-- 		        		<label >SURNAME   :</label><input type="text" name="surName" placeholder="성"/><span></span><br>        	 -->
<!-- 		        		<label >GIVEN NAME:</label><input type="text" name="givenName" placeholder="이름"/><span></span><br>        	 -->
	        		</div>
	        		<div class="join-width-large">
		        		<input type="email" name="email" placeholder="abc@gmail.com"/><br>        	
<!-- 		        		<input type="text" name="addrRough" placeholder="**시 **구 **동"/><br>        	 -->
<!-- 		        		<input type="text" name="addrDetail" placeholder="**번지"/><br>        	 -->
<!-- 		        		<input type="text" name="zipCode" placeholder="우편번호"/><br>        	 -->
<!-- 		        		<label >E-mail    :</label><input type="email" name="email" placeholder="abc@gmail.com"/><br>        	 -->
<!-- 		        		<label >ADDRESS 1 :</label><input type="text" name="addrRough" placeholder="**시 **구 **동"/><br>        	 -->
<!-- 		        		<label >ADDRESS 2 :</label><input type="text" name="addrDetail" placeholder="**번지"/><br>        	 -->
<!-- 		        		<label >ZIP-CODE  :</label><input type="text" name="zipCode" placeholder="우편번호"/><br>        	 -->
	        		</div>
<!-- 					<div class="join-width-narrow" style="margin-right: 1px;"> -->
<!-- 		        		<input type="text" name="phoneNum1" placeholder="010" style="margin-left: 79px; -->
<!--    							 margin-right: 20px;"/> -->
<!--     				   -<input type="text" name="phoneNum2" placeholder="0000" style="margin-left: 21px; -->
<!--     						margin-right: 23px;"/> -->
<!-- 					    -<input type="text" name="phoneNum3" placeholder="0000" style="margin-left: 20px; -->
<!-- 					    margin-right: 18px;"/>        	 -->
<!-- 		        		<label >PHONE     :</label><input type="text" name="phoneNum1" placeholder="010"/> - <input type="text" name="phoneNum2" placeholder="0000"/> - <input type="text" name="phoneNum3" placeholder="0000"/>        	 --> 
<!-- 					</div> -->
						<input type="submit" value="JOIN" class="btn btn-primary" id="joinBtn">
        		</div>
        	</form>

   		
<!--         <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a> -->
    </section><!--/#error-->
 

<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->


	<style>
		.floatnone {
			float: none;
		}
/* 		.center-in-outer .join-width-narrow { */
/* 		 	 margin-left: 200px */
/* 		} */
		#joinBtn {
			margin-right: 50%;
		}
	</style>


</body>
</html>