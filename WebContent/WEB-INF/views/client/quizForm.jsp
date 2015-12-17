<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
<!-- 	scripter INCLUDE -->
	<%@ include file="apart_body_footer_script.jsp" %>

<script>
	var totalP = 0;
	var corCo = 0;
	var wroCo = 0;
	var totalCo = 0;
	var per = 0;
	$(document).ready(function(){
		console.log("${dataList}");
		checkAnswer();
		sendEmail();
		$("#dialog").dialog();
		$(".ui-dialog").hide();
		sendQuizTo()
	});

	function checkAnswer(){
		$(".plan-action input[type=button]").click (function () {
// 			몇번째 문제인지 인덱스 뽑는다.
			var thisIndex = $(".plan-action input[type=button]").index($(this));
			console.log(thisIndex);
// 			문제 문항들을 가져온다.
			var $answers = $("#quiz" + thisIndex).find("input[anscode=1]");
			
			var answerCount = $answers.length;
			var checkedCount = $("#quiz" + thisIndex).find("input:checked").length;
			
//			정답 여부를 알려주는 섹션
			var $quizHidden = $(".QuizHidden").get(thisIndex);
			var resultAns= true;
			var codeNo = $(this).attr("codeNo");
			var activity = 0;
			var seqNo = $(this).attr("seqNo");
			
// 			console.log(seqNo);
			
			if(answerCount == checkedCount) {
				$answers.each(function(idx){
					console.log("each ", idx);
					// 정답 체크된 것들은 anscode가 1이 맞는지, 체크 안된 부분들은 1이 아닌지를 검사 => 정답여부 판별
					if(!$(this).is(":checked")){
						resultAns = false;
						return false; 
					}
				});
			} else {
				resultAns = false;
			}
			
			if(resultAns){
				point = 10;
				activity = 206;
				corCo = corCo + 1;
				totalCo =  corCo + wroCo;
				per = (corCo / totalCo) * 100; 
				console.log("정답");	
				$(".QuizHidden:eq("+thisIndex+") p:eq(0)").css("display","block");
				$(".QuizHidden:eq("+thisIndex+") p:eq(1)").css("display","none");
				$("#correctQ").text(corCo );
				$("#wrongQ").text(wroCo );
				$("#percent").text(per + " %");
			} else {
				point = -10;
				activity = 207;
				wroCo = wroCo + 1;
				totalCo =  corCo + wroCo;
				per = (corCo / totalCo) * 100;
				$(".QuizHidden:eq("+thisIndex+") p:eq(0)").css("display","none");
				$(".QuizHidden:eq("+thisIndex+") p:eq(1)").css("display","block");
				console.log("오답");
				$("#correctQ").text(corCo + "개");
				$("#wrongQ").text(wroCo + "개");
				$("#percent").text(per + "%");
			}
			
			$.ajax({
				url 	: "./quizScore.do",
				data 	: {"point" : point, 
						   "codeNo" : codeNo, 
						   "sourceSeqNo" : seqNo, 
						   "activity" :  activity },
				success : function(result) {
					
				}
			})
		
		});
	}
	
	function sendEmail() {
		$("#email").click(function(){
			$(".ui-dialog").show();

		});
		
	}
	
	function sendQuizTo() {
		$("#emailBtn").click(function(){

			var emailTo = document.getElementById("emailTo").value;
			
			$.ajax({
				url : "./sendEmail.do",
				type :"post",
				data : {"url" : "http://annoo.cafe24.com/quiz.do?quizCount=12&codeNo=",
						"email" : emailTo },
				success : function(result) {
					alert("Succeed in sending email");
					$(".ui-dialog").hide();
				}
			});
		})
		
	}
	
	window.fbAsyncInit = function() {
		  FB.init({
		    appId      : '1198284926864041',
		    cookie     : true,  // 쿠키가 세션을 참조할 수 있도록 허용
		    xfbml      : true,  // 소셜 플러그인이 있으면 처리
		    version    : 'v2.4' // 버전 2.4 사용
		  });
		
// 			FB.Event.subscribe('auth.logout', function(response) {
// 			    document.location.reload();
// 			});
	};
	
	function checkLoginState() {
		    FB.getLoginStatus(function(response) {
		      statusChangeCallback(response);
		    });
		  }
	function statusChangeCallback(response) {
		    console.log('statusChangeCallback');
		    console.log(response);
		    // response 객체는 현재 로그인 상태를 나타내는 정보를 보여준다. 
		    // 앱에서 현재의 로그인 상태에 따라 동작하면 된다.
		    // FB.getLoginStatus().의 레퍼런스에서 더 자세한 내용이 참조 가능하다.
		    if (response.status === 'connected') {
		      // 페이스북을 통해서 로그인이 되어있다.
		      testAPI();
		    } else if (response.status === 'not_authorized') {
		      // 페이스북에는 로그인 했으나, 앱에는 로그인이 되어있지 않다.
		      document.getElementById('status').innerHTML = 'Please log ' +
		        'into this app.';
		    } else {
		      // 페이스북에 로그인이 되어있지 않다. 따라서, 앱에 로그인이 되어있는지 여부가 불확실하다.
		      document.getElementById('status').innerHTML = 'Please log ' +
		        'into Facebook.';
		    }
		  }
	(function(d, s, id) {
		    var js, fjs = d.getElementsByTagName(s)[0];
		    if (d.getElementById(id)) return;
		    js = d.createElement(s); js.id = id;
		    js.src = "//connect.facebook.net/en_US/sdk.js";
		    fjs.parentNode.insertBefore(js, fjs);
		  }(document, 'script', 'facebook-jssdk'));
	
	function testAPI() {
		    console.log('Welcome!  Fetching your information.... ');
		    FB.api('/me', function(response) {
				  console.log(response);
			      console.log('Successful login for: ' + response.name);
			      document.getElementById('status').innerHTML =
		        	'Welcome, ' + response.name + '!';
				
					$.ajax({
						url 	: "./facebookLogin.do",
						type	: "post",
						data 	: {"id": response.id, "name" : response.name},
						success : function(data) {
							location.href="./index.do";
						}
					});
		    });
		
//	 		http://graph.facebook.com/915259715200354/picture?type=large
		  }
	
	
