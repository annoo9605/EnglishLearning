<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/pages/dailyExpression.css" rel="stylesheet"> --%>
<!-- 	scripter INCLUDE -->
	<%@ include file="apart_body_footer_script.jsp" %>
<script>
	$(document).ready(function(){
		console.log("${mylist}");
		insertExpression();
		changeLanguage();
		retrieveExpression();
		recommendArticle();
		countUpArticle();
// 		addFilterClass();
	});
	function countUpArticle(){
		$(document).on("click", "")
	}
	
	
	function recommendArticle(){
// 		$("#thumbsUp, #thumbsDown").on("click", function(){
// 			alert(123);
// 		});		//.on() method 처리 방식이 바뀌었다.
		$(document).on("click", ".thumbsUp, .thumbsDown", function(){
// 			var recommendValue = $(this).attr("value")=='up' ? 1 : -1;
			var recommendValue = $(this).attr("value");
			var recommendSeqNo = $(this).attr("seqNo");
			var recommendCodeNo = $(this).attr("codeNo");
			console.log(recommendValue);
			console.log(recommendSeqNo);
			console.log(recommendCodeNo);
			var dataArray =  
			console.log(dataArray);
			$.ajax({
				url			:	"recommendArticle.do",
				type		:	"POST",
				data		: 	{ "codeNo" : recommendCodeNo 
								 , "seqNo" : recommendSeqNo
								 , "value" : recommendValue },
				success		: function(result){
					console.log(result);
					location.reload();
				}
			});
			return false;
		});
	}
	
	
	function changeLanguage(){
		$("input[name=codeNo]").on("change",function(){
			if($("#expressionLang1").is(":checked")){
				$("#expressionSubject").text("HOW CAN I SAY THIS IN KOREAN?");
				$("input[name=title]").val("");
				$("input[name=title]").attr("placeholder","HELLO")
				$("#expressionContent").text("YOU CAN SAY LIKE THIS.");
				$("input[name=content]").val("");
				$("input[name=content]").eq(0).attr("placeholder","안녕하세요");
				$("input[name=content]").eq(1).attr("placeholder","안녕하십니까?");
				$("input[name=content]").eq(2).attr("placeholder","방가");
				$("input[name=content]").eq(3).attr("placeholder","여~");
				$("input[name=content]").eq(4).attr("placeholder","안녕");
				$(".col-sm-5>.form-group>span").text("ONE MORE");
			} else if($("#expressionLang2").is(":checked")){
				$("#expressionSubject").text("이것은 영어로 어떻게 말하나요?");
				$("input[name=title]").val("");
				$("input[name=title]").attr("placeholder","안녕하세요")
				$("#expressionContent").text("영어로 이렇게 말해요.");
				$("input[name=content]").val("");
				$("input[name=content]").eq(0).attr("placeholder","HELLO");
				$("input[name=content]").eq(1).attr("placeholder","HOW ARE YOU");
				$("input[name=content]").eq(2).attr("placeholder","HI, THERE");
				$("input[name=content]").eq(3).attr("placeholder","HEY");
				$("input[name=content]").eq(4).attr("placeholder","HI");
				$(".col-sm-5>.form-group>span").text("하나더");
			}
		});
		
		
	}
	
	function insertExpression(){
		$("button[type=submit]").click(function(){
			var f = new FormData($("#insert-expression-form")[0]);	// 1.) $("#insert-expression-form").serialzie 대신에 
																	// 		FormData()라는 객체를 만들어 준다.
																	//		그런데 이것은 javaScript 문법이라서 $("#insert-expression-form")제이쿼리를 못읽는다.
																	// 		이렇게 셀렉터가 해당되는 모든 것을 읽어오거나 제이쿼리에 필요한 것을 붙여서 온다.
																	// 		따라서 $("#insert-expression-form")[0] 선택해서 자바스크립트에 필요한 형태 하나를 가져오게 된다.
			
			$.ajax({
				url			:"./insertExpression.do",
				type		:"POST",
				data		: f,						//2.) 이것을 data에 넣어 주고
				contentType : false,					//3.) 기본적으로 Ajax 보낼때 이건 html문서라는것을 붙여 주는데 . 이것을 막겠다.
				processData : false,					//4.) data처리를 "key" = "value" ,"key" = "value" 형태로 넘어가는 것을 막아주겠다.
				success		: function(result){
					if(result.code==100){
						alert(result.msg);
						location.href=result.url;
					} else if(result.code==200){
						alert(result.msg);
						console.log(result.msg);
						location.href=result.url;
					}
				}
			});
			return false;
		});
	}
	
	function retrieveExpression(){
// 		console.dir('${dailyExpressionList}');
		
	}
	
