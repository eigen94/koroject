
var alphaState = makeListHtml();
var editorMode =0;

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
//	console.log("make list");
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
				//console.log("alpha load ");
				//console.log(essence.milestone[i].alphaState);
				var code = essence.milestone[i].alphaState[j].alphaID;
				var name = essence.milestone[i].alphaState[j].name;
				var alphaHashId = essence.milestone[i].alphaState[j].hashId;
				var returnHtml = createAlphaHtml(code,name,alphaHashId);
//				console.log(code);
//				console.log(code.substr(1,1));
//				console.log($("#"+hashId+" sortable"+code.substr(1,1)));
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
//			console.log("start");
//			console.log(this);
		},
		stop : function(e,u){
			//순서가 바뀐걸 객체에 갱신
			var itemIndex=u.item.index();
			var itemId=u.item.attr('id');
			essence.set(itemId, "index", itemIndex);
//			console.log(essence);
		}
	});
}

//하나의 마일스톤 안에 알파 스테이트sortable속성 적용
function addSortableAlphaStateRow(){
	for(var i=1; i<8;i++){
		$(".sortable"+i).sortable({
			connectWith : ".sortable"+i,
			stop : function(e,ui){
//				console.log("update!")
			
//				console.log("event : ");
//				console.log(e);
				var targetId = $(e.target).closest("tr").attr("id");
				var toElId = $(e.toElement).closest("tr").attr("id");
				
				var alphaID= lastAddedAlphaCode;
				var name = lastAddedAlphaName;
				var hashId = lastAddedAlphaHashId;
//				console.log("alphaID :"+alphaID+" name :"+name+" hashId :"+hashId);
//				console.log();
				if(targetId==toElId){
//					console.log("same");
					//같은 마일 스톤이므로 객체 순서 스캔 후 수정

				} else {
					//이동 했으므로 삭제 후 등록 target을 삭제하고 toEl을 등록
//						var milestoneHashID=$(e.toElement).closest('tr').attr('id');
					//마일스톤 등록
					//이동시 중복현상 해결할것
//					console.log("add start");
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

