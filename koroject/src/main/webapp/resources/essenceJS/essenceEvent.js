
	var numberP_id=window.location.href;
	var regExp = /(\/\d+)/g;
	var p_id = (regExp.exec(numberP_id)[0]).replace("/","");

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
			//url : "http://localhost:10000/export",
			url : "insert",
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
			url : "load",
//			url : "http://localhost:10000/import",
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
		console.log(hashId);
		console.log(essence.milestone);
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
//			var textValue = $(this).val()+e.key;
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

