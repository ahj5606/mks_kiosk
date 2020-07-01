<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HttpSession sess = request.getSession();
	String hp_code = sess.getAttribute("hp_code").toString();
	
%>
<script>
	function connectWS(){
		var hp_code = "<%=hp_code%>"
		var ws = new WebSocket("ws:\\\\192.168.0.247:7000\\echo?hp_code:"+hp_code);
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
		socket.send(msg_null+msg);
	}
</script>




