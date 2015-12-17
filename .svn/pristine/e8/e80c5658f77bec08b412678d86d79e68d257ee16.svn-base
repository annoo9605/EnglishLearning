package com.learning.eng.client.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.learning.eng.common.Util;
import com.learning.eng.dao.ClientBoardDao;


@Service
public class FullCalendarBoardService {
	@Autowired
	ClientBoardDao cbDao;
	@Autowired
	Util util;
	
	public Map<String, Object> retriveCalendarEvent(Map<String, Object> map){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		map.put("activity", "208");
		list = cbDao.retriveArticleStateByActivity(map);
		System.out.println("ser retriveCalendarEvent : " + map);
		for (Map<String, Object> TempMap : list) {
			String tempString =	TempMap.get("BOARD_CRE_DATE").toString().replace(" ", "T");
			tempString = tempString.substring(0, tempString.lastIndexOf("."));
			TempMap.put("start", tempString);
			TempMap.put("title", TempMap.get("BOARD_TITLE"));
			TempMap.remove("BOARD_CRE_DATE");
			TempMap.remove("BOARD_TITLE");
			TempMap.put("color", "#0064B5");
			TempMap.put("textColor", "white");
		}
		returnMap.put("calList", list);
		System.out.println("serv retriveCalendarEvent: " + list);
		return returnMap;
	}
	
	public Map<String, Object> retriveCalendarEventWrongAns(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		list = cbDao.retriveWrongAnsActivity(map);
		System.out.println("ser retriveCalendarEventWrongAns : " + map);
		for (Map<String, Object> TempMap : list) {
			String tempString =	TempMap.get("BOARD_CRE_DATE").toString().replace(" ", "T");
			tempString = tempString.substring(0, tempString.lastIndexOf("."));
			TempMap.put("start", tempString);
			TempMap.put("title", TempMap.get("BOARD_TITLE"));
			TempMap.remove("BOARD_CRE_DATE");
			TempMap.remove("BOARD_TITLE");
			TempMap.put("color", "#C52D2F");
			TempMap.put("textColor", "white");
		}
		returnMap.put("wrongList", list);
		System.out.println("serv retriveCalendarEventWrongAns: " + list);
		return returnMap;
	}
	
	
	public List<Map<String, Object>> retrieveBoardInCalendar(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = cbDao.retrieveBoardAnsFromSeqNo(map);
		
		System.out.println(list);
		return list;
	}

	public Map<String, Object> countUpArticle(Map<String, Object> map) {
		 Map<String, Object> returnMap = new HashMap<String, Object>();
		 map.put("activity", "208");
		 map.put("seqNo", (String) map.get("sourceSeqNo"));
		 map.put("boardHit", "Y");
		 int status1 = cbDao.insertPointCount(map);
		 int status2 = cbDao.updateBoard(map);
		 
		 if(status1 > 0 ){
			 returnMap.put("code", 200);
			if(status2> 0){
				returnMap.put("code", 200);
				returnMap.put("msg", "Succeed in Calendaring and Counting");
			}
			returnMap.put("msg", "Succeed in Calendaring but Failed in Counting");
		 } else {
			 returnMap.put("code", 300);
			 returnMap.put("msg", "Failed in Calendaring and Counting");
		 }
		 
		return returnMap;
	}


	
}
