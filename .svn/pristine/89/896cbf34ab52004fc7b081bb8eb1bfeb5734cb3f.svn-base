package com.learning.eng.client.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.learning.eng.common.Page;
import com.learning.eng.common.Util;
import com.learning.eng.dao.ClientBoardDao;


@Service
public class ClientBoardService {
	@Autowired
	ClientBoardDao cbDao;
	@Autowired
	Util util;
	
	public boolean isLogin(Map<String, Object> map){
		boolean isLogin = false;
		if(map.get("id") != null && !map.get("id").equals("")){
			isLogin = true;
		}
		return isLogin;
	}
	public Map<String, Object> retrieveMemberPoint(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();	
//		/*로그인 여부 검사*/
//		if(!isLogin(map)){
//			returnMap.put("code", 100);
//			returnMap.put("msg", "로그인이 필요합니다.");
//			returnMap.put("url", "./loginForm.do");
//			return returnMap;
//		}	//AOP로 처리
		String pageNum 	= (String) map.get("pageNum");
		int pageSize	= Integer.parseInt((String)map.get("pageSize"));
		int pageBlock	= 5;
		int count 		= cbDao.getPointCount();
		
		Page.getInstance().paging(Integer.parseInt(pageNum), count, pageSize, pageBlock);
		map.put("startRow", Page.getInstance().getStartRow());
		map.put("endRow", Page.getInstance().getEndRow());
		
		/* 게시글이 있을 경우에만 List 반환*/
		List<Map<String, Object>> list = null;
		if(count > 0){
			list = cbDao.retrieveMemberPoint(map);
		} else {
			list = null;
		}
		
		returnMap.put("articleList", list);
		returnMap.put("pagingCode", Page.getInstance().getSb().toString());
		returnMap.put("pageNum", pageNum);
		returnMap.put("count", count);
		
		
		return returnMap;
	}


	public Map<String, Object> retrieveStudyCalendar(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
//		cbDao.retrieveStudyCalendar(map);
		return returnMap;
	}


//	public Map<String, Object> retrieveComment(Map<String, Object> map) {
//		Map<String, Object> returnMap = new HashMap<String, Object>();
//		List<Map<String, Object>> commentList = cbDao.retrieveComment(map);
//		returnMap.put("commentList", commentList);
//		return returnMap;
//	}

//	@Transactional(rollbackFor={SQLException.class, LoginException.class})
	@Transactional
	public Map<String, Object> insertExpression(Map<String, Object> map, MultipartHttpServletRequest mRequest){
		//throws SQLException, RuntimeException, LoginException{
		//트랜잭션은 기본적으로 RuntimeException을 거른다.
		Map<String, Object> returnMap = new HashMap<String, Object>();
//		/*로그인 여부검사*/
//		if(!isLogin(map)){
//			returnMap.put("code", 100);
//			returnMap.put("msg", "로그인이 필요합니다.");
//			returnMap.put("url", "./loginForm.do");
//			return returnMap;
//		} 	// => AOP로 처리
		
		/*트랜잭션 필요*/
		int status1 =0;
		List<Integer> status2 = new ArrayList<Integer>();
		try{
			/*첨부파일 존재 여부 확인*/
//			if(mRequest.getFileNames().hasNext()){   // getFileNames 는 html태그 이름을 구하는 것이다.
			Iterator<String> htmlNames = mRequest.getFileNames();
			boolean isAtch = false;
			int count = 0;
			while(htmlNames.hasNext()){
				String htmlName = htmlNames.next();
				System.out.println(++count + "th:htmlName : " + htmlName);		//1번재:htmlName : file
				List<MultipartFile> mFiles = mRequest.getFiles(htmlName);		//받아온 파일즈에서 
				isAtch = !mFiles.get(0).getOriginalFilename().toString().equals("");	//파일을 꺼내어 실제 파일이름이 있는지를 검색해 봐야 한다. 
																						//공백이 아니어야 파일 존재 => isAtch = true
				System.out.println(count+"th:mFiles"+mFiles);
			}
			if(isAtch){
				map.put("isAtch", "Y");
			} else {
				map.put("isAtch", "N");
			}
			/*문제 게시판에 먼저 넣고*/
			/*QUIZ에서 요청 오면 BOARD에 CONTENT는 넣지않고 답 테이블에만 넣는다.*/
			if(map.get("codeNo").toString().equals("102") || map.get("codeNo").toString().equals("103") ){
				map.put("isQuiz","true");
			} else {
				map.put("isQuiz","false");
			}
			System.out.println("BaordService : insertExpression :==========");
			System.out.println(map);
			status1 = cbDao.insertExpression(map);
			if(status1 > 0){
			/*문제의 SEQ_NO를 조회 한다음*/
				map.put("seqNo", cbDao.retrieveRecentSeqNo(map));
				/*추천수 정보 등록*/
				cbDao.insertRecommend(map);
				/*파일 있으면 파일 업로드*/
				if(mRequest.getFileNames().hasNext()){
					util.fileUpload(map, mRequest);
				} else {
				/*파일 없을때*/
				}
			/*포인트 넣어주고*/
				map.put("point", 50);
				map.put("activity", "202");
				map.put("sourceSeqNo", map.get("seqNo"));
				cbDao.insertPointCount(map);
			}
			int ansNum = 1;
			/* 정답 테이블에 넣는다. */
			String[] contents = (String[]) map.get("contents");
			String[] ansCodes = (String[]) map.get("ansCodes");
			for (int i = 0; i <contents.length; i++ ){
				map.put("ansNum", ansNum);
				if(!contents[i].equals("")){
					map.put("content", contents[i]);
					map.put("ansCode", ansCodes[i]);
					cbDao.insertQuizAns(map);
					ansNum++;
				} else {
					break;
				}
			}
//			for (String content : (String[]) map.get("contents")) {
//				if(!content.trim().equals("")) {
//					map.put("ansNum", ansNum);
//					map.put("content", content);
//					cbDao.insertQuizAns(map);
//					ansNum++;
//				}
//			}
			/* SQLException에 대해 Transaction 처리 해준다.*/
		} catch (Exception e){
			e.printStackTrace();
			/* RuntimeException쓰면 인자없는 @Transactional 쓸 수 있다. */
			throw new RuntimeException(e);
		} 
		
		int flag = 0;
		if( status1 > 0 ) {
			/*정답 게시판에 등록 성공 여부에 따라 다른 결과메세지를 리턴한다.*/
			for(int i= 0 ; i<status2.size(); i++){
				if(!status2.get(i).toString().equals("1")){
					flag++;
				}
			}
			if(flag==0){
				returnMap.put("code", 200);
				returnMap.put("msg", "Succeed in Posting and Replying");
				returnMap.put("url", "./dailyExpressionForm.do");
			} else {
				returnMap.put("code", 201);
				returnMap.put("msg", "Succeed in Posting, but Failed in Replying");
			}
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed in Replying, please contact to homepage");
		}
		return returnMap;
	}
	
