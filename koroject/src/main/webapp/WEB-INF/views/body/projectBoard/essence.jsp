<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
table {
	float: left;
	margin: 10px;
}
#tableContainer{
	height: 800px;
}
</style>
</head>
<body>

<div id="chartContainer1" style="height: 300px; width: 50%; ">
</div>
<!-- <div id="chartContainer2" style="height: 300px; width: 50%;"></div> -->
<div id="tableContainer">

<table style="width: 290px; ">
<thead><tr><th>이해관계자</th><th>진행현황</th><th>성숙도</th></tr></thead>
<tbody>
<tr><td>식별</td><td id="a1s1Check"></td><td id="a1s1Val"></td></tr>
<tr><td>대표선출</td><td id="a1s2Check"></td><td id="a1s2Val"></td></tr>
<tr><td>작업참여</td><td id="a1s3Check"></td><td id="a1s3Val"></td></tr>
<tr><td>배포기준 합의</td><td id="a1s4Check"></td><td id="a1s4Val"></td></tr>
<tr><td>배포합의</td><td id="a1s5Check"></td><td id="a1s5Val"></td></tr>
<tr><td>사용만족</td><td id="a1s6Check"></td><td id="a1s6Val"></td></tr>
</tbody>
</table>
<table style="width: 290px;">
<thead><tr><th>기회</th><th>진행현황</th><th>성숙도</th></tr></thead>
<tbody>
<tr><td>기회식별</td><td id="a2s1Check"></td><td id="a2s1Val"></td></tr>
<tr><td>솔루션필요성확인</td><td id="a2s2Check"></td><td id="a2s2Val"></td></tr>
<tr><td>솔루션가치확인</td><td id="a2s3Check"></td><td id="a2s3Val"></td></tr>
<tr><td>솔루션타당성검증</td><td id="a2s4Check"></td><td id="a2s4Val"></td></tr>
<tr><td>솔루션개발</td><td id="a2s5Check"></td><td id="a2s5Val"></td></tr>
<tr><td>이익발생</td><td id="a2s6Check"></td><td id="a2s6Val"></td></tr>
</tbody>
</table>
<table style="width: 290px;">
<thead><tr><th>요구사항</th><th>진행현황</th><th>성숙도</th></tr></thead>
<tbody>
<tr><td>개념정의</td><td id="a3s1Check"></td><td id="a3s1Val"></td></tr>
<tr><td>범위정의</td><td id="a3s2Check"></td><td id="a3s2Val"></td></tr>
<tr><td>요건정의</td><td id="a3s3Check"></td><td id="a3s3Val"></td></tr>
<tr><td>요건합의</td><td id="a3s4Check"></td><td id="a3s4Val"></td></tr>
<tr><td>요건구현</td><td id="a3s5Check"></td><td id="a3s5Val"></td></tr>
<tr><td>니즈충족</td><td id="a3s6Check"></td><td id="a3s6Val"></td></tr>
</tbody>
</table>
<table style="width: 290px;">
<thead><tr><th>소프트웨어시스템</th><th>진행현황</th><th>성숙도</th></tr></thead>
<tbody>
<tr><td>아키텍처선정</td><td id="a4s1Check"></td><td id="a4s1Val"></td></tr>
<tr><td>아키텍처검증</td><td id="a4s2Check"></td><td id="a4s2Val"></td></tr>
<tr><td>사용가능</td><td id="a4s3Check"></td><td id="a4s3Val"></td></tr>
<tr><td>배포준비</td><td id="a4s4Check"></td><td id="a4s4Val"></td></tr>
<tr><td>운영</td><td id="a4s5Check"></td><td id="a4s1Va5"></td></tr>
<tr><td>운영종료</td><td id="a4s6Check"></td><td id="a4s6Val"></td></tr>
</tbody>
</table>
<table style="width: 290px;">
<thead><tr><th>팀</th><th>진행현황</th><th>성숙도</th></tr></thead>
<tbody>
<tr><td>팀요건정의</td><td id="a5s1Check"></td><td id="a5s1Val"></td></tr>
<tr><td>팀구성</td><td id="a5s2Check"></td><td id="a5s2Val"></td></tr>
<tr><td>팀빌딩</td><td id="a5s3Check"></td><td id="a5s3Val"></td></tr>
<tr><td>작업수행</td><td id="a5s4Check"></td><td id="a5s4Val"></td></tr>
<tr><td>팀해산</td><td id="a5s5Check"></td><td id="a5s5Val"></td></tr>
</tbody>
</table>
<table style="width: 290px;">
<thead><tr><th>작업</th><th>진행현황</th><th>성숙도</th></tr></thead>
<tbody>
<tr><td>과업확정</td><td id="a6s1Check"></td><td id="a6s1Val"></td></tr>
<tr><td>사전준비</td><td id="a6s2Check"></td><td id="a6s2Val"></td></tr>
<tr><td>작업시작</td><td id="a6s3Check"></td><td id="a6s3Val"></td></tr>
<tr><td>작업진행</td><td id="a6s4Check"></td><td id="a6s4Val"></td></tr>
<tr><td>목표달성</td><td id="a6s5Check"></td><td id="a6s5Val"></td></tr>
<tr><td>작업종료</td><td id="a6s6Check"></td><td id="a6s6Val"></td></tr>
</tbody>
</table>
<table style="width: 290px;">
<thead><tr><th>작업방식</th><th>진행현황</th><th>성숙도</th></tr></thead>
<tbody>
<tr><td>원칙수립</td><td id="a7s1Check"></td><td id="a7s1Val"></td></tr>
<tr><td>작업방식확정</td><td id="a7s2Check"></td><td id="a7s2Val"></td></tr>
<tr><td>시범적용</td><td id="a7s3Check"></td><td id="a7s3Val"></td></tr>
<tr><td>전체적용</td><td id="a7s4Check"></td><td id="a7s4Val"></td></tr>
<tr><td>작업방식내재화</td><td id="a7s5Check"></td><td id="a7s5Val"></td></tr>
<tr><td>사용종료</td><td id="a7s6Check"></td><td id="a7s6Val"></td></tr>
</tbody>
</table>
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
			var obj = essence.get("checkScore");
			drawTable(obj);
			drawChart1();
			//drawChart2();
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
	function drawTable(obj){
		for(var i=1; i<8;i++){
			var innerLength=7;
			if(i==5){
				innerLength=6;
			}
			for(var j=1; j<innerLength; j++){
				if(obj["a"+i+"s"+j]!=undefined){
					console.log(obj["a"+i+"s"+j]);
					var sign = (obj["a"+i+"s"+j])[1];
					var avr = Number((obj["a"+i+"s"+j])[0]);
					var value;
					if(sign==0){
						if(avr>3){
							value="O";
						} else if(avr>0) {
							value="△";
						} else {
							value="-";
						}
					} else {
						value="X";
					}
					$("#"+"a"+i+"s"+j+"Check").html(value);
					$("#"+"a"+i+"s"+j+"Val").html(avr);
					
				} else {
					$("#"+"a"+i+"s"+j+"Check").html("-");
					$("#"+"a"+i+"s"+j+"Val").html("-");
					
				}
			}
		}
		
		
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