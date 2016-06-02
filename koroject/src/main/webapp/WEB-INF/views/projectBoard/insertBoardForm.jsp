<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="insertBoard" method="post">
		프로젝트 이름 : <input type="text" name="p_name"><br>
		프로젝트 시작일 : <input type="date" name="p_start">
		프로젝트 종료일 : <input type="date" name="p_end"><br>
		메모 <br>
		<textarea rows="6" cols="70" name="p_memo"></textarea>
		<br>
		<input type="submit" value="등록">
	</form>
</body>
</html>