<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HttpSession sess = request.getSession();
	if(sess.getAttribute("hp_code")==null){
		response.sendRedirect("../loginFail.jsp");
	}
	String hp_code = sess.getAttribute("hp_code").toString();
	out.print(hp_code);
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 이력</title>
<%@include file="/Common.jsp" %>
<script>
	function connectWS(){
		var ws = new WebSocket("ws:\\\\192.168.0.247:7000\\echo?hp_code:<%=hp_code%>"); //여기에 세션에서 얻은 병원코드를 보냄 
		socket = ws;	
		ws.open = function(message){
			console.log(message);
		};
		// 서버로부터 메시지를 받았을 때
		ws.onmessage=function(event){
			
			var data= event.data;
			alert(data);
			var str = ""+data;
			var imsi = str.split(":");
			var separ = imsi[0];
			var mem_name = imsi[1];
			var doc_name = imsi[2];
			var res_time = imsi[3];
			var dept_name = imsi[4];
			var sch_date = imsi[5];

			alert("separ ="+separ +" mem_name = "+mem_name+"  doc_name= "+doc_name+" res_time= "+res_time+" dept_name= "+dept_name+ " sch_date= "+sch_date)
						
			 var tableText ="<tr>";
			if(separ=='100'){
				tableText +="<td>"+mem_name+"</td>"
				tableText +="<td>"+doc_name+"</td>"
				tableText +="<td>"+res_time+"</td>"
				tableText +="<td>"+dept_name+"</td>"
				tableText +="<td>"+sch_date+"</td>"
				tableText +="</tr>"
				$("#patient").append(tableText);
			}else if(separ=='102'){
				msg_count = msg_count+1;
				document.getElementById('msg_count').innerText=msg_count;
				tableText +='<td onClick="test('+"'"+mem_name+"'"+","+"'"+res_time+"'"+')" >'+mem_name;
				tableText +="<td>"+doc_name+"</td>"
				tableText +="<td>"+res_time+"</td>"
				tableText +="</tr>"
				$("#chatList").append(tableText);
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
	function test(mem_name,res_time){
		alert(mem_name);
	}
	
	function chatModal(){
		$("#chat_modal").modal('show');
		msg_count=0;
		document.getElementById('msg_count').innerText=msg_count;
	}
</script>
</head>
<body>
<div style="text-align: center;">
<div>
	<h1>환자 예약 내역 확인 테이블</h1>
	<div class="float-right"> 
	<span class="badge badge-danger" ><div id="msg_count">0</div></span>
		<button type="button" class="btn btn-secondary" data-toggle="modal" onClick="chatModal()">문의 채팅내역</button> 
	</div>
</div>
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


<!--  -->
		<div class="modal" id="chat_modal" aria-hidden="true" style="display: none; z-index: 1060;">
				  <div class="modal-dialog modal-lg">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="Search">문의 채팅</h5>
				      </div>
				      <div class="modal-body">
				      <div>
					<br>
				      	 <table class="table table-hover" id="c_List" data-toggle="table">
						<thead>
						 	<tr>
					 			 <th scope="col" data-field="name">문의자</th> 	
								 <th scope="col" data-field="time">시간</th>
								 <th scope="col" data-field="c">채팅내용</th>
				  			</tr>
						</thead>
						<tbody id="chatList">
							<tr>
								 <th></th> 	
								 <th></th> 	
								 <th></th> 		
							<tr>
						</tbody>
					 </table>
				      </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				      </div>
				    </div>
				  </div>
				</div>	
		    	
<script type="text/javascript">
	var socket=null;
	var msg_chat = "100#";	 		//방채팅 
	var msg_private = "102#";
	var msg_exit = "500#";
	var msg_count = 0;
	/* 채팅 기능 선언부  */
	$(document).ready(function(){
		$("#resList").bootstrapTable('hideLoading');
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
