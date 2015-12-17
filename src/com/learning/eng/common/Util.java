package com.learning.eng.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.learning.eng.dao.ClientBoardDao;




public class Util {
	@Autowired 
	ClientBoardDao cbDao;
	/**
	 * @return
	 * this 사용하기 위해서는 new 로 생성 해 줘야 한다.
	 */
	public String getWebAppPath(){
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();
		webAppPath = webAppPath.substring(0, webAppPath.indexOf("WEB-INF/"));
		return webAppPath;
	}
	
	public Map<String, Object> fileUpload(Map<String, Object> map, MultipartHttpServletRequest mRequest) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String savePath ="";
//		String webAppPath = this.getClass().getResource("").getPath();	//차이점은 무엇인가?
		String webAppPath = this.getClass().getClassLoader().getResource("").getPath();
		System.out.println(webAppPath);
		
		webAppPath = webAppPath.substring(0,webAppPath.indexOf("WEB-INF/"));
		webAppPath += "resources/images/upload/";
		System.out.println(webAppPath);
		savePath = webAppPath;
		
		File saveDir = new File(savePath);
		if(!saveDir.isDirectory()){
			saveDir.mkdirs();
		}
		
		map.put("seqNo", cbDao.getLastBoardSeqNo().get("LAST_SEQ_NO"));
		System.out.println(map.get("seqNo"));
		String saveFile ="";
		int count = 1; //Atch_File_No
		
		//파일 정보 추출, 데이터 베이스 삽입
		Iterator<String> htmlNames = mRequest.getFileNames();//여러 파일일 경우
		while (htmlNames.hasNext()) {
			String htmlName = htmlNames.next();
			
			List<MultipartFile> mFiles = mRequest.getFiles(htmlName);
			
			for (int i = 0; i < mFiles.size(); i++) {
				String oFile = mFiles.get(i).getOriginalFilename();
				
				if(oFile !=null && !oFile.trim().equals("")){
					long size = mFiles.get(i).getSize();
					
					saveFile = oFile;
					File f = new File(savePath + "/" + oFile);
					String fName= oFile.substring(0, oFile.lastIndexOf("."));
					String expName= oFile.substring(oFile.lastIndexOf(".")+1);
					// 원본 파일명 저장
					map.put("dspName", fName);
					
					if(f.exists()){
						fName = fName + "_" + System.currentTimeMillis() ;
					} //파일이 존재 할때 dsp 파일 이름과 save파일 이름이 달라진다.
					
					map.put("fileSeqNo", count++);
					map.put("saveName", fName);
					map.put("expName", expName);
					map.put("fileSize", size);
					
					cbDao.insertAtachFile(map);
					try {
						mFiles.get(i).transferTo(
								new File(savePath + "/" + fName + "." + expName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}//if문 끝 : 파일이 존재하면 
				
			}//for문 끝 : 여러개일때 각각의 파일에 대해 저장
			
		}//while문 끝 : html 업로드 파일 있는지, 있으면 저장
		
		resultMap.put("code", 200);
		resultMap.put("msg", "파일 업로드 성공");
		return resultMap;
	}
	
	public String getTwoDigit(int integ){
		System.out.println(integ);
		String intStr = String.valueOf(integ);
		if(intStr.length()<2){
			intStr = "0"+intStr;
		}
		return intStr;
	}
	
	
	public String getUTCTime(Date date){
		//2015-07-12T12:30:00
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int year = cal.get(Calendar.YEAR);
		int dmonth = cal.get(Calendar.MONTH)+1;
		int dday = cal.get(Calendar.DATE);
		int dhour = cal.get(Calendar.HOUR_OF_DAY);
		int dminute = cal.get(Calendar.MINUTE);
		int dsecond = cal.get(Calendar.SECOND);
		String month = getTwoDigit(dmonth);
		String day = getTwoDigit(dday);
		String hour = getTwoDigit(dhour);
		String minute = getTwoDigit(dminute);
		String second = getTwoDigit(dsecond);
		
		return year+"-"+month+"-"+day+"T"+hour+":"+minute+":"+second;
	}
	
}