	public Map<String, Object> retrieveExpression(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		System.out.println("service retrieveExpression map: " + map);
		//페이징 처리
		String pageNum 	= (String) map.get("pageNum");
		int pageSize	= Integer.parseInt((String)map.get("pageSize"));
		int pageBlock	= 5;
		int count 		= cbDao.getBoardArticleCount();
		
		Page.getInstance().paging(Integer.parseInt(pageNum), count, pageSize, pageBlock);
		map.put("startRow", Page.getInstance().getStartRow());
//		map.put("endRow", Page.getInstance().getEndRow());
		System.out.println("ser retrieveExpression startRow endRow: " + map.get("startRow") +" / " + map.get("endRow"));
		/* 게시글이 있을 경우에만 List 반환*/
		List<Map<String, Object>> list = null;
		if(count > 0){
			list = cbDao.retrieveExpression(map);
		} else {
			list = null;
		}
		
		List<Map<String, Object>> ansList = cbDao.retrieveAnswer(map);
		List<Map<String, Object>> fileList = cbDao.retrieveAtchFile(map);
		List<Map<String, Object>> recommendList = cbDao.retrieveRecommendCount(map);
		
		
		if(list != null && list.size()>0){
			returnMap.put("code", 200);
			returnMap.put("msg", "Succeed in Retrieving Daily Expression");
			returnMap.put("dailyExpressionList", list);
			returnMap.put("dailyAnswerList", ansList);
			returnMap.put("dailyFileList", fileList);
			returnMap.put("dailyrecommendList", recommendList);
			returnMap.put("imagePath", util.getWebAppPath()+"resources/images/");
			System.out.println("service retrieveExpression list: " + list);
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed in Retrieving Daily Expression");
		}
		
		return returnMap;
	}
	public Map<String, Object> retrieveMyExpression(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int pageSize = 16;
		String year = (String) map.get("Year");
		String month = (String) map.get("Month");
		String date = (String) map.get("Date");
		
		if(date.length() < 2) {
			date = "0" + date;
		}
		if(month.length() < 2) {
			month = "0" + month;
		}
		
		map.put("activityDate", year+month+date);
		map.put("pageSize", pageSize);
		System.out.println("service retrieveExpression map: " + map);
		List<Map<String, Object>> list = cbDao.retrieveExpression(map);
		List<Map<String, Object>> ansList = cbDao.retrieveAnswer(map);
		List<Map<String, Object>> fileList = cbDao.retrieveAtchFile(map);
		List<Map<String, Object>> recommendList = cbDao.retrieveRecommendCount(map);
		List<Map<String, Object>> mylist = cbDao.retrieveMyQuiz(map);
		
		System.out.println("My List :" + mylist);
		
		if(list != null && list.size()>0){
			returnMap.put("code", 200);
			returnMap.put("msg", "Succeed in Retrieving Daily Expression");
			returnMap.put("dailyExpressionList", list);
			returnMap.put("dailyAnswerList", ansList);
			returnMap.put("dailyFileList", fileList);
			returnMap.put("dailyrecommendList", recommendList);
			returnMap.put("imagePath", util.getWebAppPath()+"resources/images/");
			returnMap.put("mylist", mylist);
			System.out.println("service retrieveExpression returnMap: " + returnMap);
			System.out.println("service retrieveExpression list: " + list);
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed in Retrieving Daily Expression");
		}
		
		System.out.println("RetrieveExpression List ReturnMap :  " + returnMap);
		return returnMap;
	}
	
//	public Map<String, Object> retrieveMyQuiz(Map<String, Object> map) {
//		Map<String, Object> returnMap = new HashMap<String, Object>();
//		String year = (String) map.get("Year");
//		String month = (String) map.get("Month");
//		String date = (String) map.get("Date");
//		
//		if(date.length() < 2) {
//			date = "0" + date;
//		}
//		if(month.length() < 2) {
//			month = "0" + month;
//		}
//		
//		map.put("activityDate", year+month+date);
//		
////		if(month.length() < 2) {
////			
////			if(date.length() < 2) {
////				map.put("activityDate", year+0+month+0+date);
////			} else {
////				map.put("activityDate", year+0+month+date);
////			}
////		} else {
////			if(date.length() < 2) {
////				map.put("activityDate", year+month+0+date);
////			} else {
////				map.put("activityDate", year+month+date);
////			}
////		}
//		
//		System.out.println("MyQuiz Map :" + map);
//		
//		List<Map<String, Object>> list = cbDao.retrieveMyQuiz(map);
//		System.out.println("Service MyQuiz List :" + list);
//		returnMap.put("list", list);
//		return returnMap;
//	}
	
