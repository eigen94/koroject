<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="/resources/js/noteScript.js"></script>

<link rel="stylesheet" type="text/css" href="/resources/css/noteStyle.css">

</head>
<body>

	<h3 style="margin:20px 0px 20px 70px;">${member.m_name }님의 쪽지목록</h3>
	
	<div class="noteBody">
		<!-- 좌측에 버튼들 -->
		<div class="left">
			<div class="clickToggle"><button id="toggleBtn" style="margin-left:50px;">V</button></div><br>
			<hr style="margin:8px;">
			<div class="toggleDiv">
				<div class="sendform">	<button id="button"> 쪽지 보내기 </button>	</div>
				<div class="sendList"><button id="button"> 보낸 쪽지함 </button></div>
				<div class="receiveList"><button id="button"> 받은 쪽지함 </button></div>
			</div>
		</div>
		
		<!-- 우측 영역 -->
		<div class="right">
			<div class="sendFormArea" id="offSendForm">
				<%-- <jsp:include page="noteSend.jsp"/> --%>
				<form action="note_send" method="post" id="formTag">
					<div class="noteForm">
						<div class="hidden_text">
							<input type="hidden" name="n_sender" value="${m_id }">
						</div>
						<div class="input_text">
							<div class="title"> 
							<h3> 제목 </h3>
								<input type="text" name="n_title">
							</div>
							<div class="receive">
							<h3> 받는사람 </h3>
								<button class="searchOpen">이메일 검색</button>
								<input type="text" id="n_receiveEmail" name="n_receiveEmail">
								<input type="hidden" id="n_receive" name="n_receive">
							</div>
							<div class="content">
							<h3> 내용 </h3>
								<textarea rows="10" cols="" name="n_content"></textarea>
							</div>
						</div>
					</div>

					<div class="send">
						<input type="submit" value="전송">
					</div>
				</form>
			</div>
			
			<div class="listAndDetailArea" id="onlistAndDetail">
				<!-- 바디영역 -->
				<div class="right_left">
					<%-- <jsp:include page="noteList.jsp"/> --%>
					<div class="note_search">
						<input type="hidden" id="m_id" value="${m_id }"> 
						<select name="searchType" id="searchType">
							<option value="n" <c:out value="${cri.searchType == null?'selected':''}"/>>선택하세요</option>
							<option value="t" <c:out value="${cri.searchType eq 't'?'selected':''}"/>>제목</option>
							<option value="c" <c:out value="${cri.searchType eq 'c'?'selected':''}"/>>내용</option>
							<option value="w" <c:out value="${cri.searchType eq 'w'?'selected':''}"/>>보낸이</option>
							<option value="tc" <c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>제목 OR 내용</option>
							<option value="cw" <c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>내용 OR 보낸이</option>
							<option value="tcw" <c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>제목 OR 내용 OR 보낸이</option>
						</select> 
	
						<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
						<div class="searchBtn">
							<button id='sen_btn'>보낸쪽지검색</button>
							<button id='rec_btn'>받은쪽지검색</button>
						</div>
					</div>
					<div class="listlist">
					<div class="scroll">
						<div class='box-body'>
							<ul class="message-list">
								<c:forEach var="note" items="${list }">
								
									<li class="message-list-item">
										<button id="noteDelete">X</button>
										<div class="clickPoint">
											<div class="message-list-item-header">
												<input type="hidden" value="${note.n_id }">
												<fmt:formatDate value="${note.n_date }" pattern="yy-MM-dd hh:mm"/>
												<span class="note_senderEmail">${note.senderEmail }</span>
												<hr style="margin: 2px;">
												<p class="note_title">${note.n_title }</p>
												<p class="note_content">${note.n_content }</p>
											</div>
										</div>
									</li>
									
								</c:forEach>
							</ul>
						</div>
					</div>
					</div>
				</div>
			
				<!-- 우 영역 -->
				<div class="right_right">
					<%-- <jsp:include page="content.jsp"/> --%>
					<div class="noteDetail">
						<input type="hidden" name="noteId" value="">
						<div class="noteTitle">
							<span id="noteTitle"></span>
						</div>
						<div class="noteContent">
							<p id="noteContent"><h1> 선택된 쪽지가 <br>없습니다</h1></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>