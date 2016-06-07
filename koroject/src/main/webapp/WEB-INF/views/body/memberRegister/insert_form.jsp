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
	<form:form action="insert_member" commandName="registerCommand">
		이름<form:input path="m_name"/><form:errors path="m_name"/><br>
		이메일<form:input path="m_email"/><form:errors path="m_email"/><br>
		비밀번호<form:password path="m_pwd"/><form:errors path="m_pwd"/><br>
		비밀번호 확인<form:password path="m_pwdCheck"/><form:errors path="m_pwdCheck"/><br>
		핸드폰 번호<form:input path="m_phone"/><form:errors path="m_phone"/><br>
		질문<form:select path="m_question">
			<form:option value="1">고향은?</form:option>
			<form:option value="2">이름은?</form:option>
			<form:option value="3">주소는?</form:option>
		</form:select>
		답<form:input path="m_answer"/><br>
		<input type="submit" value="가입완료"><br>
	</form:form>
	
	<%-- <form action="insert_member" method="post">
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
	</form> --%>
	<a href="login_form"><button>로그인</button></a>
	
	
</body>
</html>