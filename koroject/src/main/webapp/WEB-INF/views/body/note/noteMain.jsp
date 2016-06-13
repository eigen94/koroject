<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="/resources/js/noteScript.js"></script>
<!-- 
<link rel="stylesheet" type="text/css" href="/resources/css/noteStyle.css">
 -->
 
 <style type="text/css">
 /* 전체 */
.noteBody {
	padding: 50px 0px;
	display: inline-table;
	height: auto;
    left: 50px; right: 0;
    word-spacing: 1pt;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* 전체 끝 */

/* 좌측 */
.left {
	border:1;
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
}

/* 좌측 끝 */

/* 좌측 버튼 */

.toggleDiv #over{
    color: #000;
    position: relative;
    text-decoration: none;
    z-index: 24;
}

.toggleDiv #over:hover{
    color: #000;
    position: relative;
    text-decoration: none;
    z-index: 24;
}

.left button {
	margin: 10px;
	height: 50px;
	width: 100%;
	border: 0;
	outline: 0;
	overflow: visible;
}

.left #toggleBtn {
	height: 100px;
	width: 100%;
	left: 0;
}

/* 좌측 버튼 끝 */

/* 우측 */
.right {
	float: right;
	margin-left : 50px;
	width: 70%;
	height: 100%;
}

/* 쪽지전송폼 숨김 */
.right #offSendForm {
	display: none;
}

/* 쪽지전송폼 보임 */
.right #onSendForm {
	display: inline;
}

/* 노트 리스트 숨김 */
.right #offListAndDetail {
	display: none;
}

/* 노트 리스트 보임 */
.right #onListAndDetail {
	display: inline;
}

/* 쪽지 전송 */
.input_text div {
	margin: 20px 0px;
}

/* 쪽지 전송 끝 */

/* 리스트 */
.right_left {
	float: left;
	width: 40%;
	height: 100%;
	text-align: center;
}

.scroll {
	/* height: 100%; */
 	overflow-x:auto;
 	overflow-x:hidden;
	width: 100%;
	height: 350px;
	margin-top: 50px;
}

ul {
	list-style: none;
}

#searchType, #keywordInput, .searchBtn a{
	height: 30px;
}

/* 검색버튼 */
.searchBtn {
	display: inline;
}

.searchBtn a{
	display: inline;
	width: 50%;
	text-align: left;
	overflow:visible;
	border: 0;
	outline: 0;
}

.searchBtn #sen_btn, .searchBtn #rec_btn{
	margin-top: 10px;
	float:left;
	font-size: 0.8em;
	text-align: center;
}

.searchBtn #sen_btn{
	padding-right: 30px;
}


/* 검색버튼 끝 */


/* 제목 */
.message-list-item-header .note_title {
	width:100%
	color: black;
	text-align: left;
	font-size: 15px;
	font-family:"돋움";
	display: inline;
}

/* 날짜 */
.message-list-item-header .note_date {
	width:100%
	color: auto;
	text-align: right;
	font-size: 10px;
	font-family:"돋움";
}

/* 내용 */
.message-list-item-header p {
	color: gray;
	text-align: center;
	font-size: 12px;
}

/* 쪽지 하나하나의 테두리 */
.message-list .message-list-item .clickPoint {
	cursor: pointer;
	display: block;
	padding: 1px;
}

/* 날짜 지금 날짜 없음 . 적용 X */
.date{	
	color: #b3b3b3;
	float: right;
	font-size: 10px;
	font-weight: 700;
	margin-top: 3px;
}

/* 삭제버튼 */
.message-list-item #noteDelete {
	position:relative;
	float : right;
	right: 10px;
	top: 10px;
	border:0;
	outline:0;
	width: 3%;
	height: 3%;
	
	text-align: center;
}


/* 리스트 끝 */


/* 내용보기 */
.right_right {
	padding: 30px 100px;
	float: left;
	width: 55%;
	height: 100%;
	text-align: center;
}

