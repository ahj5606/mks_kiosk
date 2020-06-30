package com.mks.kiosk;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KioskDao {
	Logger logger = LoggerFactory.getLogger(KioskDao.class);
	@Autowired
	SqlSessionTemplate sqlSessionTemplate = null;
	public List<Map<String,Object>> login(Map<String, Object> pMap) {
		List<Map<String,Object>> result = null;
		
		result = sqlSessionTemplate.selectList("login",pMap);
		return result;
	}
	public List<Map<String, Object>> resList(Map<String, Object> pMap) {
		List<Map<String, Object>> rList = null;
		rList = sqlSessionTemplate.selectList("resList",pMap);
		return rList;
	}
	
	
}