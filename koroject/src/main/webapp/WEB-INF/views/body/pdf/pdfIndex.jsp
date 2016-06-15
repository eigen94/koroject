
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*,com.itextpdf.text.*,com.itextpdf.text.pdf.PdfWriter"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type"content="text/html; charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

 	<form:form action="downloadPDF" method="post" id="downloadPDF">
		<h3>PDF Download</h3>
		<input id="submitId" type="submit" value="Downlaod PDF">
	</form:form>

</body>
</html>