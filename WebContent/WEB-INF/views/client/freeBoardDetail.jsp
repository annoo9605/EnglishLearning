<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="apart_head.jsp" %>
	<%@ include file="apart_body_footer_script.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세보기</title>

<style>
	table td {
		text-align: center;
		border: double;
	}
	
	.download {
		background-color: cornflowerblue;
		color: white;
	}
	
	#co_btn {
		background-color: cornflowerblue;
		color: white;
	}
	
	.rep {
		text-align: center;
	}
	
	#blog h1{
		
	}
	.entry-meta p{
		color : blue;
		font-weight: bold;
		
	}
	.entry-meta a{
		color : red;
	}
	
	.col-md-4 .widget .row *{
		text-align: left;
	}
	
	.col-md-4 .widget.categories {
		max-width: 100%;
		margin : auto;
	}
	.col-md-4 .widget.categories textarea{
		max-width: 100%;
		width:100%;
		margin : auto;
	}
	
</style>

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script>
	
	$(document).ready(function(){
		download();
		goList();
		deleteArticle();
		addComment();
		getComment();
	});
	
	function download() {
		$(".download").click(function(){
			var seqNo = ${param.seqNo};
			var atchSeqNo = $(this).parent().attr("atch_seq_no");
			alert(atchSeqNo);
			
			location.href="./download.do?seqNo="+seqNo+"&atch_seq_no="+atchSeqNo;
		});
	}
	
	function goList() {
		$("#list").click(function(){
			location.href="./freeBoardList.do?pageNum=1";
		});
		
	}
	
	function deleteArticle() {
		$("#delete").click(function(){

			$.ajax({
				url : "./delete.do", 
				type : "post",
				data : $("form").serialize(),
				success : function(result) {
// 						console.log(result.hashMap.msg);
					if(result.hashMap.code == 200) {
						alert(result.hashMap.msg);
						location.href="./freeBoardList.do?pageNum=1";
					} 
				}
			});
			return false;			
		});
	}
	
	function addComment() {
		$("#co_btn").click(function(){
			var commentContent = $('#co_content').val();
			
			console.log(commentContent);
			
			$.ajax({
				
				url 	: "./comment.do",
				type 	: "post",
				data 	: {"seqNo" : "${param.seqNo}", "co_content" : commentContent},
		
				success : function(result) {
					alert(result.msg);
// 					location.reload();
					getComment();
					$("#co_content").val("");
				}
				
			});
			return false;
		});
	}

	function getComment() {
			var seqNo = "${param.seqNo}";
		
			$.ajax({
			
			
			url 	: "./getComment.do?seqNo=" + seqNo,
			type 	: "post",
			data 	: {},
			success : function(result) {
				console.log(result);
				var html = "";
// 				html += "<ul>";
// 				for(var i = 0; i < result.comment.length; i++) {
// 					html += "<li>ID: " + result.comment[i].ID + " [RE]: " + result.comment[i].COMMENT_CONTENT + "</li>";
// 				}
// 				html += "</ul>";
// 				$("#reply div").html(html);
				for(var i = 0; i < result.comment.length; i++) {
					html += "<div class='single_comments'>";
					html += "	<img src='${pageContext.request.contextPath}/resources/images/blog/avatar3.png' alt=''  />";
					html += "	<p>"+ result.comment[i].COMMENT_CONTENT+"</p>";
					html += "	<div class='entry-meta small muted'>";					
					html += "		<span>By <a href='#'>"+result.comment[i].ID+"</a></span <span>On <a href='#'>"+result.comment[i].COMMENT_CRE_DATE+"</a></span>";			
                    html += "	</div>";
                    html += "</div>";
				}
				$(".row .col-sm-12").html(html);
			}
			
		});
	}
</script>
</head>
<body>

	<%@ include file="apart_body_header.jsp" %>
	 <section id="blog" class="container">
		<div class="blog">
			<div class="row">
				<div class="col-md-8">
				<h2>Writing Detail</h2>
				<form action="freeBoardDetail.do">
				<input type="hidden" name="seqNo" value="${param.seqNo }"><br><br>
				<table border="2" width="700" cellspacing="2" cellpadding="2">
				<tbody>
				<c:forEach var="detail" items="${detail}">
					<tr>
						<td class="left">Writer</td> <td>${detail.ID }</td>
						<td>Hit</td> <td>${detail.BOARD_HIT }</td>
					</tr>
					<tr>
						<td>Title</td> <td>${detail.BOARD_TITLE }</td>
						<td>Date</td> <td>${detail.BOARD_CRE_DATE }</td>
					</tr>
					<tr>
						<td colspan="4" height="300">${detail.BOARD_CONTENT }</td>
					</tr>
					<tr>
						<td colspan="4">Attached File
							<c:forEach var="file" items="${atchFile }">
								<li seqNo="${file.SEQ_NO }" atch_seq_no="${file.FILE_SEQ_NO }">
									<a href="./download.do?seqNo=${file.SEQ_NO }&atch_seq_no=${file.FILE_SEQ_NO}" style="color: #C52D2F;">${file.DSP_FILE_NAME }</a>
									&nbsp;&nbsp;<input type="button" class="download" value="Download" ><br>
							</c:forEach>
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4">
							<div class="btn">
								<input type="button" id="update" value="Update" class="btn btn-primary">
								<input type="button" id="delete" value="Delete" class="btn btn-primary">
								<input type="button" id="list" value="List" class="btn btn-primary">
							</div>
						</td>
					</tr>
				</tfoot>
				</table>
				
				</form>
				
				</div> <!-- 	col-md-8끝 -->
				<aside class="col-md-4">
					<div class="widget categories">
<!-- 						<fieldset id="reply" class="rep"> -->
<!-- 							<legend>답글달기</legend> -->
							<h2>Reply</h2>
							<div class="row">
								<div class="col-sm-12">
								</div>
							</div>
				<!-- 			<ul> -->
				<%-- 			<c:forEach var="list" items="${comment }"> --%>
				<!-- 				<li> -->
				<%-- 					ID: ${list.ID } [RE]: ${list.COMMENT_CONTENT} --%>
				<!-- 				</li> -->
				<%-- 			</c:forEach> --%>
				<!-- 			</ul> -->
							<textarea id="co_content" name="co_content" rows="3" cols="40" ></textarea>
							<br>
							<input type="button" id="co_btn" value="Submit" >
<!-- 					</fieldset> -->
					</div>
				</aside>
				<br><br>
			</div>
		</div><!-- .class 끝 -->
	</section>
	<%@ include file="apart_body_bottom.jsp" %>
	
	<%@ include file="apart_body_footer.jsp" %>
</body>
</html>