package com.mks.kiosk;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value="/Rkiosk/*",produces="text/plain;charset=UTF-8")
public class kioskRestContoller {
	Logger logger = LoggerFactory.getLogger(kioskRestContoller.class);
	@Autowired
	KioskLogic kioskLogic = null;
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	@ResponseBody
	public String loginBtn(@RequestParam(value="mem_id", defaultValue="false") String mem_id , @RequestParam(value="mem_pw", defaultValue="false") String mem_pw) {
		
		logger.info("로거"+mem_id);
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("mem_id", mem_id);
		pMap.put("mem_pw", mem_pw);
		List<Map<String, Object>> lList = null;
		lList = kioskLogic.login(pMap);
		System.out.println(mem_id +" / " +mem_pw);
		if(lList.size()==0) {
			return "실패";
		}else {
			return "성공";
		}
	}
	
}
