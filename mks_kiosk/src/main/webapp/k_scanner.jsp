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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Cover Template for Bootstrap</title>
<%@include file="/Common.jsp" %>
<style type="text/css">
	body{
		font-family: 'Do Hyeon', sans-serif;
	}
</style>
<script type="text/javascript">
	function home(){
		location.href="https://192.168.0.247:7000/k_main.jsp";
	}
	function qr_scanner(){
		location.href="https://192.168.0.247:7000/k_scanner.jsp";
	}
	function waiting_ticket(){
		location.href="https://192.168.0.247:7000/k_waiting.jsp";
		
	}
</script>
<script type="text/javascript">
var qr =0;
	function qrScan(qrcode){
		qr = qrcode;
		$("#resList").bootstrapTable('refreshOptions', {
		    url:'/result/result?qrcode='+qrcode+'&hp_code=<%=hp_code%>'	
		    	    ,onClickRow:function(row,element,field){
		//웹소켓으로 서버에게 보낼 값.
				var mem_name = row.MEM_NAME;
				var doc_name = row.DOC_NAME;
				var res_time = row.RES_TIME;
				var dept_name = row.DEPT_NAME;
				var sch_date = row.SCH_DATE;
				let msg =mem_name+":"+doc_name+":"+res_time+":"+dept_name+":"+sch_date+":<%=hp_code%>"+":"+qrcode ;
				alert(msg);
				if(msg.trim().length<1){	//빈공간 문자열 출력 
					socket.send(msg_null+msg);
					
				}
				else{	
					socket.send(msg_chat+msg);//소켓에 입력된 메시지를 보낸다.
					updQr()
				}
				
			 }
	 	 })
		$("#res").modal('show');
		$("#res").modal('toggle');
		//location.href="/result/result?qrcode="+qrcode
	}
	function back(){
		location.href="https://192.168.0.247:7000/k_main.jsp"

	}
	function resok(){
			location.href="https://192.168.0.247:7000/k_scanner.jsp";
	}
	function updQr(){
		$.ajax({
			url:'/Rkiosk/update?qrcode='+qr
			,success:function(data){
				if(data.trim()=="성공"){
					alert("예약 확인에 성공하였습니다.");
					location.href="https://192.168.0.247:7000/k_main.jsp";
				}
			}
		
		})
	}
	
</script>
<script>
	function connectWS(){
		var hp_code = "<%=hp_code%>"
		var ws = new WebSocket("wss:\\\\192.168.0.247:7000\\echo?hp_code:"+hp_code);
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
<body class="text-center" style="overflow-x:hidden;">
	<!-- 상단 -->
	<div class="jumbotron pt-5 pb-5 text-white rounded " style="background-color: #007bff;">
		<div class="col-md-6 px-0 mx-auto">
			<h1 class="display-4"><%=hp_name %></h1>
			<p class="lead my-2">welcome to widaehang hospital. we service the best.</p>
        </div>
	</div>
	<!-- 본문 -->
	<div class="container mt-1 mb-3 pt-1 pb-3">
		<div class="row">
			<div class="col-md" style="min-height:552px;">
				<!-- 상단 -->
				<div class="row">
					<div class="col-md">
						<h5>진료 예약 qr 코드 스캔</h5>
					</div>
				</div>
				<div class="row mb-4">
					<div class="col-md" id="output">
						&nbsp;&nbsp;&nbsp;qr코드를 카메라에 노출시켜 주세요.&nbsp;&nbsp;&nbsp;
						<span id="countdown"></span>
					</div>
				</div>
				<!-- 카메라 -->
				<div class="border mt-3 mx-auto w-75" style="background-color:#000000;height:467px;">
					<div class="border m-3" style="background-color:#FFFFFF;height:428px;">
						<!-- 로딩 메세지 -->
						<div class="row pt-5" id="loadingMessage">
							<div class="col-md" style="text-align:center;">
								<h4>[ 카메라  ]</h4>
								<span style="color:red;">
									※ 비디오 스트림에 엑세스 할 수 없습니다.<br>웹캠이 활성화되어 있는지 확인하십시오.<br><br><h2>관리자에게 문의하세요.</h2></span>
							</div>
						</div>
						<!-- canvas -->
						<div class="row">
							<div class="col-md">
								<canvas id="canvas" style="background-color:#000000;"></canvas>
							</div>
						</div>
					</div>
				</div><!-- 카메라 끝 -->
			</div>
		</div>
	</div>
	<!-- 하단 -->
	<div class="fooger" style="height:140px;background-color: #007bff;">
		<div class="row pt-4">
			<div class="col"></div>
			<div class="col-4">
				<a href="#" style="color:#FFFFFF;font-size:xx-large">Ko:MEDI</a>
			</div>
			<div class="col-2"></div>
			<div class="col-1">
				<div class="row" onClick="home()">
					<img class="card-img-right" style="height: 50px;" src="/resources/img/home.svg">
					<a>메인화면</a>
				</div>
			</div>
			<div class="col-1">
				<div class="row" id="wait_menu" onClick="waiting_ticket()">
					<img class="card-img-right"style="height: 50px;" src="/resources/img/print.svg">
					<a>대기표</a>
				</div>
			</div>
			<div class="col-1">
				<div class="row" id="qr_menu" onClick="qr_scanner()">
					<img class="card-img-right" style="height: 50px;" src="/resources/img/qr.svg">
					<a>qr코드스캔</a>
				</div>
			</div>
			<div class="col"></div>
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
	<script type="text/javascript">
var socket=null;
var msg_chat = "100#";	 		//방채팅 
var msg_exit = "500#";
$(document).ready(function(){
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
</body>
</html>