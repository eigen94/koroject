<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	업데이트폼
	
	<form action="note_update" method="post">
		<input type="hidden" name="n_id" value="${note.n_id }">
		제목 : <input type="text" name="n_title" value="${note.n_title }">
		내용 : <textarea name="n_content" rows="" cols="">${note.n_content }</textarea>

		<input type="submit" value="수정">	
	
	</form>
	
</body>
</html>