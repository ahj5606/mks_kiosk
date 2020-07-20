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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<style type="text/css">
	body{
		font-family: 'Do Hyeon', sans-serif;
	}
</style>
<script type="text/javascript">
var waitNum;
	function home(){
		location.href="https://192.168.0.247:7000/k_main.jsp";
	}
	function qr_scanner(){
		location.href="https://192.168.0.247:7000/k_scanner.jsp";
	}
	function waiting_ticket(){
		location.href="https://192.168.0.247:7000/k_waiting.jsp";
	}
	function ticketing(){
		alert("대기표발급!");
		share(waitNum);
	}
	function share(wait) {
		var url = 'http://192.168.0.245:5000/client/waitNum.jsp?wait='+wait;
		Kakao.Link.createDefaultButton({
			container: '#kakao-link-btn',
			objectType: 'feed',
			content: {
				title: "mks 코스모 병원",
				description: "대기번호 발급",
				imageUrl: './health_96630.png',
				link: {
					mobileWebUrl: url,
					androidExecParams: 'test'
				}
			},
			buttons: [
				{
					title: '웹으로 이동',
					link: {
						webUrl: url
					},
				},
				{
					title: '앱으로 이동',
					link: {
						mobileWebUrl: url
					},
				}, 
			],
			success: function(response) {
				console.log(response);
			},
			fail: function(error) {
				console.log(error);
			}
		});
	}
	function wait(){
		$.ajax({
			url:'/Rkiosk/wait?hp_code='+'<%=hp_code%>'
			,success:function(data){
				var res = JSON.parse(data)
     			wait_number=res[0].DEPT_LASTWAIT
     			wait_time =res[0].WAIT_TIME
					document.getElementById("dept_lastwait").innerHTML = wait_number
					document.getElementById("wait_time").innerHTML =wait_time
					waitNum=wait_number+1;
			}

		})
	}	
</script>
</head>
<body class="text-center" style="overflow-x:hidden;">
	<!-- 상단 -->
	<div class="jumbotron pt-5 pb-5 text-white rounded " style="background-color: #007bff;">
		<div class="col-md-6 px-0 mx-auto">
			<h1 class="display-4"><%=hp_name %></h1>
        </div>
	</div>
	<!-- 본문 -->
	<div class="container my-5 pb-5 pt-4">
		<div class="row">
			<div class="col-md" style="min-height:452px;">
				<!-- 테이블 -->
				<div class="row w-100 mr-0 mb-4 justify-content-center" style="font-size:xx-large;">
					<table>
						<tr>
							<th style='padding:10px;'>대기인원수</th>
							<td style='padding:10px;' >&nbsp;&nbsp;<div id="dept_lastwait" style="display: inline;">0</div>&nbsp;명</td>
						</tr>
						<tr>
							<th style='padding:10px;'>&nbsp;대기 시간</th>
							<td style='padding:10px;' >&nbsp;<div id="wait_time" style="display: inline;">0</div>&nbsp;분</td>
						</tr>
					</table>
				</div>
				<div class="row mb-4 justify-content-center">
					<img class="card-img-right" style="height: 200px;" src="/resources/img/print2.svg">
				</div>
				<!-- 버튼 -->
				<div class="row h-25">
					<div class="col-md">
						<button type="button" class="btn btn-warning btn-lg" onClick="ticketing()">대기표 발급 받기</button>
					</div>
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
	<script type="text/javascript">
		$(document).ready(function(){
			wait()
			Kakao.init("265447647e1cb17951a10eb622ba9fbc");
		});
	</script>
</body>
</html>