<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="noteDetail">
		<div class='box-body'>
			<select name="searchType">
				<option value="n"
					<c:out value="${cri.searchType == null?'selected':''}"/>>
					---</option>
				<option value="t"
					<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
					제목</option>
				<option value="c"
					<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
					내용</option>
				<option value="w"
					<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
					보낸이</option>
				<option value="tc"
					<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
					제목 OR 내용</option>
				<option value="cw"
					<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
					내용 OR 보낸이</option>
				<option value="tcw"
					<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
					전체</option>
			</select> <input type="text" name='keyword' id="keywordInput"
				value='${cri.keyword }'>
			<button id='searchBtn'>Search</button>
			<button id='newBtn'>New Board</button>

		</div>
		<div class="noteTitle"></div>
		<div class="noteContent"></div>
	</div>
</body>
</html>