package com.learning.eng.common;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.velocity.VelocityEngineUtils;

public class Mailer extends Authenticator {
	
	private static Mailer instance = null;

	public static Mailer getInstance() {
		return instance == null ? new Mailer() : instance;
	}

	/**
	 * 인증
	 */
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("annoo9605@gmail.com", "jesfodmceosubxgn");
	}

	public void sendMail(String subject, String content, String[] receiver, VelocityEngine vEngine) {

		// 메일 정보를 담기 위한 객체
		Properties p = new Properties();

		// SMTP 서버의 계정 설정
		p.put("mail.smtp.user", "seorab.honeyv@gmail.com");

		// SMTP 서버 정보 설정
		p.put("mail.smtp.host", "smtp.gmail.com");
		// 메일 발송 기본 정보
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		p.put("mail.smtp.socketFactory.fallback", "false");

		try {
			// Java Mail 에서 사용할 세션 객체 생성
			Session ses = Session.getInstance(p, this);
			Map<String, Object> prop = new HashMap<String, Object>();
			prop.put("url", content);
			
			String htmlContent = VelocityEngineUtils.mergeTemplateIntoString(vEngine, "EmailTemplate.vm", "UTF-8", prop);

			// 메일을 전송할 때 상세한 상황을 콘솔에 출력
			ses.setDebug(true);

			// 메일의 내용을 담기 위한 객체
			MimeMessage msg = new MimeMessage(ses);
			MimeMessageHelper helper = new MimeMessageHelper(msg, true);
			msg.setContent(htmlContent, "text/html; charset=utf8;"); 
			helper.setSubject(subject); // 제목
//			helper.setText(htmlContent); // 본문 내용
			helper.setTo(receiver); // 수신자 메일 주소

			final MimeMessage fMsg = msg;

			// 메일 발송 실행
			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						Transport.send(fMsg);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}).start();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
