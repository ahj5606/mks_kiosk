<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String hp_code =request.getParameter("hp_code");
	SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분ss초");
	
	Date time = new Date();
	String time2 = format2.format(time);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="/Common.jsp" %>
<script type="text/javascript">
	function send(){
		var mem_name = $("#name").val();
		var content = $("#content").val();
		var time = $("#time").val();
		var dept_name ="";
		var sch_date ="";
		let msg =mem_name+":"+time+":"+content+":"+dept_name+":"+sch_date+":<%=hp_code%>" ;
		alert(msg);
		if(msg.trim().length<1){	//빈공간 문자열 출력 
			socket.send(msg_null+msg);
		}
		else{	
			socket.send(msg_pri+msg);//소켓에 입력된 메시지를 보낸다.
		}
	}
	function connectWS(){
		var hp_code = "<%=hp_code%>"
		var ws = new WebSocket("ws:\\\\localhost:7000\\echo?hp_code:"+hp_code);
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
<div>
<label>채팅자 이름설정</label>
<input type="text" id="name" class="form-control"/>
</div>
<div>
<label>채팅 내용</label>
<input type="text" id="content" class="form-control"/>
</div>
<div>
<label>현재 시간</label>
<input type="text" id="time" value="<%=time2%>" class="form-control" readonly/>
</div>
<button onClick="send()">전송</button>
<script>
	var socket=null;
	var msg_exit = "500#";
	var msg_null ="101#";
	var msg_pri = "102#";
$(document).ready(function(){
	connectWS();
	
})
	
</script>
</body>
</html>