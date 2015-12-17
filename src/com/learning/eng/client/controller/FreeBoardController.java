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

import com.learning.eng.client.service.FreeBoardService;

@Controller
public class FreeBoardController {
	@Autowired
	FreeBoardService fs;
	
	
	
	@RequestMapping(value="freeBoardWrite.do", method=RequestMethod.GET)
	public String addArticleForm() {
		
		return "client/freeBoardWrite";
	}
	
	@RequestMapping(value="freeBoardWrite.do", method=RequestMethod.POST)
	public ModelAndView addArticle(MultipartHttpServletRequest mRequest,
			@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("Free Map JSP: " + map);
		
		String id = (String) session.getAttribute("id");
		
		map.put("id", id);
		
		mav.addAllObjects(fs.addArticle(map, mRequest));
		
		System.out.println("Controller Mav :" + mav);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="freeBoardList.do", method=RequestMethod.GET)
	public ModelAndView boardList(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("List Controller Map : " + map);
		
	
		mav.addAllObjects(fs.boardList(map));
		mav.setViewName("client/freeBoardList");
		return mav;
	}
	
	@RequestMapping(value="freeBoardDetail.do")
	public ModelAndView retrieve(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> resultMapDet = new HashMap<String, Object>();
//		Map<String, Object> resultMapCom = new HashMap<String, Object>();
		
		resultMapDet = fs.retrieve(map);
//		resultMapCom = ;
		System.out.println("Detail Map :" + map);
		System.out.println("Detail Controller : " + resultMapDet);

		Map<String, Object> listMap = fs.listComment(map);
		System.out.println("Comment controller ListMap: " + listMap);
		mav.addAllObjects(listMap);

		mav.addAllObjects(resultMapDet);
//		mav.addAllObjects(resultMapCom);
		mav.setViewName("client/freeBoardDetail");
		return mav;
	}
	
	@RequestMapping(value="download.do")
	public ModelAndView download(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("Download Controller Map: " + map);
		mav.addObject("down", fs.downloadFile(map));
		mav.setViewName("DOWNLOAD");
		
		return mav;
	}
	
	@RequestMapping(value="delete.do")
	public ModelAndView deleteArticle(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("delete map : " + map);
		
		Map<String, Object> resultMap = fs.delete(map);
		
		System.out.println("DEl resultMap : " + resultMap);
		
		mav.addObject(resultMap);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="comment.do")
	public ModelAndView insertComment(@RequestParam Map<String, Object>map, 
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String id = (String) session.getAttribute("id");
		System.out.println("Comment Id : " + id);
		
		
		map.put("id", id);
		
		Map<String, Object> resultMap = fs.insertComment(map);
		
		System.out.println("Comment controller : " + resultMap);
		
		mav.addAllObjects(resultMap);

		Map<String, Object> listMap = fs.listComment(map);
		System.out.println("Comment controller ListMap: " + listMap);
		mav.addAllObjects(listMap);
		
		
		mav.setViewName("JSON");
		
		return mav;
		
		
	}

	@RequestMapping(value="getComment.do")
	public ModelAndView getComment(@RequestParam Map<String, Object>map) {
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> listMap = fs.listComment(map);
		System.out.println("Comment controller ListMap: " + listMap);
		mav.addAllObjects(listMap);
		
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="search.do", method=RequestMethod.POST)
	public ModelAndView search(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> resultMap = fs.searchList(map);
		
		System.out.println("Search Map :" + map);
		System.out.println("Search Controller : " + resultMap);
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="searchList.do")
	public ModelAndView searchList(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("Search Map Controller :" + map);
		Map<String, Object> resultMap = fs.searchList(map);
		mav.addAllObjects(resultMap);
		mav.setViewName("client/searchList");
		return mav;
	}
	
	@RequestMapping(value="searchDetail.do", method=RequestMethod.GET)
	public ModelAndView searchDetail(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> resultMap = fs.searchDetail(map);
		mav.addAllObjects(resultMap);
		
		mav.setViewName("client/searchList");
		
		return mav;
	}
	
	
}
