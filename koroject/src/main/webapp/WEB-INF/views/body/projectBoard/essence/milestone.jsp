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
.alphastate{
	width: 116px;
}
.alphastate ul{
	min-height: 30px;
}
.alphastate li{
	height: auto;
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
<input type="text" id="test">
<button id="essenceset">?</button>
<button id="essenceSave">저장</button>
<button id="essenceLoad">로딩</button>
<!-- 테이블이 올 장소 -->
<div class="milestoneField"></div>

<script type="text/javascript">
$(function(){

	var numberP_id=window.location.href;
	var regExp = /(\/\d+)/g;
	var p_id = (regExp.exec(numberP_id)[0]).replace("/","");
	
	var lastAddedAlphaName;
	var lastAddedAlphaCode;
	var lastAddedAlphaHashId;
	var editorMode =0;
	var alphaState = makeListHtml();
	//초기 객체 생성
	var essence = {
			$this : this,
			milestone : [],
			set : function(hashId,attr,newValue,newValue2,newValue3){
				//console.log("set start");
				for(var i=0; i<(this.milestone).length; i++){
					
					//셀렉트 한 다음 객체에 점수 수정
					if(attr=="alphastateValue")
					{
						if((this.milestone[i].alphaState)!=undefined){
							for(var j=0;j<(this.milestone[i].alphaState).length;j++){
								if(this.milestone[i].alphaState[j].hashId==hashId){
									if(this.milestone[i].alphaState[j ].checkvalue==undefined){//점수 없으면 배열 등록
										console.log(essenceJsonData[this.milestone[i].alphaState[j].alphaID].checkList);
										var zeroPadding = essenceJsonData[this.milestone[i].alphaState[j].alphaID].checkList.length;
										console.log("zero padding :"+zeroPadding);
										this.milestone[i].alphaState[j].checkvalue=[];
										for(var k=0; k<zeroPadding;k++){
											this.milestone[i].alphaState[j].checkvalue.push(0);
										}
									} 
									//추가
									var index = newValue;
									var value = newValue2;
									console.log("in, index : "+index+" value : "+value);
									//essence.set(hashId,"alphastateValue",index,value)
									this.milestone[i].alphaState[j].checkvalue.splice(index,1,value);
								
								}//end of if
							}//end of scan for loop
							
						}//end of alphastate length Check
					}//end of alphaStateValue command
				
					//객체 조작
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
						else if(attr=="addAlpha")
							{
							if(this.milestone[i].alphaState==undefined)//최초에 행렬등록
								{
								this.milestone[i].alphaState=[];
								this.milestone[i].alphaState.push({"alphaID":newValue,"name":newValue2,"hashId":newValue3});
								console.log("등록");
								}
							else
								{
								this.milestone[i].alphaState.push({"alphaID":newValue,"name":newValue2,"hashId":newValue3});
								console.log("등록");
								}
							}
						else if(attr=="removeAlpha")
							{
							for(var j=0;j<(this.milestone[i].alphaState).length;j++){
								if(this.milestone[i].alphaState[j].hashId==newValue){
									this.milestone[i].alphaState.splice(j,1);
									console.log("삭제")
								}
							}
							
							}

						//수행테스크
						
						//console.log(this.milestone);
					}
				}
			},
			get : function(attr){
				if(attr=="alpha"){
					var alphastateList = [];
					for(var i=0; i<(essence.milestone).length;i++){
						if(essence.milestone[i].alphaState!=undefined){
							for(var j=0; j<(essence.milestone[i].alphaState).length;j++){
								//console.log(essence.milestone[i].alphaState[j]);
								alphastateList.push(essence.milestone[i].alphaState[j]);
							}
						}
					}
					//정렬 알고리즘 추가할것
					//console.log(alphastateList);
					return alphastateList;
				}
			},
			importJson : function(data){
				//console.log(data);
				var obj = data;
				console.log("importJson : "+obj);
				console.log(obj);
				console.log(JSON.parse(obj));
				this.milestone = JSON.parse(obj);
				//this.milestone = data;
			},
			exportJson : function(){
				var tmp = JSON.stringify(this.milestone);
				console.log(tmp);
				return tmp;
			}
			
	}//end of essence
	
	//정의 알파상태 수행테스크
	//기본으로 시작하자마자 정의 호출
	//테이블 그리는 함수 (옵션에 따라 정의, 알파상태, 수행테스크를 적용)
	
	//0.테이블 그리기  
	function drawTable(tableType, scope,hashId){//테이블 유형(1,2,3,) 그릴범위(전체, 행추가)
		
		var tableHeadArr = ["<th class='milestoneDue'>기간</th><th class='milestoneDef'>마일스톤 정의</th><th class='milestoneGoal'>마일스톤 목표 이미지</th><th class='milestoneNote'>비고</th><th class='removeMilestone'>삭제</th>"
		                    //,"<th>이해관계자</th><th>기회</th><th>요구사항</th><th>S/W</th><th>팀</th><th>작업방식</th><th>작업</th><th class='removeMilestone'>삭제</th>"
		                    ,alphaState
		                    ,"<th class='milestoneTask'>수행타스크</th><th class='milestoneResult'>수행산출물</th><th class='milestoneNote2'>비고</th><th class='removeMilestone'>삭제</th>"
		                    ,"<th class=''>알파</th><th class=''>상태</th><th class=''>체크리스트</th><th class=''><select><option value=0/></select></th>"
		                    ,"<th class='checklistAlpha'>알파</th><th class='checklistAlphastate'>상태</th><th class='checklistList'>체크리스트</th><th class='checklistState'>상태</th>"
		                    ];
		var tableBodyArr = ["<td class='milestoneDue'><input type='text'></td><td class='milestoneDef'><textarea/></td><td class='milestoneGoal'><textarea/></td><td class='milestoneNote'><textarea/></td><td class='removeMilestoneBtn'>X</td>"
		                    ,"<td class='alphastate'><ul class='sortable1'></ul></td><td class='alphastate'><ul class='sortable2'></ul></td><td class='alphastate'><ul class='sortable3'></ul></td><td class='alphastate'><ul class='sortable4'></ul></td><td class='alphastate'><ul class='sortable5'></ul></td><td class='alphastate'><ul class='sortable6'></ul></td><td class='alphastate'><ul class='sortable7'></ul></td><td class='removeMilestoneBtn'>X</td>"
		                    ,"<td class='milestoneTask'><textarea/></td><td class='milestoneResult'><textarea/></td><td class='milestoneNote2'><textarea/></td><td class='removeMilestoneBtn'>X</td>"
		                    ,"<td class=''></td><td class=''></td><td class=''></td><td class=''></td>"
		                    ,createChecklistHtml()
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
		} else if(scope===2){
			returnHtml += "<table><thead><tr>"
			returnHtml += tableHeadArr[tableType];
			returnHtml += "</tr></thead><tbody class='milestoneRow'>"+tableBodyArr[tableType]+"</tbody></table>";
		}
		
		return returnHtml;
	}
	//console.log(alphaState);
	//알파상태 배치
	function makeListHtml(){//리스트 html제작
		console.log("make list");
		this.makeListHtmlArr = [6,6,6,6,5,6,6];
		this.makeListHtmlIdValue = ['dropdown-stakeholder','dropdown-opportunity','dropdown-requirement','component-softwareSystem','dropdown-team','dropdown-work','dropdown-wayofworking'];
		this.makeListHtmlIcon = ["icon fa fa-desktop",'icon fa fa-table','icon fa fa-file-text-o','icon fa fa-cubes','icon fa fa-slack','icon fa fa-archive','icon fa fa-archive']
		this.makeListHtmlAlpha = ["이해관계자","기회","요구사항","소프트웨어시스템","팀","작업","작업방식"]
		
		//this.returnHtmlValue ='<th><button type="button" class="btn btn-info addMilestoneBtn">+</button></th>';
		this.returnHtmlValue ='';
//		this.returnHtmlValue +='<ul class="pure-menu-list alphaSource">';
		
		for(var i=1;i<=7;i++){
			this.returnHtmlValue += '<th class="alphastate">';
			this.returnHtmlValue += '<li class="pure-menu-item pure-menu-has-children pure-menu-allow-hover">';
			this.returnHtmlValue += '<a class="pure-menu-link" href="#">';
			this.returnHtmlValue += this.makeListHtmlAlpha[i-1];
			this.returnHtmlValue += '</a>';
//			this.returnHtmlValue += '<ul class="">';
			this.returnHtmlValue += '<ul class="pure-menu-children">';
			this.returnHtmlValue += '';
			for(var j=1;j<=this.makeListHtmlArr[i-1];j++){
				var keyValue = 'a'+(i)+'s'+j;
				var jsonData = essenceJsonData[keyValue];
				this.returnHtmlValue += '<li value="'+keyValue+'" class="pure-menu-item alphaLists"><a class="pure-menu-link" href="">'+j+' '+jsonData.name+'</a></li>';
			}
			this.returnHtmlValue += '</ul>';
			this.returnHtmlValue += '</li>';
			this.returnHtmlValue += '</th>';
			
		}
		//할일 
		this.returnHtmlValue +="<th class='removeMilestone'>삭제</th>";
		
		
		return this.returnHtmlValue;
	}
	function createChecklistHtml(){
		var checkArr = essence.get("alpha");
		var returnHtml = "";
		if(checkArr.length!=undefined){
			//returnHtml += "<tr>"
			for(var i=0; i<checkArr.length;i++){
				for(var k=0; k<(essenceJsonData[checkArr[i].alphaID].checkList).length; k++){
					//returnHtml += "<table>"
					returnHtml += "<tr value='"+checkArr[i].hashId+"'>"
					returnHtml += "<td>"
					returnHtml += essenceJsonData[(checkArr[i].alphaID).substr(0,2)].name;
					returnHtml += "</td>"
					
					returnHtml += "<td>"
					returnHtml += essenceJsonData[checkArr[i].alphaID].name;
					returnHtml += "</td>"
					
					returnHtml += "<td>"
					returnHtml += essenceJsonData[essenceJsonData[checkArr[i].alphaID].checkList[k]].desc;
					returnHtml += "</td>"
					
					returnHtml += "<td><select class='checkliststateValue arrIndex"+k+"'>"
					
					var selectedValue = -1;
					if(checkArr[i].checkvalue!=undefined){
						selectedValue = checkArr[i].checkvalue[k];
					}
					
					for(var j=0;j<6;j++){//객체에 저장된 값과 같으면 셀렉트를 추가
						returnHtml += "<option"
						if(j==selectedValue){
							returnHtml += " selected";
						}
						returnHtml += ">"+j+"</option>";
						
					}
					returnHtml += "</select></td>"
					
					returnHtml += "</tr>"
					//returnHtml += "</table>"
					
				}
				
			}
			//returnHtml += "</td>"
		}
		//"<td class='checklistAlpha'></td><td class='checklistAlphastate'></td><td class='checklistList'></td><td class='checklistState'></td>"
		return returnHtml;
	}
	
	//헬퍼 html코드 부분
	function createAlphaHtml(code,name,hashId){
//		console.log(obj)
		this.returnHtml= '<li value='+code+' id='+hashId+' class="pure-menu-item addedAlphaLists ui-sortable"><a class="pure-menu-link" href="" style="display: block;">'+name+'<div class="removeAlphastate">x</div></a></li>'
		return this.returnHtml;
	}
	
	//알파상태 객체들
	function addClassDraggable(target){
		$(target).each(function(){
			var $this = $(this);
			var sortableNumber = ($(this).attr('value')).substr(1,1);
			var connectToSortableStr = ".sortable"+sortableNumber;
			$this.draggable({
 				helper : function(e){
 					lastAddedAlphaCode = $(this).attr('value');
 					lastAddedAlphaName = $(this).find("a").html();
 					lastAddedAlphaHashId = createHashID();
					var returnHtml = createAlphaHtml(lastAddedAlphaCode,lastAddedAlphaName,lastAddedAlphaHashId); 
					return returnHtml;
				},
				connectToSortable : connectToSortableStr,
				stop : function(e,ui){
					console.log("add");
					var milestoneHashID=$(e.toElement).closest('tr').attr('id');
					//마일스톤 등록
					if(milestoneHashID!=undefined){
						essence.set(milestoneHashID,"addAlpha",lastAddedAlphaCode,lastAddedAlphaName,lastAddedAlphaHashId);
					}
				} 
			});
		});
	}

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
			if(editorMode==1&&essence.milestone[i].alphaState!=undefined){
				for(var j=0; j<(essence.milestone[i].alphaState).length; j++){
					console.log("alpha load ");
					console.log(essence.milestone[i].alphaState);
					var code = essence.milestone[i].alphaState[j].alphaID;
					var name = essence.milestone[i].alphaState[j].name;
					var alphaHashId = essence.milestone[i].alphaState[j].hashId;
					var returnHtml = createAlphaHtml(code,name,alphaHashId);
					console.log(code);
					console.log(code.substr(1,1));
					console.log($("#"+hashId+" sortable"+code.substr(1,1)));
					$("#"+hashId+" .sortable"+code.substr(1,1)).append(returnHtml);
				}
			}
		}
		$("td").css("vertical-align","middle");
		addSortable();
	}
	
	function addSortable(){
		// 추가한 마일스톤에 sortable 갱신, 마일스톤끼리 순서 변경
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
	
	//하나의 마일스톤 안에 알파 스테이트sortable속성 적용
	function addSortableAlphaStateRow(){
		for(var i=1; i<8;i++){
			$(".sortable"+i).sortable({
				connectWith : ".sortable"+i,
				stop : function(e,ui){
					console.log("update!")
				
					console.log("event : ");
					console.log(e);
					var targetId = $(e.target).closest("tr").attr("id");
					var toElId = $(e.toElement).closest("tr").attr("id");
					
					var alphaID= lastAddedAlphaCode;
					var name = lastAddedAlphaName;
					var hashId = lastAddedAlphaHashId;
					console.log("alphaID :"+alphaID+" name :"+name+" hashId :"+hashId);
					console.log();
 					if(targetId==toElId){
						console.log("same");
						//같은 마일 스톤이므로 객체 순서 스캔 후 수정

					} else {
						//이동 했으므로 삭제 후 등록 target을 삭제하고 toEl을 등록
//						var milestoneHashID=$(e.toElement).closest('tr').attr('id');
						//마일스톤 등록
						//이동시 중복현상 해결할것
						console.log("add start");
						essence.set(targetId,"removeAlpha",hashId);
						essence.set(toElId,"addAlpha",alphaID,name,hashId);
//						if(milestoneHashID!=undefined){
//							console.log("add");
//						}
						
					}
					//console.log(ui);
					}
			});
		}
	}
	
	//
	//이벤트 발생 부분
	//
	
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
		//메뉴에 드래그 속성 추가
		addClassDraggable($('.alphaLists'));
		addSortableAlphaStateRow();
	});
	$(".taskBtn").click(function(){
		editorMode=2;
		$(".milestoneField").empty().append(drawTable(2,0));
		//
		drawMilestone();
	});
	$(".essencemenu").click(function(){
		$(".essencemenu").css("color","#ef7f5b");
		$(this).css("color","black");
	});
	// 버튼 
	$("body").on("click","#essenceActivityBtn",function(){
		editorMode=3;
		$(".milestoneField").empty().append(drawTable(3,0));
		//
		drawMilestone();
		
	});
	//checklist 버튼 
	$("body").on("click","#essenceChecklistBtn",function(){
		editorMode=4;
		$(".milestoneField").empty().append(drawTable(4,2));
		//
		//drawMilestone();
		
	});
	
	//테스트 버튼
	$("body").on("click","#essenceset",function(){
		//console.log(" event get")
		console.log(essence);
		//essence.exportJson()
		
	});
	//저장
	$("body").on("click","#essenceSave",function(){
		var sendData = essence.exportJson();
		console.log("send : "+sendData);
		$.ajax({
			url : "http://localhost:10000/export",
			data : {
				milestone : sendData,
				p_id : p_id
			},
			method : "POST",
			success : function(){
				console.log("save done");
			}
		})
	});
	
	//로드
	$("body").on("click","#essenceLoad",function(){
		$.ajax({
			url : "http://localhost:10000/import",
			method : "POST",
			data : {
				p_id : p_id
			},
			success : function(data){
				console.log("load done");
				console.log(data);
				essence.importJson(data);
			}
		})
		
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
		addSortableAlphaStateRow();
	});
	//마일스톤 삭제
	$('body').on("click",".removeMilestoneBtn",function(){
		
		var targetId = $(this).parent().attr("id");
		essence.set(targetId,"remove"); //객체+뷰 동시 삭제
	});
	//마일스톤 text내용 반영
	$('body').on("keypress","input,textarea",function(e){
		var targetId = $(this).closest("tr").attr("id");
//		var textValue = $(this).val()+e.key;
		var textValue = $(this).val();
		var attr = $(this).parent().attr("class");
		essence.set(targetId,attr,textValue);
		
		console.log();
	});
	$('.milestoneField').on("click","a",function(e){
		e.preventDefault();
	});
	$('body').on("click",".removeAlphastate",function(e){
		e.preventDefault();
		var milestoneHashId = $(this).closest("tr").attr("id");
		var alphaHashId = $(this).closest("li").attr("id");
		console.log();
		//알파스테이스 삭제 이벤트ilestoneHashId기
		essence.set(milestoneHashId,"removeAlpha",alphaHashId);
		//뷰제거
		$(this).closest("li").remove();
	});
	
	//체크리스트 점수 매기는 부분
	$('body').on("change",".checkliststateValue",function(){
		var hashId = $(this).closest("tr").attr("value");
		var alphaStateValue = $(this).val();
		var index = $(this).attr("class").replace("checkliststateValue ","").replace("arrIndex","");
		essence.set(hashId,"alphastateValue",index,alphaStateValue);
		console.log();
		console.log();
	});

	$.ajax({
		url : "http://localhost:10000/import",
		method : "POST",
		data : {
			p_id : p_id
		},
		success : function(data){
			console.log("load done");
			console.log(data);
			essence.importJson(data);
			
			
			//1.정의 테이블 보여주기, 정의 선택
			$(".milestoneField").append(drawTable(0,0));
			$(".definitionBtn").css("color","black");
			drawMilestone();
		}
	})
	
	
	//
	//
	//에센스 체크리스트 블럭
	//
	//
	

	
});
</script>
<script type="text/javascript" src="/js/static/jquery-ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/md5.js"></script>
<script type="text/javascript" src="/resources/js/alphaStateJson.js"></script>
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