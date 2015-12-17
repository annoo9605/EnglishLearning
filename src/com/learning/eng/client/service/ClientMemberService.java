package com.learning.eng.client.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.learning.eng.common.AES256Util;
import com.learning.eng.common.Mailer;
import com.learning.eng.dao.MemberDao;



@Service
public class ClientMemberService {
	@Autowired
	MemberDao mDao;
	
	@Autowired
	VelocityEngine vEngine;
	
	public Map<String, Object> insertMember(Map<String, Object> map) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		map.put("phoneNum", ""+map.get("phoneNum1")+ "-" + map.get("phoneNum2")+ "-" + map.get("phoneNum3"));
		map.put("id", map.get("id").toString().trim());
		
		int status = mDao.insertMember(map);
		
		if(status > 0) {
			resultMap.put("code", 200);
			resultMap.put("msg", "Welcome to Join In Our Member");
		} else {
			resultMap.put("code", 300);
			resultMap.put("msg", "Failed to Join. Please Try Again");
		}
		System.out.println("Service code: " + resultMap.get("code"));
		return resultMap;
	}

	public Map<String, Object> retrieveMember(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = mDao.retrieveMember(map);
		
		if(list.size()>0) {
//			if(list !=null && list.size()>0) {
			resultMap.put("code", 300);
			resultMap.put("msg", "Not Available ID");
		} else {
			/* list == null && list.size()<=0 */
			resultMap.put("code", 200);
			resultMap.put("msg", "Available ID");
		}
		
		System.out.println("retrieve list: " + list);
		return resultMap;
	}
	
	public Map<String, Object> login(Map<String, Object> map) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = mDao.retrieveMember(map);
		
		if(list != null && list.size()>0) {
			resultMap = list.get(0);
			System.out.println("list.get(0): " + resultMap);
			if (resultMap.get("PW").equals(map.get("pw"))) {
				// 쿠키값 생성
				Random random = new Random();
				int ran = random.nextInt();
				String password = "" + map.get("id") + ran;
				AES256Util aes = AES256Util.getInstance();
				String pa = aes.encrypt(password);
				System.out.println("Cookie random no: " + pa);
				
				returnMap.put("code", 200);
				returnMap.put("id", map.get("id"));
				returnMap.put("msg", "Sign In Succeed");
				returnMap.put("cookie_val", pa);
				System.out.println("map.getid : " + map.get("id"));
				System.out.println("resultmap.getID : " + resultMap.get("ID"));
				
				mDao.updateCookieCode(returnMap);
				
			} else {
				returnMap.put("code", 300);
				returnMap.put("msg", "Wrong Password");
			}
			
		} else {
			returnMap.put("code", 400);
			returnMap.put("msg", "The ID does not exist");
		}
		
		
		System.out.println("Login Service Returnmap : " + returnMap);
		
		return returnMap;
	}
	
	public Map<String, Object> fbLogin(Map<String, Object> map) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = mDao.findFbId(map);
//		List<Map<String, Object>> list = mDao.retrieveMember(map); 
		
		//쿠키값 생성
		Random random = new Random();
		int ran = random.nextInt();
		String password = "" + map.get("id") + ran;
		AES256Util aes = AES256Util.getInstance();
		String pa = aes.encrypt(password); 
		System.out.println("Cookie :" + pa);
		
		if(resultMap != null && resultMap.size() > 0) {
			System.out.println(" 페북 id 존재");
			returnMap.put("msg", "Available Facebook Id/ Success");
			returnMap.put("cookie_val", pa);
			returnMap.put("name", map.get("name"));
			System.out.println("Cookie 2 :" + pa);
			System.out.println("Map : " + map );
			System.out.println("ReturnMap : " + returnMap );
		} else {
			map.put("pw", '1');
			map.put("email", '1');
			System.out.println(map);
			mDao.insertMember(map);
			mDao.retrieveMember(map);
			returnMap.put("name", map.get("name"));
			returnMap.put("cookie_val", pa);
			System.out.println("ReturnMap : " + returnMap );
		}
		
		return returnMap;
	}
	
	public Map<String, Object> ktLogin(Map<String, Object> map) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = mDao.findFbId(map);
		List<Map<String, Object>> list = mDao.retrieveMember(map); 
		
		Random random = new Random();
		int ran = random.nextInt();
		String password = "" + ran;
		
		AES256Util aes = AES256Util.getInstance();
		String pa = aes.encrypt(password);
		
		System.out.println("Cookie :" + pa);
		
		if(resultMap != null && resultMap.size() > 0) {
			returnMap.put("msg", "Available kakaoTalk Id/ Success");
			returnMap.put("cookie_val", pa);
//			returnMap.put("name", map.get("name"));
			System.out.println("Cookie 2 :" + pa);
			System.out.println("Map : " + map );
			System.out.println("ReturnMap : " + returnMap );
		} else {
			map.put("pw", '1');
			map.put("email", '1');
			System.out.println(map);
			mDao.insertMember(map);
			mDao.retrieveMember(map);
//			returnMap.put("name", map.get("name"));
			returnMap.put("cookie_val", pa);
			System.out.println("Cookie3 :" + pa);
			System.out.println("Map : " + map );
			System.out.println("ReturnMap : " + returnMap );
		}
		
		return returnMap;
	}
	
	public Map<String, Object> findCode(Map<String, Object> map) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		resultMap = mDao.findCode(map);
		String id = (String) resultMap.get("ID");
		String pw = (String) resultMap.get("PW");
		
		System.out.println("ID : " + id);
		System.out.println("PW: " + pw);
		System.out.println("Service findId resultMap : " + resultMap);
		
		Random random = new Random();
		int num1 = random.nextInt(10);
		int num2 = random.nextInt(10);
		int num3 = random.nextInt(10);
		int num4 = random.nextInt(10);
		
		String confirmCode = ""+ num1+ num2 + num3 + num4;
		
		System.out.println("confirmCode : " + confirmCode);
		
		
