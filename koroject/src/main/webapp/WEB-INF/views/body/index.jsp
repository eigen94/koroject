<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
.newsDiv{
	border: 1px solid white;
	width: 100%;
	height: 500px;
	
}

#temp_c{
	display: inline;
}
.newsDivRight{
	overflow:auto;
	border: 1px solid white;
	width:50%;
	height: 500px;
	padding:10px; 
	display: inline-block;
	
	
}
.newsDivLeft{
	/* overflow:auto; */
	border: 1px solid white;
	width:50%;
	height: 500px;
	background: black;
	display: inline-block;
	float:left
}
.newsDivRightTop{
	border: 1px solid white;
	background: black;
	height:250px;
}
.newsDivRightBottom{
	border: 1px solid white;
	background: black;
	height:250px;
}


</style>


<title>koroject</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1" name="viewport">
<style type="text/css">

</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/jquery.scrolly.min.js"></script>
<script type="text/javascript">
$(function(){
		var href = "";
		var count = 0;
		$.ajax({
			url: '/croll',
			dataType: "json",
			 success:function(data){
				 
				$.each(data,function(){
//					$('.newsDivLeft').append('<ul><li>'+this+'</li></ul>');
//					href = $('.newsDivLeft').children().children().children().last().attr('href');
					$('.newsDivLeft').append('<li>'+this+'</li>');
					href = $('.newsDivLeft').children().children().last().attr('href');
					$('.newsDivLeft').children().last().attr('href', '');
					$('.newsDivLeft').append('<input type="hidden" class="href" value="'+href+'">');
					
					$('.newsDivLeft a').addClass('link')
				})					
				
			 }
		});
	
	
	
	$("body").on('click',".link",function(event){
		event.preventDefault()
//		var href = $(this).parent().parent().next().val();
		var href = $(this).parent().next().val();
		$(".newsDivRight").empty();
		$.ajax({
			url: '/news?href='+href,
			dataType: "json",
			 success:function(data){
				 $.each(data,function(){
					
				 	$(".newsDivRight").append('<br>');
				 	$(".newsDivRight").append(this);
				 })
			 }
		});
	});
});
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			url:"http://api.wunderground.com/api/dfadac8b2b673cb5/forecast/conditions/q/Korea/Seoul.json",
			dataType:"jsonp",
			success:function(parsed_json){
				console.log(parsed_json); //파싱된 날씨 데이터를 콘솔에 출력
				
				var weather = parsed_json['current_observation']['weather'];//현재날씨
				
				var temp_c = parsed_json['current_observation']['temp_c'];//현재 기온(섭씨)
				
				var icon_url = parsed_json['current_observation']['icon_url'];//현재 기온(섭씨)
				$('#result').html('');
				$('#result').html('<p style="margin-bottom: 0px;">Seoul City, South Korea</p>'+
						 	'<h2 id="temp_c">'+temp_c + '℃</h2>' +'&nbsp;&nbsp;<img src="'+icon_url+'"><br>'+
								'현재날씨 :' + weather );//result <div>태그 출력
			}
		});
	});
</script>
  
<body class="">


    
<section id="banner">
<div class="inner">
<h2 class="major special">Kosta Project</h2>
<p>안녕하세요 koroject 입니다.</p>
<ul class="actions vertical">
<li>
<a class="button special big" id="startProject" href="#">project go!</a>
</li>
<li>
<a class="button big scrolly" href="#one">뉴스 보기</a>
</li>
</ul>
</div>
</section>

<!-- 뉴스 시작  -->
<section id="one" class="wrapper alt style2">
<div class="newsDiv">
<div class="newsDivLeft">
<h3><strong>최신 IT뉴스 기사 리스트 top 10 </strong></h3>
출처 : http://www.itnews.or.kr/
<!-- 기사 들어갈곳 -->
</div>
<div class="newsDivRight">
<!-- 컨텐츠 들어갈곳 -->

<div class="newsDivRightTop">
최신 IT 뉴스를 만나보세요.<br>
기사 제목을 누르시면 기사가 보여집니다.
</div>

<div class="newsDivRightBottom">
	<div id="result"></div>
</div>
</div>
</div>
</section>
<!-- 뉴스 끝  -->
<section id="two" class="wrapper alt">
<section class="spotlight">
<div class="image">
<img alt="" src="/images/pic01.jpg">
</div>
<div class="content">
<h3 class="major">Pharetra Turpis</h3>
<p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus, convallis ante et, bibendum ligula. Integer porttitor lacus eu diam pretium, ac purus rutrum.</p>
</div>
</section>
<section class="spotlight">
<div class="image">
<img alt="" src="/images/pic02.jpg">
</div>
<div class="content">
<h3 class="major">Convallis Bibendum</h3>
<p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus, convallis ante et, bibendum ligula. Integer porttitor lacus eu diam pretium, ac purus rutrum.</p>
</div>
</section>

<section class="spotlight">
<div class="image">
<img alt="" src="/images/pic03.jpg">
</div>
<div class="content">
<h3 class="major">Arcu Sed Tempus</h3>
<p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus, convallis ante et, bibendum ligula. Integer porttitor lacus eu diam pretium, ac purus rutrum.</p>
</div>
</section>
</section>
<section id="three" class="wrapper style1 special">
<div class="inner narrow">
<h3 class="major special">Sed Lacus Bibendum</h3>
<p>Sagittis mauris hendrerit vitae feugiat etiam ante elementum vulputate faucibus convallis bibendum ligula.</p>
<ul class="actions">
<li>
<a class="button special big"  id="startProject" href="#">Get started</a>
</li>
</ul>
</div>
</section>

<!-- 
<nav id="menu">
<ul class="links">
<li>
<a href="projectPage">Project</a>
</li>
<li>
<a href="generic.html">Generic</a>
</li>
<li>
<a href="elements.html">Elements</a>
</li>
</ul>
<ul class="actions vertical">
<li>
<a class="button fit special signUp" href="#">Sign Up</a>
</li>
<li>
<a class="button fit menuLoginButton" href="#">Log In</a>
<script type="text/javascript">
</script>

</li>
</ul>
<a class="close" href="#menu"></a>
</nav> -->



</body>
</html>