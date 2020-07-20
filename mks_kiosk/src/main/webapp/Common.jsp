<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
%>
<script src="<%=path %>resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="<%=path %>resources/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path %>resources/css/jquery-ui.css">
<script src="<%=path %>resources/js/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=path %>resources/css/keyboard.css">
<script src="<%=path %>resources/js/jquery.keyboard.js"></script>
<script src="<%=path %>resources/js/jquery.keyboard.extension-autocomplete.js"></script>
<script src="<%=path %>resources/js/jquery.keyboard.extension-typing.js"></script>
<script src="<%=path %>resources/js/jquery.mousewheel.js"></script>
<script src="<%=path %>resources/js/bootstrap-table.min.js"></script>
<script src="<%=path %>resources/js/bootstrap.min.js"></script>
<script src="<%=path %>resources/js/jsQR.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path %>resources/css/bootstrap-grid.css">
<link rel="stylesheet" type="text/css" href="<%=path %>resources/css/bootstrap-reboot.css">
<script src='<%=path.toString()%>resources/js/kakao_img.js'></script>
<style>
table{font-size: 20px;}
</style>