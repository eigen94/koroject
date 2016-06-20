<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/js/static/fullcalendar/2.6.1/fullcalendar.css">
<!-- <link rel="stylesheet" type="text/css" href="/js/static/fullcalendar/2.6.1/fullcalendar.print.css"> -->
<style type="text/css">

	.checkListA:hover{
		font-weight: bold;
		
	}
	#calendar {
		width: 700px;
		 margin-left:80px; 
		padding:10px;
	}
	.checkListDiv{
		margin-top: 60px;
		margin-left: 70px;
		border:1px solid;
		padding:10px;
		width: 25%;
		height: 30%;
	    overflow:auto;
	}
	.modal-dialog{
		margin-top: 100px;
	}
	
	#checklistPage{
		width: 90%;
		background: white;
	}
	body{
	background: #e6e8e8;
	}
	label{
		font-size:18px;
		margin-left:10px;
	}
	.example{
		padding-bottom:10px;
	}
	
	.bb {
			width:40px;
			height:25px;
			border: 3px dotted #666666;
			display: inline-block;
			cursor:pointer;
			color: #9b0e0e;
			position:relative;
		}

		.bt {
			width:40px;
			font-size: 14px;
			font-family: verdana;
			position:relative;
			top:-5px;
			text-align:center;
			border: 2px solid #9b0e0e;
			-moz-transform: rotate(-5deg);
			-webkit-transform: rotate(-5deg);
			-o-transform: rotate(-5deg);
			-ms-transform: rotate(-5deg);
			transform: rotate(-5deg);
			position:absolute;
		}

		.bb.disabled {
			border: 3px dotted #898989;
			background:#ededed;
		}

		.bt.disabled {
			color: #898989;
			border: 2px solid #898989;
		}
	#checkListPlus{
		margin-top: 20px;
		
		margin-left:0px;
		}
	.checklists{
		border-bottom: 1px solid
	} 
	
</style>
</head>
<body>
<div id="checklistPage" class="container-fluid">

<div class="checkListDiv col-md-4">
<a data-toggle="modal" data-target="#checkCreateModal"  id="checkListPlus">
	<img alt="checkPlus" src="/images/checkPlus.jpg">
</a>
<div class="checklistContainer" ></div>
</div>
<div id='calendar' class="col-md-5"></div>

</div>


	<!-- Modal -->

	<!-- checkCreateModal -->
	<div id="checkCreateModal" class="modal fade" role="dialog" style="padding: 20px;">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content" style="width: 480px; height: 330px;">
	      <div class="modal-body" style="padding:20px; padding-left:40px;">
	      <!-- to projectDetail.do -->
	        <form action="#" method="post" class="form-horizontal">
		        <div class="form-group">
	       			<label for="inputName" style="display: inline-block; margin-bottom: 0px; font-size:14px" >일정이름</label>
	   				<div class="">
						<input class="" id="checkListName" type="text" name="check_name" size="10" style="width:60%; display: inline-block;"  placeholder="체크리스트 이름을 입력하세요">
					</div>
					
					<div class="StartEndDate" style="display: inline-block; width:200px; float:left; margin-right:20px; ">
	       			<label for="inputStartDate" style="margin-bottom: 0px; font-size: 14px">시작일</label>
		                <div class='input-group date' id='datetimepicker1'>
		                    <input type='text' id="checkListStartDate" class="form-control" name="check_start" value="1"/>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
	       			<label for="inputEndDate" style="margin-bottom: 0px; font-size: 14px">종료일</label>
		                <div class='input-group date' id='datetimepicker2'>
		                    <input type='text' id="checkListEndDate" class="form-control" name="check_end" value="1"/>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
					</div>
					
					<div class="typePM" style="display: inline-block; width:200px;">
	       			<label for="inputPwdCheck" style="margin-bottom: 0px; font-size:14px;">일정타입</label>
	   				<div>
					  <select class="form-control" id="checkListCheckType" name="check_type">
					    <option value="1">기능명세(usecase)</option>
					    <option value="2">기능명세(usecase diaram)</option>
					    <option value="3">데이터명세(uml)</option>
					    <option value="4">데이터명세(ERD)</option>
					    <option value="5">화면명세</option>
					  </select>
					</div>
	       			<label for="inputPhone" style="margin-bottom: 0px; font-size:14px;">담당자</label>
	   				<div>
						<input class="form-control" id="checkListManager" type="text" name="check_manager" size="20" placeholder="담당자를 입력하세요" value="1">
					</div>
					
					</div>
					
				 
							<input type="hidden" id="checkListProjectId" name="check_projectId" value="${p_id }">
		        </div><!-- end of form group -->
		        
			  	<div class="form-group">
			    	<div style="float:right;">
			      		<button id="createCheckListBtn" class="btn btn-default" data-dismiss="modal">일정 생성</button>
			    	</div>
			  	</div>
			</form><!-- end of projectDetail.do modalForm -->
	      </div><!-- end of modal body -->
	    </div><!-- end of modal contents -->
	  </div><!-- end of modal dialog -->
	</div><!--end of checkCreateModal -->
	<input type="hidden" id="memberid" value="${member.m_id }">

