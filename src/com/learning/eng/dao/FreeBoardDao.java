package com.learning.eng.dao;

import java.util.List;
import java.util.Map;

public interface FreeBoardDao {
	
	public int insertBoard(Map<String, Object> map);
	public List<Map <String, Object>> boardList(Map<String, Object> map);
	public int countArticle(Map<String, Object> map);
	public int getLastSeqNo(Map<String, Object> map);
//	public int insertAtchFile(Map<String, Object> map);
	public List<Map<String, Object>> retrieve(Map<String, Object> map);
	public List<Map<String, Object>> atchFileDetail(Map<String, Object> map);
	public List<Map<String, Object>> downAtchFile(Map<String, Object> map);
	public int delUpdate(Map<String, Object> map);
	public int insertComment(Map<String, Object> map);
	public List<Map<String, Object>> commentList(Map<String, Object> map);
	public List<Map<String, Object>> searchList(Map<String, Object> map);
	public List<Map<String, Object>> searchDetail(Map<String, Object> map);
	public int hit(Map<String, Object> map);
}
