<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="http://localhost:4000/socket.io/socket.io.js"></script>
<script type="text/javascript">
	var socket = io.connect('http://localhost:4000');
	socket.emit('my event', ".");
</script>
<!-- jQuery -->
<script type="text/javascript" src="../js/jquery.min.js"></script>

<!-- BootStrap -->
<link rel="stylesheet" href="../css/bootstrap/bootstrap.css">
<script type="text/javascript" src="../js/bootstrap/bootstrap.min.js"></script>

<style type="text/css">
.center {
	bottom: 300px;
}

.contents {
	margin-left: 100px;
	padding-left: 65px;
	font-size: 20px;
}

body {
	color: white;
}
</style>

</head>
<body>
	<div class="container-fluid">


		<div class="row contents">

			<!-- content -->
				<div class="col-md-12 content">
					<table class="table">
						<thead>
							<tr>
								<th>${post.send_id }님이${post.receive_id }님에게보낸쪽지<br>${post.p_date }</th>
							</tr>
						</thead>
						<tr>
							<th><div class="con">
									<span class="cons">&nbsp;&nbsp;${post.p_content }</span>
								</div></th>
						</tr>
					</table>
					<form name="fmt">
						<input type="hidden" name="id" value="${id }"> <input
							type="hidden" name="p_num" value="${post.p_num }">
						<div class="button2">
							<input type="hidden" name="send_id" value="${post.send_id }">
							<button type="button" class="btn btn-default btn-sm"
								name="p_delete" id="p_delete">삭제</button>
							<c:if test="${post.p_check == 1 }">
								<input type="hidden" name="page" value="st">
								<button type="button" class="btn btn-default btn-sm"
									name="p_response" id="p_response">답장</button>
								<button type="button" class="btn btn-default btn-sm"
									name="p_list" id="p_list">목록</button>
							</c:if>
							<c:if test="${post.p_check != 1 }">
								<input type="hidden" name="page" value="r">
								<button type="button" class="btn btn-default btn-sm"
									name="p_store" id="p_store">보관</button>
								<button type="button" class="btn btn-default btn-sm"
									name="p_response" id="p_response">답장</button>
								<button type="button" class="btn btn-default btn-sm"
									name="p_list" id="p_list">목록</button>
							</c:if>

						</div>
						<%-- <input type="hidden" name="id" value="${post.receive_id }"> --%>
					</form>
				</div>
		</div>
	</div>


</body>
</html>