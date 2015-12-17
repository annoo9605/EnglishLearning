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
	$(document).ready(function(){
		console.log("${dataList}");
		checkAnswer();
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
			var point = 0;
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
				console.log("정답");	
				$(".QuizHidden:eq("+thisIndex+") p:eq(0)").css("display","block");
				$(".QuizHidden:eq("+thisIndex+") p:eq(1)").css("display","none");
			} else {
				point = -10;
				activity = 207;
				$(".QuizHidden:eq("+thisIndex+") p:eq(0)").css("display","none");
				$(".QuizHidden:eq("+thisIndex+") p:eq(1)").css("display","block");
				console.log("오답");	
			}
			
			$.ajax({
				url 	: "./quizScore.do",
				data 	: {"point" : point, 
						   "codeNo" : codeNo, 
						   "sourceSeqNo" : seqNo, 
						   "activity" :  activity },
				success : function(result) {
					alert("point 점수 반영");
					alert(result.msg);
				}
			})
		
		});
	}
</script>
<style>
	.heading-two:hover {
 		background-color: #ff9900;
	}
	
	.QuizHidden p {
		display:none;
	}
	
/* 	#correct { */
/* 		visibility: hidden; */
/* 		position: absolute;  */
/* 	    left: 0;  */
/* 	    top: 0;  */
/* 	    width: 100%;  */
/* 	    height: 100%;  */
/* 	    text-align: center;  */
/* 	    background: rgba(0, 0, 255, 0.9);  */
/* 	    z-index: 100; */
/* 	} */
	
/* 	#fish1 { */
/*  	   margin-top: auto; */
/* 	   position: relative;  */
/* 	   top: 300px;  */
/* 	   vertical-align: middle;  */
/* 	   width: 20%;  */
/* 	} */
	
	
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
                <p class="lead">오늘의 퀴즈<br> 다음 표현을 한국어로 말하면?</p>
            </div>  
            

            
            
<!--             <div id="front" class="pricing-area text-center"> -->
            <div class="pricing-area text-center">
                <div class="row class-rearrange-items">
                
                <c:set var="quizCount" value="-1"/>
                <c:forEach var="list" items="${dataList}">
                <c:set var="quizCount" value="${quizCount +1}"/>
                
	                <div id="quiz${quizCount}" class="apps col-xs-12 col-sm-4 col-md-3 plan price-one wow fadeInDown front class-rearrange-item isotope-item
	                							<c:if test="${list.CODE_NO==102}">.cls-inKorean-arti</c:if>
	                							<c:if test="${list.CODE_NO==103}">.cls-inEnglish-arti</c:if>"> 
	                        <ul>
	                            <li class="heading-two">
	                                <h3>Quiz ${quizCount+1 }</h3>
	                                <span><h2>${list.BOARD_TITLE }</h2></span>
	                            </li>
	                            <br>
	                            <c:set var="ansCount" value="-1"/>
	                            <c:forEach var="answer"items="${list.ansList }">
	                            <c:set var="ansCount" value="${ansCount+1 }"/>
	                            		<input type="checkbox" value="${ansCount }" name="option${quizCount}" anscode="${answer.Q_ANS_CODE}">${answer.Q_ANS }<br>
	                            </c:forEach>
								<div class='QuizHidden' >
									<p><input type="image" src="/resources/images/correct.png" >맞았어요 *^^*</p>
									<p><input type="image" src="/resources/images/wrong.png" >틀렸어요 ㅠㅠ</p>
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
	<%@ include file="apart_body_bottom.jsp" %>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>



</body>
</html>