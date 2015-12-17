package com.learning.eng.client.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.learning.eng.client.service.ClientMemberService;

@Controller
public class ClientMemberController {
	@Autowired
	ClientMemberService ms;
	
	@RequestMapping(value="joinForm.do", method=RequestMethod.GET)
	public ModelAndView joinForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("client/joinForm");
		
		return mav;
	}
	
	@RequestMapping(value="join.do", method=RequestMethod.POST)
	public ModelAndView join(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView();
		
		
		mav.addAllObjects(ms.insertMember(map));
		System.out.println("Controller : " + mav);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="retrieveId.do", method=RequestMethod.POST)
	public ModelAndView retrieveId(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(ms.retrieveMember(map));
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="loginForm.do", method=RequestMethod.GET)
	public String loginForm() {
		
		return "client/loginForm";
	}
	
	@RequestMapping(value="loginCheck.do", method=RequestMethod.GET)
	public ModelAndView loginForm(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String status = "";
		
		System.out.println("session id : " + session.getAttribute("id"));
		
		if (session.getAttribute("id") != null){
			status = "200";
		} else if(session.getAttribute("id")==null || session.getAttribute("id").toString().equals("")) {
			status = "400";
		}
		
		mav.addObject("status", status);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, Object> map, HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("login Con Map :" + map);
		resultMap = ms.login(map);
		session.setAttribute("id", resultMap.get("id"));
		mav.addAllObjects(resultMap);
		System.out.println("login Con ResultMap : " + resultMap);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="facebookLogin.do")
	public ModelAndView fbLogin(@RequestParam Map<String, Object> map,
			HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		ModelAndView mav = new ModelAndView(); 
		session.setAttribute("id", map.get("id"));
		session.setAttribute("name", map.get("name"));
		System.out.println("FB Map id :" + map.get("id"));
		Map<String, Object> resultMap = ms.fbLogin(map);
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="ktLogin.do")
	public ModelAndView ktLogin(@RequestParam Map<String, Object> map,
			HttpSession session) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		ModelAndView mav = new ModelAndView();
		session.setAttribute("id", map.get("id"));
		session.setAttribute("nickname", map.get("nickname"));
		System.out.println("Kt id:" + map.get("id"));
		System.out.println("Kt nickname:" + map.get("nickname"));
		Map<String, Object> resultMap = ms.ktLogin(map);
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		return mav;
	}
	
	@RequestMapping(value="logout.do", method=RequestMethod.GET)
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("client/index");
		
		return mav;
	}
	
	@RequestMapping(value="findId.do", method=RequestMethod.GET)
	public String findIdForm() {
		
		return "client/findId";
	}
	
	
	@RequestMapping(value="findCode.do", method=RequestMethod.POST)
	public ModelAndView findId(@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> resultMap = ms.findCode(map);
		
		session.setAttribute("findId", resultMap.get("id"));
		session.setAttribute("findPw", resultMap.get("pw"));
		System.out.println("Session ID : " + resultMap.get("id"));
		System.out.println("Session PW : " + resultMap.get("pw"));
		
		System.out.println("Member Controller resultMap: " + resultMap);
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="sendEmail", method=RequestMethod.POST)
	public ModelAndView sendQuizEmail(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		System.out.println("SendEmail Controller Map :" + map);
		mav.addAllObjects(ms.sendQuizEmail(map));
		mav.setViewName("client/quizForm");
		return mav;
	}
			
	
	@RequestMapping(value="approveId.do", method=RequestMethod.POST)
	public ModelAndView approveId(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("Controller : " + map);
		
		Map<String, Object> resultMap = ms.approveId(map);
		
		System.out.println("ResultMap Controller: " + resultMap);
//		
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		return mav;
		
	}
	
	@RequestMapping(value="appId.do", method=RequestMethod.GET)
	public ModelAndView appId(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();

		System.out.println("Session get: " + session.getAttribute("findId"));
		mav.addObject(session.getAttribute("findId"));
		mav.setViewName("client/appId");
		
		return mav;
	}
	
	@RequestMapping(value="findPw.do", method=RequestMethod.GET)
	public String findPwForm() {
		
		return "client/findPw";
	}
	
	@RequestMapping(value="appPw.do", method=RequestMethod.GET)
	public ModelAndView appPw(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("appPw session pw : " + session.getAttribute("findPw"));
		mav.addObject(session.getAttribute("findPw"));
		mav.setViewName("client/appPw");
		
		return mav;
	}
	
	@RequestMapping(value="cookie.do")
	public ModelAndView cookie(@RequestParam Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("RequestParam Cookie Map: " + map);
		
		Map<String, Object> resultMap = ms.cookie(map);
		System.out.println("cookie id: " + resultMap.get("id"));
		
		session.setAttribute("id", resultMap.get("id"));
		
		System.out.println("Cookie session id :" + session.getAttribute("id"));
		
		mav.addAllObjects(map);
		mav.addAllObjects(resultMap);
		mav.setViewName("JSON");
		
		return mav;
	}
	
	@RequestMapping(value="modifyMemberForm.do", method= RequestMethod.GET)
	public ModelAndView modifyMemberForm(HttpSession session){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(ms.retrieveMemberInfo(session));
		mav.setViewName("client/modifyMemberForm");// 명령어에 대해 redirect해야 한다.
		return mav;
	}

	@RequestMapping(value="modifyMember.do", method= RequestMethod.POST)
	public ModelAndView modifyMember(@RequestParam Map<String,Object> map){
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(ms.updateMemberInfo(map));
		mav.setViewName("JSON");
		return mav;
	}
}