/* 선택한 쪽지가 없을때 */
.right_right h1{
	font-size: 50px;
	text-align: center;
	margin: 100px;
}

/* 제목 */
.noteTitle .noteTitle {
	color: black;
	text-align: center;
	font-size: 50px;
}

/* 날짜 */
.noteDate .noteDate {
	color: gray;
	text-align: left;
	font-size: 50px;
}

/* 내용 */
.noteContent .noteContent {
	margin: 100px 0px;
	color: gray;
	text-align: left;
	font-size: 20px;
}


/* 내용보기 끝 */

/* 우측 끝 */





 
 </style>
 
</head>
<body>

	<h3>${member.m_email }의쪽지목록</h3>
	
	<div class="noteBody">
		<!-- 좌측에 버튼들 -->
		<div class="left">
			<div class="clickToggle"><button id="toggleBtn"></button></div>
			<div class="toggleDiv">
				<div class="sendform">	
					<span id="over"><button id="button"> 쪽지 보내기 </button></span>
				</div>
				<div class="sendList">
					<span id="over"><button id="button"> 보낸 쪽지함 </button></span>
				</div>
				<div class="receiveList">
					<span id="over"><button id="button"> 받은 쪽지함 </button></span>
				</div>
			</div>
		</div>
		
		<!-- 우측 영역 -->
		<div class="right">
			<div class="sendFormArea" id="offSendForm">
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
					<div class="scroll">
						<div class='box-body'>
							<ul class="message-list">
								<c:forEach var="note" items="${list }">
									<li class="message-list-item">
										<button id="noteDelete">X</button>
										<div class="clickPoint">
											<div class="message-list-item-header">
												<input type="hidden" value="${note.n_id }">
												<span class="note_title">${note.n_title }</span><br>
												<span class="note_date"> ${note.n_date } </span>
												<p class="note_content">${note.n_content }</p>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
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
							<a id='sen_btn'>보낸쪽지검색</a>
							<a id='rec_btn'>받은쪽지검색</a>
						</div>
					</div>
				</div>
			
				<!-- 우 영역 -->
				<div class="right_right">
					<div class="noteDetail">
						<input type="hidden" name="noteId" value="">
						<div class="noteTitle">
							<span id="noteTitle"></span>
						</div>
						<div class="noteContent">
							<p id="noteContent"></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>



<!-- 
	<div id="inbox" class="inbox">
		<div class="col email-options">
			<div class="col email-list">
				<div class="wrap-list">
					<div id="wrap-options" class="wrap-options">
						<div class="messages-options paddin">
							<div class="messages-search"></div>
							<div class="messages-list ps-container">
								<ul>
									<li class="messages-item"><a href="#"></a></li>
								</ul>
							</div>
							<div class="ps-scrollbar-x-rail">
								<div class="ps-scrollbar-y-rail"></div>
							</div>
						</div>
						<div class="email-reader ps-container">
							<div class="message-actions">
								<ul class="actions no-margin no-padding block">
									<li class="email-list-toggle">
									<li><a href="#"> Reply </a></li>
									<li><a href="#"> Reply all </a></li>
									<li><a href="#"> Forward </a></li>
									<li><a href="#"> Delete </a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="message-header ng-scope">
					<div class="message-time ng-binding">06/13/2016 at 11:02AM</div>
					<div class="message-from ng-binding ng-scope">
						Nicole Bell
					</div>
					<div class="message-to">To: Peter Clark</div>
				</div>
				<div class="message-subject ng-binding ng-scope">New Project</div>
				<div class="message-content ng-binding ng-scope">
					Hi there! Are you available
					around 2pm today? I’d like to talk to you about a new project
				</div>
			</div>
		</div>
		<div class="ps-scrollbar-x-rail">
			<div class="ps-scrollbar-y-rail"></div>
		</div>
	</div>
 -->