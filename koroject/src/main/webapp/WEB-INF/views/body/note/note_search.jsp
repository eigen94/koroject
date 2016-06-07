<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">


//search
$(function() {
	
	//검색 버튼
	$('.search button').on('click', function () {
		/*var search = $('#emailSearch').val();*/
		var search = $('.search input').val();
		location.href="searchId?name="+ search;
	})
	
	//검색된 아이디 클릭
	$('.list a').on('click', function() {
		var email = $(this).html();
		window.opener.receive(email);
		self.close();
	})
	
});
</script>
</head>
<body>
	<div class="search">
		<input type="text" name="search">
		<button>검색</button>
	</div>
		<hr>
	<div class="list">
		<c:forEach var="list" items="${list }">
			
			<a href="#">${list }</a><br>
			<hr>
		</c:forEach>
	</div>
</body>
</html>