<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.matchingIdDiv{
 width: 300px;
 height: 200px;
 background-color: #e6e8e8;
 padding: 30px;
 margin-left:35%; 
 margin-top: 5%;
 margin-bottom: 5%;
}
</style>
</head>
<body>

<div class="matchingIdDiv">
<label style="margin-bottom: 0px;">아이디</label>
<input type="text" style="width: 200px; margin-top: 0px;"><Br>
<input  class="comeback" type="button" value="확인" style="background:#ef7f5b; float:right;">



</div>

<script type="text/javascript">
	$(".comeback").click(function(){
		location.href="index";
	})
</script>
</body>
</html>