<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HttpSession sess = request.getSession();
	String hp_code = null;
	if(sess.getAttribute("hp_code")==null){
		response.sendRedirect("./loginFail.jsp");
	}else{
	    hp_code = sess.getAttribute("hp_code").toString();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QR스캔페이지</title>
<!-- <meta http-equiv="refresh" content="18; url=./kiosk.jsp"> -->
<style type="text/css">
	#d{
		background-color: #CEF279;
	
	}
	main {
		width: 100%;
		height: 100%;
		text-align: center;
	}
	
	
	main>div:first-child {
		width: 100%;
	}
	
	main>div:last-child {
		background-color: #00D8FF;
		width: 100%;
	}
	
	div#output {
		background-color: #00D8FF;
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 10px;
		padding-bottom: 10px;
	}
	
	div#frame {
		border: 2px solid #005666;
		background-color: #FFFFFF;
		margin-left: 10px;
		margin-right: 10px;
		padding-left: 8px;
		padding-right: 8px;
		padding-top: 8px;
		padding-bottom: 8px;
	}
	
	div#outputLayer {
		text-align: left;
	}
	
	canvas {
		width: 100%;
		hight: 100%;
	}
</style>
<%@include file="/Common.jsp" %>
<script type="text/javascript">
	function qrScan(qrcode){
		$("#resList").bootstrapTable('refreshOptions', {
		    url:'/result/result?qrcode='+qrcode
		    ,onClickRow:function(row,element,field){
		//웹소켓으로 서버에게 보낼 값.
				var mem_name = row.MEM_NAME;
				var doc_name = row.DOC_NAME;
				var res_time = row.RES_TIME;
				var dept_name = row.DEPT_NAME;
				var sch_date = row.SCH_DATE;
				let msg =mem_name+":"+doc_name+":"+res_time+":"+dept_name+":"+sch_date+":<%=hp_code%>" ;
				alert(msg);
				if(msg.trim().length<1){	//빈공간 문자열 출력 
					socket.send(msg_null+msg);
				}
				else{	
					socket.send(msg_chat+msg);//소켓에 입력된 메시지를 보낸다.
				}
				
			 }
	 	 })
		$("#res").modal('show');
		$("#res").modal('toggle');
		//location.href="/result/result?qrcode="+qrcode
	}
	function back(){
		location.href="./kiosk.jsp"

	}
	function resok(){
			location.href="./qrscan.jsp";
	}
</script>


<script>
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

<div id="d" class="container-fluid" id="sidebar" style="height:910px;">
	    <div class="row">
	        <div class="col-sm-3"   style="text-align: center;">
	        <!--  
	       		 <img src="resources/img/scanning.gif" style="width:60% ; height: 40%; margin-top: 150px;"/>
	        -->
	        </div>
	        <div class="col-sm-6"  style="text-align: center;">
	        	<main>
					<div id="test">
						<h1>QR 코드 스캔</h1>
						<div id="output">
							<div>QR코드를 카메라에 노출시켜 주세요</div>
							<div id="countdown"></div>
						</div>
					</div>
					<div>&nbsp;</div>
					<div>
						<h1>카메라</h1>
						<div id="frame">
							<div id="loadingMessage">
								🎥 비디오 스트림에 액세스 할 수 없습니다<br />웹캠이 활성화되어 있는지 확인하십시오<br><br><br><h2>관리자에게 문의하세요.</h2>
							</div>
							<canvas id="canvas"></canvas>
						</div>
					</div>
				</main>
	        </div>
			<div class="col-sm-3"   style="text-align: center;">
	        	<!--  
	        	<img src="resources/img/scanning2.gif" style="width:60% ; height: 40%; margin-top: 150px;"/>
	        	-->
	      	</div>
	    </div>
	</div>
	
	<!-- modal   -->
		<div class="modal fade" id="res" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-xl" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">확인</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				      
				      <table class="table table-hover" id="resList" data-toggle="table">
						<thead>
						 	<tr>
					 			 <th scope="col" data-field="MEM_NAME" id="MEM_NAME">환자 이름</th> 	
								 <th scope="col" data-field="MEM_PHONE">환자 전화번호</th> 
								 <th scope="col" data-field="MEM_ADDRESS">환자 주소</th>
								 <th scope="col" data-field="DOC_NAME" id="DOC_NAME">의사 이름</th>
								 <th scope="col" data-field="RES_TIME" id="RES_TIME">예약시간</th>
								 <th scope="col" data-field="DEPT_NAME" id="DEPT_NAME">부서 이름</th>
								 <th scope="col" data-field="HP_NAME">병원 이름</th>
								 <th scope="col" data-field="SCH_DATE" id="SCH_DATE">예약날짜</th>
				  			</tr>
						</thead>
					 </table>
					 <div style="color: #FF0000; text-align: center;"><h1>위 예약내역을 클릭해 주세요</h1></div>
			      	  </div>
			     <div class="modal-footer">
			       <button type="button" class="btn btn-primary" onClick="resok()">다시 스캔</button>
			       <button type="button" class="btn btn-secondary" onClick="back()">뒤로가기</button>
			     </div>
			   </div>
			 </div>
		</div>	
	<!-- modal   -->
	
</body>
<script type="text/javascript">
var socket=null;
var msg_chat = "100#";	 		//방채팅 
var msg_exit = "500#";
$(document).ready(function(){
	/* var timeleft = 15;
	var downloadTimer = setInterval(function(){
	  document.getElementById("countdown").innerHTML = timeleft + " 초 뒤에 선택화면으로 이동됩니다.";
	  timeleft -= 1;
	  if(timeleft <= 0){
	    clearInterval(downloadTimer);
	    document.getElementById("countdown").innerHTML = "Finished"
	  }
	}, 1000); */
	connectWS();
	
})
document.addEventListener("DOMContentLoaded", function() {
	var video = document.createElement("video");
	var canvasElement = document.getElementById("canvas");
	var canvas = canvasElement.getContext("2d");
	var loadingMessage = document.getElementById("loadingMessage");
	var outputContainer = document.getElementById("output");
	function drawLine(begin, end, color) {
		canvas.beginPath();
		canvas.moveTo(begin.x, begin.y);
		canvas.lineTo(end.x, end.y);
		canvas.lineWidth = 4;
		canvas.strokeStyle = color;
		canvas.stroke();
	}
	// 카메라 사용시
	navigator.mediaDevices.getUserMedia({
		video : {
			facingMode : "environment"
		}
	}).then(function(stream) {
		video.srcObject = stream;
		video.setAttribute("playsinline", true); 
		video.play();
		requestAnimationFrame(tick);
	});
	function tick() {
		loadingMessage.innerText = " 스캔 기능을 활성화 중입니다."
		if (video.readyState === video.HAVE_ENOUGH_DATA) {
			loadingMessage.hidden = true;
			canvasElement.hidden = false;
			outputContainer.hidden = false;
			// 읽어들이는 비디오 화면의 크기

			canvasElement.height = video.videoHeight;
			canvasElement.width = video.videoWidth;
			canvas.drawImage(video, 0, 0, canvasElement.width,
					canvasElement.height);
			var imageData = canvas.getImageData(0, 0, canvasElement.width,
					canvasElement.height);
			var code = jsQR(imageData.data, imageData.width,
					imageData.height, {
						inversionAttempts : "dontInvert",
					});

			// QR코드 인식에 성공한 경우

			if (code) {
				var qrcode = code.data;
				qrScan(qrcode);
				 return;
			}
			// QR코드 인식에 실패한 경우 
			else{
			
			}
		}
		requestAnimationFrame(tick);
	}
});
	
</script>
</html>