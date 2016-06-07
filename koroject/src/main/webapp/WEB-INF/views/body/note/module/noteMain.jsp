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
		$('#searchBtn').on('click', function(event){
			alert($('#m_id').val());
			self.location="note_search?m_id" + $('#m_id').val();
				+"searchType=" + $("select option:selected").val()
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
	
</script>

<style type="text/css">
.header {
	width: 100%;
	height: 20%;
	text-align: center;
}

.center {
	height: 60%;
	width: 100%;
	margin-bottom: 200px;
	margin-top: 200px;
	display: table;
}

.body {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
	/* background: olive; */
}

.footer {
	width: 100%;
	height: 20%;
	text-align: center;
}

.left {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
}

.right {
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
</head>
<body>

	<!-- 헤더영역 -->
	<!-- header.jsp가 여기(insertAttri~)로 들어온다  -->
	<div class="header">
		<jsp:include page="right.jsp"></jsp:include>
	</div>

	<div class="center">
		<!-- 좌 영역 -->
		<div class="left">
			<jsp:include page="left.jsp"></jsp:include>
		</div>
		<!-- 바디영역 -->
		<div class="body">
			<jsp:include page="note_list.jsp"></jsp:include>
		</div>
		<!-- 우 영역 -->
		<div class="right">
			<jsp:include page="content.jsp"></jsp:include>
		</div>
	</div>
	<!-- 푸터영역 -->
	<div class="footer">
		<jsp:include page="right.jsp"></jsp:include>
	</div>



</body>
</html>