<script type="text/javascript" src="/js/static/momentjs/2.10.3/moment.js"></script>
<script type="text/javascript" src="/js/static/jquery/2.0.3/jquery.js"></script>
<script type="text/javascript" src="/js/static/bootstrap/3.3.5/js/bootstrap.js"></script>
<script type="text/javascript" src="/js/static/fullcalendar/2.6.1/fullcalendar.js"></script>
<script src="/resources/js/betterCheckbox.js"></script>
<script type="text/javascript">
$(function(){

	var projectid = (window.location.pathname).replace("/projectBoard/","").replace("/checklist","");
	$('#calendar').fullCalendar({

	});
	
	//체크리스트 생성부분
	$("#createCheckListBtn").click(function(){
		$.ajax({
			url : "/projectBoard/"+projectid+"/checklist/create",
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
		var check_path = $(this).next().attr("href");
		$.ajax({
			url : check_path+"/delete",
			method : "POST",
			success : function(){
				getChecklist();
			}
		});
	});
	
	//개별 html태그 생성함수
	function generateChecklistHtml(i, check_id, check_name,check_sign){
		
		var returnHtml = '<div class="checklists"><img class="deleteChecklistBtn" src="/images/CheckMinus.jpg" style="cursor:pointer"><a class="checkListA" href=/projectBoard/'+projectid+'/checklist/'+check_id+' style="color:black;" >'+i+" : "+check_name;
		returnHtml += '</a>&nbsp&nbsp<input class="b" checked="checked" type="checkbox" name="b" value="b" style="display: none;">'
		returnHtml += '<div class="bb" style="-webkit-user-select: none;" value="'+check_id+'">';
		if(check_sign==1){
			returnHtml += '<div class="bt">승인</div>'
		}
		returnHtml += '</div></div>';
		return returnHtml;
	}
	
	//체크리스트 호출 함수
	function getChecklist(){
		$.ajax({
			url : "/projectBoard/"+projectid+"/checklist/list",
			method : "POST",
			success : function(data){
				$.ajax({
					url : "/projectBoard/getPMid",
					method : "POST",
					data : {
						"projectId": projectid
					},
					success : function(pmid){
						var pmid = pmid;
						var memberid = $("#memberid").val();
						var checkNumber=-1;
						if(pmid==memberid){
							checkNumber = 1;
						}
						console.log(data);
						$(".checklists").remove();
						for(var i=0; i<data.length; i++){
							var html = generateChecklistHtml(i+1,data[i].check_id,data[i].check_name,data[i].check_sign);
							$('.checklistContainer').append(html);
							if(checkNumber==1){
								$(".b").eq(i).betterCheckbox({boxClass: 'bb', tickClass: 'bt', tickInnerHTML: "승인"});
								if(data[i].check_sign==1){
									$(".b").eq(i).betterCheckbox("check");
								}
							}
						}
						
					}
				});//end of call pmid ajax
			}
		});
	}
	

	
	//시작하자마자 체크리스트 불러오는 부분
	getChecklist();
	
});
</script>
<!-- <script type="text/javascript">
    jQuery(document).ready(function(){ 
		
		$('.b').betterCheckbox({boxClass: 'bb', tickClass: 'bt', tickInnerHTML: "approved"});
		$('#b-dis').betterCheckbox({boxClass: 'bb', tickClass: 'bt', tickInnerHTML: "approved"});
		$('#b-dis').betterCheckbox('disable');
	});
	</script> -->

</body>
</html>