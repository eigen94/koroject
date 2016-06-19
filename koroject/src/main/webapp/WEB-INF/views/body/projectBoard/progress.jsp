<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>

<head>
<style type="text/css">
.chartCon{
margin: 20px;
}
</style>
</head>
<body>

<div id="chartContainer2" class="chartCon" style="height: 300px; width: 40%; float: left;"></div>
<div id="chartContainer1" class="chartCon" style="height: 300px; width: 40%;"></div>
<div id="chartContainer3" class="chartCon" style="height: 300px; width: 90%;"></div>
<script type="text/javascript" src="http://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">
window.onload = function () {
/* 
     */
	

}
$(function(){
	  $.ajax({
			 url : "getStat",
			 method : "POST",
			 success : function(data){
				 console.log(data);
				 console.log(data["erd"]/data["count"]);
				 console.log(data["erd"]/data["count"]*100);
				 console.log();
				 var sign = data["sign"];
				 var count = data["count"];
				 var erd = Math.round((data["erd"]/data["count"]*100)); 
				 var uml = Math.round((data["uml"]/data["count"]*100)); 
				 var image = Math.round((data["image"]/data["count"]*100)); 
				 var usecase = Math.round((data["usecase"]/data["count"]*100)); 
				 var usediagram = Math.round((data["usediagram"]/data["count"]*100)); 
				 console.log(erd);
					var chart1 = new CanvasJS.Chart("chartContainer1",
							{
								title:{
									text: "사용중인 일정의 비율",
									fontFamily: "Impact",
									fontWeight: "normal"
								},

								legend:{
									verticalAlign: "bottom",
									horizontalAlign: "center"
								},
								data: [
								{
									//startAngle: 45,
									indexLabelFontSize: 20,
									indexLabelFontFamily: "Garamond",
									indexLabelFontColor: "darkgrey",
									indexLabelLineColor: "darkgrey",
									indexLabelPlacement: "outside",
									type: "doughnut",
									showInLegend: true,
									dataPoints: [
										{  y: usecase, legendText:"usecase", indexLabel: "usecase "+usecase+"%" },
										{  y: usediagram, legendText:"usecase Diagram", indexLabel: "usecaseDiagram "+usediagram+"%" },
										{  y: uml, legendText:"uml diagram", indexLabel: "uml diagram "+uml+"%" },
										{  y: erd, legendText:"erd diagram", indexLabel: "erd diagram "+erd+"%" },
										{  y: image, legendText:"image board", indexLabel: "image board "+image+"%" }
									]
								}
								]
							});

							chart1.render();
						var chart2 = new CanvasJS.Chart("chartContainer2",
								{
									animationEnabled: true,
									title:{
										text: "일정 진행 현황"
									},
									data: [
									{
										type: "column", //change type to bar, line, area, pie, etc
										dataPoints: [
											{ label: "생성한 총 일정 개수", y: count },
											{ label: "완료한 일정 개수", y: sign },
											{ label: "uml", y: data["uml"] },
											{ label: "usecase", y: data["usecase"] },
											{ label: "usecase diagram", y: data["usediagram"] },
											{ label: "erd", y: data["erd"] },
											{ label: "image", y: data["image"] },
										]
									}
									]
								});

								chart2.render();
								var dataPoints = [];
							    var y = 0;
							    
							    for ( var i = 0; i < 10000; i++ ) {
							      
							      y += Math.round(5 + Math.random() * (-5 - 5));	
							      dataPoints.push({ y: y});
							    }
							    
							    var chart3 = new CanvasJS.Chart("chartContainer3",
							    {
							      animationEnabled: true,
							      zoomEnabled: true,
							      
							      title:{
							        text: "프로젝트 능률의 변화"
							      },    
							      data: [
							      {
							        type: "spline",              
							        dataPoints: dataPoints
							      }
							      ]
							    });
							    chart3.render();
			 }
		  });
});
</script>
</body>

</html>