<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

<div id="chartContainer1" style="height: 300px; width: 50%; ">
</div>
<div id="chartContainer2" style="height: 300px; width: 50%;">
</div>
</body>
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
	
	
	var milestoneNum=0;
	var alphaNum=0;
	$.ajax({
		url : "essence/load",
		method : "POST",
		data : {
			p_id : p_id
		},
		success : function(getData){
			//console.log("load done");
			//console.log(data);
			var data = decodeURIComponent(getData);
			essence.importJson(data);
			console.log(essence);
			milestoneNum = essence.milestone.length;
			alphaNum = (essence.get("alpha")).length;
			console.log(milestoneNum+" "+alphaNum);
			drawChart1();
			drawChart2();
		}
	});
	
	function drawChart1(){
		var totalAlpha = 207;
		var usedAlpha = Math.ceil(alphaNum/207*100); 
		console.log(usedAlpha)
		var unuseAlpha = 100-usedAlpha;
		
		var chart = new CanvasJS.Chart("chartContainer1",
		{
			title:{
				text: "알파상태 사용율",
				verticalAlign: 'top',
				horizontalAlign: 'left'
			},
	                animationEnabled: true,
			data: [
			{        
				type: "doughnut",
				startAngle:20,
				toolTipContent: "{label}: {y} - <strong>#percent%</strong>",
				indexLabel: "{label} #percent%",
				dataPoints: [
					{  y: unuseAlpha, label: "미사용" },
					{  y: usedAlpha, label: "사용" },
				]
			}
			]
		});
		chart.render();
	}
	function drawChart2(){
		var chart = new CanvasJS.Chart("chartContainer2",
				{
					animationEnabled: true,
					title:{
						text: "평가지수",
						horizontalAlign: 'left'
					},
					data: [
					{
						type: "column", //change type to bar, line, area, pie, etc
						dataPoints: [
							{ x: 10, y: 71 },
							{ x: 20, y: 55 },
							{ x: 30, y: 50 },
							{ x: 40, y: 65 },
							{ x: 50, y: 95 },
							{ x: 60, y: 68 },
							{ x: 70, y: 28 },
							{ x: 80, y: 34 },
							{ x: 90, y: 14 }
						]
					}
					]
				});

				chart.render();
	}
	
});

</script>
<script type="text/javascript" src="/js/static/jquery-ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/essenceJS/md5.js"></script>
<script type="text/javascript" src="/resources/essenceJS/alphaStateJson.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceObj.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceFn.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceEvent.js"></script>
<script type="text/javascript" src="http://canvasjs.com/assets/script/canvasjs.min.js"></script>
</html>