// 	function addFilterClass(){
// 		var $deList = '${dailyExpressionList}';
			/*
				문자열로 받아온 $deList = '${dailyExpressionList}' 은 문자열이며
				따라서 length를 찍으면 문자열의 길이가 나온다.
				또한 MAP 형태올 넘겨 { 키값 = 밸류값 , 키값 = 밸류값 }이 된다.
				JSON 형태는 { "키값" : "밸류값" , "키값" : "밸류값"} 형태가 되기에 
				parseJSON도 안먹힌다.
			*/
// 		$deList = $deList.split("=").join(":");
// 		console.log($deList);
// 		$deList = $.parseJSON($deList);
// 		console.log($deList[0].BOARD_CONTENT);
// 		for(var i = 0; i < deList.size; i++){
// 		}
// 	}
	/*
		자바를 스크립트로 가져와 가공하는 방식은 보안문제들 문제가 있다.
		HTML 방식 + AJAX를 사용 하면 JSP 없이도 동적 웹을 구성 할 수 있다.
		그러나 C: 태그 라이브러리를 사용해 동적으로 구성하는 방식이 가장 깔끔하다.
	*/
</script>
<style>
.image-box {
	display: none;
}

.pp_inline img{
	width : 100%;
}
.article-box-recommend,
.article-box-article {
	float : left;
}

.article-box-recommend{
	padding : 10% 1%;
}

.table-space{
 	border-collapse: separate;
    border-spacing: 10px 20px;
}

.fa.fa-chevron-down,
.fa.fa-chevron-up {
	color : black;
}
</style>

</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
	
	<section id="dailyExpression" >
        <div class="container">
            <div class="center">        
                <h2>나의 퀴즈 노트</h2>
            </div> 
            <div class="row contact-wrap"> 
                <div class="status alert alert-success" style="display: none"></div>
                <form id="insert-expression-form" enctype="multipart/form-data">
                    <div class="col-sm-4 col-sm-offset-1">
                        <div class="form-group">
<!--                             <label>ID  *</label> -->
                            <label>${sessionScope.id }님 환영합니다</label>
                        </div>
                    </div>                        
                </form> 
            </div><!--/.row-->
        </div><!--/.container-->
    </section><!--/#expressionForm-page-->
	
	
	<form id="recommend-article"></form>
	 <section id="dailyExpressionShow">
        <div class="container">
            <div class="center">
            <c:forEach items="${mylist }" var="list">
               
				<c:if test="${list.ACTIVITY == 206 }">
					<h2>
					<img src="${pageContext.request.contextPath}/resources/images/Minion-Shout-icon.png" />
					내가 맞은 문제들 
					<img src="${pageContext.request.contextPath}/resources/images/Minion-Crazy-icon.png" /></h2>
				</c:if>
			
				<c:if test="${list.ACTIVITY == 207 }">
					<h2>
					<img src="${pageContext.request.contextPath}/resources/images/Minion-Amazed-icon.png" />
					내가 틀린 문제들 
					<img src="${pageContext.request.contextPath}/resources/images/Minion-Sad-icon.png" /></h2>
				</c:if>
			</c:forEach>
            </div>
        

            <div class="row">
                <div class="image-rearrange-items">
                	<c:set var="interCount" value="0"/>
                	<c:forEach items="${mylist }" var="list">
                		<c:set var="interCount" value="${interCount+1}"/>
						
						<!--각 Expression 게시글 -->
						<div class="image-rearrange-item apps col-xs-12 col-sm-4 col-md-3<c:if test='${list.CODE_NO == 103}'> cls-inKorean-arti</c:if><c:if test='${list.CODE_NO == 103}'> cls-inEnglish-arti</c:if>">
	                        <div class="image-rearrange-wrap">
	                        	
	                        	<!-- 1. 게시글 사진 -->
	                        	
	                        	<c:choose>
										<c:when test="${list.IS_ATCH_FILE=='Y'}">
											<c:set var="doneloop" value="false"/>
											<c:forEach var="dFiles"items="${dailyFileList}" varStatus="status">
											<c:if test="${not doneloop}">
												<c:if test="${dFiles.SEQ_NO == list.SEQ_NO}" var="matchImg">
														<img class="img-responsive" src="${pageContext.request.contextPath}/resources/images/upload/${dFiles.SAVE_FILE_NAME}.${dFiles.EXTENSION}">
														<c:if test="${matchImg}">
															<c:set var="doneloop" value="true"/>
														</c:if>
												</c:if>						
											</c:if>						
											</c:forEach>
										</c:when>
										<c:otherwise>
											<%--<img src="${pageContext.request.contextPath}/resources/images/upload/full/item${interCount}.png"> --%>
											<img class="img-responsive" src="${pageContext.request.contextPath}/resources/images/portfolio/recent/item${interCount }.png" alt="">
										</c:otherwise>
									</c:choose>
	                        	
	                            
	                            
