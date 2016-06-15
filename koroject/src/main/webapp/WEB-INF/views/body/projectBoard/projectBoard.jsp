<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/resources/css/projectBoard.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>projectPage</title>
</head>
<body>
	<H3 id="projectH3">프로젝트 관리</H3>
	<div id="projectPageContainer">
	   <div class="projectList" >
		<div id="plusButton" class="col-sm-3" data-toggle="modal" data-target="#projectCreateModal">
			<a> <img id="plusImg" src="/images/plus01.jpg">
			</a>
		</div>
	   </div>
	</div>
	<!-- end projectPageContainer div -->
	<!-- <div class="projectList">
		
	</div> -->
		<!-- registerFormMoadl -->
	<div id="projectCreateModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-body">
	      
	        <form id="createProject" class="form-horizontal">
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
					
					<!-- 맴버 전송을 위한 히든폼 -->
					<input type="hidden" id="projectCrew" name="p_crew">
					<input type="hidden" id="projectCreator" name="p_pmid" value="${member.m_id }">
		        </div>
		        <p>추가할 인원을 선택하시오.</p>
		        <div id="memberAddPoint" class="memberAdd">
						
				</div>
				<p>추가된 인원</p>
				<div id="memberAddList" class="memberAdd">
				
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
	<!-- 프로젝트보드에 관한거 여기에 정리해놓음 -->
	<script type="text/javascript" src="/resources/js/projectBoard.js"></script>

</body>
</html>