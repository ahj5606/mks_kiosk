<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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
		alert("메인화면으로!");
		setTimeout(function() {
			location.href="/kiosk/k_main.jsp";
		}, 500);
	}
	function qr_scanner(){
		//alert("qr 코드 스캔 화면으로 이동!");
		$("#btn_qr").removeClass("border border-light bg-light pb-3");
		$("#btn_qr").addClass("border border-secondary bg-light pb-3");
		setTimeout(function() {
			location.href="/kiosk/k_scanner.jsp";
		}, 500);
	}
	function waiting_ticket(){
		//alert("원무과 대기표 발급 화면으로 이동!");
		$("#btn_waiting").removeClass("border border-light bg-light pb-3");
		$("#btn_waiting").addClass("border border-secondary bg-light pb-3");
		setTimeout(function() {
			location.href="/kiosk/k_waiting.jsp";
		}, 500);
	}
</script>
</head>
<body class="text-center" style="overflow-x:hidden;">
	<!-- 상단 -->
	<div class="jumbotron pt-5 pb-5 text-white rounded " style="background-color: #007bff;">
		<div class="col-md-6 px-0 mx-auto">
			<h1 class="display-4">위대항 병원</h1>
			<p class="lead my-2">welcome to widaehang hospital. we service the best.</p>
        </div>
	</div>
	<!-- 본문 -->
	<div class="container my-5 py-5">
		<div class="row">
			<div class="col-md" style="min-height:428px;">
				<div id="btn_waiting" onClick="waiting_ticket()">
					<div class="card-body d-flex flex-column">
		            	<strong class="d-inline-block mb-2 text-primary">waiting ticket</strong>
		            	<h3 class="mb-0">
		           		<a class="text-dark">원무과 대기표 발급</a>
		            	</h3>
		            </div>
					<img class="card-img-right" style="height: 300px;" src="./print.svg">
				</div>
			</div>
			<div class="col-md">
				<div id="btn_qr" onClick="qr_scanner()">
					<div class="card-body d-flex flex-column">
		            	<strong class="d-inline-block mb-2 text-primary">qr code scanner</strong>
		            	<h3 class="mb-0">
		           		<a class="text-dark">진료 예약 qr 코드 스캔</a>
		            	</h3>
		            </div>
					<img class="card-img-right" style="height: 300px;" src="./qr.svg">
				</div>
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
						<img class="card-img-right" style="height: 50px;" src="./home.svg">
						<a>메인화면</a>
					</div>
				</div>
				<div class="col-1">
					<div class="row" id="wait_menu" onClick="waiting_ticket()">
						<img class="card-img-right"style="height: 50px;" src="./print.svg">
						<a>대기표</a>
					</div>
				</div>
				<div class="col-1">
					<div class="row" id="qr_menu" onClick="qr_scanner()">
						<img class="card-img-right" style="height: 50px;" src="./qr.svg">
						<a>qr코드스캔</a>
					</div>
				</div>
				<div class="col"></div>
			</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#btn_qr").mouseover(function(){
				$("#btn_qr").addClass("border border-light bg-light pb-3");
	        }).mouseout(function(){
				$("#btn_qr").removeClass("border border-light bg-light pb-3");
	        });
			$("#qr_menu").mouseover(function(){
				$("#btn_qr").addClass("border border-light bg-light pb-3");
	        }).mouseout(function(){
				$("#btn_qr").removeClass("border border-light bg-light pb-3");
	        });
			
			$("#btn_waiting").mouseover(function(){
				$("#btn_waiting").addClass("border border-light bg-light pb-3");
	        }).mouseout(function(){
				$("#btn_waiting").removeClass("border border-light bg-light pb-3");
	        });
			$("#wait_menu").mouseover(function(){
				$("#btn_waiting").addClass("border border-light bg-light pb-3");
	        }).mouseout(function(){
				$("#btn_waiting").removeClass("border border-light bg-light pb-3");
	        });
				
		});
	</script>
</body>
</html>