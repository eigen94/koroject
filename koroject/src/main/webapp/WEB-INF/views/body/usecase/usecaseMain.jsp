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
	left: 200px;
	height: 600px;
	width: 1200px;	
	position: relative;
	
}

#stencil-holder {
	width: 200px;
	height: 400px;	
	position: absolute;
}

.inspector input{
	height: 40px;
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
		var numberP_id=window.location.href;
		var regExp = /(\/\d+)$/g;
		var p_id = (regExp.exec(numberP_id)[0]).replace("/","");
		
		var graph = new joint.dia.Graph();
		
		var paper = new joint.dia.Paper({
			el : $('#paper-holder'),
			width : 1250,
			height : 600,
			gridSize : 1,
			model : graph
		});		
		
		var stencil = new joint.ui.Stencil({ 
	        graph: graph, 
	        paper: paper,
	        width: 300,
	        height: 400
	    });	
		
	    $('#stencil-holder').append(stencil.render().el);
	    
	    var actor = createActor();
	    var usecase = createUsecase();
	    //var system = createSystem();
		
		stencil.load([actor, usecase]);  
		
		var inspector;
		
		function createInspector(cellView) {
			if (!inspector || inspector.options.cellView !== cellView) {
				if (inspector) {
					inspector.updateCell();
					inspector.remove();
				}

				inspector = new joint.ui.Inspector({
					inputs : {				
												
						
						labels: {
			                type: 'list',
			                group: 'labels',
			                attrs: {
			                    label: { 'data-tooltip': 'Set (possibly multiple) labels for the link' }
			                },
			                item: {
			                    type: 'object',
			                    properties: {
			                        position: { type: 'range', min: 0.1, max: .9, step: .1, defaultValue: .5, label: 'position', index: 2, attrs: { label: { 'data-tooltip': 'Position the label relative to the source of the link' } } },
			                        attrs: {
			                            text: {
			                                text: { type: 'text', label: 'text', defaultValue: 'label', index: 1, attrs: { label: { 'data-tooltip': 'Set text of the label' } } }
			                            }
			                        }
			                    }
			                }
			            },
						
						
						
						
						attrs : {
							text : {
								text : {
									type : "text",
									label : "text",
									group : "text",
									index : 1
								},
								'font-size' : {
									type : 'range',
									min : 5,
									max : 30,
									label : "Font size",
									group : 'text',
									index : 2
								}
							}
						}
					},
					groups : {
						text : {
							label : 'text',
							index : 1
						},
						labels: { label: 'Labels', index: 2 },

					},
					cellView : cellView
				});
				$('#inspector-holder').html(inspector.render().el);
			}
		}
		; //end of createInspector
		
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
				url : "/usecase/save",
				data : { 
					"jsonData" : JSON.stringify(json),
					"id" : p_id
					},
				dataType : "text",
				success : function(){
					graph.clear();
				}
			})					
		});
		
		$("#load").click(function(){
			$.ajax({
				type:"post",
				url : "/usecase/load",
				dataType: "json",			
				data : {"id" : p_id},
				success : function(data){					
					graph.fromJSON(JSON.parse(data.jsonData));
				},
				error : function(){
					console.log("실패")
				}			
			})			
		})	
		
		
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
			        
			        { action: 'link-change', content: 'link-change' }
			        
			    ],
			    target: circle
			});

			ct.on('action:link-change', function() { 				
				var g = new uml.Implementation({ source: { id: source }, target: { id: target }});				
				graph.addCell(g)
				realLink.remove()
				console.log($(this).parent())
				
			});			

			ct.render();
			
			
		}); // end of relation change
		
		
		
	})//end jquery 
	
	var createActor = function()
	{
		return (new joint.shapes.basic.Image({
			position : {
				x : 20,
				y : 20
			},
			size : {
				width : 125,
				height : 75,
			},
			attrs : {
				image : {
					width : 100,
					height : 100,
					"xlink:href" : "/images/actor.jpg"
					//src : "/images/actor.jpg"
				},
				text: { text: 'Actor', 'font-size': 18, display: '', stroke: '#000000', 'stroke-width': 0 }
			}
		}));
	}
	
	var createUsecase = function()
	{
		return ( new joint.shapes.basic.Circle({
			position : {
				x : 20,
				y : 220
			},
			size : {
				width : 125,
				height : 75,
			},
            attrs: {
                circle: { width: 50, height: 30, },
                text: { text: 'usecase', 'font-size': 18, stroke: '#000000', 'stroke-width': 0 }
            }
        }));
	}
	
	var createSystem = function()
	{
		return (new joint.shapes.basic.Rect({
			position : {
				x : 20,
				y : 390
			},
			size : {
				width : 250,
				height : 150,
			},
            attrs: {
                rect: {
                    rx: 2, ry: 2, width: 50, height: 30,
                    //fill: '#27AE60'
                },
                text: { text: 'System', 'font-size': 18, stroke: '#000000', 'stroke-width': 0 }
            }
        }));
	}

</script>


</head>
<body>
	<div>
	<button id="save">저장</button>
	<button id="load">불러오기</button>
	<button id="convert">convert</button>
	
	</div>
	<div id="stencil-holder"></div>
	<div id="paper-holder" class="paper"></div>
	<div id="inspector-holder"></div>

</body>
</html>