package com.mks.kiosk;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
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
	public String loginBtn(HttpServletRequest req  ,@RequestParam(value="mem_id", defaultValue="false") String mem_id , @RequestParam(value="mem_pw", defaultValue="false") String mem_pw) {
		
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("mem_id", mem_id);
		pMap.put("mem_pw", mem_pw);
		List<Map<String, Object>> lList = null;
		lList = kioskLogic.login(pMap);
		System.out.println(mem_id +" / " +mem_pw);
		if(lList.size()==0) {
			return "실패";
		}else {
			HttpSession ses = req.getSession();
			ses.setAttribute("hp_code", lList.get(0).get("HP_CODE").toString());
			ses.setAttribute("hp_name", lList.get(0).get("HP_NAME").toString());
			return "성공";
		}
	}
	@RequestMapping(value="/update",method=RequestMethod.GET)
	@ResponseBody
	public String reserve(Model model, @RequestParam(value="qrcode", defaultValue="false") String qrcode ) {
		
		int result = 0;
		Map<String, Object> pMap = new HashMap<>();
		pMap.put("qrcode", qrcode);
		
		result = kioskLogic.qrupdate(pMap);
		if(result==0) {
			return "실패";
		}else {
			return "성공";
		}
	}
}
