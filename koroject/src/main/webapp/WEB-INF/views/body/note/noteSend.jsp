<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function receive(email) {

		$('.receive #n_receiveEmail').val(email);

		$.ajax({
			url : "getM_id?m_id=" + email,
			dataType : 'json',
			success : function(data) {
				$('.receive #n_receive').val(data);
			}
		});

	}
	//noteForm
	$(function() {

		$('#formTag button').click(function() {
			return false;
		});

		$('.searchOpen')
				.on(
						'click',
						function() {
							var popUrl = "search"; //팝업창에 출력될 페이지 URL
							var popOption = "width=370, height=360, resizable=no, scrollbars=no, "
									+ "status=no; scrollbars = no; resizable = no"; //팝업창 옵션(optoin)
							window.open(popUrl, "", popOption);
						})
	});

	//storage
	$(function() {
		$('.box button').on('click', function() {
			//히든값으로 들어가있는 n_id값
			var id = $('.hidden_text input').val();
			location.href = "note_list";
		})
	})
</script>
</head>
<body>


	<form action="note_send" method="post" id="formTag">
		<div class="noteForm">
			<div class="hidden_text"><input type="hidden" name="n_sender" value="${m_id }"></div>
			<div class="input_text">
				<div class="title">제목: <input type="text" name="n_title"></div>
				<div class="receive">
					받는사람: <input type="text" id="n_receiveEmail" name="n_receiveEmail">
					<input type="hidden" id="n_receive" name="n_receive">
					<button class="searchOpen">이메일 검색</button>
				</div>
				<div class="content"> 내용 : <textarea name="n_content"></textarea></div>
			</div>
		</div>

		<div class="send">
			<input type="submit" value="전송">
		</div>
	</form>







	<!-- 
	
	<form action="note_send" method="post">
		제목 : <input type="text" name="n_title" >
		내용 : <textarea name="n_content" rows="" cols=""></textarea>
		발신 : <input type="text" name="n_sender" >
		수신 : <input type="text" name="n_receive" >
		<input type="submit" value="입력">	
	
	</form>
	<a href="listAll"><button>취소</button></a>
	
	 -->

</body>
</html>