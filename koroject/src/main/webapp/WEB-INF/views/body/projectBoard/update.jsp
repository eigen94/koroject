<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="update" method="post">
		<input type="hidden" name="pId" value="${pId }">
		프로젝트 이름 : <input type="text" name="pTitle"><br>
		프로젝트 시작일 : <input type="date" name="pStart">
		프로젝트 종료일 : <input type="date" name="pEnd"><br>
		메모 <br>
		<textarea rows="6" cols="70" name="pContent"></textarea>
		<br>
		<input type="submit" value="등록">
	</form>
</body>
</html>