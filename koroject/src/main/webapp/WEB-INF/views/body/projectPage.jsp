<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#plusButton {
	background: #e6e8e8;
	width: 170px;
	height: 200px;
	display: inline-block;
}

.modal-dialog{
	margin-top: 80px;
	}
#plusImg {
	padding-left: 70%;
	padding-top: 80%;
}

#projectPageContainer {
	margin: 40px;
	margin-bottom: 300px;
}
</style>

<title>projectPage</title>
</head>
<body>
	<div id="projectPageContainer">
		<div id="plusButton" data-toggle="modal" data-target="#projectCreateModal">
			<a> <img id="plusImg" src="/images/plus01.jpg">
			</a>
		</div>
	</div>
	<!-- end projectPageContainer div -->
	<div class="projectList">
		
	</div>
		<!-- registerFormMoadl -->
	<div id="projectCreateModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-body">
	      
	        <form class="form-horizontal">
		        <div class="form-group">
	       			<label for="inputName" class="col-sm-3 control-label">프로젝트 이름</label>
	   				<div class="col-sm-7">
						<input class="form-control" id="inputName" type="text" name="p_name" size="20" placeholder="프로젝트 이름을 입력하세요"><br>
					</div>
					
	       			<label for="inputStartDate" class="col-sm-3 control-label">시작일</label>
	   				<div class="col-sm-7">
		                <div class='input-group date' id='datetimepicker1'>
		                    <input type='text' id="projectStartDate" class="form-control" name="p_start"/>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
					</div>
					
	       			<label for="inputEndDate" class="col-sm-3 control-label">종료일</label>
	   				<div class="col-sm-7">
		                <div class='input-group date' id='datetimepicker2'>
		                    <input type='text' id="projectEndDate" class="form-control" name="p_end"/>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
					</div>
	       			<label for="inputPwdCheck" class="col-sm-3 control-label">메모</label>
	   				<div class="col-sm-7">
						<input class="form-control" id="projectMemo" type="text" name="p_memo" size="20" placeholder="메모를 입력하세요"><br>
					</div>
	       			<label for="projectMemeber" class="col-sm-3 control-label">맴버추가</label>
	   				<div class="col-sm-7">
		                <div id="inputIndicator" class='input-group'>
							<input class="form-control" id="projectMemeber" type="text" name="p_member" size="20" placeholder="추가할 맴버 이름이나 이메일을 입력하세요"><br>
		                    <span id="memberAddBtn" class="input-group-addon">
		                        <span class="glyphicon glyphicon-plus-sign"></span>
		                    </span>
	                    </div>
					</div>
					<div id="memberAddPoint">
					</div>
					<!-- 맴버 전송을 위한 히든폼 -->
					<input type="hidden" id="projectCrew" name="p_crew">
					<input type="hidden" id="projectCreator" name="p_pmid" value="${member.m_id }">
		        </div>
			  	<div class="form-group">
			    	<div class="col-sm-offset-3 col-sm-9">
			      		<button class="btn btn-default p-createButton">프로젝트 생성</button>
			    	</div>
			  	</div>
			</form>
	      
	      </div>
	    </div>
	
	  </div>
	</div><!-- 프로젝트 생성 모달 -->


   <script type="text/javascript" src="js/static/jquery/2.1.1/jquery.min.js"></script>
       <script src="http://momentjs.com/downloads/moment-with-locales.min.js"></script>
   <script type="text/javascript" src="js/static/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<!-- 부트스트랩 데이트피커가 적용 안되서 새로운 곳에서 가져옴 -->
	<!-- 출처 : https://eonasdan.github.io/bootstrap-datetimepicker/ -->
	<script type="text/javascript" src="js/static/Eonasdan-bootstrap-datetimepicker/4.15.35/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript">
 $(function(){
    //시작, 종료일에 데이트피커 속성을 걸어줌
	 $('#datetimepicker1').datetimepicker({format: 'YYYY-MM-DD'});
     $('#datetimepicker2').datetimepicker({format: 'YYYY-MM-DD'});
	
     $(".form-horizontal").on("click",function(e){
		 e.preventDefault();
	 });
	 $("#plusButton").mousedown(function(){
		 $("#plusImg").attr("src","/images/plus02.jpg");
	 })
	  $("#plusButton").mouseup(function(){
		 $("#plusImg").attr("src","/images/plus01.jpg");
	 })
	 
	 function setInputFormDate(){//데이트 피커의 모달에 오늘 날짜를 기본으로 설정해주는 부분 
			var dateObj = new Date; 
			var modalDefaultYear = dateObj.getFullYear();
			var modalDefaultMonth = dateObj.getMonth()+1;
			if(modalDefaultMonth<10){
				modalDefaultMonth = '0'+modalDefaultMonth;
			}
			var modalDefaultDay = dateObj.getDate();
			var modalDefaultValue = modalDefaultYear+"-"+modalDefaultMonth+"-"+modalDefaultDay;
			$('#projectStartDate').val(modalDefaultValue);
			$('#projectEndDate').val(modalDefaultValue);
		}//end of set input form date
		setInputFormDate();
		
		//프로젝트 생성버튼을 눌렀을때 ajax로 생성 후, 성공하면 리스트를 불러오고 모달을 닫아줌 
	 $("body").on("click",".p-createButton",function(){
		 var projectName = $('#inputName').val();
		 var projectCreatorId = $('#projectCreator').val();
		 var projectStartDate = $('#projectStartDate').val();
		 var projectEndDate = $('#projectEndtDate').val();
		 console.log("name : "+projectName);
		 if(projectName==""){//제목이 없으면 실행 되지 않게 함 todo : 제목에 벨리데이션 추가할것
			 
		 } else {
			 $.ajax({
				url : "projectBoard/create",
				method : "POST",
				data : {
					projectName : projectName,
					projectManger : projectCreatorId,
					projectStartDate : projectStartDate,
					projectEndDate : projectEndDate
				},
				success : function(){
					loadProjectList();
					$("#projectCreateModal").modal("toggle");
					
				}
			 });
			 
		 }
	 });
	 
	 //불러온 프로젝트정보를 html태그로 변환해주는 함수 
	 function makeProjectHtml(p_id,p_name){//간단하게 아이디, 프로젝트 이름만 넣음, 추후에 정보 수정필요
		 var returnHtml = "<div class='projects'><div> 아이디 : "+p_id+"</div>";
		 returnHtml += "<div> 프로젝트이름 : "+p_name+"</div></div>";
		 return returnHtml;
	 }
	 
	 //프로젝트리스트 불러오는 함수
	 function loadProjectList(){
		 $.ajax({
			url : "projectBoard/list" ,
			method : "POST",
			data : {
				memberid : $('#projectCreator').val()
			},
			success : function(data){
				console.log(data);
				$(".projects").remove();
				for(var i=0;i<data.length;i++){
					var p_id = data[i].p_Id;
					var p_name = data[i].p_name;
					var projectHtml = makeProjectHtml(p_id, p_name);
					$(".projectList").append(projectHtml);
				}
			}
		 });
	 }
	 
	 //페이지를 열었을때 회원이 속해있는 프로젝트리스트 불러오기 위한 함수 호출 
	 loadProjectList();
 
 });
 </script>
</body>
</html>