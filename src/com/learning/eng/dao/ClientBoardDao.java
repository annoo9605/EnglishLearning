package com.learning.eng.dao;

import java.util.List;
import java.util.Map;

public interface ClientBoardDao {
	public int insertPointCount(Map<String, Object> map);
	public int getPointCount();
	public int getBoardArticleCount();
	public List<Map<String, Object>> retrieveMemberPoint(Map<String, Object> map);
	public int insertExpression(Map<String, Object> map);
	public int insertQuizAns(Map<String, Object> map);
	public int retrieveRecentSeqNo(Map<String, Object> map);
	public List<Map<String, Object>>  retrieveExpression(Map<String, Object> map);
	public List<Map<String, Object>>  retrieveAnswer(Map<String, Object> map);
	public Map<String, Object> getLastBoardSeqNo();
	public int insertAtachFile(Map<String, Object> map);
	public List<Map<String, Object>> retrieveQuizData(Map<String, Object> map);
	public List<Map<String, Object>> getQuizCount(Map<String, Object> map);
	public List<Map<String, Object>> retrieveAtchFile(Map<String, Object> map);
	public int insertRecommend(Map<String, Object> map);
	public int updateRecommend(Map<String, Object> map);
	public List<Map<String, Object>> retrieveRecommendCount(Map<String, Object> map);
	public List<Map<String, Object>> retrievePoint(Map<String, Object> map);
	public List<Map<String, Object>> retrieveMyQuiz(Map<String, Object> map);
	public List<Map<String, Object>> retriveArticleStateByActivity(
			Map<String, Object> map);
	public List<Map<String, Object>> retrieveAnsFromSeqNo(
			Map<String, Object> map);
	public List<Map<String, Object>> retrieveBoardFromSeqNo(
			Map<String, Object> map);
	public List<Map<String, Object>> retrieveBoardAnsFromSeqNo(
			Map<String, Object> map);
	public List<Map<String, Object>> retriveWrongAnsActivity(
			Map<String, Object> map);
	public int updateBoard(Map<String, Object> map);
	public List<Map<String, Object>> isSelfRecommend(Map<String, Object> map);
	
	

}
