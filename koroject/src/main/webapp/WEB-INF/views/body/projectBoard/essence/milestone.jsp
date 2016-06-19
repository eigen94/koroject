<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/js/static/jquery-ui/1.11.4/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/js/static/purecss/0.6.0/build/pure.css">
<style type="text/css">
.milestoneField{
	min-height: 500px;
}

.milestoneHead{
	width : 150px;
}
.milestoneDue{
	width : 70px; 
}
.milestoneDef{
	width: 250px;
}
.milestoneGoal{
	width: 250px;
}
 .milestoneResult, .milestoneTask{
 	width: 285px;
 }
.milestoneNote, .milestoneNote2{
	width: 250px;
}
.removeMilestone{
	width: 70px;
}
.removeAlphastate{
	position: absolute;
	top: 5px;
	right: 20px;
}
.alphastate{
	width: 116px;
}
.alphastate ul{
	min-height: 80px;
	list-style: none;
}
.alphastate li{
	height: auto;
}
.addedAlphaLists a{
	position: relative;
	min-width: 120px;
}
/* 
녹색 #43C367
노랑 #E6EB5C
파랑 #4958FF
<th class='checklistAlpha'>알파</th><th class='checklistAlphastate'>상태</th><th class='checklistList'>체크리스트</th><th class='checklistState'>상태</th>

 */
.checklistAlpha{
	width: 200px;
}
.checklistAlphastate{
	width: 200px;
	
}
.checklistList{
	
}
.checklistState{
	width: 80px;
}
</style>
</head>
<body>
<br>
<a class="essencemenu definitionBtn">
정의
</a>
<a class="essencemenu alphastateBtn">
알파상태배치
</a>
<a class="essencemenu taskBtn">
수행테스크
</a>
<a id="essenceChecklistBtn">
체크리스트
</a>
<!-- <input type="text" id="test">
<button id="essenceset">?</button> -->
<a id="essenceSave">저장</a>
<!-- <button id="essenceLoad">로딩</button> -->
<!-- 테이블이 올 장소 -->
<div class="milestoneField"></div>

<script type="text/javascript">
$(function(){

	
	
	//프로젝트 번호를 가져오기 위한 블럭
	var numberP_id=window.location.href;
	var regExp = /(\/\d+)/g;
	var p_id = (regExp.exec(numberP_id)[0]).replace("/","");
	//임시로 데이터를 저장해놓는 변수
	var lastAddedAlphaName;
	var lastAddedAlphaCode;
	var lastAddedAlphaHashId;

	//페이지 로드시 서버에서 데이터 가져오는 작업 
	$.ajax({
		url : "load",
		//url : "http://localhost:10000/import",
		method : "POST",
		data : {
			"p_id" : p_id
		},
		success : function(getData){
			console.log("load done");
			console.log(data);
			var data = decodeURIComponent(getData);
			console.log(data);
			if(data=="{}"){
				
			} else {
				essence.importJson(data);
				
			}
			
			//1.정의 테이블 보여주기, 정의 선택
			$(".milestoneField").append(drawTable(0,0));
			$(".definitionBtn").css("color","black");
			drawMilestone();
			essence.get("checkScore");
		},
		error : function(){
			console.log("error")
			$(".milestoneField").append(drawTable(0,0));
			$(".definitionBtn").css("color","black");
			drawMilestone();
		}
	});
	
	
});
</script>
<script type="text/javascript" src="/js/static/jquery-ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/essenceJS/md5.js"></script>
<script type="text/javascript" src="/resources/essenceJS/alphaStateJson.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceObj.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceFn.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceEvent.js"></script>
<script type="text/javascript">
var addHashSaltCnt=0;
function createHashID(){
	addHashSaltCnt+=1;
	this.date = new Date();
	this.time = date.getTime().toString();
	this.day = date.getDate().toString();
	this.month = date.getMonth().toString();
	this.year = date.getFullYear().toString();
	this.value = year+month+day+time+addHashSaltCnt;
	this.hashID = md5(value);
	return hashID;
}
</script>
</body>
</html>