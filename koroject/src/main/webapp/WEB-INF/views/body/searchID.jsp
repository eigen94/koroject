<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

.searchIDdiv{
	width: 500px;
	height: 400px;
	background-color: #e6e8e8;
	margin-left: 35%;
	margin-top: 5%;
	border-bottom: 4px solid white;
	padding-top: 20px;
	padding-left: 50px;
}
.searchNext{
	width:300px;
	height:60px;
	margin-left: 35%;
	background-color: #ef7f5b;
	margin-bottom: 5%;
	color: white;
}
.searchNext:hover{
	background-color:  #f19172
}
</style>
</head>
<body>



	<div class="searchIDdiv">
		<form action="searchID" method="post">
			<h3>비밀번호 찾기 </h3>
			
			<label style="margin-bottom: 0px;">이메일</label> 
			<input type="text" name="m_email" placeholder="이름을 입력해 주세요" style="width: 200px">
			<label style="margin-bottom: 0px;">질문</label> <select
				name="m_question" style="width: 200px">
				<option value="1">고향은?</option>
				<option value="2">이름은?</option>
				<option value="3">주소는?</option>
			</select> <label style="margin-bottom: 0px;">답</label>
			 <input type="text" name="m_answer" placeholder="답을 입력해 주세요" style="width: 200px">
			 ${message}<br>
			 <input type="submit" value="비밀번호 찾기"> 
		</form>

	</div>
	<input class="searchNext" type="button" value="메인페이지" style="background-color: #ef7f5b; ">
	<!--  -->


<script src="/resources/js/index.js"></script>
<script type="text/javascript">
$(".searchNext").click(function(){
	$.ajax({
		url: "sessionDelete",
		success:function(){
			location.href="/index";
		}
	})
	
})
</script>
</body>
</html>