<!-- 	                            2. 마우스 오버시 나타나는 글자 -->
<!-- 	                            <div class="overlay"> -->
<!-- 	                                <div class="image-rearrange-inner"> -->
<%-- 	                                	<c:if test='${list.CODE_NO == 102}'> --%>
<%-- 	                                		<h3><a href="#">'${list.BOARD_TITLE}'</a></h3> --%>
<!-- 	                                		<p>can be spoken like this</p> -->
<%-- 	                                	</c:if> --%>
<%-- 	                                	<c:if test='${list.CODE_NO == 103}'> --%>
<%-- 	                                		<h3><a href="#">'${list.BOARD_TITLE}'</a></h3> --%>
<!-- 	                                		<p>는 이렇게 말해요</p> -->
<%-- 	                                	</c:if> --%>
<%-- <%-- 	                                    <a class="preview" href="${pageContext.request.contextPath}/resources/images/portfolio/full/item${interCount }.png" rel="prettyPhoto"><i class="fa fa-eye"></i> View</a> --%> --%>
<%-- 	                                    <a class="preview" href="#question-box${interCount}" rel="prettyPhoto" seqNo="${list.SEQ_NO}" codeNo="${list.CODE_NO}"><i class="fa fa-eye"></i> View</a> --%>
<!-- 	                                </div>  -->
<!-- 	                            </div> -->
	                            
	                            <!-- 3. View 상세 보기 -->
								<div id="question-box${interCount}" style="display: none;" >
									<c:choose>
										<c:when test="${list.IS_ATCH_FILE=='Y'}">
											<c:forEach var="dFiles"items="${dailyFileList}">
											<c:if test="${dFiles.SEQ_NO == list.SEQ_NO}">
												<img src="${pageContext.request.contextPath}/resources/images/upload/${dFiles.SAVE_FILE_NAME}.${dFiles.EXTENSION}">
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<img src="${pageContext.request.contextPath}/resources/images/upload/full/item${interCount}.png">
										</c:otherwise>
									</c:choose>
<%-- 									<img src="${pageContext.request.contextPath}/resources/images/portfolio/full/item${interCount}.png"> --%>
<%-- 									<img src="${imagePath}portfolio/full/item${interCount}.png"> --%>
									<div class="article-box-wrap">
										<div class="article-box-recommend" style="float:left;">
										<p><a herf="#" class="thumbsUp" value="up" seqNo="${list.SEQ_NO}" codeNo="${list.CODE_NO}"><i class="fa fa-chevron-up"></i></a></p>
										<c:forEach items="${dailyrecommendList}" var="recommend">
											<c:if test="${recommend.SOURCE_SEQ_NO==list.SEQ_NO}">
												<p>${recommend.TOTAL_LIKE}</p>
											</c:if>
										</c:forEach>
										<p><a herf="#" class="thumbsDown" value="down" seqNo="${list.SEQ_NO}" codeNo="${list.CODE_NO}"><i class="fa fa-chevron-down"></i></a></p>
										</div>
										<div class="article-box-article"style="float:left;">
											<table class="table-space">
												<tr>
													<th colsapn='3'>
														<h3>${list.BOARD_TITLE}</h3>
													</th>
												</tr>
			                                    <c:forEach var="answer" items='${dailyAnswerList}'>
			                                    		<c:if test='${list.SEQ_NO == answer.SEQ_NO}'>
			                                    		<tr>
			                                    			<td><c:if test='${answer.Q_ANS_CODE==1}'>유사어</c:if>
			                                    				<c:if test='${answer.Q_ANS_CODE==2}'>매력적 오답</c:if>
			                                    				<c:if test='${answer.Q_ANS_CODE==3}'>질문자도 몰라</c:if></td>
			                                    			<td>&nbsp;</td>
			                                    			<td>${answer.Q_ANS}</td>
			                                    			<td><i class="fa fa-bullhorn"></i></td>
			                                    		</tr>
			                                    	</c:if>
			                                    </c:forEach>
											</table>
										</div>
										
									</div>
									
								</div> <!-- 3. View 상세 보기 끝 -->
	                        </div>
                    	</div><!--/.image-rearrange-item-->  <!--각 Expression 게시글  끝-->           	
                	</c:forEach>
<!--                 required Class : image-rearrange-item col-xs-12 col-sm-4 col-md-3 -->
                   
                </div>
            </div>
        </div>
    </section><!--/#dailyExpression-items-->
	

 	
 
 

<!-- 	bottom menu INCLUDE	 -->
	<%@ include file="apart_body_bottom.jsp" %>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>



</body>
</html>