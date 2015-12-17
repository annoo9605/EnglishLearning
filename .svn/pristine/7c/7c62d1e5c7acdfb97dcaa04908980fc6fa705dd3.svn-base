package com.learning.eng.client.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.learning.eng.common.Page;
import com.learning.eng.common.Util;
import com.learning.eng.dao.FreeBoardDao;

@Service
public class FreeBoardService {
	@Autowired
	FreeBoardDao fdao;
	@Autowired
	Util util;
	
	@Transactional
	public Map<String, Object> addArticle(Map<String, Object> map,
			MultipartHttpServletRequest mRequest) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.println("Controller map :" + map);
		
		int add = fdao.insertBoard(map);
		
		
		try {
			if(add > 0) {
				returnMap.put("code", 200);
				returnMap.put("msg", "You've successfully posted articles");
				
				if(mRequest.getFileNames().hasNext()) {
					util.fileUpload(map, mRequest);
					System.out.println("Util FileUpload: " + map);
					System.out.println("Util mRequest: " + mRequest);
					returnMap.put("atchFileNo", map.get("atchFileNo"));
				} 
				
			} else {
				returnMap.put("code", 300);
				returnMap.put("msg", "You've failed in posting articles");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		System.out.println("Service ReturnMap : " + returnMap);
		
	
		
		
		return returnMap;
	}
	
	public Map<String, Object> boardList(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.println("boardList Service Map: " + map);
		
		String pageNumStr = (String) map.get("pageNum");
		
		if(pageNumStr == null || pageNumStr.equals("")) {
			pageNumStr = "1";
		}
		
		int pageNum = Integer.parseInt(pageNumStr);
		int pageSize = 10;
		int pageBlock = 10;
		int count =  fdao.countArticle(map);
		
		System.out.println("Count : " + count);
		
		Page.getInstance().paging(pageNum, count, pageSize, pageBlock);
		
		map.put("startRow",  Page.getInstance().getStartRow());
		map.put("endRow", Page.getInstance().getEndRow());
		
		List<Map<String, Object>> list = fdao.boardList(map);
		
		System.out.println("Service BoardList: " + list);
		
		returnMap.put("atchFile", fdao.atchFileDetail(map));
		returnMap.put("list", list);
		returnMap.put("pagingCode", Page.getInstance().getSb().toString());
		returnMap.put("pageNum", pageNum);
		
		System.out.println("Service ReturnMap : " + returnMap);
		
		return returnMap;
	}
	
	public Map<String, Object> retrieve(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("detail", fdao.retrieve(map));
		List<Map<String, Object>> fileList = fdao.atchFileDetail(map);
		resultMap.put("atchFile", fileList);
		fdao.hit(map);
		System.out.println("fileMap : " + fileList);
		System.out.println("Service Retrieve Map: " + map);
		System.out.println("Service Retrieve : " + resultMap);
		
		return resultMap;
	}
	
	public Map<String, Object> downloadFile(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		
		List<Map<String, Object>> fileList = fdao.downAtchFile(map);
		
		returnMap.put("fileList", fileList);
		System.out.println("fileList : " + fileList);
		
		String webPath = this.getClass().getClassLoader().getResource("").getPath();
		
		webPath = webPath.substring(0, webPath.indexOf("WEB-INF/"));
		
		File saveFile = new File(webPath + "resources/images/upload/" + fileList.get(0).get("SAVE_FILE_NAME") + "." +fileList.get(0).get("EXTENSION"));
		returnMap.put("file", saveFile);
		
		System.out.println("Down Service SaveFile : " + saveFile);
		
		return returnMap;
	}
	
	public Map<String, Object> delete(Map<String, Object> map) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int delete = fdao.delUpdate(map);
		
		System.out.println("Del Service map :" + map);
		System.out.println("Del Update result int :" + delete);
		
		if(delete > 0) {
			returnMap.put("code", 200);
			returnMap.put("msg", "You've successfully deleted articles");
		} else {
			returnMap.put("code", 300);
			returnMap.put("msg", "You've failed in deleting articles");
		}
	
		return returnMap;
	}
	
	public Map<String, Object> insertComment(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = fdao.insertComment(map);
		
		if(result > 0) {
			resultMap.put("code", 200);
			resultMap.put("msg", "You've successfully updated comments");
		} else {
			resultMap.put("code", 200);
			resultMap.put("msg", "You've failed in updating comments");
		}
		
		return resultMap;
	}
	
	public Map<String, Object> listComment(Map<String, Object> map) {
		
		List<Map<String, Object>> resultList = fdao.commentList(map);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("comment", resultList);
		
		return returnMap;
		
	}
	
	public Map<String, Object> searchList(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = fdao.searchList(map);
		
		System.out.println("Search Service List : " + list);
		System.out.println("Search Service Map : " + map);
//		
//		int pageNum = Integer.parseInt((String) map.get("pageNum"));
//		int pageSize = 10;
//		int pageBlock = 10;
//		int count =  list.size();
//		
//		System.out.println("Count : " + count);
//		
//		Page.getInstance().paging(pageNum, count, pageSize, pageBlock);
//		
//		map.put("startRow",  Page.getInstance().getStartRow());
//		map.put("endRow", Page.getInstance().getEndRow());
		
		resultMap.put("searchList", list);
//		resultMap.put("pagingCode", Page.getInstance().getSb().toString());
//		resultMap.put("pageNum", pageNum);
		
		return resultMap;
	}
	
	public Map<String, Object> searchDetail(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println("SearchDetail Map :" + map);
		
		List<Map<String, Object>> list = fdao.searchDetail(map);
		
		resultMap.put("searchList", list);
		
		return resultMap;
	}
	
	

}
