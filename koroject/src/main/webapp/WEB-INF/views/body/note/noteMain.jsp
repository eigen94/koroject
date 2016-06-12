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

<link rel="stylesheet" href="/resources/css/noteStyle.css">

<script type="text/javascript">

function receive(email) {
		//받아온 email을 hidden영역에 쓴다 (server에는 id로 웹상엔 email로 보이기 위함)
		$('.receive #n_receiveEmail').val(email);
	
		//email 가져가서 id값 받아옴. 
		$.ajax({
	        url : "getM_id?m_id=" + email,
	        dataType : 'json',
	        success : function(data) {
				$('.receive #n_receive').val(data);
	        }
		});
	}

	//noteForm
	$(function() {
	
		//폼태그 버튼죽임 
		$('#formTag button').click( function() {
		    return false;
		}); 
	
		//받는사람 email 검색하기위한 새창 열림 
		$('.searchOpen').on('click', function() {
			var popUrl = "search";    //팝업창에 출력될 페이지 URL
		    var popOption = "width=370, height=360, resizable=no, scrollbars=no, " +
		    		"status=no; scrollbars = no; resizable = no";    //팝업창 옵션(optoin)
		    window.open(popUrl,"",popOption);
		})
	});

	$(function(){
		
		//보낸 쪽지함
		$('.sendList button').on('click', function(){
			$('.sendFormArea').attr('id', 'offSendForm');
			$('.listAndDetailArea').attr('id', 'onListAndDetail');
			$.ajax({
	            url : "note_sendList",
	            dataType : 'json',
	            success : function(data) {
	            	var $html = "";
	            	$('.message-list').empty();
	            	$.each(data, function(index, list){
	            		$html += '<li class="message-list-item">';
	            		$html += '<button id="noteDelete">X</button>';
	            		$html += '<div class="clickPoint">';
	            		$html += '<div class="message-list-item-header">';
	            		$html += '<input type="hidden" value="' + list.n_id + '">';
	            		$html += '<span class="note_title">' + list.n_title  + '</span>'; 
	            		$html += '<p class="note_content">' + list.n_content + '</p>';
	            		$html += '</div></div></li>';
	            	});
	            	$('.message-list').append($html);
	            }
			});
		})
		
		//받은 쪽지함
		$('.receiveList button').on('click', function(){
			$('.sendFormArea').attr('id', 'offSendForm');
			$('.listAndDetailArea').attr('id', 'onListAndDetail');
			$.ajax({
	            url : "note_receiveList",
	            dataType : 'json',
	            success : function(data) {
	            	var $html = "";
	            	$('.message-list').empty();
	            	$.each(data, function(index, list){
	            		$html += '<li class="message-list-item">';
	            		$html += '<button id="noteDelete">X</button>';
	            		$html += '<div class="clickPoint">';
	            		$html += '<div class="message-list-item-header">';
	            		$html += '<input type="hidden" value="' + list.n_id + '">';
	            		$html += '<span class="note_title">' + list.n_title  + '</span>'; 
	            		$html += '<p class="note_content">' + list.n_content + '</p>';
	            		$html += '</div></div></li>';
	            	});
	            	$('.message-list').append($html);
	            }
			})
		})
	})

	$(function(){	
		
		//쪽지 보내기 
		$('.left .sendform button').on('click', function(){
			$('.sendFormArea').attr('id', 'onSendForm');
			$('.listAndDetailArea').attr('id', 'offListAndDetail');
			
			/* location.href="note_sendForm"; */
		})
		
		//노트 삭제 
		$(document).on('click', '#noteDelete', function(){
			var noteId = $(this).parent().find('input').val();
			self.location="note_delete" + noteId;
		})
	})

	$(function(){	
		//검색버튼 클릭!
		//보낸쪽지
		$('#sen_btn').on('click', function(event){
			self.location="note_searchSen?m_id=" + $('#m_id').val()
				+"&searchType=" + $('#searchType option:selected').val()
    			+"&keyword=" + $('#keywordInput').val();
		})
		
		//받은쪽지
		$('#rec_btn').on('click', function(event){
			self.location="note_searchRec?m_id=" + $('#m_id').val()
				+"&searchType=" + $('#searchType option:selected').val()
    			+"&keyword=" + $('#keywordInput').val();  
		})
	})
	
	$(function(){	
		//노트 클릭시 오른쪽에 나오게함 
		$(document).on('click', '.clickPoint', function(){
			var n_id = $(this).find('input').val();
			var $html = "";
			$.ajax({
	            url : "note_detail"+n_id,
	            dataType : 'json',
	            success : function(data) {
	            	$('.noteDetail').empty();
	            	/* $html += '<input type="text" name="noteId" value="' + data.n_id + '">'; */
	            	$html += '<div class="noteTitle">';
	            	$html += '<span id="noteTitle">' + data.n_title + '</span></div>';
	            	$html += '<div class="noteContent">';
	            	$html += '<p id="noteContent">' + data.n_content + '</p></div>';
	            	$('.noteDetail').append($html);
	            }
			});
		})
	})
	


	$(function(){
		
		$('.left #toggleBtn').on('click', function(){
			$('.noteBody .toggleDiv').toggle(1000);
		})
		
	})

















</script>

<style type="text/css">
/* 전체 */
.noteBody {
	margin: 100px 50px;
	height: 100%;
	width: 100%;
}

/* 전체 끝 */

/* 좌측 */
.left {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
}

/* 좌측 끝 */

/* 좌측 버튼 */

.left button {
	width: 100%;
	margin: 10px;
}

.left #toggleBtn {
	height: 30px;
}

/* 좌측 버튼 끝 */

/* 우측 */
.right {
	float: left;
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
	width: 35%;
	height: 100%;
	text-align: center;
}

.scroll {
	/* height: 100%; */
	overflow: auto;
	width: 100%;
	height: 450px;
	margin-top: 50px;
}

ul {
	list-style: none;
}

/* 검색버튼 */
.searchBtn {
	display: inline;
	width: 50%;
	
}

.searchBtn button{
	display: inline;
	width: 50%;
}

.searchBtn #sen_btn{
	float:left;
	text-align: center;
}

/* 검색버튼 끝 */


/* 제목 */
.message-list-item-header span {
	color: black;
	text-align: left;
	font-size: 25px;
}

/* 내용 */
.message-list-item-header p {
	color: gray;
	text-align: center;
	font-size: 17px;
}

/* 쪽지 하나하나의 테두리 */
.message-list .message-list-item .clickPoint {
	cursor: pointer;
	display: block;
	padding: 15px;
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
	float: left;
	width: 55%;
	height: 100%;
	text-align: center;
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
			<div class="clickToggle"><button id="toggleBtn">V</button></div>
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
					<div class="scroll">
						<div class='box-body'>
							<ul class="message-list">
								<c:forEach var="note" items="${list }">
								
									<li class="message-list-item">
										<button id="noteDelete">X</button>
										<div class="clickPoint">
											<div class="message-list-item-header">
												<input type="hidden" value="${note.n_id }">
												<span class="note_title">${note.n_title }</span>
												<p class="note_content">${note.n_content }</p>
											</div>
										</div>
									</li>
									
								</c:forEach>
							</ul>
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
							<p id="noteContent"></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>