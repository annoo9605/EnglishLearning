<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
<script>
	$(document).ready(function(){
		
		var id = "";
		var pw = "";
		var confPw = "";
		
		join();
// 		idRedundancyCheck();
// 		pwCheck();
// 		confirmPw();
	});
	
	function confirmPw(){
	

		$("input[name=confirmPw]").on("keyup", function(){
			
			pw = $("input[name=pw]").val();// 밖에서 값 받아 오면 안되네...
			confPw = $("input[name=confirmPw]").val();
			if(pw==confPw){
				$("#confirmPw").text("비밀번호가 일치합니다.").css("color", "green");
			}else {
				$("#confirmPw").text("비밀번호가 다릅니다.").css("color", "blue");
			}
			
		});
		
		
	}
	
	
	function pwCheck(){
		/***************
		 비밀번호 체크 정규식
		 1. 영대문자 반드시 포함
		 2. 영소문자 반드시 포함
		 3. 숫자 반드시 포함
		 4. 특수문자 포함
		 
		****************/
		var pwReg1=/[A-Z]/;
		var pwReg2=/[a-z]/;
		var pwReg3=/[0-9]/;
		var pwReg4=/[!@#$%^&]/;
		
		$("input[name=pw]").on("blur", function(){
			pw = $("input[name=pw]").val();
			if(pw.length<6 || pw.length>20){
				$("#checkPw").text("비밀번호를 한번 더 고려해 주세요").css("color", "blue");
				$("input[name=pw]").focus();
				alert("비밀번호는 6자리 이상 20자리 이하의 비밀번호를 입력해 주세요.")
			} else if(pwReg1.test(pw)&&pwReg2.test(pw)&&pwReg3.test(pw)&&pwReg4.test(pw)){
				$("#checkPw").text("사용 가능한 비밀번호 입니다.").css("color", "green");
			} else {
				$("#checkPw").text("비밀번호를 한번 더 고려해 주세요").css("color", "blue");
				$("input[name=pw]").focus();
				alert("비밀 번호는 영문 대소문자, 숫자, 특수문자를 반드시 포함해야 합니다.")
			} 
		});
		
	}
	
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
											// -TURE : 특수문자, 한글, 빈칸등등
											
											// if()에서 !idReg2.test(id)
											// TRUE  : 대소영문자, 숫자
											// -FALSE: 특수문자, 한글, 빈칸
											
											//!(idReg1.test(id)&&!idReg2.test(id))
											// FALSE : 대소영문자, 숫자
											// -TRUE : 특수문자, 한글, 빈칸
											
											// ==> alert()창 실행
			var idReg = /^[A-za-z]{5,19}/g; // 영문 대소문자로 시작, 5~19자리, 끝날때 제한 없음
		***************/
		var idReg1=/^[a-zA-Z]/; 
		var idReg2=/[^a-zA-Z0-9]/; 
		
		
		
		$("input[name=id]").on("keyup", function(){
			id = $("input[name=id]").val();
			
			if(!(idReg1.test(id)&&!idReg2.test(id))){
				alert("아이디는 영문자로 시작하는 4~10자 영문자 또는 숫자이어야 합니다.");
				$("#checkId").text("사용할 수 없는 아이디입니다.").css("color", "blue");
			} else if(id.length>10){
				alert("아이디는 영문자로 시작하는 4~10자 영문자 또는 숫자이어야 합니다.");
				$("#checkId").text("사용할 수 없는 아이디입니다.").css("color", "blue");
			} else {
				$.ajax({
					url			: "./retrieveId.do",
					type		: "post",
					data		: {"id" : id},
					success		: function(result){
						if(result.code==200){
							$("#checkId").text(result.msg).css("color", "green");
						}else if(result.code==300){
							$("#checkId").text(result.msg).css("color", "blue");
						}
					}
					
				});
				return false;
			}
		});
		
		$("input[name=id]").on("blur", function(){
			id = $("input[name=id]").val();
			if(id.length<4){
				alert("아이디는 영문자로 시작하는 4~10자 영문자 또는 숫자이어야 합니다.");
				$("input[name=id]").focus();
				return false;
			}
			
		});
		
	}
	
	function join(){
		
		$("input[type=submit]").click(function(){
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
        <h1>JoinForm</h1>
        	<form>
        		<div class="center-in-outer">
	        		<div class="join-width-mid">
		        		<label >I      D  :</label><input type="text" name="id" placeholder="USERID" maxlength="12"/><span id="checkId"></span><br>        	
		        		<label >PASSWORD  :</label><input type="password" name="pw" placeholder="PASSWORD"/><span id="checkPw"></span><br>        	
		        		<label >CONFRIM   :</label><input type="password" name="confirmPw" placeholder="PASSWORD"/><span id="confirmPw"></span><br>        	
		        		<label >SURNAME   :</label><input type="text" name="surName" placeholder="David"/><span></span><br>        	
		        		<label >GIVEN NAME:</label><input type="text" name="givenName" placeholder="Eugeon"/><span></span><br>        	
	        		</div>
	        		<div class="join-width-large">
		        		<label >E-mail    :</label><input type="email" name="email" placeholder="abc@gmail.com"/><br>        	
		        		<label >ADDRESS 1 :</label><input type="text" name="addrRough" placeholder="부산"/><br>        	
		        		<label >ADDRESS 2 :</label><input type="text" name="addrDetail" placeholder="동구"/><br>        	
		        		<label >ZIP-CODE  :</label><input type="text" name="zipCode" placeholder="23534"/><br>        	
	        		</div>
					<div class="join-width-narrow">
		        		<label >PHONE     :</label><input type="text" name="phoneNum1" placeholder="010"/> - <input type="text" name="phoneNum2" placeholder="1234"/> - <input type="text" name="phoneNum3" placeholder="4567"/>        	
					</div>
						<input type="submit" value="JOIN"/>
        		</div>
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