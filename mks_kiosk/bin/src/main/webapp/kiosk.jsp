<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 키오스크</title>
<%@include file="/Common.jsp" %>
<style type="text/css">
 body{
 	background-color: #00D8FF
 
 }
.navbar-nav > li > a { padding: 26px 25px }
</style>
<script type="text/javascript">
	function wait(){

		alert("대기번호 뽑기");
	}
	
	function qrcode(){

		location.href="./qrscan.jsp"
	}

</script>
</head>
<body>
<nav  class="navbar  navbar-expand-sm  bg-dark"> 
  <ul  class="navbar-nav"> 
    <li  class="nav-item"> 
      <a  class="nav-link" style="color: white; font-size: 30px;">병원 키오스크</a> 
    </li> 
  </ul> 
</nav> 

​

<!-- 리스트 처리 시작  -->
	
	<div class="container-fluid" id="sidebar">
	    <div class="row">
	        <div class="col-sm-6"  id="sticky-sidebar" style="text-align: center;">
	        <%
	        	HttpSession sess = request.getSession();
	        	String str = sess.getAttribute("hp_code").toString();
	        	out.print(str);
	        %>
	        <a onClick="wait()"><img src="resources/img/wait.jpg"/></a>
	        </div>
	        <div class="col-sm-6" id="main" style="text-align: center;">
	       <a onClick="qrcode()"><img src="resources/img/qrcode.jpg"/></a>
	        	
	        	
	        </div>
	    </div>
	</div>
<!-- 리스트 처리 끝  -->




</body>
</html>