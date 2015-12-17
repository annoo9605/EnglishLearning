package com.learning.eng.client.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.learning.eng.client.service.ClientBoardService;
import com.learning.eng.client.service.StudyBoardService;

@Controller
public class StudyBoardController {
	 @Autowired
	 StudyBoardService ss;
	@Autowired
	ClientBoardService cbService;
	 
//	스터디 게시판 수정 폼
	@RequestMapping(value="studyBoardUpdate.do", method=RequestMethod.GET)
	public ModelAndView BoardUpdateForm(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("client/studyBoardUpdate");
		return mav;
		
	}
	@RequestMapping(value="studyBoardUpdate", method=RequestMethod.POST)
	public ModelAndView BoardUpdate(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(ss.boardList(map));
		mav.setViewName("client/studyBoardList");
		return mav;
		
	}
	
	
//	public ModelAndView 
	 //스터디 게시판 리스트 폼
	@RequestMapping(value="studyBoardList.do", method=RequestMethod.GET)
	public ModelAndView boardList(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("StudyBoardList Controller Map : " + map);
		mav.addAllObjects(ss.boardList(map));
		mav.setViewName("client/studyBoardList");
		return mav;
	}
	@RequestMapping(value="studyBoardList.do", method=RequestMethod.POST)
	public ModelAndView boardListpost(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("StudyBoardList Controller Map : " + map);
		mav.addAllObjects(ss.boardList(map));
		mav.setViewName("client/studyBoardList");
		return mav;
	}
	
	@RequestMapping(value="studySearch.do", method=RequestMethod.POST)
	public ModelAndView search(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> resultMap = ss.searchList(map);
		
		System.out.println("Study Search Map" + map);
		System.out.println("Study Search Controller ResultMap" + resultMap); 
		
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="studySearchList.do")
	public ModelAndView searchList(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("Study Search Detail Controller Map" + map);
		Map<String, Object> resultMap = ss.searchList(map);
		System.out.println("Study Search Detail Controller resultMap" + resultMap);
		
		mav.addAllObjects(resultMap);
		mav.setViewName("client/searchList_study");
		
		return mav;
	}
	
	//스터디 게시판 글쓰기 폼
	@RequestMapping(value="studyBoardWrite.do", method=RequestMethod.GET)
	public String addArticleForm() {
		
		return "client/studyBoardWrite";
	}
	
	//스터디 게시판 글쓰기 입력
	@RequestMapping(value="studyBoardWrite.do", method=RequestMethod.POST)
	public ModelAndView addArticle(MultipartHttpServletRequest mRequest,
			@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("Free Map JSP: " + map);
		
		String id = (String) session.getAttribute("id");
		
		map.put("id", id);
		
		mav.addAllObjects(ss.addArticle(map, mRequest));
		
		System.out.println("Controller Mav :" + mav);
		mav.setViewName("JSON");
		
		return mav;
	}

	//스터디 게시판 상세보기
	@RequestMapping(value="studyBoardDetail.do")
	public ModelAndView retrieve(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> resultMapDet = new HashMap<String, Object>();
//		Map<String, Object> resultMapCom = new HashMap<String, Object>();
		
		resultMapDet = ss.retrieve(map);
//		resultMapCom = ;
		System.out.println("Detail Map :" + map);
		System.out.println("Detail Controller : " + resultMapDet);
		
		Map<String, Object> listMap = ss.listComment(map);
		System.out.println("Comment controller ListMap: " + listMap);
		mav.addAllObjects(listMap);
		
		mav.addAllObjects(resultMapDet);
//		mav.addAllObjects(resultMapCom);
		mav.setViewName("client/studyBoardDetail"); 
		return mav;
	}
	
	//스터디 게시판 게시글 삭제
	@RequestMapping(value="studyDelete.do")
	public ModelAndView deleteArticle(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("delete map : " + map);
		
		Map<String, Object> resultMap = ss.delete(map);
		
		System.out.println("DEl resultMap : " + resultMap);
		
		mav.addObject(resultMap);
		mav.setViewName("JSON");
		
		return mav;
	}
	
//	//스터디 게시판 캘린더
//	@RequestMapping(value="studyBoardCalendarForm.do", method= RequestMethod.GET)
//	public ModelAndView studyCalendarForm(@RequestParam Map<String,Object> map, HttpSession session){
//		ModelAndView mav = new ModelAndView();
//		map.put("id", session.getAttribute("id"));
//		mav.addAllObjects(ss.retrieveStudyCalendar(map));//키 없이 넘기면 list인 경우 hashMapList로 받는다.
////		mav.setViewName("JSON");
//		mav.setViewName("client/study/studyBoardCalendarForm");
//		return mav;
//	}
	
	//스터디 게시판 캘린더
	@RequestMapping(value="studyBoardCalendar.do", method=RequestMethod.GET)
	public ModelAndView studyCalendar(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		String id = (String) session.getAttribute("id");
		map.put("id", id);
		System.out.println("Calendar Controller Id : " + id);
		mav.addObject("dateList", ss.getCalendar(map));
		mav.setViewName("client/studyBoardCalendarForm");
//		mav.setViewName("JSON");
		
		return mav;
	}
}
