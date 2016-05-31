<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="http://jointjs.com/cms/downloads/joint.min.js" />
<script src="http://jointjs.com/js/vendor/jquery/jquery.min.js"></script>
<script src="http://jointjs.com/js/vendor/lodash/lodash.min.js"></script>
<script src="http://jointjs.com/js/vendor/backbone/backbone-min.js"></script>
<script src="http://jointjs.com/cms/downloads/joint.min.js"></script>

<script>
	SVGElement.prototype.getTransformToElement = SVGElement.prototype.getTransformToElement
			|| function(toElement) {
				return toElement.getScreenCTM().inverse().multiply(
						this.getScreenCTM());
			};
</script>

<script type="text/javascript">

	$(function(){
		var graph = new joint.dia.Graph();

		var paper = new joint.dia.Paper({
			el : $('#paper'),
			width : 1500,
			height : 500,
			gridSize : 1,
			model : graph
		});
		var uml = joint.shapes.uml;

		var classes = new Array();
		var relations = new Array();
		
		$("#addClass").on("click", function(){
			var obj = new uml.Class({
				position : {
					x : 20,
					y : 190
				},
				size : {
					width : 220,
					height : 100,
				},
				name : "",
				attribute : "",
				methods : ""
			});
			
			classes.push(obj);
			_.each(classes, function(c) {
				graph.addCell(c);
			});
		})//end of addClass.on
		
		$("#addInterface").on("click", function(){
			var obj = new uml.Interface({
				position : {
					x : 300,
					y : 50
				},
				size : {
					width : 220,
					height : 100,
				},
				name : "",
				attribute : "",
				methods : ""
			});
			
			classes.push(obj);
			_.each(classes, function(c) {
				graph.addCell(c);
			});
		})//end of addInterface.on
		
		$("#addAbstract").on("click", function(){
			var obj = new uml.Abstract({
				position : {
					x : 300,
					y : 190
				},
				size : {
					width : 220,
					height : 100,
				},
				name : "",
				attribute : "",
				methods : ""
			});
			
			
			classes.push(obj);
			_.each(classes, function(c) {
				graph.addCell(c);
			});
		})//end of addAbstract.on
		
		
		
		
	})//end jquery
	
	var objClick = function(){
		
	}
	

</script>


</head>
<body>
	<div id="menubar">
		<button id="addClass">addClass</button><br>
		<button id="addInterface">addInterface</button><br>
		<button id="addAbstract">addAbstract</button>
	</div>
	<div id="paper" class="paper"></div>

</body>
</html>