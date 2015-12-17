package com.learning.eng.client.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.learning.eng.common.Page;
import com.learning.eng.common.Util;
import com.learning.eng.dao.StudyBoardDao;

@Service
public class StudyBoardService {
	@Autowired
	StudyBoardDao sdao;
	@Autowired
	Util util;
	
	
	//스터디 게시판 리스트 //
	public Map<String, Object> boardList(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.println("StudyboardList Service Map: " + map);
		
		String pageNumStr = (String) map.get("pageNum");
		if(pageNumStr == null || pageNumStr.equals("")) {
			pageNumStr = "1";
		}

		int pageNum = Integer.parseInt(pageNumStr);
		
		int pageSize = 10;
		int pageBlock = 10;
		int count =  sdao.countArticle(map);
		
		System.out.println("Count : " + count);
		
		Page.getInstance().paging(pageNum, count, pageSize, pageBlock);
		
		map.put("startRow",  Page.getInstance().getStartRow());
		map.put("endRow", Page.getInstance().getEndRow());
		
		List<Map<String, Object>> list = sdao.boardList(map);
		
		System.out.println("Service BoardList: " + list);
		
		returnMap.put("atchFile", sdao.atchFileDetail(map));
		returnMap.put("list", list);
		returnMap.put("pagingCode", Page.getInstance().getSb().toString());
		returnMap.put("pageNum", pageNum);
		
		System.out.println("Service ReturnMap : " + returnMap);
		
		return returnMap;
	}
	
	//검색기능 미실현
	public Map<String, Object> retrieve(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("detail", sdao.retrieve(map)); 
		List<Map<String, Object>> fileList = sdao.atchFileDetail(map);
		resultMap.put("atchFile", fileList);
		
		System.out.println("fileMap : " + fileList);
		System.out.println("Service Retrieve Map: " + map);
		System.out.println("Service Retrieve : " + resultMap);
		
		return resultMap;
	}
	//커맨드 리스트
public Map<String, Object> listComment(Map<String, Object> map) {
		
		List<Map<String, Object>> resultList = sdao.commentList(map);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("comment", resultList);
		
		return returnMap;
		
	}

//스터디 게시판 글쓰기
@Transactional
public Map<String, Object> addArticle(Map<String, Object> map,
		MultipartHttpServletRequest mRequest) {
	Map<String, Object> returnMap = new HashMap<String, Object>();
	
	System.out.println("Controller map :" + map);
	
	int add = sdao.insertBoard(map);
	
	
	try {
		if(add > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "Succeed in Posting Articles");
			
			if(mRequest.getFileNames().hasNext()) {
				util.fileUpload(map, mRequest);
				System.out.println("Util FileUpload: " + map);
				System.out.println("Util mRequest: " + mRequest);
				returnMap.put("atchFileNo", map.get("atchFileNo"));
			} 
			
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed in Posting Articles");
		}
	} catch (Exception e) {
		e.printStackTrace();
		throw new RuntimeException(e);
	}
	
	System.out.println("Service ReturnMap : " + returnMap);
	

	
	
	return returnMap;
}


	// 스터디 게시판 글 삭제
	public Map<String, Object> delete(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int delete = sdao.delUpdate(map);

		System.out.println("Del Service map :" + map);
		System.out.println("Del Update result int :" + delete);

		if (delete > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "Succeed in Deleting Articles");
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed in Deleting Articles");
		}

		return returnMap;
	}

//스터디 게시판 달력 생성 날짜
	public Map<String, Object> retrieveStudyCalendar(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
//		cbDao.retrieveStudyCalendar(map);
		return returnMap;
	}
	
		Map<String, Object> ReturnMap = new HashMap<String, Object>();
		
		//달력 기능
	public List<Map<String, Object>> getCalendar(Map<String, Object> map) {

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
			
			List<Map<String, Object>> studyList = new ArrayList<Map<String,Object>>();
//			String month1 = month + "";
//			String date1 = i + "";
//			if(month1.length() < 2) {
//				month1 = 0 + month1;
//			}
//			if(date1.length() < 2) {
//				date1  = 0 + date1;
//			}
//			map.put("STUDY_DATE", year + month1 + date1);
			
			map.put("STUDY_DATE", year +"/" + (month +1) + "/" + i);
			System.out.println("Study Date Service Map : " + map);
			studyList = sdao.retrieveStudy(map);
			dateMap.put("studySubject", studyList);
			
			System.out.println("Study subject :" + studyList);
			
			
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
		
//		
		return dateList;
	}
	
	public Map<String, Object> searchList(Map<String, Object> map) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = sdao.searchList(map);
		
		System.out.println("Study Search List " + list);
		System.out.println("Study Search Map " + map);
		
		resultMap.put("searchList", list);
		
		return resultMap;
	}
	
	public Map<String, Object> searchDetail(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println("Study Search Detail Map " + map);
		
		List<Map<String, Object>> list = sdao.searchDetail(map);
		
		resultMap.put("searchList", list);
		
		return resultMap;
	}
}
