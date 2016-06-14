<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <script src="//code.jquery.com/jquery.min.js"></script> -->
<style type="text/css">
#progressArea {
	
}

#chatting {
	position: fixed;
	bottom: 100;
	right: 0;
	height: 400px;
	border:1px;
	width: 250px;
}
</style>

<script type="text/javascript">
	$(function(){
/* 		$('#btn button').on('click', function(){
			
			var m_email = $('#btn #m_email').val();
			var p_id = $('#btn #p_id').val();
			
			$('#iframeLink').attr("src","http://localhost:7777/?email=" + m_email + "&p_id=" + p_id);
			
			  
			location.href = "http://localhost:7777/?email=" + m_email + "&p_id=" + p_id;
			  
		}) */
			var numberP_id=window.location.href;
			var regExp = /(\/\d+)/g;
			var p_id = (regExp.exec(numberP_id)[0]).replace("/","");
			
			var m_email = $('#btn #m_email').val();
			
			$('#iframeLink').attr("src","http://localhost:7777/?email=" + m_email + "&p_id=" + p_id);
			
			 /* 
			location.href = "http://localhost:7777/?email=" + m_email + "&p_id=" + p_id;
			  */


	})
</script>

</head>
<body>

	<div id="progressArea">
		<div id="btn">
			<input type="text" id="m_email" value="${member.m_email}">
			<input type="text" id="p_id" value="kosta">
			<button>채팅창을 열어주는 임시버튼</button>
		</div>
		
		<div id="chatting">
			<iframe id="iframeLink" src="" width="250" height="400"></iframe>
		</div>
	</div>
	
</body>
</html>