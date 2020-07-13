<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키오스크 관리자 로그인</title>
<%@include file="/Common.jsp" %>
<style type="text/css">
	body {
	  font-size: 30px;
	  margin-top: 200px;
	}
	
</style>
<script type="text/javascript">
		function login(){
			//alert("로그인 버튼 호출 성공");
			var id = $("#k_id").val();
			var pw = $("#k_pw").val();
			//alert(id+"/"+pw);
			if(id==""){
				//alert("id를 입력해주세요");
				$("#confirm").modal();
			}else if(pw==""){
				//alert("pw를 입력해주세요");
				$("#confirm").modal();
			}else{
				$.ajax({
					url:'/Rkiosk/login'
					,data:"mem_id="+id+"&mem_pw="+pw
					,success:function(data){
						if(data.trim()=="성공"){
								location.href="https://192.168.0.247:7000/msg/msg.jsp"
						}else{
								alert("아이디와 비밀번호를 확인해 주세요");
						}
					}
					
				})
			}
			
		}
</script>
</head>
<body>

<div class="container" style="text-align: center;">
	<div class="col-md-12" style="align-content: center;">
        <h1 class="form-signin-heading">키오스크 관리자</h1>
       </div>
	<div class="col-md-12" style="align-content: center;">
        <h2 class="form-signin-heading"style="margin-bottom:40px;margin-top:120px;">로그인</h2>
       	<input type="text" id="k_id" style=" margin-bottom:20px;" class="form-control" value="seaum" placeholder="아이디" required autofocus>
        <input type="password" id="k_pw" style=" margin-bottom:20px;" class="form-control" value="123" placeholder="비밀번호" required>
        <button class="btn btn-lg btn-primary btn-block" style="margin-bottom:20px;" onclick="login()">로그인</button>
	</div>
	<div class="col-md-4" >
	</div>
	<!-- 로그인모달 시작 -->
	<div id="confirm" class="modal" tabindex="-1" role="dialog">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">확인창</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <p>&nbsp;아이디 또는 비밀번호를 입력해주세요.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 로그인 모달 끝 -->
	</div>
</body>
</html>