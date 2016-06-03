<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	번호 : ${note.n_id }	<br>
	제목 : ${note.n_title}	<br>
	내용 : ${note.n_content}<br><br><br><br>
	
	<a href="note_updateForm${note.n_id }"><button>수정</button></a><br><br>
	<a href="listAll"><button>목록</button></a><br><br>
	<a href="note_delete${note.n_id }"><button>삭제</button></a>
	
</body>
</html>