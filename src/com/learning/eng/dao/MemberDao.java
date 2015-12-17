package com.learning.eng.dao;

import java.util.List;
import java.util.Map;


public interface MemberDao {
	
	
	public int insertMember(Map<String, Object> map);
	public List<Map<String, Object>> retrieveMember(Map<String, Object> map);
	public Map<String, Object> findCode(Map<String, Object> map);
	public int insertConfirmCode(Map<String, Object> map);
	public Map<String, Object> selectConfirmCode(Map<String, Object> map);
	public int updateCookieCode(Map<String, Object> map);
	
	public List<Map<String, Object>> retrieveMemberAllInfo(Map<String, Object> map);
	public int updateMemberInfo(Map<String, Object> map);
	public Map<String, Object> findFbId(Map<String, Object> map);
}




