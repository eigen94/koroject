<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="/js/static/jquery-ui/1.11.4/jquery-ui.css" />

<script src="/js/static/jquery/2.0.3/jquery.min.js"></script>
<script src="/js/static/jquery-ui/1.11.4/jquery-ui.js"></script>

<style type="text/css">
.table {
	display: inline-block;
	border: 1px solid black;
	padding: 5px;
	margin: 5px;
}

div.usecaseName, div.actorName, div.usecaseSummary, div.precondition, div.eventFlow,  div.postcondition
	div.eventFlow {
	border-bottom: 1px solid black;
	padding-bottom: 2px;
}

input {
	margin-left: 10px;
}

label
{
	font-size: 15px;
	font-weight: bold;
}
</style>

<script type="text/javascript">
	var table = '<div class="table">'+
					'<div class="usecaseName">'+
						'<label class="usecaseName">유즈케이스 명</label>&nbsp;&nbsp;'+
						'<input type="text" class="usecaseName">'+
					'</div>'+

					'<div class="actorName">'+
						'<label class="actorName">액터 명</label>&nbsp;&nbsp;'+
						'<input type="text" class="actorName">'+
					'</div>'+

					'<div class="usecaseSummary">'+
						'<label class="usecaseSummary">유즈케이스 개요</label>&nbsp;&nbsp;'+ 
						'<input type="text" class="usecaseSummary">'+		
					'</div>'+
	
					'<div class="precondition">'+
						'<label class="precondition">사전 조건</label>&nbsp;&nbsp;'+ 
						'<input type="text" class="precondition">'+
					'</div>'+
	
					'<div class="eventFlow">'+
						'<label class="eventFlow">이벤트 흐름</label><br>'+
						'<textarea class="eventFlow" rows="10" cols="35"></textarea>'+
					'</div>'+
	
					'<div class="postcondition">'+
						'<label class="postcondition">사후 조건</label>&nbsp;&nbsp;'+ 
						'<input type="text" class="postcondition">'+
					'</div>'+		
				'</div>';
				
	var createTable = function(usecaseName, actorName, usecaseSummary, precondition, eventFlow, postcondition)
	{
		var table = '<div class="table">'+
		'<div class="usecaseName">'+
			'<label class="usecaseName">유즈케이스 명</label>&nbsp;&nbsp;'+
			'<input type="text" class="usecaseName" value="'+usecaseName+'">'+
		'</div>'+

		'<div class="actorName">'+
			'<label class="actorName">액터 명</label>&nbsp;&nbsp;'+
			'<input type="text" class="actorName" value="'+actorName+'">'+
		'</div>'+

		'<div class="usecaseSummary">'+
			'<label class="usecaseSummary">유즈케이스 개요</label>&nbsp;&nbsp;'+ 
			'<input type="text" class="usecaseSummary" value="'+usecaseSummary+'">'+		
		'</div>'+

		'<div class="precondition">'+
			'<label class="precondition">사전 조건</label>&nbsp;&nbsp;'+ 
			'<input type="text" class="precondition" value="'+precondition+'">'+
		'</div>'+

		'<div class="eventFlow">'+
			'<label class="eventFlow">이벤트 흐름</label><br>'+
			'<textarea class="eventFlow" rows="10" cols="35" value="'+eventFlow+'"></textarea>'+
		'</div>'+

		'<div class="postcondition">'+
			'<label class="postcondition">사후 조건</label>&nbsp;&nbsp;'+ 
			'<input type="text" class="postcondition" value="'+postcondition+'">'+
		'</div>'+		
	'</div>';
	
	return table;
	}

				
	
	

	$(function(){
		$("#add").click(function(){
			$("#usecaseContainer").append(table);
		})
		
	
		$("#save").click(function(){
			var usecaseList = new Array();
			tables = $(".table");
			$.each(tables, function(){
				var table = new Object();
				
				table.usecaseName = $(this).find("input.usecaseName").val();
				table.actorName = $(this).find("input.actorName").val();
				table.usecaseSummary = $(this).find("input.usecaseSummary").val();
				table.precondition = $(this).find("input.precondition").val();
				table.eventFlow = $(this).find("textarea.eventFlow").val();
				table.postcondition = $(this).find("input.postcondition").val();
				//console.log(table)
				usecaseList.push(table);				
			})
			//console.log(usecaseList);
			
			$.ajax({
				type : "post",
				url : "save",
				data : { "jsonData" : JSON.stringify(usecaseList) },
				dataType : "text",
				success : function(){
					//alert("성공");
					$("#usecaseContainer").empty();
				}
			})	
		})	
		
		$("#load").click(function(){
			$("#usecaseContainer").empty();
			
			$.ajax({
				type : "post",
				url : "load",
				dataType : "json",
				success : function(data){
					//console.log(data.jsonData)
					$.each(JSON.parse(data.jsonData), function(){
						//console.log(this)
						$("#usecaseContainer").append(createTable(this.usecaseName,
								this.actorName, this.usecaseSummary, this.precondition, this.eventFlow,
								this.postcondition));
					})
					
					
				}
			})
		})
	
	})//end jquery
	
	
	
</script>
</head>
<body>
	<div>
		<button id="add">추가</button>&nbsp;&nbsp;
		<button id="save">저장</button>&nbsp;&nbsp;
		<button id="load">불러오기</button>
	</div>	

	<div id="usecaseContainer"></div>
</body>
</html>