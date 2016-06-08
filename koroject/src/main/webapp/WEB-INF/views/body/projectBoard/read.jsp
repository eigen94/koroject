<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="/js/static/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var form = $("form");
		
		$("#update").click(function(){
			form.attr("action", "update");
			form.attr("method", "get");
			form.submit();
		})
		
		$("#delete").click(function(){
			form.attr("action", "delete");
			form.attr("method", "get");
			form.submit();
		})
	})
	
</script>

</head>
<body>
	프로젝트 ID : ${pb.pId }<br>
	프로젝트 Title : ${pb.pTitle }<br>
	프로젝트 Writer : ${pb.pWriter }<br>	
	프로젝트 Memo : ${pb.pContent }<br>
	<form>
		<input type="hidden" id="pId" name="pId" value="${pb.pId }">
		<button type="submit" id="update">update</button>
		<button type="delete" id="delete">delete</button>
	</form>
</body>
</html>