 $(function(){
	    $('#datetimepicker1').datetimepicker({format: 'YYYY-MM-DD'});
	    $('#datetimepicker2').datetimepicker({format: 'YYYY-MM-DD'});
 
 $("#plusButton").mouseover(function(){
	 $("#plusImg").attr("src","/images/plus02.jpg");
 })
 $("#plusButton").mouseout(function(){
	 $("#plusImg").attr("src","/images/plus01.jpg");
 })
 
 function setInputFormDate(){//set modal default dateValue
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
	
     $(".form-horizontal").on("click",function(e){
		 e.preventDefault();
	 });

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
					$("#inputName").val("");
				}
			 });
			 
		 }
	 });
	 
	 //불러온 프로젝트정보를 html태그로 변환해주는 함수 
	 function makeProjectHtml(p_id,p_name){//간단하게 아이디, 프로젝트 이름만 넣음, 추후에 정보 수정필요
		 var returnHtml = "<div class='projectThumbnail'><div class='projectContainer'>"
		     returnHtml += "<img class='minusButton' src='/images/minus01.jpg' style='display:none' value="+p_id+"><p class='prjectName'>"+p_name+"</p>";
		     returnHtml += "<a class='startPageButton' type='button' style='color:black' href='/projectBoard/"+p_id+"/progress'>프로젝트 시작</a></div></div>"
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
				$(".projectThumbnail").remove();
				for(var i=0;i<data.length;i++){
					var p_id = data[i].p_Id;
					var p_name = data[i].p_name;
					var projectHtml = makeProjectHtml(p_id, p_name);
					$(".projectList").append(projectHtml);
					//$(".projectList").append($("#plusButton").clone());
				}
			}
		 });
	 }
	 
	 //페이지를 열었을때 회원이 속해있는 프로젝트리스트 불러오기 위한 함수 호출 
	 loadProjectList();
	  
	 $("body").on("mouseenter",".projectThumbnail",function(){
		 $(this).children().children().eq(0).css("display","inline");
	 });
	  $("body").on("mouseleave",".projectThumbnail",function(){
		 $(this).children().children().eq(0).css("display","none");
	 }); 
 
	  $("body").on("click",".minusButton",function(){
		  var p_id = $(this).attr("value");
		  $.ajax({
			 url : "projectBoard/"+p_id+"/delete",
			 method : "POST",
			 success : function(data){
				 loadProjectList();
			 }
			 
		  });
		  console.log();
	  });
 });