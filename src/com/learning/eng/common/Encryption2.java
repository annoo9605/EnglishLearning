package com.learning.eng.common;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class Encryption2 {
	public static void main(String[] args) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		Random random = new Random();
		int ran = random.nextInt();
		String password = "seorab+";
		
		AES256Util aes = AES256Util.getInstance();
		String pa = aes.encrypt(password);
		String en = aes.decrypt(pa);
		System.out.println(pa);
		System.out.println(en);
	}
}
//xhJD5NOeCZEx5HLrhfquLg==
//oylHhoFvpX0ycm6PMQErQ==