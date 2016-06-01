<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>${member.m_email }의노트 목록</h3>
	
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>발신인</td>
			<td>보낸날짜</td>
		</tr>
		<c:forEach var="note" items="${list2 }">
				<tr>
					<td>${note.n_id }</td>
					<td><a href="note_detail${note.n_id }">${note.n_title }</a></td>
					<td>${note.n_sender }</td>
					<td>${note.n_date }</td>
				</tr>
		</c:forEach>
	</table>

	<div class='box-body'>

		<select name="searchType">
			<option value="n"
				<c:out value="${cri.searchType == null?'selected':''}"/>>
				---</option>
			<option value="t"
				<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
				Title</option>
			<option value="c"
				<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
				Content</option>
			<option value="w"
				<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
				Writer</option>
			<option value="tc"
				<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
				Title OR Content</option>
			<option value="cw"
				<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
				Content OR Writer</option>
			<option value="tcw"
				<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
				Title OR Content OR Writer</option>
		</select> 
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
		
		<button id='searchBtn'>Search</button>
		<button id='newBtn'>New Board</button>

	</div>

	<a href="note_sendForm"><button>보내기</button></a>
</body>
</html>