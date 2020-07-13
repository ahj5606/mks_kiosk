<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
	HttpSession sess = request.getSession();
	String hp_code = null;
	String hp_name = null;
	if(sess.getAttribute("hp_code")==null){
		response.sendRedirect("https://192.168.0.247:7000/loginFail.jsp");
	}else{
	    hp_code = sess.getAttribute("hp_code").toString();
	    hp_name = sess.getAttribute("hp_name").toString();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 이력</title>
<%@include file="/Common.jsp" %>
<script>
	function connectWS(){
		var ws = new WebSocket("wss:\\\\192.168.0.247:7000\\echo?hp_code:<%=hp_code%>"); //여기에 세션에서 얻은 병원코드를 보냄 
		socket = ws;	
		ws.open = function(message){
			console.log(message);
		};
		// 서버로부터 메시지를 받았을 때
		ws.onmessage=function(event){
			
			var data= event.data;
			//alert(data);
			var str = ""+data;
			var imsi = str.split(":");
			var separ = imsi[0];
			var mem_name = imsi[1]+"님";
			var doc_name = imsi[2];
			var res_time = imsi[3];
			var dept_name = imsi[4];
			var sch_date = imsi[5];
			var qrcode = imsi[5];
			
			//alert("separ ="+separ +" mem_name = "+mem_name+"  doc_name= "+doc_name+" res_time= "+res_time+" dept_name= "+dept_name+ " sch_date= "+sch_date+" qrcode = "+qrcode)
			 var tableText ="<tr>";
			if(separ.trim()=='100'){
	/* 			tableText +="<td>"+mem_name+"</td>"
				tableText +="<td>"+doc_name+"</td>"
				tableText +="<td>"+res_time+"</td>"
				tableText +="<td>"+dept_name+"</td>"
				tableText +="<td>"+sch_date+"</td>"
				tableText +="</tr>" */
				//$("#patient").append(tableText);
				$("#resList").bootstrapTable('refreshOptions', {
				    url:'/result/fresList?hp_code=<%=hp_code%>'	
				    	    ,onClickRow:function(row,element,field){
					 }
			 	 })
			 	speech(mem_name);
			}else if(separ=='102'){
/* 				msg_count = msg_count+1;
				document.getElementById('msg_count').innerText=msg_count;
				tableText +='<td onClick="test('+"'"+mem_name+"'"+","+"'"+res_time+"'"+')" >'+mem_name;
				tableText +="<td>"+doc_name+"</td>"
				tableText +="<td>"+res_time+"</td>"
				tableText +="</tr>"
				$("#chatList").append(tableText); */
			} 
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

	var voices = [];
	function setVoiceList() {
		voices = window.speechSynthesis.getVoices();
	}
	setVoiceList();
	if (window.speechSynthesis.onvoiceschanged !== undefined) {
		window.speechSynthesis.onvoiceschanged = setVoiceList;
	}
	function speech(txt) {
		if (!window.speechSynthesis) {
			alert("음성 재생을 지원하지 않는 브라우저입니다. 크롬, 파이어폭스 등의 최신 브라우저를 이용하세요");
			return;
		}
		var lang = 'ko-KR';
		var utterThis = new SpeechSynthesisUtterance(txt);
		utterThis.onend = function(event) {
			console.log('end');
		};
		utterThis.onerror = function(event) {
			console.log('error', event);
		};
		var voiceFound = false;
		for (var i = 0; i < voices.length; i++) {
			if (voices[i].lang.indexOf(lang) >= 0
					|| voices[i].lang.indexOf(lang.replace('-', '_')) >= 0) {
				utterThis.voice = voices[i];
				voiceFound = true;
			}
		}
		if (!voiceFound) {
			alert('voice not found');
			return;
		}
		utterThis.lang = lang;
		utterThis.pitch = 1;
		utterThis.rate = 0.7; //속도
		window.speechSynthesis.speak(utterThis);
	}


</script>
</head>
<body>
<div style="text-align: center;">
<div>
	<h1><%=hp_name %></h1>
	<h1>키오스크 확인</h1>
	<div class="float-right"> 
	</div>
	 <table class="table table-hover" id="resList" data-toggle="table">
						<thead>
						 	<tr>
					 			 <th scope="col" data-field="MEM_NAME" id="MEM_NAME">환자 이름</th> 	
								 <th scope="col" data-field="DOC_NAME" id="DOC_NAME">의사 이름</th>
								 <th scope="col" data-field="RES_TIME" id="RES_TIME">예약시간</th>
								 <th scope="col" data-field="DEPT_NAME" id="DEPT_NAME">부서 이름</th>
								 <th scope="col" data-field="SCH_DATE" id="SCH_DATE">예약날짜</th>
								 <th scope="col" data-field="ISOK" id="ISOK">확인</th>
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
	var msg_count = 0;
	/* 채팅 기능 선언부  */
	$(document).ready(function(){

		$("#resList").bootstrapTable('refreshOptions', {
		    url:'/result/fresList?hp_code=<%=hp_code%>'	
		    	    ,onClickRow:function(row,element,field){
			 }
	 	 })


		
		$("#c_List").bootstrapTable('hideLoading');
		
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
