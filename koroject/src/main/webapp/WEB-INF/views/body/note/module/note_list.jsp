<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	
</script>
<title>Insert title here</title>
</head>
<body>
	<h3>${member.m_email }의쪽지목록</h3>
	<div class="note_search">
		<input type="text" id="m_id" value="${m_id }">
		<select name="searchType">
			<option value="n"
				<c:out value="${cri.searchType == null?'selected':''}"/>>
				---</option>
			<option value="t"
				<c:out value="${cri.searchType eq 't'?'selected':''}"/>>제목</option>
			<option value="c"
				<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>내용</option>
			<option value="w"
				<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>보낸이</option>
			<option value="tc"
				<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>제목
				OR 내용</option>
			<option value="cw"
				<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>내용
				OR 보낸이</option>
			<option value="tcw"
				<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
				전체</option>
		</select> <input type="text" name='keyword' id="keywordInput"
			value='${cri.keyword }'>
		<button id='searchBtn'>Search</button>
	</div>
	<div class="scroll">
		<div class='box-body'>
			<ul class="message-list">
				<c:forEach var="note" items="${list }">
					<li class="message-list-item">
						<div class="clickPoint">
							<div class="message-list-item-header">
								<input type="hidden" value="${note.n_id }">
								<div class="time ng-binding">날짜</div>
								<span class="ng-binding">${note.n_title }</span>
								<p class="ng-binding">${note.n_content }</p>
							</div>
						</div>
						<button id="noteDelete">삭제</button>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>






	<%-- 
	<table border="1">
		<c:forEach var="note" items="${list2 }">
			<tr>
				<td>${note.n_id }</td>
				<td><a href="note_detail${note.n_id }">${note.n_title }</a></td>
				<td>${note.n_sender }</td>
				<td>${note.n_date }</td>
			</tr>
		</c:forEach>
	</table> 
	--%>



</body>
</html>