package com.learning.eng.client.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.learning.eng.client.service.ClientMemberService;

@Controller
public class ClientMainController {

	@Autowired
	ClientMemberService ms;

	@RequestMapping(value="index.do")
	public String main(
			@CookieValue(value="cookie", required=false) String cookie, 
			@CookieValue(value="id", required=false) String id, 
			HttpSession session){
		System.out.println("main con cookie : " + cookie);
		System.out.println("session id check : " + session.getAttribute("id"));
		
		if(cookie != null && !cookie.equals("")) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cookie", cookie);
			System.out.println("cookie 실행됨");
			Map<String, Object> resultMap = ms.cookie(map);
			
			if(resultMap != null && resultMap.size() > 0) {
				session.setAttribute("id", resultMap.get("id"));
			}
		} 
		
		
		return "client/index";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value="404.do", method= RequestMethod.GET)
	public String error404(){
		return "client/template/404";
	}
	
	@RequestMapping(value="about-us.do", method= RequestMethod.GET)
	public String aboutUs(){
		return "client/template/about-us";
	}
	@RequestMapping(value="blog-item.do", method= RequestMethod.GET)
	public String blogItem(){
		return "client/template/blog-item";
	}
	@RequestMapping(value="blog.do", method= RequestMethod.GET)
	public String blog(){
		return "client/template/blog";
	}
	@RequestMapping(value="contact-us.do", method= RequestMethod.GET)
	public String contactUs(){
		return "client/template/contact-us";
	}
	@RequestMapping(value="portfolio.do", method= RequestMethod.GET)
	public String portfolio(){
		return "client/template/portfolio";
	}
	@RequestMapping(value="pricing.do", method= RequestMethod.GET)
	public String pricing(){
		return "client/template/pricing";
	}
	@RequestMapping(value="services.do", method= RequestMethod.GET)
	public String services(){
		return "client/template/services";
	}
	@RequestMapping(value="shortcodes.do", method= RequestMethod.GET)
	public String shortcodes(){
		return "client/template/shortcodes";
	}
	
	
	
	
	
}
