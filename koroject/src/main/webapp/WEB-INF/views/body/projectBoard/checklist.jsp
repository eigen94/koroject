<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/js/static/fullcalendar/2.6.1/fullcalendar.css">
<!-- <link rel="stylesheet" type="text/css" href="/js/static/fullcalendar/2.6.1/fullcalendar.print.css"> -->
<style type="text/css">

	#calendar {
		width: 700px;
		margin: 0 auto;
	}
	.modal-dialog{
		margin-top: 100px;
	}

</style>
</head>
<body>
<button data-toggle="modal" data-target="#checkCreateModal">일정생성</button>

<div class="checklistContainer"></div>

<div id='calendar'></div>


	<!-- Modal -->

	<!-- checkCreateModal -->
	<div id="checkCreateModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-body">
	      <!-- to projectDetail.do -->
	        <form action="#" method="post" class="form-horizontal">
		        <div class="form-group">
	       			<label for="inputName" class="col-sm-2 control-label">일정이름</label>
	   				<div class="col-sm-10">
						<input class="form-control" id="checkListName" type="text" name="check_name" size="20" placeholder="체크리스트 이름을 입력하세요"><br>
					</div>
	       			<label for="inputStartDate" class="col-sm-2 control-label">시작일</label>
	   				<div class="col-sm-4">
		                <div class='input-group date' id='datetimepicker1'>
		                    <input type='text' id="checkListStartDate" class="form-control" name="check_start" value="1"/>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
					</div>
	       			<label for="inputEndDate" class="col-sm-2 control-label">종료일</label>
	   				<div class="col-sm-4">
		                <div class='input-group date' id='datetimepicker2'>
		                    <input type='text' id="checkListEndDate" class="form-control" name="check_end" value="1"/>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
		                <br>
					</div>
	       			<label for="inputPwdCheck" class="col-sm-2 control-label">일정타입</label>
	   				<div class="col-sm-4">
					  <select class="form-control" id="checkListCheckType" name="check_type">
					    <option value="1">기능명세(usecase)</option>
					    <option value="2">기능명세(usecase diaram)</option>
					    <option value="3">데이터명세(uml)</option>
					    <option value="4">데이터명세(ERD)</option>
					    <option value="5">화면명세</option>
					  </select>
					</div>
	       			<label for="inputPhone" class="col-sm-2 control-label">담당자</label>
	   				<div class="col-sm-4">
						<input class="form-control" id="checkListManager" type="text" name="check_manager" size="20" placeholder="담당자를 입력하세요" value="1"><br>
					</div>
					<input type="hidden" id="checkListProjectId" name="check_projectId" value="${p_id }">
		        </div><!-- end of form group -->
		        
			  	<div class="form-group">
			    	<div class="col-sm-offset-2 col-sm-10">
			      		<button id="createCheckListBtn" class="btn btn-default" data-dismiss="modal">일정 생성</button>
			    	</div>
			  	</div>
			</form><!-- end of projectDetail.do modalForm -->
	      </div><!-- end of modal body -->
	    </div><!-- end of modal contents -->
	  </div><!-- end of modal dialog -->
	</div><!--end of checkCreateModal -->
	

<script type="text/javascript" src="/js/static/momentjs/2.10.3/moment.js"></script>
<script type="text/javascript" src="/js/static/jquery/2.0.3/jquery.js"></script>
<script type="text/javascript" src="/js/static/bootstrap/3.3.5/js/bootstrap.js"></script>
<script type="text/javascript" src="/js/static/fullcalendar/2.6.1/fullcalendar.js"></script>
<script type="text/javascript">
$(function(){

	$('#calendar').fullCalendar({

	});
	
	//체크리스트 생성부분
	$("#createCheckListBtn").click(function(){
		$.ajax({
			url : "/projectBoard/checklist/create",
			method : "POST",
			data : {
				check_name : $("#checkListName").val(),
				check_projectid : $("#checkListProjectId").val(),
				check_start : $("#checkListStartDate").val(),
				check_end : $("#checkListEndDate").val(),
				check_manager : $("#checkListManager").val(),
				check_type : $("#checkListCheckType").val()
			},
			success : function(){
				$("#checkListName").val("")
				getChecklist();
			}
		});
	});
	
	$("body").on("click",".deleteChecklistBtn",function(){
		console.log();
		var check_id = $(this).prev().attr("href").replace("/projectBoard/checklist/read?check_id=","");
		$.ajax({
			url : "/projectBoard/checklist/delete",
			data : {
				check_id : check_id
			},
			method : "POST",
			success : function(){
				getChecklist();
			}
		});
	});
	
	//개별 html태그 생성함수
	function generateChecklistHtml(i, check_id, check_name){
		var returnHtml = '<div class="checklists"><a href=/projectBoard/checklist/read?check_id='+check_id+'>'+i+'체크리스트 : '+check_name;
		returnHtml += '</a><button class="deleteChecklistBtn">삭제</button></div>';
		return returnHtml;
	}
	
	//체크리스트 호출 함수
	function getChecklist(){
		$.ajax({
			url : "/projectBoard/checklist/list",
			data : {
				check_projectid : $("#checkListProjectId").val()
			},
			method : "POST",
			success : function(data){
				$(".checklists").remove();
				for(var i=0; i<data.length; i++){
					var html = generateChecklistHtml(i+1,data[i].check_id,data[i].check_name);
					$('.checklistContainer').append(html);
				}
			}
		});
	}
	//시작하자마자 체크리스트 불러오는 부분
	getChecklist();
	
});
</script>
</body>
</html>