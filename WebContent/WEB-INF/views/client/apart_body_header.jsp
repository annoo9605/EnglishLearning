<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="/resources/js/jquery.cookie.js"></script>
<script>
		$(document).ready(function(){
// 			checkCookie();
			finishCookie();
		});
		
			function checkCookie(){
				var login = $.cookie("cookie");
				alert('cookie: ' + login);
				if(login != '') {
					$.ajax({
						url : "./cookie.do",
						type : "post",
						data : {"cookie" : login},
						success : function(data) {
// 							location.reload();
						}
					});
				}
			}
			
			function finishCookie() {
				$("#logout").click(function(){
					
// 					$.cookie('cookie', null, {expires:-1});
					$.removeCookie('cookie');
					
				});
			}
	</script>
        

    <header id="header">
    	
        <div class="top-bar">
            <div class="container">
                <div class="row">
               		<div class="col-sm-6 col-xs-4">
                       <div class="social">
                            <ul class="social-share">
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-linkedin"></i></a></li> 
                                <li><a href="#"><i class="fa fa-dribbble"></i></a></li>
                                <li><a href="#"><i class="fa fa-skype"></i></a></li>
                            </ul>
                            <div class="search">
                                <form role="form">
                                    <input type="text" class="search-form" autocomplete="off" placeholder="Search">
                                    <i class="fa fa-search"></i>
                                </form>
                           </div>
                       </div>
                    </div>
                    <div class="col-sm-6 col-xs-8">
                    <c:if test="${sessionScope.id == null}">
                        <div class="top-number"><p><i class="fa fa-unlock"></i> <span><a href="loginForm.do">Sign In</a></span> | <span><a href="joinForm.do">Join</a></span></p>  </div>
                    </c:if>
                    <c:if test="${sessionScope.id != null}">
	                    <div class="collapse navbar-collapse ">
		                    <ul class="nav navbar-nav">
		                        <div class="dropdown active">
		                        <c:choose>
		                        	<c:when test="${sessionScope.name != null }">
		                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" style="text-decoration: underline;color: white; "> Welcome ${sessionScope.name} <i class="fa fa-angle-down"></i></a>
		                        	</c:when>
		                        	<c:when test="${sessionScope.nickname != null }">
		                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" style="text-decoration: underline;color: white; "> Welcome ${sessionScope.nickname} <i class="fa fa-angle-down"></i></a>
		                        	</c:when>
		                        	<c:otherwise>
		                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="text-decoration: underline;color: white; "> Welcome ${sessionScope.id} <i class="fa fa-angle-down"></i></a>
		                        	</c:otherwise>
		                        </c:choose>
		                            <ul class="dropdown-menu">
				                        <li><a href="logout.do" id="logout" name="logout">Sign out</a></li>
				                        <li><a href="modifyMemberForm.do">Modify Info</a></li>
				                        <li><a href="retrieveMemberPoint.do?pageNum=1&pageSize=5">My Points</a></li>
		                            </ul>
		                        </div>
		                    </ul>
	                </div>
                    

                    </c:if>
                    </div>
                    
                </div>
            </div><!--/.container-->
        </div><!--/.top-bar-->

        <nav class="navbar navbar-inverse" role="banner">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.do"><img src="${pageContext.request.contextPath}/resources/images/logoEng.png" alt="logo"></a>
                </div>
                
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">
                        <li><a href="index.do">Home</a></li>
<!-- 						<li><a href="studyCalendar.do">스터디 달력</a> -->
						<li><a href="fullCalendar.do">Study Calendar</a>
                        <li><a href="dailyExpressionForm.do">Daily Expression</a></li>
                        <li><a href="./quiz.do?quizCount=12&codeNo=">Quiz</a>
                        <li><a href="../studyBoardList.do">Study Board</a>
                        <li><a href="freeBoardList.do">Free Board</a></li>
<!--                         <li class="dropdown "> -->
<!--                             <a href="#" class="dropdown-toggle" data-toggle="dropdown">Pages <i class="fa fa-angle-down"></i></a> -->
<!--                             <ul class="dropdown-menu"> -->
<!-- 		                        <li><a href="about-us.do">About Us</a></li> -->
<!-- 		                        <li><a href="services.do">Services</a></li> -->
<!-- 		                        <li><a href="portfolio.do">Portfolio</a></li> -->
<!--                                 <li><a href="blog-item.do">Blog Single</a></li> -->
<!-- 		                        <li><a href="blog.do">Blog</a></li>  -->
<!--                                 <li><a href="pricing.do">Pricing</a></li> -->
<!--                                 <li><a href="shortcodes.do">Shortcodes</a></li> -->
<!-- 		                        <li><a href="contact-us.do">Contact</a></li>                         -->
<!--                                 <li class="active"><a href="404.do">404</a></li> -->
<!--                             </ul> -->
<!--                           </li> -->
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
        
        
    </header><!--/header-->