	public Map<String, Object> scoreBoard(Map<String, Object> map) {
		
		System.out.println("ScoreBoard Service Map :" + map);
		
		
		return null;
	}
	
	public List<Map<String, Object>> getCalendar(Map<String, Object> map) {
		Map<String, Object> ReturnMap = new HashMap<String, Object>();

		Calendar cal = Calendar.getInstance();
		String tempYear 	="";
		String tempMonth 	="";
		/*초기에 불러올때 대비, 현재 년 월을 조회 한다.*/
		if(map.get("year")!=null && !map.get("year").toString().equals("")){
			tempYear 	= (String) map.get("year");
		} else {
			tempYear = ""+cal.get(Calendar.YEAR);
		}
		if(map.get("month")!=null && !map.get("month").toString().equals("")){
			tempMonth 	= (String) map.get("month");
		} else {
			tempMonth = ""+(cal.get(Calendar.MONTH)+1);
		}
		
		if(tempYear != null && !tempYear.equals("")){
			cal.set(Integer.parseInt(tempYear), Integer.parseInt(tempMonth)-1, 1);
			// JSP view에서 실제 월로 저장되어 있으므로, calendar에서는 인덱스로 저장되어 있다.
			// 첫날로 세팅
		}
		
		/* 마지막 날짜 필요 for 그달 날짜 계산 위해,
		 * 
		 * 현재 월의 마지막 날짜를 만드는 방법*/
		cal.add(Calendar.MONTH, 1);
		cal.add(Calendar.DATE, -1);
		
		int year 		= cal.get(Calendar.YEAR);
		int month 		= cal.get(Calendar.MONTH);
		int lastDate 	= cal.get(Calendar.DATE);
		int week 		= 0;
		
		/* 그 달의 날짜를 다 담는다. */
		List<Map<String, Object>> dateList = new ArrayList<Map<String, Object>>();
		Map<String, Object> dateMap = null;
		for (int i = 1; i <= lastDate; i++) {
			dateMap = new HashMap<String, Object>();
			
			cal.set(year, month, i);
			
			dateMap.put("date", i);
			dateMap.put("week", cal.get(Calendar.DAY_OF_WEEK));
			dateMap.put("lastDate", lastDate);	//view에서 forEach돌려야 하므로 마지막 날짜 필요

			
			/*이번달 */
			dateMap.put("thisYear", year);/* 판별 필요!! year와 month를 넣을 필요가 있는가?? */
			dateMap.put("thisMonth", (month+1));
			
			/*저번달 */
			cal.add(Calendar.MONTH, -1);
			dateMap.put("prevYear", cal.get(Calendar.YEAR));
			dateMap.put("prevMonth", (cal.get(Calendar.MONTH) + 1));

			/*다음달 */
			cal.add(Calendar.MONTH, 2);
			dateMap.put("nextYear", cal.get(Calendar.YEAR));
			dateMap.put("nextMonth", (cal.get(Calendar.MONTH) + 1));
			
			System.out.println("Calendar Service dateList : " + dateMap);
			
			dateList.add(dateMap);
			
			
			List<Map<String, Object>> pointList = new ArrayList<Map<String,Object>>();
			map.put("activityDate", year +"/" + (month +1) + "/" + i);
			System.out.println("cal servcie------"+map.get("activityDate"));
			pointList = cbDao.retrievePoint(map);
			dateMap.put("point", pointList);
			
			
		}
		
		ObjectMapper om = new ObjectMapper();
		try {
			String json = om.writeValueAsString(dateList);
			System.out.println("Object Mapper Json: " + json);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
//		for (Map<String, Object> temp : dateList) {
//			System.out.println(year +"년 "+ (month+1)+"월 "+ temp.get("date")+"일 "+ temp.get("week") + "요일");
//			
//		}
//		
		return dateList;
	}
	
	
	public Map<String, Object> getQuizData(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> dataList = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> ansList = null;
		dataList = cbDao.retrieveQuizData(map);
		for(int i = 0 ; i < dataList.size() ; i++ ){
			ansList = new ArrayList<Map<String,Object>>();
			map.put("qSeqNo", dataList.get(i).get("SEQ_NO"));
			ansList = cbDao.retrieveAnswer(map);
			dataList.get(i).put("ansList", ansList);
		}
		returnMap.put("dataList", dataList);
		return returnMap;
	}
	public Map<String, Object> updateRecommend(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("sourceSeqNo", (String) map.get("seqNo"));
		if(map.get("value") != null && map.get("value").equals("up")){
			map.put("activity", "204");
		} else {
			map.put("activity", "205");
		}
		//자기 추천 방지
		List<Map<String, Object>> list2 = cbDao.isSelfRecommend(map);
		for (Map<String, Object> tempMap : list2) {
			String retrievedSEQ_NO = tempMap.get("SEQ_NO").toString();
			String mapSeqNo = map.get("sourceSeqNo").toString();
//			System.out.println("ser updaterecommend : " + retrievedSEQ_NO + "/ " + mapSeqNo);
			if(retrievedSEQ_NO.equals(mapSeqNo)){
				returnMap.put("code", 301);
				returnMap.put("msg", "Not allowed to recommend articles written by yourself.");
				return returnMap;
			}
		}
		
		//중복 추천/비추천 방지
		List<Map<String, Object>> list = cbDao.retriveArticleStateByActivity(map);
		for (Map<String, Object> tempMap : list) {
			String retrievedSEQ_NO = tempMap.get("SEQ_NO").toString();
			String mapSeqNo = map.get("sourceSeqNo").toString();
			
			if(retrievedSEQ_NO.equals(mapSeqNo)){
				returnMap.put("code", 301);
				returnMap.put("msg", "You've already done once.");
				return returnMap;
			}
		}
		
		System.out.println("ser updateRecommend :"+list);
		
		int state = cbDao.updateRecommend(map);
		List<Map<String, Object>> recommendList = cbDao.retrieveRecommendCount(map);
		
		if(state>0){
			returnMap.put("code", 200);
			returnMap.put("msg", "You've successfully recommended.");
			returnMap.put("dailyrecommendList", recommendList);
			//활동 등록 시작----------
			int stateAct =cbDao.insertPointCount(map);	//활동등록
			//활동 등록 끝----------
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "You failed to recommend.");
		}
		return returnMap;
	}
	
	public Map<String, Object> scoreCalculate(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int score = cbDao.insertPointCount(map);
		
		if (score > 0) {
			returnMap.put("msg", "You've successfully scored points");
		} else {
			returnMap.put("msg", "You've failed in scoring points");
		}
		
		return returnMap;
	}
	
	public Map<String, Object> getJSONCalendarData(Map<String, Object> map){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		long curTime = System.currentTimeMillis();
		Date curDate = new Date(curTime);
		returnMap.put("curDate", util.getUTCTime(curDate));
		
		return returnMap;
	}
	
	
}
