<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.0/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/resources/css/keyboard.css">
<script src="/resources/js/jquery.keyboard.js"></script>
<script src="/resources/js/jquery.keyboard.extension-autocomplete.js"></script>
<script src="/resources/js/jquery.keyboard.extension-typing.js"></script>
<script src="/resources/js/jquery.mousewheel.js"></script>
<script src="/resources/js/bootstrap-table.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jsQR.js"></script>
<script>
	function connectWS(){
		var ws = new WebSocket("ws:\\\\192.168.0.2:7000\\echo?hp_code:280HP");
		socket = ws;	
		ws.open = function(message){
			console.log(message);
		};
		// 서버로부터 메시지를 받았을 때
		ws.onmessage=function(event){
			
			var data= event.data;
			
			if(data){
				var str = ""+data;
				var strs = str.split('?')
				alert(strs[1]);
				var imsi = strs[1].split(']');
				var imsi2 = imsi[0].split(':');
				var hp_code = imsi2[1];
				alert("hp_code"+hp_code)
				//이서연:윤정민:1230:영상의학과:2020/07/23:280HP
				var imsi3 = imsi[1].split(':');
				var mem_name = imsi3[0];
				var doc_name = imsi3[1];
				var res_time = imsi3[2];
				var dept_name = imsi3[3];
				var sch_date = imsi3[4];
				alert("환자 이름 : "+mem_name +" 의사 이름:  "+doc_name+" 예약 시간 :"+res_time+" 부서 이름 : "+dept_name+" 날짜 :"+sch_date);
				}
			var tableText ="<tr>";
			tableText +="<td>"+mem_name+"</td>"
			tableText +="<td>"+doc_name+"</td>"
			tableText +="<td>"+res_time+"</td>"
			tableText +="<td>"+dept_name+"</td>"
			tableText +="<td>"+sch_date+"</td>"
			tableText +="</tr>"
			$("#patient").append(tableText);
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
<div style="text-align: center;">
	<div id="socketAlert">환자 예약 내역 확인 테이블</div>
	 <table class="table table-hover" id="resList" data-toggle="table">
						<thead>
						 	<tr>
					 			 <th scope="col" data-field="MEM_NAME" id="MEM_NAME">환자 이름</th> 	
								 <th scope="col" data-field="DOC_NAME" id="DOC_NAME">의사 이름</th>
								 <th scope="col" data-field="RES_TIME" id="RES_TIME">예약시간</th>
								 <th scope="col" data-field="DEPT_NAME" id="DEPT_NAME">부서 이름</th>
								 <th scope="col" data-field="SCH_DATE" id="SCH_DATE">예약날짜</th>
				  			</tr>
						</thead>
						<tbody id="patient">
							<tr>
								 <th></th> 	
								 <th></th> 	
								 <th></th> 	
								 <th></th> 	
								 <th></th> 	
							<tr>
						</tbody>
					 </table>
</div>
	
<script type="text/javascript">
	var socket=null;
	var msg_chat = "100#";	 		//방채팅 
	var msg_exit = "500#";
	/* 채팅 기능 선언부  */
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
