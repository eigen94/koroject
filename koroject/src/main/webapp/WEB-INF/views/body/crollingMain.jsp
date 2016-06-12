<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/jquery.scrolly.min.js"></script>
<script type="text/javascript">
$(function(){
		var href = "";
		var count = 0;
		$.ajax({
			url: '/croll',
			dataType: "json",
			 success:function(data){
				$.each(data,function(){
					$('#news').append('<br>');
					$('#news').append(this);
					href = $('#news').children().last().attr('href');
					$('#news').children().last().attr('href', '');
					$('#news').append('<input type="hidden" class="href" value="'+href+'">')
					console.log($('#news a'))
					$('#news a').addClass('link')
					console.log(href);
				})					
				
			 }
		});
	
	
	
	$("body").on('click',".link",function(event){
		event.preventDefault()
		var href = $(this).next().val();
		$("#content").empty();
		$.ajax({
			url: '/news?href='+href,
			dataType: "json",
			 success:function(data){
				 $.each(data,function(){
					
				 	$("#content").append('<br>');
				 	$("#content").append(this);
				 })
			 }
		});
	});
});
</script>

<body>

<div id="news"></div>
<div id="content"></div>

</body>
</html>