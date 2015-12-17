package com.learning.eng.common;

public class Page {
	private int startRow, endRow;
	private StringBuffer sb;
	private static Page page = new Page();
	
	private Page(){
	}
	
	public static Page getInstance(){
		return page;
	}
	public int getStartRow() {
		return startRow;
	}
	public int getEndRow() {
		return endRow;
	}	
	public StringBuffer getSb() {
		return sb;
	}
	
	/**
	 * @param pageNum	: 현재 페이지번호
	 * @param count		: 조회된 전체 게시물의 갯수
	 * @param pageSize	: 한 페이지에 들어가는 Row 수~ 10개씩 보기 20개씩 보기
	 * @param pageBlock	: 페이징 블록 단위
	 * 
	 * 
	 * 
	 * if (pageNum == null) {
			pageNum = "1";
		}
		
		count = oracleDao.getArticleCount();
		
		if(count > 0 ){
			articleList = oracleDao.getArticles(Page.getInstance().getStartRow(), Page.getInstance().getEndRow())
		} else {
			articleList = null;
			
			
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("articleList", articleList);
		req.setAttribute("count", count);
		req.setAttribute("pagecode", Page.getInstance().getSb().toString());
		
		
		// <tr>	  
      	// 	<td colspan="5" align="center" height="40">	 
	  	//		${pagecode}
	  	//	</td>
  		// </tr>
		
	 */
	public void paging (int pageNum, int count, int pageSize, int pageBlock){
		System.out.println("pageNum : " + pageNum + ", count : " + count + ", pageSize : " + pageSize + ", pageBlock : "+ pageBlock);
		
		int totalPage = (int) Math.ceil((double)count/pageSize); 
																//전체 페이지를 구한다. 한 페이지에 몇개씩 보느냐에 따라 전체 페이지 갯수가 구해진다.
																//(int)+1하는 방법은 10일때(정수로 딱 떨어질때) 빈페이지가 하나 만들어 지므로...
		
		startRow = ( pageNum - 1 ) * pageSize;	//전 페이지의 마지막게시물 다음 번호가 첫 행이다.
//		endRow = pageNum * pageSize;				//
		
//		int startPage = (int) ( ( pageNum - 1 ) / pageBlock ) * pageBlock + 1; // 
//		int endPage = startPage + pageBlock - 1 ;
		int startPage = pageNum - (int) pageBlock/2;
		if(startPage< 1){
			startPage = 1;
		}
		int endPage = startPage + pageBlock;
		
		if(totalPage < endPage){		//totalPage가 작을때 , endPage보다
			endPage = totalPage;		//endPage를 totalPage에 맞춰준다.
		}
		System.out.println("totalPage : " + totalPage + ", startRow : " + startRow + ", endRow : " +endRow +", startPage : " + startPage + ", endPage : " + endPage);
		
		/*******************************
		 * <ul class="pagination pagination-lg">
                        <li><a href="#"><i class="fa fa-long-arrow-left"></i>Previous Page</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">Next Page<i class="fa fa-long-arrow-right"></i></a></li>
           </ul><!--/.pagination-->
		 * 
		 ********************************/
		
		
		
		
		sb= new StringBuffer();
		sb.append("<ul class='pagination pagination-lg'>");
		
		if(startPage < pageBlock - (int) pageBlock/2){		//1~10밖에 없다. 이때 왼쪽으로 블록 넘길때 비활성화 하는것 필요.
			sb.append("<li><a href='#' style='color: #797070;font-weight: bold;'><i class='fa fa-arrow-left'></i>Prev</a></li>");
		} else {
			sb.append("<li><a href='javascript:movePage(" + (startPage - pageBlock) + ")'><i class='fa fa-arrow-left'></i>Page</a></li>");
			sb.append("<li><a href='javascript:movePage(1)'>1</a></li>");
			sb.append("<li><a href='#'>...</a></li>");
//			sb.append("<li><a href='"+command+"?pageNum=");
//			sb.append(startPage - pageBlock);
//			sb.append("'><i class='fa fa-long-arrow-left'></i>Previous Page</a></li>");
		}
		
		for (int i = startPage; i <= endPage; i++) {
			if(i == pageNum){
				sb.append("<li class='active'><a href='#'>"+i+"</a></li>");
			} else {
//				sb.append("<li><a href='"+command+"?pageNum="+i+"'>"+i+"</a></li>");
				sb.append("<li><a style='color: #797070;font-weight: bold;' href='javascript:movePage(" + i + ")'>"+i+"</a></li>");
			}
		}
		
		if(endPage < totalPage){ //마지막 페이지
			sb.append("<li><a href='#'>...</a></li>");
			sb.append("<li><a href='javascript:movePage("+totalPage+")'>"+totalPage+"</a></li>");
			sb.append("<li><a href='javascript:movePage(" + (startPage + pageBlock) + ")'>Next<i class='fa fa-arrow-right'></i></a></li>");
//			sb.append("<li><a href='"+command+"?pageNum=");
//			sb.append(startPage + pageBlock);
//			sb.append("'>Next Page<i class='fa fa-long-arrow-right'></i></a></li>");
		} else {
			sb.append("<li><a href='#' style='color: #797070;font-weight: bold;'>Next<i class='fa fa-arrow-right'></i></a></li>");
		}
		
		sb.append("</ul>");
	}
	
	
}
