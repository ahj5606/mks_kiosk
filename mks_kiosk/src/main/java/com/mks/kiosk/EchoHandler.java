package com.mks.kiosk;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.StringTokenizer;

import javax.lang.model.element.Element;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
@Component
public class EchoHandler extends TextWebSocketHandler {
	Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	List<WebSocketSession> sessionList = new ArrayList<>();
	Map<String,List<WebSocketSession>> sessionMap = new HashMap<>();
	String hp_code = null;
	//클라이언트와 연결 이후에 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) 
	throws Exception
	{
		String uri = session.getUri().toString();
		//ws:\\\\192.168.0.244:5000\\ver2\\echo?roomCreate:kosmo59
		String real = uri.split("\\?")[1];//roomCreate:kosmo59
		String status = real.split("\\:")[0];//roomCreate
		hp_code = real.split("\\:")[1];//kosmo59
		if("hp_code".equals(status)) {
			sessionList.add(session);
			sessionMap.put(hp_code,sessionList);
		}
		logger.info("sessionList : "+sessionList.size()+" 병원코드 : "+hp_code );
	}
	//클라이언트가 서버로 메시지를 전송했을 때 실행되는 메소드
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) 
			throws Exception
	{
		logger.info("{} 로 부터 {} 받음", session.getId(), message.getPayload());
		String msg_chat = "100";//일반대화
		String msg_null = "101";//빈 문자가 넘어올 때
		String msg_exit = "500";//방 나갈때
		StringTokenizer st = new StringTokenizer(message.getPayload(),"#");
		String kind = st.nextToken();
		//메시지 null 체크
		if(msg_null.equals(kind)) {
			String info ="빈 공간을 입력하였습니다.";
			for(WebSocketSession sess:sessionList) {
				sess.sendMessage(new TextMessage(info));
			}
			

		}
		//메시지가 null이 아닌 경우
		else {
			if(msg_chat.equals(kind)) {
				String msg = st.nextToken();
				/*
				 * for(WebSocketSession sess:sessionList) { 
				 * sess.sendMessage(new
				 * TextMessage(session+msg)); }
				 */
				String code[] = msg.split(":");
				int i=0;
				Iterator<Entry<String, List<WebSocketSession>>> entries = sessionMap.entrySet().iterator();
				while(entries.hasNext()){
					
					Entry<String, List<WebSocketSession>>entry = (Entry<String, List<WebSocketSession>>)entries.next();
					logger.info("sessionKey? : "+entry.getKey());
					if(entry.getKey().equals(code[5])) {		//키값 = 세션 = 병원 // 해당 병우너에
						WebSocketSession sess = entry.getValue().get(i);
						logger.info(sess+"");
						sess.sendMessage(new TextMessage(session+msg));
					}
					i++;
				}
				
			}
			//나가기 일때
			if(msg_exit.equals(kind)) {
				//String msg = st.nextToken();
				for(WebSocketSession sess:sessionList) {
					sess.sendMessage(new TextMessage(session+""));
				}
			}
		}
	}
	
	//클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception
	{
		logger.info("afterConnectionClosed 호출 성공");
		logger.info("{} 연결 끊김 : ", session.getId());
		run_start:
		for(int i=0;i<sessionMap.size();i++) {
			Object[] keys = sessionMap.keySet().toArray();
			sessionList = sessionMap.get(keys[i]);
			for(int j=0;j<sessionList.size();j++) {
				if(session.equals(sessionList.get(j))){
					sessionList.remove(j);
					for(WebSocketSession sess : sessionList) {
						sess.sendMessage(new TextMessage(sessionList.size()+":"+"현재 인원수"));
					}
					logger.info("for문 안에 {} 연결 끊김 : ", session.getId());
					break run_start;
				}
			}
		}
	}
}









