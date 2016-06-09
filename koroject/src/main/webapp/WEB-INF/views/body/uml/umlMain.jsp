<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="/js/static/jointjs/0.9.7/dist/joint.min.css" />
<link rel="stylesheet" type="text/css"
	href="http://jointjs.com/css/rappid.min.css" />
<style type="text/css">
#inspector-holder {
	position: absolute;
	top: 0;
	left: 1500px;	
	bottom: 0;
	width: 300px;
	height: 600px;	
	background-color: #333;
	color: #bcbcbc;
}

#paper-holder {
	left: 300px;
	height: 600px;
	width: 1200px;	
	position: relative;
}

#stencil-holder {
	width: 300px;
	height: 600px;	
	position: absolute;
}
</style>

<script src="/js/static/jquery/2.0.3/jquery.min.js"></script>
<script src="/js/static/lodash/3.10.1/lodash.min.js"></script>
<script src="/js/static/backbone/1.2.1/backbone-min.js"></script>
<script src="/js/static/jointjs/0.9.7/dist/joint.min.js"></script>
<script src="http://jointjs.com/js/rappid.min.js"></script>

<script type="text/javascript">
	var uml = joint.shapes.uml;
	
	$(function(){
		var graph = new joint.dia.Graph();
		
		var paper = new joint.dia.Paper({
			el : $('#paper-holder'),
			width : 1150,
			height : 600,
			gridSize : 1,
			model : graph
		});		
		
		var stencil = new joint.ui.Stencil({ 
	        graph: graph, 
	        paper: paper,
	        width: 300,
	        height: 600
	    });	
		
	    $('#stencil-holder').append(stencil.render().el);
	    
	    var c = createClass();	    
	    var i = createInterface();	    
	    var a = createAbstract();
		
		stencil.load([c,i,a]);  
		
		var inspector;
		
		function createInspector(cellView) {
	        if (!inspector || inspector.options.cellView !== cellView) {
	            if (inspector) {	                
	                inspector.updateCell();	                
	                inspector.remove();
	            }

	            inspector = new joint.ui.Inspector({
	               inputs: {
	                    name : { 
	                    	type: 'textarea', group: 'name', index: 1	                    	
	                    	},             	                    
	                    attributes: { type: 'list', item: { type: 'text' }, group: 'attributes', index: 1, label: 'Attributes' },
	                    methods: { type: 'list', item: { type: 'text' }, group: 'methods', index: 1, label: 'Methods' },	                        
	                    size : {
	                    	width : {type:"number",index: 1, label:"width", group: "size"},
	                    	height : {type:"number",index: 2, label:"height", group: "size"}	                    	
	                    },	                 	
	                    attrs : {
	                    	text:{'font-size': { type: 'range', min: 5, max: 30, label:"Font size", group: 'size', index: 3 }}	                    	
	                    }
	                },
	                groups: {
	                    Name: { label: 'name', index: 1 },
	                    Attributes: { label: 'attributes', index: 2 },
	                    Methods : { label: "methods", index:3},		                    
	                    Size: { label:"size", index:4}                     
	                }, 	       
	                cellView: cellView
	            });  
	            $('#inspector-holder').html(inspector.render().el);
	        }
	    }; //end of createInspector
		
		paper.on('cell:pointerdown', function(cellView) {
	        createInspector(cellView);	        
	    });
		
		paper.on('cell:pointerup', function(cellView) {	        
	        if (cellView.model instanceof joint.dia.Link) return;

	        var halo = new joint.ui.Halo({ cellView: cellView });
	        halo.removeHandle('clone');
	        halo.removeHandle('fork');
	        halo.removeHandle('rotate');
	        halo.render();
	    });
				
		var json;
		$("#save").click(function(){			
			json = graph.toJSON();
			//console.log(json);
			$.ajax({
				type : "post",
				url : "save",
				data : { "jsonData" : JSON.stringify(json) },
				dataType : "text",
				success : function(){
					graph.clear();
				}
			})					
		});
		
		$("#load").click(function(){
			$.ajax({
				type:"post",
				url : "load",
				dataType: "json",				
				success : function(data){					
					graph.fromJSON(JSON.parse(data.jsonData));
				},
				error : function(){
					console.log("실패")
				}			
			})			
		})	
		
		
		//relation change
		$('body').on('click','.tool-options',function(){
			var circle = this;
			var link = $(this).parent().parent().parent();			
			var linkId = link.attr("model-id");
			var links = graph.getLinks();
			var source;
			var target;
			var realLink;
			
			$.each(links, function(){
				if(this.prop("type") == "link")
				{
					if(this.id == linkId)
					{
						realLink = this;						
						source = this.prop("source");
						target = this.prop("target");
					}
				}
				else
				{
					if(this.id == linkId)
					{
						realLink = this;
						source = this.prop("source").id
						target = this.prop("target").id
					}
				}				
			})			
			
			var ct = new joint.ui.ContextToolbar({
			    tools: [
			        { action: 'Generalization', content: 'Generalization' },
			        { action: 'Implementation', content: 'Implementation' },
			        { action: 'Aggregation', content: 'Aggregation' },
			        { action: 'Composition', content: 'Composition' }
			    ],
			    target: circle
			});

			ct.on('action:Generalization', function() { 				
				var g = new uml.Generalization({ source: { id: source }, target: { id: target }});				
				graph.addCell(g)
				realLink.remove()
				console.log($(this).parent())
				
			});
			ct.on('action:Implementation', function() {				
				var g = new uml.Implementation({ source: { id: source }, target: { id: target }});				
				graph.addCell(g)
				realLink.remove()
				$(this).parent().toggle();
			});
			ct.on('action:Aggregation', function() {				
				var g = new uml.Aggregation({ source: { id: source }, target: { id: target }});
				
				graph.addCell(g)
				realLink.remove()
				$(this).parent().toggle();
			});
			ct.on('action:Composition', function() {				
				var g = new uml.Composition({ source: { id: source }, target: { id: target }});				
				graph.addCell(g)
				realLink.remove()
				$(this).parent().toggle();
			});

			ct.render();
			
			
		}); // end of relation change
		
		
		
	})//end jquery 
	
	var createClass = function()
	{
		 var c = new uml.Class({
				position : {
					x : 20,
					y : 20
				},
				size : {
					width : 250,
					height : 150,
				},
				attrs:{text:{'font-size':18}},
				name : "Class",
				attribute : "",
				methods : ""
			});
		 return c;
	}
	
	var createInterface = function()
	{
		var i = new uml.Interface({
			position : {
				x : 20,
				y : 190
			},
			size : {
				width : 250,
				height : 150,
			},
			attrs:{text:{'font-size':18}},
			name : "Interface",
			attribute : "",
			methods : ""
		});
		return i;
	}
	
	var createAbstract = function()
	{
		var a = new uml.Abstract({
			position : {
				x : 20,
				y : 360
			},
			size : {
				width : 250,
				height : 150,
			},
			attrs:{text:{'font-size':18}},
			name : "Abstract",
			attributes : "",
			methods : ""
		});
		return a;
	}

</script>


</head>
<body>
	<div>
	<button id="save">저장</button>
	<button id="load">불러오기</button>
	
	</div>
	<div id="stencil-holder"></div>
	<div id="paper-holder" class="paper"></div>
	<div id="inspector-holder"></div>

</body>
</html>