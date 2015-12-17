package com.learning.eng.test;

import static org.junit.Assert.fail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.learning.eng.client.service.ClientBoardService;
import com.learning.eng.client.service.FullCalendarBoardService;
import com.learning.eng.common.Util;
import com.learning.eng.dao.ClientBoardDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations = {
		 "classpath:client-context.xml"
		,"classpath:root-context.xml"
		,"classpath:dao-context.xml"
})
public class ServiceTest {
	@Autowired
	ClientBoardDao cbDao;
	@Autowired
	ClientBoardService cbService;
	@Autowired
	FullCalendarBoardService fService;
	@Autowired
	Util utilTest;
	
	@Test
	public void test() {
		fail("Not yet implemented");
	}

	@Test
	public void Quiztest(){
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("codeNo", "");
		returnMap = cbService.getQuizData(map);
		System.out.println(returnMap);
		
	}
	
	@Test
	public void updateRrecommendTest(){
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("value", "up");
		map.put("seqNo", "49");
		map.put("codeNo", "103");
		cbService.updateRecommend(map);
		System.out.println(returnMap);
	}
	
	@Test
	public void retriveCalendarEvent(){
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		map.put("id", "1");
		map.put("activity", "208");
		list = cbDao.retriveArticleStateByActivity(map);
		
		for (Map<String, Object> TempMap : list) {
			String tempString =	TempMap.get("BOARD_CRE_DATE").toString().replace(" ", "T");
			tempString = tempString.substring(0, tempString.lastIndexOf("."));
			TempMap.put("start", tempString);
			TempMap.put("title", TempMap.get("BOARD_TITLE"));
			TempMap.remove("BOARD_CRE_DATE");
			TempMap.remove("BOARD_TITLE");
		}
		returnMap.put("calList", list);
		System.out.println(returnMap);
	}
	
	
	@Test
	public void getfullCalendar(){
		Map<String, Object> map = new HashMap<String,Object>();
		Map<String, Object> returnMap = new HashMap<String,Object>();
		map.put("id", "1");
		returnMap.put("list", fService.retriveCalendarEvent(map));
		System.out.println(returnMap);
	}
	
}
