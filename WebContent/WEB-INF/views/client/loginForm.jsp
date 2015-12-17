<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
	
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
  <style>
  #status {
    background-color: #3C56A2;
    color: #FBFCFD;
    width: 30%;
    max-width: 20%;
    margin: 1% auto;
    font-family: sans-serif;
  }
  
  #ktimg {
	width: 100px;
    height: 30px;
    padding-left: 30px;
  }
  
  #test {
 	background-color: #C52D2F;
    color: white;
    font-weight: 600;
	}
 }
  </style>
<script>
	$(document).ready(function(){
		loginCheck();
		login();
	});
	
	function loginCheck(){
		$.ajax({
			url			: "./loginCheck.do",
			type		: "get",
			success		: function(result){
				if(result.status == 200){
// 					alert("로그인 상태입니다.");
// 					history.back();
// 					history.go(-1);
				} else {
// 					alert("로그인 해주세요");
				}
			}
		});
		return false;
	}
	
	function login(){
		
		$("input[type=submit]").click(function(){
			
// 			alert("login button click");
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
// 					location.reload();
					
					if(result.code==200){
						
						location.href="./index.do";
						var sl = document.getElementById("stayLogin");
						if(sl.checked) {
// 							console.log("login check");
							$.cookie("cookie", result.cookie_val, {expires : 1000});
							
							$.ajax({
								url :"./cookie.do",
								type : "post",
								data : {"cookie" : result.cookie_val},
								success : function(result) {
// 									alert("cookie success");
									alert(result.msg);
									location.href = "./index.do";
								}
							})// end ajax
						}// end checked 
						else {
						location.href="./index.do";
						}
					} else if(result.code==300){
// 						alert(result.msg);
					} else if(result.code==400){
// 						alert(result.msg);
					}	//end if
				}	//end success
			});	//end ajax
			return false;			
		});	//end click
		
	}	//end function
	
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
	  // This is called with the results from from FB.getLoginStatus().
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
	 
	  // 이 함수는 누군가가 로그인 버튼에 대한 처리가 끝났을 때 호출된다.
	  // onlogin 핸들러를 아래와 같이 첨부하면 된다.
	  function checkLoginState() {
	    FB.getLoginStatus(function(response) {
	      statusChangeCallback(response);
	    });
	  }
	 
	  
	 
	  // 자바스크립트 SDK를 초기화 했으니, FB.getLoginStatus()를 호출한다.
	  //.이 함수는 이 페이지의 사용자가 현재 로그인 되어있는 상태 3가지 중 하나를 콜백에 리턴한다.
	  // 그 3가지 상태는 아래와 같다.
	  // 1. 앱과 페이스북에 로그인 되어있다. ('connected')
	  // 2. 페이스북에 로그인되어있으나, 앱에는 로그인이 되어있지 않다. ('not_authorized')
	  // 3. 페이스북에 로그인이 되어있지 않아서 앱에 로그인이 되었는지 불확실하다.
	  //
	  // 위에서 구현한 콜백 함수는 이 3가지를 다루도록 되어있다.
	 
// 	    FB.getLoginStatus(function(response) {
// 	      statusChangeCallback(response);
// 	    });
	 
	  // SDK를 비동기적으로 호출
	  (function(d, s, id) {
	    var js, fjs = d.getElementsByTagName(s)[0];
	    if (d.getElementById(id)) return;
	    js = d.createElement(s); js.id = id;
	    js.src = "//connect.facebook.net/en_US/sdk.js";
	    fjs.parentNode.insertBefore(js, fjs);
	  }(document, 'script', 'facebook-jssdk'));
	 
	  // 로그인이 성공한 다음에는 간단한 그래프API를 호출한다.
	  // 이 호출은 statusChangeCallback()에서 이루어진다.
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
	
// 		http://graph.facebook.com/915259715200354/picture?type=large
	  }
	
// KakaoTalk 로그인
	
	 // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('a2536f1c5dcee1fdf71675f4c657bf26');

	 
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
//     	  Kakao.API.request({
//     	        url: '/v1/user/me',
//     	        success: function(res) {
//     	          alert(JSON.stringify(res));
//     	        },
//     	        fail: function(error) {
//     	          alert(JSON.stringify(error))
//     	        }
//     	      });
    	    },
      fail: function(err) {
        alert(JSON.stringify(err))
      }
    });
    
    function loginWithKakao() {
        // 로그인 창을 띄웁니다.
        Kakao.Auth.login({
          success: function(authObj) {
        	console.log("카톡 로그인 성공");
//             alert(JSON.stringify(authObj));
            
            Kakao.API.request({
    	        url: '/v1/user/me',
    	        success: function(res) {
//     	          alert(JSON.stringify(res));
    	          
    	          $.ajax({
    					url 	: "./ktLogin.do",
    					type	: "post",
    					data 	: {"nickname": JSON.stringify(res.properties.nickname),
    								"id" : JSON.stringify(res.id)},
    					success : function(data) {
    						location.href="./index.do";
    					}
    				});
    	          
    	        },
    	        fail: function(error) {
    	          alert(JSON.stringify(error))
    	        }
    	      });
            
            

          },
          fail: function(err) {
        	  console.log("카톡 로그인 실패");	
        	 alert(JSON.stringify(err))
          }
        });
      };
      
      
      
	
</script>


</head><!--/head-->
<body>


<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	
 
 	
    <section id="loginForm" class="container text-center">
        <h1>LOGIN</h1>
        	<form>
        		<div class="login-width-large">
<!-- 	        		<label >I      D  :</label><input type="text" name="id" placeholder="아이디 입력"/><br>        	 -->
<!-- 	        		<label >PASSWORD  :</label><input type="password" name="pw" placeholder="패스워드 입력"/><br><br>        	 -->
	        		<input type="text" name="id" placeholder="ID"/><br>        	
	        		<input type="password" name="pw" placeholder="PASSWORD"/><br><br>        	
        		</div>
					<input type="submit" value="LOGIN" id ="test"/><br><br>
        	</form>
   
   			<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
		 	</fb:login-button>
		 	
		 	<a id="kakao-login-btn"></a>
		 	
		 	<a href="javascript:loginWithKakao()" id="custom-login-btn">
		      <img id="ktimg" src="http://mud-kage.kakao.co.kr/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg"></img>
		    </a>
			
<!-- 			<span id="fbLogout" onclick="fbLogout()"><a class="fb_button fb_button_medium"><span class="fb_button_text">Logout</span></a></span>  -->
			
<!-- 			<a href="#" onclick="FB.logout();"><input type="button" value="log out" id="logout"></a><br> -->
			
			<div id="status" ></div>
			
			
        		<input type="checkbox" name="stayLogin" id="stayLogin" style="background-color:#00FF00;" ><font color="#C52D2F">Stay Signed In</font>&nbsp;&nbsp;&nbsp;
        		<a href="findId.do" style="color: #C52D2F;">Find Id</a>&nbsp;&nbsp;&nbsp;
        		<a href="findPw.do" style="color: #C52D2F;">Find Password</a><br><br>

<!--         <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a> -->
    </section><!--/#error-->
 

<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->

</body>
</html>