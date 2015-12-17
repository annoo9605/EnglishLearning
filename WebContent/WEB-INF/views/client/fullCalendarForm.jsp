<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- 	meta info with head content INCLUDE -->
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>
	<link href='${pageContext.request.contextPath}/resources/cal/fullcalendar.css' rel='stylesheet' />
	<link href='${pageContext.request.contextPath}/resources/cal/lib/cupertino/jquery-ui.min.css' rel='stylesheet' />
	<link href='${pageContext.request.contextPath}/resources/cal/fullcalendar.print.css' rel='stylesheet' media='print' />
	<script src='${pageContext.request.contextPath}/resources/cal/lib/moment.min.js'></script>
	<script src='${pageContext.request.contextPath}/resources/cal/fullcalendar.js'></script>
	<script src='${pageContext.request.contextPath}/resources/cal/lang-all.js'></script>
	<script src='${pageContext.request.contextPath}/resources/cal/lib/jquery-ui.custom.min.js'></script>
	
	
<script>

	var date = new Date();
	var crntDate;
	$(document).ready(function() {
// 		defaultCalendar();
		getCurrentDate();
		initCalendar();
		initExernal();
		clickExpression();
		
		var state = true;
		$("#drop-btn").click(function() {
			if(state) {
				$("#external-events")
				.animate({
					height : 50
				}, 500)
				.animate({
					width : 50,
				}, 500);
				$(this).parent().children().not("#drop-btn").hide(1000);
			} else {
				$("#external-events")
				.animate({
					height : 270.795
				}, 500)
				.animate({
					width : 150,
				}, 500);
				$(this).parent().children().not("#drop-btn").show(1000);
			}
			state= !state
		});
	});
	function clickExpression(){
// 		var count = 0;
		$("body").on("click", "a[id^='ans']",function(){
			$("#ans-events").remove();
			var $a = $(this);
// 			if(count<1){
// 			}
// 			count++;
			var seqNo = $(this).attr("seqno");
			var codeNo = $(this).attr("codeno");
			$.ajax({
				url			: "retrieveBoard.do",
				type		: "POST",
				data		: { "seqNo" : seqNo , "codeNo" : codeNo},
				success		: function(data){
					console.dir(data.ansList);
					html = "<div id='ans-events'><div><h4>"+data.ansList[0].BOARD_TITLE+"</h4></div><div>";
					if((typeof data.ansList[0].Q_ANS) != 'undefined'){
						html += data.ansList[0].Q_ANS +"</div>";
// 						if((typeof data.ansList[1].Q_ANS) != 'undefined'){
// 							html += "<div>"+data.ansList[1].Q_ANS +"</div>";
							
// 						}
					} else {
						html += "</div>";
					}
					html += "</div>"; 
// 					$a.parent().parent().parent().after(html);
// 					$("#external-events").after(html);
					$("#calendar").before(html);
				}
				
			})
			return false;
		});
		
	}
	function getCurrentDate(){
// 		var nYear = date.getFullYear()
// 		var nMonth = date.getMonth()+1;
// 		var nDate = date.getDate;
// 		if(nMonth.toString().length == 1){
// 			nMonth = "0" + nMonth;
// 		}
// 		if(nDate.toString().length == 1){
// 			nDate = "0" + nDate;
// 		}
// 		var crntDate = nYear + "-" + nMonth + "-" + nDate;

		Date.prototype.today = function () { 
		    return this.getFullYear() + "-" + (((this.getMonth()+1) < 10)?"0":"") + (this.getMonth()+1) + "-" + ((this.getDate() < 10)?"0":"") + this.getDate() ;
		}

		// For the time now
		Date.prototype.timeNow = function () {
		     return ((this.getHours() < 10)?"0":"") + this.getHours() +":"+ ((this.getMinutes() < 10)?"0":"") + this.getMinutes() +":"+ ((this.getSeconds() < 10)?"0":"") + this.getSeconds();
		}
// 		console.log(date.today());
// 		console.log(date.timeNow());
// 		console.log(date.today()+"T"+date.timeNow());
		crntDate = date.today()+"T"+date.timeNow();
	}
	
	function initCalendar(){
		/* initialize the calendar
		-----------------------------------------------------------------*/
		var dataList1 ;
		var dataList2 ;
		$.ajax({
			url : './getfullCalendar.do',
			data : {},
			async : false,
			success : function(data) {
				dataList1 = data.calList;
				console.log(dataList1);
			}
		});
		$.ajax({
			url : './getfullCalendarWrongAns.do',
			data : {},
			async : false,
			success : function(data) {
				dataList2 = data.wrongList;
				console.log(dataList2);
			}
		});

		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultDate: crntDate,
			eventSources: [
			              dataList1,
			              dataList2,
			],
			loading: function(bool) {
				$('#loading').toggle(bool);
			},
			eventLimit: true, // allow "more" link when too many events
			editable: true,
			selectable: true,			//************
			selectHelper: true,			//************
			select: function(start, end) {
				var title = prompt('Event Title:');
				var eventData;
				if (title) {
					eventData = {
						title: title,
						start: start,
						end: end
					};
					$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
				}
				$('#calendar').fullCalendar('unselect');
			},
			droppable: true, // this allows things to be dropped onto the calendar
			drop: function() {
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
			}
			
		});

	}
	function initExernal(){
		/* initialize the external events
		-----------------------------------------------------------------*/

		$('#external-events .fc-event').each(function() {

			// store data so the calendar knows to render an event upon drop
			$(this).data('event', {
				title: $.trim($(this).text()), // use the element's text as the event title
				stick: true // maintain when user navigates (see docs on the renderEvent method)
			});

			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});

		});
	}

	function defaultCalendar(){

		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultDate: '2015-07-30',
			selectable: true,			//************
			selectHelper: true,			//************
			select: function(start, end) {
				var title = prompt('Event Title:');
				var eventData;
				if (title) {
					eventData = {
						title: title,
						start: start,
						end: end
					};
					$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
				}
				$('#calendar').fullCalendar('unselect');
			},
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			events: [
						{
							title: 'All Day Event',
							start: '2015-07-01'
						},
						{
							title: 'Long Event',
							start: '2015-07-07',
							end: '2015-07-10'
						},
						{
							id: 999,
							title: 'Repeating Event',
							start: '2015-07-09T16:00:00'
						},
						{
							id: 999,
							title: 'Repeating Event',
							start: '2015-07-16T16:00:00'
						},
						{
							title: 'Conference',
							start: '2015-07-11',
							end: '2015-07-13'
						},
						{
							title: 'Meeting',
							start: '2015-07-12T10:30:00',
							end: '2015-07-12T12:30:00'
						},
						{
							title: 'Lunch',
							start: '2015-07-12T12:00:00'
						},
						{
							title: 'Meeting',
							start: '2015-07-12T14:30:00'
						},
						{
							title: 'Happy Hour',
							start: '2015-07-12T17:30:00'
						},
						{
							title: 'Dinner',
							start: '2015-07-12T20:00:00'
						},
						{
							title: 'Birthday Party',
							start: '2015-07-13T07:00:00'
						},
						{
							title: 'Click for Google',
							url: 'http://google.com/',
							start: '2015-07-28'
						}
					]
		});
		
		
	}
