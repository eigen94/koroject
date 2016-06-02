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
	<h3>${member.m_email }의노트목록</h3>
	<div class="scroll">
		<ul class="message-list">
			<c:forEach var="note" items="${list2 }">
				<hr>
				<li class="message-list-item">
					<div class="clickDiv">
						<div class="message-list-item-header">
							<input type="hidden" name="n_id" value="${note.n_id }">
							<div class="time ng-binding">날짜</div>
							<span class="ng-binding">${note.n_sender }</span>
							<p class="ng-binding">${note.n_title }</p>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
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