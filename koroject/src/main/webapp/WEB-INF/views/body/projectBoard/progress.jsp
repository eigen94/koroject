<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>

<head>

</head>
<body>

<div id="chartContainer1" style="height: 300px; width: 100%;">
</div>
<div id="chartContainer2" style="height: 300px; width: 100%;"></div>
<script type="text/javascript" src="http://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">
window.onload = function () {

    var dataPoints = [];
    var y = 0;
    
    for ( var i = 0; i < 10000; i++ ) {
      
      y += Math.round(5 + Math.random() * (-5 - 5));	
      dataPoints.push({ y: y});
    }
    
    var chart2 = new CanvasJS.Chart("chartContainer2",
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
    chart2.render();
	
	var chart1 = new CanvasJS.Chart("chartContainer1",
	{
		title:{
			text: "코로젝트와 함께 프로젝트를 관리하세요",
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
				{  y: 53.37, legendText:"효과적인설계 53%", indexLabel: "효과적인설계 53%" },
				{  y: 35.0, legendText:"체계적문서관리 35%", indexLabel: "체계적문서관리 35%" },
				{  y: 7, legendText:"다양한방법론 7%", indexLabel: "다양한방법론 7%" },
				{  y: 2, legendText:"불필요한회의 2%", indexLabel: "불필요한회의 2%" },
				{  y: 5, legendText:"아름다움 5%", indexLabel: "아름다움 5%" }
			]
		}
		]
	});

	chart1.render();
}
</script>
</body>

</html>