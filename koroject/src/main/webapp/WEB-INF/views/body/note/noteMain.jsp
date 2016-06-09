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

<style type="text/css">

.noteBody {
	height: 60%;
	width: 100%;
	margin-bottom: 200px;
	margin-top: 200px;
	display: table;
}

.right_left {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
	/* background: olive; */
}

.left {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
}

.right_right {
	float: left;
	width: 60%;
	height: 100%;
	text-align: center;
}

.scroll {
	/* height: 100%; */
	overflow:auto;
    width:100%; 
    height:450px;
}

/* 쪽지 하나하나의 테두리 (a태그)  */
.message-list .message-list-item a {
    cursor: pointer;
    display: block;
    padding: 15px;
}

/* 제목 */
.message-list .message-list-item a .message-list-item-header span {
    color: #333;
}

/* 날짜 */
.message-list .message-list-item a .time {
    color: #b3b3b3;
    float: right;
    font-size: 10px;
    font-weight: 700;
    margin-top: 3px;
}

/* 내용 */
.message-list .message-list-item a p {
    margin-bottom: 0;
}
p {
    color: #7a7a7a;
}


</style>

<script type="text/javascript">
	
	$(function(){
		//쪽지 보내기 
		$('.sendform button').on('click', function(){
			location.href="note_sendForm";
		})
		
		//보낸 쪽지함
		$('.sendList button').on('click', function(){
			$.ajax({
	            url : "note_sendList",
	            dataType : 'json',
	            success : function(data) {
	            	var $html = "";
	            	$('.message-list').empty();
	            	$.each(data, function(index, list){
	            		$html += '<li class="message-list-item">';
	            		$html += '<div class="clickPoint">';
	            		$html += '<div class="message-list-item-header">';
	            		$html += '<input type="hidden" value="' + list.n_id + '">';
	            		$html += '<div class="time ng-binding">날짜</div>';
	            		$html += '<span class="ng-binding">' + list.n_title  + '</span>'; 
	            		$html += '<p class="ng-binding">' + list.n_content + '</p>';
	            		$html += '</div></div><button id="noteDelete">삭제</button></li>';
	            	});
	            	$('.message-list').append($html);
	            }
			});
		})
		
		//받은 쪽지함
		$('.receiveList button').on('click', function(){
			$.ajax({
	            url : "note_receiveList",
	            dataType : 'json',
	            success : function(data) {
	            	var $html = "";
	            	$('.message-list').empty();
	            	$.each(data, function(index, list){
	            		$html += '<li class="message-list-item">';
	            		$html += '<div class="clickPoint">';
	            		$html += '<div class="message-list-item-header">';
	            		$html += '<input type="hidden" value="' + list.n_id + '">';
	            		$html += '<div class="time ng-binding">날짜</div>';
	            		$html += '<span class="ng-binding">' + list.n_title  + '</span>'; 
	            		$html += '<p class="ng-binding">' + list.n_content + '</p>';
	            		$html += '</div></div><button id="noteDelete">삭제</button></li>';
	            	});
	            	$('.message-list').append($html);
	            }
			})
		})
	})

	$(function(){	
		//노트 삭제 
		$(document).on('click', '#noteDelete', function(){
			var noteId = $(this).prev().find('input').val();
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
		$('.openChatting button').on('click', function(){
			var m_email = $('#m_email').val();
			location.href="http://localhost:7777/?email="+m_email;
			
		})
	})
	
</script>


</head>
<body>

	<div class="noteBody">
		<!-- 좌측에 버튼들 -->
		<div class="left">
			<%-- <jsp:include page="noteButton.jsp" /> --%>
			<div class="sendform">	<button> 쪽지 보내기 </button>	</div>
			<div class="sendList"><button> 보낸 쪽지함 </button></div>
			<div class="receiveList"><button> 받은 쪽지함 </button></div>
			<div class="openChatting">
				<button>채팅채팅</button>
				<input type="text" id="m_email" value="Email">
			</div>
		</div>
		
		<!-- 우측 영역 -->
		<div class="right">
			<%-- <jsp:include page="noteSend.jsp"/> --%>
			<!-- 바디영역 -->
			<div class="right_left">
				<%-- <jsp:include page="noteList.jsp"/> --%>
				<h3>${member.m_email }의쪽지목록</h3>
				<div class="note_search">
					<input type="hidden" id="m_id" value="${m_id }"> 
					<select name="searchType" id="searchType">
						<option value="n" <c:out value="${cri.searchType == null?'selected':''}"/>>---</option>
						<option value="tcw" <c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>제목 OR 내용 OR 보낸이</option>
						<option value="t" <c:out value="${cri.searchType eq 't'?'selected':''}"/>>제목</option>
						<option value="c" <c:out value="${cri.searchType eq 'c'?'selected':''}"/>>내용</option>
						<option value="w" <c:out value="${cri.searchType eq 'w'?'selected':''}"/>>보낸이</option>
						<option value="tc" <c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>제목 OR 내용</option>
						<option value="cw" <c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>내용 OR 보낸이</option>
					</select> 

					<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
					<button id='sen_btn'>보낸쪽지검색</button>
					<button id='rec_btn'>받은쪽지검색</button>
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


</body>
</html>