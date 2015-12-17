<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <header id="header">
        <div class="top-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-xs-4">
                    <c:if test="${sessionScope.id == null}">
                        <div class="top-number"><p><i class="fa fa-unlock"></i> <span><a href="loginForm.do">로그인</a></span> | <span><a href="joinForm.do">회원가입</a></span></p>  </div>
                    </c:if>
                    <c:if test="${sessionScope.id != null}">
	                    <div class="collapse navbar-collapse ">
		                    <ul class="nav navbar-nav">
		                        <li class="dropdown active">
		                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"> ${sessionScope.id} <i class="fa fa-angle-down"></i></a>
		                            <ul class="dropdown-menu">
				                        <li><a href="modifyMemberForm.do">회원정보 수정</a></li>
				                        <li><a href="retrieveMemberPoint.do?pageNum=1&pageSize=5">포인트 조회</a></li>
		                            </ul>
		                        </li>
		                        <li> | <a href="logout.do">로그아웃</a></li>
		                    </ul>
	                </div>
                    

                    </c:if>
                    </div>
                    <div class="col-sm-6 col-xs-8">
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
                    <a class="navbar-brand" href="index.do"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo"></a>
                </div>
                
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">
                        <li><a href="index.do">홈으로</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">마이페이지<i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu">
		                        <li><a href="modifyMemberForm.do">회원정보 수정</a></li>
		                        <li><a href="studyCalendarForm.do">스터디 달력</a></li>
                            </ul>
                        </li>
                        <li><a href="dailyExpressionForm.do">오늘의 표현</a></li>
                        <li><a href="dailyExpressionForm.do">QUIZ</a></li>
                        <li><a href="freeboard.do">자유게시판</a></li>
                        <li class="dropdown ">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Pages <i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu">
		                        <li><a href="about-us.do">About Us</a></li>
		                        <li><a href="services.do">Services</a></li>
		                        <li><a href="portfolio.do">Portfolio</a></li>
                                <li><a href="blog-item.do">Blog Single</a></li>
		                        <li><a href="blog.do">Blog</a></li> 
                                <li><a href="pricing.do">Pricing</a></li>
                                <li><a href="shortcodes.do">Shortcodes</a></li>
		                        <li><a href="contact-us.do">Contact</a></li>                        
                                <li class="active"><a href="404.do">404</a></li>
                            </ul>
                          </li>
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
        
    </header><!--/header-->
