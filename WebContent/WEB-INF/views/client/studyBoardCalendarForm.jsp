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
// 		console.log("${dateList}");
// 		alert('${dateList[0].studySubject[0].STUDY_DATE}');
	});

</script>

<style>
	.head {
	    background-color: #C52D2F;;
	    color: white;
	    font-size: large;
	}
	
	#span {
	    display: inline-flex;
	}

	.bg-table {
	    background-color: floralwhite;
	}
	
	td {
		background-color: white;
	}
</style>

</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
	<form id="studyBoardCalendarForm">
		<input type="hidden" name="year" value="${dateList[0].thisYear}"/>
		<input type="hidden" name="month" value="${dateList[0].thisMonth}"/>
	</form>
	
 <label>
 
 
    <section id="studyBoardCalendarForm" class="container text-center">
       <div class="calendar">
<%-- 	   		<span id="prev" month="${dateList[0].prevMonth}" year="${dateList[0].prevYear}" style="float:left"> --%>
<!-- 			<a href="#"><i class="fa fa-angle-double-left"></i></a></span> -->
			<a href="./studyBoardCalendar.do?year=${dateList[0].prevYear }&month=${dateList[0].prevMonth }">  <img src='/resources/images/arrow-back-icon.png' style="padding-right: 30px;"></a>
			<span id="span"><h2>${fn:substring(dateList[0].thisYear,0,4)} year</h2> </span>&nbsp;
			<span id="span" style="font-size: 2em; font-weight: bold;"> ${dateList[0].thisMonth} Month</span>
			<a href="./studyBoardCalendar.do?year=${dateList[0].nextYear }&month=${dateList[0].nextMonth}">  <img src='/resources/images/arrow-next-3-icon.png' style="padding-left: 50px;"></a>
<%-- 			<span id="next" month="${dateList[0].nextMonth}" year="${dateList[0].nextYear}" style="float:right"> --%>
<!-- 			<a href="#"><i class="fa fa-angle-double-right"></i></a></span> -->
       </div>
       <a href="studyBoardWrite.do" style="color: #C52D2F"  >Write</a></label>
       <br><br>
       <div class="calendar center wow fadeInDown">
	      	<table border="1" class="bg-table">
	       	<colgroup>
				<col span="1" style="width:14%;">
				<col span="1" style="width:14%;">
				<col span="1" style="width:14%;">
				<col span="1" style="width:14%;">
				<col span="1" style="width:14%;">
				<col span="1" style="width:14%;">
				<col span="1" style="width:14%;">
	       	</colgroup>
	       	<thead>
	       		<tr class="head">
	       			<th>SUN</th>
	       			<th>MON</th>
	       			<th>TUE</th>
	       			<th>WED</th>
	       			<th>THU</th>
	       			<th>FRI</th>
	       			<th>SAT</th>
	       		</tr>
	       	
	       	</thead>
	<!--        	/* 달력 리스트로 돌린다. */ 								-->
	<!--        	/* if 첫 열일때 (일요일) 이면 */ /* 행 시작 <tr> 열어준다. */ 	-->
	<!--        			/* 일별 삽입 */ 									-->
	<!--        			/* if 마지막날 조건 - 나머지 칸 공백 삽입 */			-->
	<!--        	/* if 첫 열이 아닐때 이면*/ 								-->
	<!--        			/* if 1일인데 첫 열이 아닐 경우 - 빈칸 삽인 후 */ 		-->
	<!--        			/* 일별 삽입 */ 									-->
	<!--        			/* if 마지막날 조건 - 나머지 칸 공백 삽입 */ 			-->
	<!--        			/* if 마지막 행 (토요일) 조건 */ 					-->
	       	<tbody >
	       		<c:forEach items="${dateList}" var="list">
	       			<c:choose>
	       				<c:when test="${list.week == 1 }">
	       					<tr>
	       						<td year="${list.thisYear}" month="${list.thisMonth}" date="${list.date}">
	       						${list.date}
       							<c:forEach var="row" items="${list.studySubject}">
	       							<br/><a href="./studyBoardDetail.do?seqNo=${row.SEQ_NO}" style="color: red"> ${row.STUDY_SUBJECT}</a>
	       						</c:forEach>
	       						</td>
	       						<c:if test="${list.date == list.lastDate}">
	       							<c:forEach begin="1" end="${7 - list.week}">
	       								<td>
	       								</td>
	       							</c:forEach>
	       						</c:if>
	       				</c:when>
	       				<c:otherwise>
	       						<c:if test="${list.date == 1 &&  list.week > 1 }"> <!-- 1일일때 앞칸 빈칸 채움-->
	       							<c:forEach begin="2" end="${list.week}" >
<%-- 	       							<c:forEach begin="1" end="${list.week - 1}"> --%>
	       								<td> </td>
	       							</c:forEach>
	       						</c:if>
	       						<td year="${list.thisYear}" month="${list.thisMonth}" date="${list.date}">
	       						${list.date}
	       						<c:forEach var="row" items="${list.studySubject}">
	       							<br/><a href="./studyBoardDetail.do?seqNo=${row.SEQ_NO}" style="color: red">${row.STUDY_SUBJECT}</a>
<%--     								<c:choose> --%>
<%--     									<c:when test="${row.ACTIVITY==202}">문제 등록 : ${row.POINT}점</c:when> --%>
<%--     									<c:when test="${row.ACTIVITY==206}">맞은 문제 : ${row.POINT}점</c:when> --%>
<%--     									<c:when test="${row.ACTIVITY==207}">틀린 문제 : ${row.POINT}점</c:when> --%>
<%--     									<c:otherwise> </c:otherwise> --%>
<%--     								</c:choose> --%>
    								</a>
	       						</c:forEach>
	       						</td>
	       						<!-- 마지막 날짜 루프롤 돌때 나머지 빈칸은 추가시켜 준다. -->
	       						<c:if test="${list.date == list.lastDate }">
		       						<c:forEach begin="1" end="${7 - list.week}">
		       							<td> </td>
		       						</c:forEach>
	       						</c:if>
	       						<c:if test="${list.week == 7}">
	       							</tr>
	       						</c:if>
	       				</c:otherwise>
	       			</c:choose>
	       		</c:forEach>
	       	</tbody>
	       	<tfoot>
	       	
	       	</tfoot>
	      	
	      	</table>
       
       </div>
    </section><!--/#studyCalendar-->
 

<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>