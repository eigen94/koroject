
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
			$('.noteBody .toggleDiv').toggle();
		})
		
	})