//		String code = (String) map.get("appCode");
		
		String email = (String) resultMap.get("EMAIL");
		System.out.println("email: " +email);
		
		String surName = (String) map.get("surName");
		System.out.println("surName: " + surName);
		String givenName = (String) map.get("givenName");
		System.out.println("givenName: " + givenName);
		
		System.out.println("EMAIL : " + email);
		
		if (resultMap != null ) {
			
			returnMap.put("code", 200);
			returnMap.put("msg", "Succeed in Fining ID");
			returnMap.put("id", id);
			returnMap.put("pw", pw);
			returnMap.put("info", resultMap);
			returnMap.put("val_code", confirmCode);
			returnMap.put("surName", surName);
			returnMap.put("givenName", givenName);
			returnMap.put("email", email);
			
			Mailer.getInstance().sendMail(
					"Find ID", "Confirm Code" + confirmCode, new String[] {email}, vEngine);
		
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed to find ID");
		}
		
		mDao.insertConfirmCode(returnMap);
		
		return returnMap;
	}
	
	public Map<String, Object> sendQuizEmail(Map<String, Object> map) {
		
		String email = (String) map.get("email");
		String url = (String) map.get("url");
		
		Mailer.getInstance().sendMail("Hey Dude, Try this Quiz", url, new String[] {email}, vEngine);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("msg", "Succeed to sending Email");
		
		return resultMap;
		
	}
	
	public Map<String, Object> approveId(Map <String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		Map<String, Object> resultMap = mDao.selectConfirmCode(map);
		System.out.println("ApproveId resultMap:" + resultMap);
		System.out.println("Typed Confirm Code: " + map.get("val_code"));

		if(resultMap.get("VAL_CODE").equals(map.get("val_code")) ) {
//			if(resultMap.get("VAL_CODE").toString()== map.get("val_code").toString() ) {
			returnMap.put("code", 200);
		} else {
			returnMap.put("code", 201);
		}
		
		
		return returnMap;
	}
	
	public Map<String, Object> cookie(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = mDao.retrieveMember(map);
		if(list != null && list.size() > 0) {
			resultMap = list.get(0);
			System.out.println("Cookie resultMap : " + resultMap);
			String cookie = (String) resultMap.get("COOKIE_VAL");
			
			System.out.println("Cookie: " +cookie);
		
			returnMap.put("code", 200);
			returnMap.put("id", resultMap.get("ID"));
			returnMap.put("pw", resultMap.get("PW"));
			returnMap.put("cookie", cookie);
			returnMap.put("msg", "Succeed in staying signed in");
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed in staying signed in");
		}
		
		return returnMap;
	}
	
	
	public Map<String, Object> retrieveMemberInfo(HttpSession session){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		paramMap.put("id", session.getAttribute("id"));
		List<Map<String, Object>> list = mDao.retrieveMemberAllInfo(paramMap);

		String phoneStr = (String) list.get(0).get("PHONE_NUMBER");
		String phoneNum3 = phoneStr.substring(phoneStr.lastIndexOf("-")+1);
		String phoneNum2 = phoneStr.substring(phoneStr.indexOf("-") +1 , phoneStr.indexOf("-", phoneStr.indexOf("-")+1));
		String phoneNum1 = phoneStr.substring(0, phoneStr.indexOf("-"));
		list.get(0).put("phoneNum1",phoneNum1);
		list.get(0).put("phoneNum2",phoneNum2);
		list.get(0).put("phoneNum3",phoneNum3);
		
		if(list != null && list.size() >0 ){
			returnMap.put("code", 200);
			returnMap.put("memberMap", list.get(0));
		} else {
			returnMap.put("code", 300);
		}
		return returnMap;
		
	}
	public Map<String, Object> updateMemberInfo(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("phoneNum", ""+map.get("phoneNum1") +"-"+map.get("phoneNum2") +"-"+map.get("phoneNum3"));
//		if(map.get("pw")!=null && map.get("pw").equals("")){
//			map.remove("pw");
//		}
		int status = mDao.updateMemberInfo(map);
		if(status> 0 ){
			returnMap.put("code", 200);
			returnMap.put("msg", "Succeed in modifying personal information.");
		} else{
			returnMap.put("code", 300);
			returnMap.put("msg", "Failed in modifying personal information.");
		}
		return returnMap;
	}
	

}