</script>
<style>
	.heading-two:hover {
 		background-color: #37BFFF;
	}
	.heading-two {
 		background-color: #E34C48;
	}
	
	.heading-two h2 {
		color: white;
   		font-weight: bold;
	}
	
	.heading-two .plan-action { 
	    background-color: rgba(255, 244, 25, 0.35);
	}
	
/* 	#quiz0 {margin-left:15px;} */
	
	.QuizHidden p {
		display:none;
	    text-align: center;
	    color: #093D2C;
}
	}
	
 	#quizWrap div.apps {
/*  		margin-left:20px; */
		padding-left : 10px;
		padding-right : 10px;
/*  		box-sizing : border-box;  */
/*  		-webkit-box-sizing : border-box;  */
 	}
	
/* 	#score { */
/* 		padding: 8px 20px; */
/* 	    background: #c52d2f; */
/* 	    color: #fff; */
/* 	    border-radius: 4px; */
/* 	    margin-top: 25px; */
/* 	    display: inline-block; */
/* 	    font-weight: bold; */
/* 	} */
	
 	#email { 
  	    background-color: #C52D2F;
	    color: white;
	    width: 97%;
	    position: relative;
	    right: -486%;
	    top: -61px;
	    font-weight: 700;
	    height: 80px;
 	} 
	
	.scoreBoard {
		background-color: #C52D2F;
	    color: white;
	    width: 17%;
	    height: 80px;
	    position: relative;
	    right: 41%;
	    top: -61px;
	    font-weight: 700;
	}
	
</style>

</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
 	<section class="pricing-page">

<!-- 		<div id="correct" >  -->
<!-- 			<img id="fish1" src="/images/fish1.png" />  -->
<!-- 		</div> -->

        <div class="container">
            <div class="center">  
                <h2>Daily Quiz</h2>
<!--                 <p class="lead">오늘의 퀴즈</p> -->
            </div>  
            
		<div class="scoreBoard">
        	Correct &nbsp;&nbsp;<span id="correctQ"></span><br>
        	Wrong &nbsp;&nbsp;<span id="wrongQ"></span><br>
        	Score &nbsp;&nbsp;<span id="percent" ></span>
        
        	<div 	style="margin-left: 265%;
        			z-index: 5"
			 	 	class="fb-like"
				  	data-share="true"
				  	data-width="450"
				  	data-show-faces="true">
			</div>
        
        	<input type="button" value="Email Quiz" id="email">
			<div id="dialog" title="Email Quiz to Friends">
			  <input type="email" placeholder="Email" id="emailTo" ><br><br>
			  <input type="button" value="Send" id="emailBtn">
			</div>   
			         
        </div>    
<!--             <div id="front" class="pricing-area text-center"> -->
            <div class="pricing-area text-center">
                <div id="quizWrap" class="row class-rearrange-items">
                
                <c:set var="quizCount" value="-1"/>
                <c:forEach var="list" items="${dataList}" varStatus="status1">
                <c:set var="quizCount" value="${quizCount +1}"/>
                
	                <div id="quiz${quizCount}" class="apps col-xs-12 col-sm-3 col-md-3 plan price-one wow fadeInDown front class-rearrange-item isotope-item
	                							<c:if test="${list.CODE_NO==102}">.cls-inKorean-arti</c:if>
	                							<c:if test="${list.CODE_NO==103}">.cls-inEnglish-arti</c:if>"> 
	                        <ul>
	                            <li class="heading-two">
	                                <h3>Quiz ${quizCount+1 }</h3>
	                                <span><h2>${list.BOARD_TITLE }</h2></span>
	                            </li>
	                            <br>
	                            <c:set var="ansCount" value="-1"/>
	                            <c:forEach var="answer" items="${list.ansList }" varStatus="status2">
	                            <c:set var="ansCount" value="${ansCount+1 }"/>
	                            	<input type="checkbox" value="${ansCount }" name="option${quizCount}" anscode="${answer.Q_ANS_CODE}" id="checkBox_id_${status1.count}_${status2.count}"><label for="checkBox_id_${status1.count}_${status2.count}"> &nbsp;${answer.Q_ANS }</label><br>
	                            </c:forEach>
	                            <br>
								<div class='QuizHidden' >
									<p style="background-color: rgba(121, 216, 73, 0.25);"><input type="image" src="/resources/images/correct.png" > Correct </p>
									<p style="background-color: rgba(255, 118, 118, 0.24);"><input type="image" src="/resources/images/wrong.png" > Wrong </p>
								</div>
	                            <li class="plan-action">
	                                <input type="button" class="btn btn-primary" id="btn${quizCount}"  
	                                	resultid="result${quizCount}" optionid="option${quizCount}" answerid="answer${quizCount}" seqNo="${list.SEQ_NO}" codeNo="${list.CODE_NO}" value="정답 확인">
	                            </li>
		                        
	                        </ul>
	                </div>
                </c:forEach>


            </div><!--/pricing-area-->
        </div><!--/container-->
        
       </div>
       
       
    </section><!--/pricing-page-->
 
 

<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>



</body>
</html>