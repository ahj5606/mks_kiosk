package com.mks.kiosk;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KioskLogic {
	Logger logger = LoggerFactory.getLogger(KioskLogic.class);
	@Autowired
	private KioskDao kioskDao;
	
	public List<Map<String,Object>> login(Map<String, Object> pMap) {
		List<Map<String,Object>> result = null;
		result = kioskDao.login(pMap);
		return result;
		
	}

	public List<Map<String, Object>> resList(Map<String, Object> pMap) {
		List<Map<String, Object>> rList = null;
		rList = kioskDao.resList(pMap);
		return rList;
	}
	
}
