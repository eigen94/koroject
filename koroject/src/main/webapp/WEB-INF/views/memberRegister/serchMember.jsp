<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="serchMember" method="post">
	이메일<input type="text" name="m_email"><br>
	질문<select name="m_question">
			<option value="1">고향은?<option>
			<option value="2">이름은?<option>
			<option value="3">주소는?<option>
		</select>
	답<input type="text" name="m_answer"/><br>
	<input type="submit" value="비밀번호 찾기">
</form>
<br>
${param.message}
</body>
</html>