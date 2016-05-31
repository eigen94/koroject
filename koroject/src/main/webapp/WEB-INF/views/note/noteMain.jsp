<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.header {
	width: 100%;
	height: 20%;
	text-align: center;
}

.center {
	height: 60%;
	width: 100%;
	display: table;
}

.body {
	float: left;
	width: 60%;
	height: 100%;
	text-align: center;
	background: olive;
}

.footer {
	width: 100%;
	height: 20%;
	text-align: center;
}

.left {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
}

.right {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
}
</style>
</head>
<body>

	<!-- 헤더영역 -->
	<!-- header.jsp가 여기(insertAttri~)로 들어온다  -->
	<div class="header">
		<tiles:insertAttribute name="header" />
	</div>

	<div class="center">
		<!-- 좌 영역 -->
		<div class="left">
			<tiles:insertAttribute name="left" />
		</div>
		<!-- 바디영역 -->
		<div class="body">
			<tiles:insertAttribute name="body" />
		</div>
		<!-- 우 영역 -->
		<div class="right">
			<tiles:insertAttribute name="right" />
		</div>
	</div>
	<!-- 푸터영역 -->
	<div class="footer">
		<tiles:insertAttribute name="footer" />
	</div>



</body>
</html>