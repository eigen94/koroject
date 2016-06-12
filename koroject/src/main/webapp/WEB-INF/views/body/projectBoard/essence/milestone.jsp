<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
.alphastate{
	width: 116px;
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
<input type="text" id="test">
<button id="essenceset">?</button>
<!-- 테이블이 올 장소 -->
<div class="milestoneField"></div>

<script type="text/javascript">
$(function(){

	var editorMode =0;
	//초기 객체 생성
	var essence = {
			$this : this,
			milestone : [],
			set : function(hashId,attr,newValue){
				console.log("set start");
				for(var i=0; i<(this.milestone).length; i++){
					if((this.milestone[i]).hashId==hashId){
						if(attr=="name"){
							(this.milestone[i]).name = newValue;
						}
						
						//정의 수정하는 부분
						else if(attr=="milestoneHead")
							{
							this.milestone[i].milestoneHead=newValue
							}
						else if(attr=="milestoneDue")
							{
							this.milestone[i].milestoneDue=newValue
							}
						else if(attr=="milestoneDef")
							{
							this.milestone[i].milestoneDef=newValue
							}
						else if(attr=="milestoneGoal")
							{
							this.milestone[i].milestoneGoal=newValue
							}
						else if(attr=="milestoneNote")
							{
							this.milestone[i].milestoneNote=newValue
							}
						else if(attr=="index")
							{
							var tmp = this.milestone[i];
							(this.milestone).splice(i,1);
							(this.milestone).splice(newValue,0,tmp);
							break;
							}
						else if(attr=="remove")
							{
							console.log("remove");
							(this.milestone).splice(i,1);
							$("#"+hashId).remove();
							}
						//알파상태
						else if(attr=="milestoneTask")
							{
							this.milestone[i].milestoneTask=newValue
							}
						else if(attr=="milestoneResult")
							{
							this.milestone[i].milestoneResult=newValue
							}
						else if(attr=="milestoneNote2")
							{
							this.milestone[i].milestoneNote2=newValue
							}
						
						//수행테스크
						
						console.log(this.milestone);
					}
				}
			},
			get : function(attr){
				console.log(attr);
			}
			
	}//end of essence
	
	//정의 알파상태 수행테스크
	//기본으로 시작하자마자 정의 호출
	//테이블 그리는 함수 (옵션에 따라 정의, 알파상태, 수행테스크를 적용)
	
	//0.테이블 그리기  
	function drawTable(tableType, scope,hashId){//테이블 유형(1,2,3,) 그릴범위(전체, 행추가)
		var tableHeadArr = ["<th class='milestoneDue'>기간</th><th class='milestoneDef'>마일스톤 정의</th><th class='milestoneGoal'>마일스톤 목표 이미지</th><th class='milestoneNote'>비고</th><th class='removeMilestone'>삭제</th>"
		                    ,"<th><ul>이해관계자<li>1</li></ul></th>"
		                    +"<th>기회</th><th>요구사항</th><th>S/W</th><th>팀</th><th>작업방식</th><th>작업</th><th class='removeMilestone'>삭제</th>"
		                    ,"<th class='milestoneTask'>수행타스크</th><th class='milestoneResult'>수행산출물</th><th class='milestoneNote2'>비고</th><th class='removeMilestone'>삭제</th>"
		                    ];
		var tableBodyArr = ["<td class='milestoneDue'><input type='text'></td><td class='milestoneDef'><textarea/></td><td class='milestoneGoal'><textarea/></td><td class='milestoneNote'><textarea/></td><td class='removeMilestoneBtn'>X</td>"
		                    ,"<td class='alphastate'></td><td class='alphastate'></td><td class='alphastate'></td><td class='alphastate'></td><td class='alphastate'></td><td class='alphastate'></td><td class='alphastate'></td><td class='removeMilestoneBtn'>X</td>"
		                    ,"<td class='milestoneTask'><textarea/></td><td class='milestoneResult'><textarea/></td><td class='milestoneNote2'><textarea/></td><td class='removeMilestoneBtn'>X</td>"
		                    ];
		var returnHtml="";
		if(scope===0){
			returnHtml += "<table><thead><tr><th class='addMilestoneBtn milestoneHead'>마일스톤 +</th>"
			returnHtml += tableHeadArr[tableType];
			returnHtml += "</tr></thead><tbody class='milestoneRow'></tbody></table>";
		} else if(scope===1){
			var lengthArr = [5,8,4];
			returnHtml += "<tr class='milestoneTr' id="+hashId+"><td class='milestoneHead'><input type='text'></td>";
			returnHtml += tableBodyArr[tableType];
			returnHtml += "</tr>";
		}
		
		return returnHtml;
	}
	
	
	//메뉴 클릭 이벤트
	$(".definitionBtn").click(function(){
		editorMode=0;
		$(".milestoneField").empty().append(drawTable(0,0));
		drawMilestone();
	});
	$(".alphastateBtn").click(function(){
		editorMode=1;
		$(".milestoneField").empty().append(drawTable(1,0));
		drawMilestone();
	});
	$(".taskBtn").click(function(){
		editorMode=2;
		$(".milestoneField").empty().append(drawTable(2,0));
		drawMilestone();
	});
	$(".essencemenu").click(function(){
		$(".essencemenu").css("color","#ef7f5b");
		$(this).css("color","black");
	});
	
	//마일스톤을 그려주는 함수 (값 복원)
	function drawMilestone(){
		for(var i=0; i<(essence.milestone).length; i++){
			var hashId = essence.milestone[i].hashId;
			//console.log(hashId);
			$(".milestoneRow").append(drawTable(editorMode,1,hashId));
			$("#"+hashId+" .milestoneHead input").val(essence.milestone[i].milestoneHead);
			$("#"+hashId+" .milestoneDue input").val(essence.milestone[i].milestoneDue);
			$("#"+hashId+" .milestoneDef textarea").val(essence.milestone[i].milestoneDef);
			$("#"+hashId+" .milestoneGoal textarea").val(essence.milestone[i].milestoneGoal);
			$("#"+hashId+" .milestoneNote textarea").val(essence.milestone[i].milestoneNote);
			$("#"+hashId+" .milestoneResult textarea").val(essence.milestone[i].milestoneResult);
			$("#"+hashId+" .milestoneTask textarea").val(essence.milestone[i].milestoneTask);
			$("#"+hashId+" .milestoneNote2 textarea").val(essence.milestone[i].milestoneNote2);
		}
		$("td").css("vertical-align","middle");
		addSortable();
	}
	
	function addSortable(){
		// 추가한 마일스톤에 sortable 갱신
		$(".milestoneRow").sortable({
			start : function(){
				console.log("start");
				console.log(this);
			},
			stop : function(e,u){
				//순서가 바뀐걸 객체에 갱신
				var itemIndex=u.item.index();
				var itemId=u.item.attr('id');
				essence.set(itemId, "index", itemIndex);
				console.log(essence);
			}
		});
	}
	
	//테스트 버튼
	$("body").on("click","#essenceset",function(){
		//console.log(" event get")
		//console.log(essence.set());
		
		//essence.set($("#test").val(),"hi","hi");
	});
	
	//마일스톤을 누르면 행 추가
	$("body").on("click",".addMilestoneBtn",function(){
		//객체에 추가
		//뷰에 추가
		var hashId = createHashID();
		essence.milestone.push({
			hashId : hashId
		});
		console.log(hashId);
		$(".milestoneRow").append(drawTable(editorMode,1,hashId));
		addSortable();
	});
	//마일스톤 삭제
	$('body').on("click",".removeMilestoneBtn",function(){
		
		var targetId = $(this).parent().attr("id");
		essence.set(targetId,"remove"); //객체+뷰 동시 삭제
	});
	$('body').on("keypress","input,textarea",function(e){
		var targetId = $(this).closest("tr").attr("id");
		var textValue = $(this).val()+e.key;
		var attr = $(this).parent().attr("class");
		essence.set(targetId,attr,textValue);
		
		console.log();
	});
	
	//초기
	//1.정의 테이블 보여주기, 정의 선택
	$(".milestoneField").append(drawTable(0,0));
	$(".definitionBtn").css("color","black");
	
	
});
</script>
<script type="text/javascript" src="/js/static/jquery-ui/1.9.2/js/jquery-ui-1.9.2.custom.js"></script>
<script type="text/javascript" src="/resources/js/md5.js"></script>
<script type="text/javascript">//hashID
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