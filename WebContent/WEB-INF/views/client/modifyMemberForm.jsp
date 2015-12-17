<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		
		modify();
// 		pwCheck();
// 		confirmPw();
		changeMode();
		changePw();
	});
	
	
	function changeMode(){
		$("#modify_btn").click(function(){
			$("#modify_member_show_form").css("display","none");
			$("#modify_member_form").css("display","block");
			
			$("#modify_phone_show_form").css("display","none");
			$("#modify_phone_form").css("display","block");
			
		});
	}
	
	function changePw(){
		$("#pw_change_btn").click(function(){
			$("#modify_pw_show_form").css("display","none");
			$("#modify_pw_form").css("display","block");
			
		});
	}
	
	
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
	
	function modify(){
		
		$("input[type=submit]").click(function(){
			$.ajax({
				url			: "./modifyMember.do",
				type 		: "post",
				data 		: $("form").serialize(),
				success 	: function(data) {
					console.log(data);
					if(data.code==200){
						alert(data.msg);
						location.href="./modifyMemberForm.do"
					}
				}
			});
			return false;			
		});
	}

</script>
<style>
/* #modifyMemberForm { */
/* 	max-width : 80%; */
/* 	margin : 1% auto; */
/* } */

</style>

</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
 
    <section id="modifyMemberForm" class="container text-center">
        <h1>Personal Info</h1>
        	<form>
        		<div class="center-in-outer">
	        		<div class="modify-width-mid" id="modify_pw_show_form" style="margin-left: 36%"> <br><br>
		        		<label >I      D  :</label>${memberMap.ID }<br>        	
		        		<label >PASSWORD  :</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="pw_change_btn" value="Change PW" class="btn btn-primary"><br>        	
		        		<label >CONFRIM   :</label><br>        	
		        		<label >SURNAME   :</label>${memberMap.SUR_NAME }<br>        	
		        		<label >GIVEN NAME:</label>${memberMap.GIVEN_NAME }<br>        	
	        		</div>
	        		<br><br>
	        		<div class="modify-width-large" id="modify_pw_form" style="display: none">
		        		<label >I      D  :</label><input type="hidden" name = "id" value="${memberMap.ID }" >${memberMap.ID }<br>        	
		        		<label >PASSWORD  :</label><input type="password" name="pw" placeholder="PASSWORD"/><span id="checkPw"></span><br>        	
		        		<label >CONFRIM   :</label><input type="password" name="confirmPw" placeholder="PASSWORD"/><span id="confirmPw"></span><br>        	
		        		<label >SURNAME   :</label>${memberMap.SUR_NAME }<br>        	
		        		<label >GIVEN NAME:</label>${memberMap.GIVEN_NAME }<br>        	
	        		
	        		</div>
	        		
	       			<input type="button" id="modify_btn" value="Submit" class="btn btn-primary" style="text-align : center"/><br>
<!-- 	        		<div class="modify-width-large" id="modify_member_show_form"> -->
<%-- 		        		<label >E-mail    :</label>${memberMap.EMAIL }<br>        	 --%>
<%-- 		        		<label >ADDRESS 1 :</label>${memberMap.ADDRESS_ROUGH }<br>        	 --%>
<%-- 		        		<label >ADDRESS 2 :</label>${memberMap.ADDRESS_DETAIL }<br>        	 --%>
<%-- 		        		<label >ZIP-CODE  :</label>${memberMap.ZIP_CODE }<br>        	 --%>
<!-- 	        		</div> -->
<!-- 	        		<div class="modify-width-large" id="modify_member_form" style="display: none"> -->
<%-- 		        		<label >E-mail    :</label><input type="text" name="email" value="${memberMap.EMAIL }"/><br>        	 --%>
<%-- 		        		<label >ADDRESS 1 :</label><input type="text" name="addrRough" value="${memberMap.ADDRESS_ROUGH }"/><br>        	 --%>
<%-- 		        		<label >ADDRESS 2 :</label><input type="text" name="addrDetail" value="${memberMap.ADDRESS_DETAIL }"/><br>        	 --%>
<%-- 		        		<label >ZIP-CODE  :</label><input type="text" name="zipCode" value="${memberMap.ZIP_CODE }"/><br>        	 --%>
<!-- 	        		</div> -->
<!-- 					<div class="modify-width-narrow" id="modify_phone_show_form"> -->
<%-- 		        		<label >PHONE     :</label> ${memberMap.phoneNum1 } - ${memberMap.phoneNum2 } - ${memberMap.phoneNum3 }        	 --%>
<!-- 					</div> -->
<!-- 					<div class="modify-width-narrow" id="modify_phone_form" style="display: none"> -->
<%-- 		        		<label >PHONE     :</label><input type="text" name="phoneNum1" placeholder="010" value="${memberMap.phoneNum1 }"/> - <input type="text" name="phoneNum2" placeholder="1234" value="${memberMap.phoneNum2 }"/> - <input type="text" name="phoneNum3" placeholder="4567" value="${memberMap.phoneNum3 }"/>        	 --%>
<!-- 					</div> -->
<!-- 						<input type="submit" value="MODIFY"/> -->
<!--         		</div> -->
        	</form>
   
<!--         <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a> -->
    </section><!--/#error-->
 

<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>