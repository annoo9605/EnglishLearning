package com.learning.eng.client.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.learning.eng.client.service.ClientBoardService;
import com.learning.eng.client.service.FullCalendarBoardService;


@Controller
public class ClientBoardController {
	
	@Autowired
	ClientBoardService cbService;
	@Autowired
	FullCalendarBoardService fService;
	
	@RequestMapping(value="retrieveMemberPoint.do", method= RequestMethod.GET)
	public ModelAndView retrieveMemberPointForm(@RequestParam Map<String,Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		System.out.print("controller : retrieveMemberPoint.do :");
		System.out.println(map);
		mav.addAllObjects(cbService.retrieveMemberPoint(map));//키 없이 넘기면 list인 경우 hashMapList로 받는다.
		mav.setViewName("client/retrievePointForm");
		return mav;
	}
	
	@RequestMapping(value="retrieveMemberPoint.do", method= RequestMethod.POST)
	public ModelAndView retrieveMemberPoint(@RequestParam Map<String,Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		System.out.print("controller : retrieveMemberPoint.do :");
		System.out.println(map);
		mav.addAllObjects(cbService.retrieveMemberPoint(map));//키 없이 넘기면 list인 경우 hashMapList로 받는다.
//		mav.setViewName("JSON");
		mav.setViewName("client/retrievePointForm");
		return mav;
	}
	
	
	
	@RequestMapping(value="studyCalendarForm.do", method= RequestMethod.GET)
	public ModelAndView studyCalendarForm(@RequestParam Map<String,Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		mav.addAllObjects(cbService.retrieveStudyCalendar(map));//키 없이 넘기면 list인 경우 hashMapList로 받는다.
//		mav.setViewName("JSON");
		mav.setViewName("client/studyCalendarForm");
		return mav;
	}
	
	@RequestMapping(value="dailyExpressionForm.do", method= RequestMethod.GET)
	public ModelAndView quizForm(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		map.put("pageNum", "1");
		map.put("pageSize", "16");
		mav.addAllObjects(cbService.retrieveExpression(map));
//		mav.setViewName("JSON");
		mav.setViewName("client/dailyExpressionForm");
		return mav;
	}
	
	@RequestMapping(value="insertExpression.do", method= RequestMethod.POST)
	public ModelAndView insertQuiz(@RequestParam Map<String, Object> map, HttpSession session,
			HttpServletRequest request, MultipartHttpServletRequest mRequest){
		// name을 같은값으로 주면 맵으로 받아오면 동일한 키 값이므로 겹쳐지짐나,
		// HttpServletRequest를 써서 parameter로 받아오면 content=1, content=1, content=1, content=1,...이렇게 들어온다.
		// parameter로 받은것을 attribute로 넘기면 된다.
		System.out.println("controller insertQuiz pre: " + map);
		String[] contents = request.getParameterValues("content");
		String[] ansCodes = request.getParameterValues("ansCode");
		map.put("contents", contents);
		map.put("ansCodes", ansCodes);
		
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		System.out.println("controller insertQuiz : " + map);
		mav.addAllObjects(cbService.insertExpression(map, mRequest));
		mav.setViewName("JSON");
//		mav.setViewName("client/dailyExpressionForm");
		return mav;
	}
	
	@RequestMapping(value="retrieveDailyExpression.do", method=RequestMethod.GET)
	public ModelAndView retrieveDailyExpression(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		
		mav.addAllObjects(cbService.retrieveExpression(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="studyCalendar.do", method=RequestMethod.GET)
	public ModelAndView studyCalendar(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		mav.addObject("dateList", cbService.getCalendar(map));
		String id = (String) session.getAttribute("id");
		map.put("id", id);
		mav.setViewName("client/studyCalendarForm");
//		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="quiz.do", method=RequestMethod.GET)
	public ModelAndView quizForm(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(cbService.getQuizData(map));
		mav.setViewName("client/quizForm");
//		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="scoreBoard.do")
	public ModelAndView scoreBoard(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		mav.addAllObjects(cbService.scoreBoard(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="recommendArticle.do", method=RequestMethod.POST)
	public ModelAndView recommend(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		System.out.println("con recommend : " +  map);
		map.put("id", session.getAttribute("id"));
		mav.addAllObjects(cbService.updateRecommend(map));
		mav.setViewName("JSON");
		return mav;
	}
	@RequestMapping(value="fullCalendar.do", method=RequestMethod.GET)
	public ModelAndView fullCalendarForm(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		System.out.println("con fullCalendarForm : " +  map);
		mav.addObject("dateList", cbService.getCalendar(map));
//		mav.setViewName("JSON");
		mav.setViewName("client/fullCalendarForm");
		return mav;
	}
	@RequestMapping(value="getfullCalendar.do", method=RequestMethod.GET)
	public ModelAndView getfullCalendar(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		mav.addAllObjects(fService.retriveCalendarEvent(map));	//calList
		mav.setViewName("JSON");
		return mav;
	}
	@RequestMapping(value="getfullCalendarWrongAns.do", method=RequestMethod.GET)
	public ModelAndView getfullCalendarWrongAns(@RequestParam Map<String, Object> map, HttpSession session){
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		mav.addAllObjects(fService.retriveCalendarEventWrongAns(map));	//calList
		mav.setViewName("JSON");
		return mav;
	}
			
	@RequestMapping(value="fullCalendar.do", method=RequestMethod.POST)
	public ModelAndView fullCalendar(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		System.out.println("con fullCalendarForm : " +  map);
//		mav.addObject("dateList", cbService.getCalendar(map));
		mav.addAllObjects(fService.retriveCalendarEvent(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="quizScore.do")
	public ModelAndView scoreCalculate(@RequestParam Map<String, Object> map, 
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		// annoo 
		// quiz 풀때 id없이도 가능하기 위해서 id를 nullable로 수정
		
		String id = (String) session.getAttribute("id");
		if (id!= null && id.equals("")) {
			map.put("id", id);
		}
		
//		map.put("point", value)
		System.out.println("quizScore Map : " + map);
		
		Map<String, Object> resultMap = cbService.scoreCalculate(map);
		mav.addAllObjects(resultMap);
		System.out.println("quiz Controller resultMap : " + resultMap);
		mav.setViewName("client/quizForm");
		return mav;
	}
	
	@RequestMapping(value="retrieveBoard.do")
	public ModelAndView retrieveBoard(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		mav.addObject("ansList", fService.retrieveBoardInCalendar(map));
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="countUpArticle.do")
	public ModelAndView countUpArticle(@RequestParam Map<String, Object> map,  HttpSession session){
		ModelAndView mav = new ModelAndView();
		map.put("id", session.getAttribute("id"));
		mav.addAllObjects(fService.countUpArticle(map));
		mav.setViewName("JSON");
		return mav;
	}

}
