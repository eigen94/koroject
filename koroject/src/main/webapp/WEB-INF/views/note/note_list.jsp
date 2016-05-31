<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>노트 목록</h3>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>발신인</td>
			<td>수신인</td>
			<td>보낸날짜</td>
		</tr>
		<c:forEach var="note" items="${list }">
		<tr>
			<td>${note.n_id }</td>
			<td><a href="note_detail${note.n_id }">${note.n_title }</a></td>
			<td>${note.n_sender }</td>
			<td>${note.n_receive }</td>
			<td>${note.n_date }</td>
		</tr>
		</c:forEach>
	</table>
	<a href="note_sendForm"><button>보내기</button></a>
</body>
</html>