package com.learning.eng.test;

import static org.junit.Assert.fail;

import java.security.NoSuchAlgorithmException;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.learning.eng.client.service.ClientBoardService;
import com.learning.eng.common.Util;
import com.learning.eng.dao.ClientBoardDao;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations = {
		 "classpath:client-context.xml"
		,"classpath:root-context.xml"
		,"classpath:dao-context.xml"
})
public class WebTest {

	@Autowired
	ClientBoardDao cbDao;
	@Autowired
	ClientBoardService cbService;
	@Autowired
	Util utilTest;
	
	@Test
	public void test() {
		fail("Not yet implemented");
	}
	
	@Test
	public void generateKey() {
		KeyGenerator keyGen = null;
		try {
			keyGen = KeyGenerator.getInstance("AES");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		keyGen.init(256); // for example
		SecretKey secretKey = keyGen.generateKey();
		System.out.print("secretKey : ");
		System.out.println(secretKey.toString()); //secretKey : javax.crypto.spec.SecretKeySpec@17b81
	}
	
	@Test
	public void fileUploadTest(){
//		String svaePath ="";
//		String webAppPath = this.getClass().getResource("").getPath();	// /D:/SpringWork/FinalProject1/target/test-classes/com/english/www/
//		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();	// /D:/SpringWork/FinalProject1/target/test-classes/
		
	}
	
}