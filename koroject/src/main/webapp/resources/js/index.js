$('input[type="submit"]').mousedown(function(){
  $(this).css('background', '#fff');
  $(this).css('color','#ef7f5b');
});
$('input[type="submit"]').mouseup(function(){
  $(this).css('background', '#ef7f5b');
  $(this).css('color', '#fff');
});


$('input[type="button"]').mousedown(function(){
	  $(this).css('background', ' #f19172');
	  $(this).css('color','white');
	});
$('input[type="button"]').mouseup(function(){
	  $(this).css('background', '#ef7f5b');
	  $(this).css('color','white');
	});


$('').on("click","#loginform",function(){
  $('.login').fadeToggle('slow');
 // $(this).toggleClass('green');
  
});


//로그인세팅클릭 
$('body').on("click","#settingLogin",function(){
	   $('.settingNav').fadeToggle('slow');
	   
	   
	 });		

 

$('body').on("click","#startProject",function(){
	location.href="projectBoard";
});

//로그인 하고 나서 나오는 회원정보에서의 네비게이션
$('#temp').mouseover(function(){
	 $('#list').fadeToggle('slow');
	//$('#settingNav').css("position","absolute");
})

	//특정영역 제외한 곳 클릭하면 사라지기 
	$("body").click(function(e){
		if($("#list").css("display")=="block"){
			if(!$("#list").has(e.target).length){
				$("#list").fadeToggle("slow");
			}
			
		}
	})


//회원정보에 대한 네비게이션 링크 걸어둠
$('#settingMypage').click(function(){
	location.href="/myPage";
})
$('#settingNote').click(function(){
	location.href="/note/main";
})
$('#settingMessenger').click(function(){
	location.href="/note/main";
})
$('#settingLogOut').click(function(){
	location.href="/logout";
})

$('.settingA').click(function(e){
	e.preventDefault();
})





$(document).mouseup(function (e)
{
    var container = $(".login");

    if (!container.is(e.target) // if the target of the click isn't the container...
        && container.has(e.target).length === 0) // ... nor a descendant of the container
    {
        container.hide();
        $('#loginform').removeClass('green');
    }
});