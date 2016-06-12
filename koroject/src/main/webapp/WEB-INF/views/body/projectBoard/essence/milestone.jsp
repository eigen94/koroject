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

<!-- 테이블이 올 장소 -->
<div class="milestoneField"></div>

<script type="text/javascript">
$(function(){
	
	//정의 알파상태 수행테스크
	//기본으로 시작하자마자 정의 호출
	//테이블 그리는 함수 (옵션에 따라 정의, 알파상태, 수행테스크를 적용)
	
	//0.테이블 그리기  
	function drawTable(tableType, scope){
		var tableHeadArr = ["<th>기간</th><th>마일스톤 정의</th><th>마일스톤 목표 이미지</th><th>비고</th>","<th>기간</th><th>마일스톤 정의</th><th>마일스톤 목표 이미지</th><th>비고</th>","<th>이해관계자</th><th>기회</th><th>요구사항</th><th>S/W</th><th>팀</th><th>작업방식</th><th>작업</th>"];
		
		var returnHtml = "<table><thead><tr><th class='addMilestoneBtn'>마일스톤 +</th>"
		returnHtml += tableHeadArr[tableType];
		returnHtml += "</tr>";
		
		returnHtml += "</thead><tbody class='milestoneRow'></tbody></table>";
		return returnHtml;
	}
	//1.정의 
	function drawDefinitionTable(){
		var returnHtml = "<table><thead><tr><th class='addMilestoneBtn'>마일스톤 +</th></tr>";
		returnHtml += "</thead><tbody class='milestoneRow'></tbody></table>";
		return returnHtml;
	}
	//2.알파상태
	function drawAlphastateTable(){
		var returnHtml = "<table><thead><tr>";
		returnHtml += "<th class='addMilestoneBtn'>마일스톤 +</th></tr>";
		returnHtml += "</thead><tbody class='milestoneRow'></tbody></table>";
		return returnHtml;
	}
	//3.수행테스크
	function drawTaskTable(){
		var returnHtml = "<table><thead><tr>";
		returnHtml += "<th class='addMilestoneBtn'>마일스톤 +</th><th>수행테스크</th><th>수행산출물</th><th>비고</th></tr>";
		returnHtml += "</thead><tbody class='milestoneRow'></tbody></table>";
		return returnHtml;
	}
	
	//2.
	
	//메뉴 클릭 이벤트
	$(".definitionBtn").click(function(){
		$(".milestoneField").empty().append(drawDefinitionTable());
	});
	$(".alphastateBtn").click(function(){
		$(".milestoneField").empty().append(drawAlphastateTable());
	});
	$(".taskBtn").click(function(){
		$(".milestoneField").empty().append(drawTaskTable());
	});
	$(".essencemenu").click(function(){
		$(".essencemenu").css("color","#ef7f5b");
		$(this).css("color","black");
	});
	
	//마일스톤을 누르면 행 추가
	$("milestoneField").on("click",".addMilestoneBtn",function(){
		$(".milestoneRow").append()
	});
	
	//초기
	//1.정의 테이블 보여주기, 정의 선택
	$(".milestoneField").append(drawDefinitionTable());
	$(".definitionBtn").css("color","black");
});
</script>
<script type="text/javascript" src="/js/static/jquery-ui/1.9.2/js/jquery-ui-1.9.2.custom.js"></script>
</body>
</html>