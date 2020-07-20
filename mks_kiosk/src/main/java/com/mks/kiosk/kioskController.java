package com.mks.kiosk;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/result/*")
public class kioskController {
	Logger logger = LoggerFactory.getLogger(kioskController.class);
	@Autowired
	KioskLogic kioskLogic = null;
	@RequestMapping("result")
	public String result(Model model, @RequestParam(value="qrcode", defaultValue="false") String qrcode , String hp_code ) {
		
		List<Map<String, Object>> rList = null;
		Map<String, Object> pMap = new HashMap<>();
		pMap.put("qrcode", qrcode);
		pMap.put("hp_code", hp_code);
		
		rList = kioskLogic.resList(pMap);
		model.addAttribute("rList",rList);
		return "result";
	}
	@RequestMapping("fresList")
	public String fresList(Model model, @RequestParam(value="hp_code", defaultValue="false") String hp_code ) {
		
		List<Map<String, Object>> rList = null;
		Map<String, Object> pMap = new HashMap<>();
		pMap.put("hp_code", hp_code);
		
		rList = kioskLogic.fresList(pMap);
		model.addAttribute("rList",rList);
		return "result";
	}

	
}
