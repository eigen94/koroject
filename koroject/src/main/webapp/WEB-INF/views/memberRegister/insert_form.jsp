<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원 가입</h2>
	<form action="insert_member" method="post">
		이름<input type="text" name="m_name"><br>
		이메일<input type="text" name="m_email"><br>
		비밀번호<input type="password" name="m_pwd"><br>
		비밀번호 확인<input type="password" name="m_pwdCheck"><br>
		핸드폰 번호<input type="text" name="m_phone"><br>
		질문<select name="m_question">
			<option value="1">고향은?</option>
			<option value="2">이름은?</option>
			<option value="3">주소는?</option>
		</select>
		<input type="text" name="m_answer"><br>
		<input type="submit" value="회원가입">
	</form>
	
	
</body>
</html>