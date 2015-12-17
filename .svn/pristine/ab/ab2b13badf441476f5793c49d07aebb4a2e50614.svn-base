<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
<script>
	$(document).ready(function(){
		var articleList;
		init();
		changePageSize();
	});
	
	function init(){
		/*hidden에 바로 넣어 버림*/
// 		console.log('${param.pageNum}');
// 		$('input[name=pageNum]').val("${param.pageNum}");

	}
	
	
	function changePageSize(){
		$("select[name=pageSize]").on("change", function(){
			$("#pointRetrieve").submit();
// 			$.ajax({
// 				url			: "retrieveMemberPoint.do",
// 				type		: "POST",
// 				data		: $("#pointRetrieve").serialize(),
// 				success		: function(data){
// 					alert(1);
// 					console.log(data.articleList);
// 					articleList = data.articleList;
// 				}
// 			});
		});
	}

</script>
<style>
		#theader {
		    background-color: rgba(95, 70, 194, 0.89);
   			color: white;
		}
	
		 tr:nth-child(odd){
	    	background-color: rgba(95, 70, 194, 0.16);
	    }
	    
	    table {
	    	border : none;
	    	max-width: 100%;
	    	margin : auto;
		    background-color: transparent;
		    width: 700px;
		    height: 300px;
		    text-align: center;
	    }
		.pagination li a{
			color: #797070;
			font-weight: bold;
		}
	</style>

</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	<form method ="post" id="pointRetrieve" action="retrieveMemberPoint.do">
		<input type="hidden" name="pageNum" value="${param.pageNum}">
		<input type="hidden" name="isRestrieve" value="true">
	</form>
 
    <section class="container text-center">
       	<div class="center">
        	<div><h2>Point History (ID:${sessionScope.id }) </h2></div>
        	
        	<table id="point_table">
	        	<colgroup>
		            <col span="1"/>
		            <col span="1" style="background:lightgrey" />
		            <col span="1"/>
		            <col span="1"/>
<%-- 		            <col style="background:yellow" /> --%>
<%-- 		            <col style="background:green" /> --%>
	        	</colgroup>
        		<thead>
        			<tr>
        				<td colspan="4">
        			<div style=" float : right;">
		        		<select name="pageSize" form="pointRetrieve" >
							<option selected="true" disabled="disabled">SELECT</option>
							<option value="5">Every 5</option>
							<option value="10">Every 10</option>
							<option value="20">Every 20</option>
							<option value="50">Every 50</option>
		        		</select>
		        	</div>
		        		</td>
        			</tr>
        			<tr>
        				<th>Date</th>
        				<th>Activity</th>
        				<th>Gained Points</th>
        				<th>Used Points</th>
        			</tr>
        		</thead>
        		<tbody>
        			<c:set var="sum" value="0"/>
        			<c:forEach items="${articleList }" var="point">
	        			<tr>
	        				<td>${point.ACTIVITY_DATE }</td>
	        				<td>${point.CODE_NO }</td>
	        					<c:choose>
	        						<c:when test="${point.POINT > 0 }">
				        				<td>${point.POINT }</td>
				        				<td></td>
	        						</c:when>
	        						<c:otherwise>
	        							<td></td>
	        							<td>${point.POINT }</td>
	        						</c:otherwise>
	        					</c:choose>
	        					<c:set var="sum" value="${sum + point.POINT}"/>
	        			</tr>
        			</c:forEach>
        		</tbody>
        		<tfoot>
        			<tr>
        				<td colspan="2">Total</td>
        				<td colspan="2" style="background:lightgrey">${sum}</td>
        				
        			</tr>
        		</tfoot>
        	
        	</table>
        ${pagingCode}
       	</div>
<!--         <a class="btn btn-primary" href="index.do">GO BACK TO THE HOMEPAGE</a> -->
    </section><!--/#error-->
 

<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>