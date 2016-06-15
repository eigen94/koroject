<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

<p>
당신의 프로젝트에 에센스를 도입하세요!
</p>

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
	$.ajax({
		url : "http://localhost:10000/import",
		method : "POST",
		data : {
			p_id : p_id
		},
		success : function(data){
			//console.log("load done");
			//console.log(data);
			essence.importJson(data);
			
			//1.정의 테이블 보여주기, 정의 선택
			$(".milestoneField").append(drawTable(0,0));
			$(".definitionBtn").css("color","black");
			drawMilestone();
		}
	})
	
});
</script>
<script type="text/javascript" src="/js/static/jquery-ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/essenceJS/md5.js"></script>
<script type="text/javascript" src="/resources/essenceJS/alphaStateJson.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceObj.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceFn.js"></script>
<script type="text/javascript" src="/resources/essenceJS/essenceEvent.js"></script>
</html>