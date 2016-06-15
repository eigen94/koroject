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
	var erd = joint.shapes.erd;

	$(function() {
		var numberP_id=window.location.href;
		var regExp = /(\/\d+)$/g;
		var p_id = (regExp.exec(numberP_id)[0]).replace("/","");
		
		var graph = new joint.dia.Graph();

		var paper = new joint.dia.Paper({
			el : $('#paper-holder'),
			width : 1150,
			height : 600,
			gridSize : 1,
			model : graph
		});

		var stencil = new joint.ui.Stencil({
			graph : graph,
			paper : paper,
			width : 300,
			height : 600
		});

		$('#stencil-holder').append(stencil.render().el);

		var c = createEntity();
		var i = createIsa();
		var a = createRelationship();
		var n = createNormal();
		var k = createKey();

		stencil.load([ c, i, a, n, k ]);
		//stencil.load();

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
			if (cellView.model instanceof joint.dia.Link)
				return;

			var halo = new joint.ui.Halo({
				cellView : cellView
			});
			halo.removeHandle('clone');
			halo.removeHandle('fork');
			halo.removeHandle('rotate');
			halo.render();
		});

		var json;
		$("#save").click(function() {
			json = graph.toJSON();
			//console.log(json);
			$.ajax({
				type : "post",
				url : "/erd/save",
				data : {
					"jsonData" : JSON.stringify(json),
					"id" : p_id
				},
				dataType : "text",
				success : function() {
					graph.clear();
				}
			})
		});

		$("#load").click(function() {
			$.ajax({
				type : "post",
				url : "/erd/load",
				dataType : "json",
				data : {"id" : p_id},
				success : function(data) {
					graph.fromJSON(JSON.parse(data.jsonData));
				},
				error : function() {
					console.log("실패")
				}
			})
		})
		
		

		
	})//end jquery 

	var createEntity = function() {
		var c = new erd.Entity({
			position : {
				x : 20,
				y : 20
			},
			size : {
				width : 100,
				height : 50,
			},
			attrs : {
				text : {
					//'font-size':18
					text : "Entity"

				}
			},

		});
		return c;
	}

	var createIsa = function() {
		var i = new erd.ISA({
			position : {
				x : 130,
				y : 20
			},
			size : {
				width : 100,
				height : 50,
			},
			attrs : {
				text : {//'font-size':18
					text : "ISA"
				}
			},

		});
		return i;
	}

	var createRelationship = function() {
		var a = new erd.Relationship({
			position : {
				x : 20,
				y : 100
			},
			size : {
				width : 100,
				height : 50,
			},
			attrs : {
				text : {
					//'font-size':18
					text : "Relationship"
				}
			},

		});
		return a;
	}
	
	var createKey = function(){
		return (new erd.Key({
		    position: { x: 130, y: 100 },
		    size : {
				width : 100,
				height : 50,
			},
		    attrs: {
		        text: {		            
		            text: 'Key'		           
		        }
		    }
		}))
		
	}
		
		
	
	
	var createNormal = function(){
		return(new erd.Normal({
		    position: { x: 20, y: 180 },
		    size : {
				width : 100,
				height : 50,
			},
		    attrs: {
		        text: {		            
		            text: 'Normal'
		            
		        }
		    }
		}))
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