</script>
<style>

	body {
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}
	#calendar a {
		color : black;
		}
	section h1{
		color : #4e4e4e;
	
	}
/* 	********* external*********** */
	#wrap {
		max-width: 1100px;
		margin: 5% auto;
	}
		
	#external-events {
		position : fixed;
		z-index : 998;
		left: 1%;
		float: left;
		width: 150px;
		padding: 0 10px;
		border: 1px solid #ccc;
		background: #eee;
		text-align: left;
	}
		
	#external-events h4 {
		font-size: 16px;
		margin-top: 0;
		padding-top: 1em;
	}
		
	#external-events .fc-event {
		min-width: 30px;
		margin: 10px 0;
		cursor: pointer;
	}
		
	#external-events p {
		margin: 1.5em 0;
		font-size: 11px;
		color: #666;
	}
		
	#external-events p input {
		margin: 0;
		vertical-align: middle;
	}
	
/* 	********* external end*********** */
/* 	********* external array*********** */

	#ans-events {
		position : fixed;
		z-index : 999;
		right : 1% ;
		width: 150px;
		padding: 0 10px;
		border: 1px solid #ccc;
		background: #F2F2F2;
		text-align: left;
	}
/* 	********* external array end*********** */
	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>

</head><!--/head-->
<body>
<!-- 	navigation and header INCLUDE -->
	<%@ include file="apart_body_header.jsp" %>
 	<section id="studyCalendar" class="container text-center">
		<h1>Study Calendar</h1>
		 <div id='wrap'>
<!-- 		<div id='external-events'> -->
<!-- 			<div id='drop-btn'>&nbsp;</div> -->
<!-- 			<h4 >Draggable Events</h4> -->
<!-- 			<div class='fc-event'>My Event 1</div> -->
<!-- 			<div class='fc-event'>My Event 2</div> -->
<!-- 			<div class='fc-event'>My Event 3</div> -->
<!-- 			<div class='fc-event'>My Event 4</div> -->
<!-- 			<div class='fc-event'>My Event 5</div> -->
<!-- 			<p> -->
<!-- 				<input type='checkbox' id='drop-remove' /> -->
<!-- 				<label for='drop-remove'>remove after drop</label></p> -->
<!-- 		</div> -->

		<div id='calendar'></div>

		<div style='clear:both'></div>

	</div>
		
    </section><!--/#studyCalendar-->
   
    

<!-- 	bottom menu INCLUDE	 -->
<%-- 	<%@ include file="apart_body_bottom.jsp" %> --%>

<!--  	footer INCLUDE -->
	<%@ include file="apart_body_footer.jsp" %>

<!-- 	scripter INCLUDE -->



</body>
</html>