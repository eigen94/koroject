<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="loginMember" method="post">
		이메일 <input type="text" name="m_email">
		비밀번호<input type="password" name="m_pwd">
		<input type="submit" value="로그인">
	</form>
	<a href="serchMember"><button>비밀번호 찾기</button></a>
	<br>
	${param.message}
</body>
</html>