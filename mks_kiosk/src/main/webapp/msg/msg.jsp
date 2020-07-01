<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/js/jquery.min.js"></script>
<script>
	function connectWS(){
		var ws = new WebSocket("ws:\\\\192.168.0.247:7000\\echo?roomCreate:kosmo59");
		socket = ws;	
		ws.open = function(message){
			console.log(message);
		};
		// 서버로부터 메시지를 받았을 때
		ws.onmessage=function(event){
			
			var data= event.data;
			$("#socketAlert").append("<br>"+data);
			$("#socketAlert").css("display","block");
		};
		//브라우저 닫을시
		ws.onclose = function(event){
			console.log("Server disconnect");
		};
		//브라우저 에러시 
		ws.onerror = function(event){
			console.log("Server Error");
		};		
	}
</script>
</head>
<body>
	<div id="socketAlert">이곳에 채팅이 적힘</div>
	<input type="text" id="msg" value="123test" class="form-control">
	<input id="btnSend" value="메세지 전송" type="button">
	<input id="btnExit" value="나가기" type="button">
	<input id="testSend" value="공지" type="button">
<script type="text/javascript">
	var socket=null;
	var msg_chat = "100#";	 		//방채팅 
	var msg_exit = "500#";
	/* 채팅 기능 선언부  */
	//connectWS();
	$(document).ready(function(){
		connectWS();
		$("#btnSend").on('click',function(evt){
			evt.preventDefault();
			// 메시지 전송
			let msg = $("#msg").val();
	 
			if(msg.trim().length<1){	//빈공간 문자열 출력 
				socket.send(msg_null+msg);
			}
			else{	
				socket.send(msg_chat+msg);//소켓에 입력된 메시지를 보낸다.
			}
		});//////////////end of btnSend
		$("#btnExit").on('click',function(evt){
			evt.preventDefault();
			socket.send(msg_exit);//소켓에 입력된 메시지를 보낸다.
		});//////////////end of exit
	});//////////////////end of ready
</script>	
</body>
</html>
