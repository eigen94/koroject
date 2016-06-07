$('input[type="submit"]').mousedown(function(){
  $(this).css('background', '#fff');
  $(this).css('color','#ef7f5b');
});
$('input[type="submit"]').mouseup(function(){
  $(this).css('background', '#ef7f5b');
  $(this).css('color', '#fff');
  
});

$('').on("click","#loginform",function(){
  $('.login').fadeToggle('slow');
 // $(this).toggleClass('green');
  
});


//로그인세팅클릭 
$('body').on("click","#settingLogin",function(){
	   console.log(this);
	   $('.settingNav').fadeToggle('slow');
	   
	   
	 });		

 

$('body').on("click","#startProject",function(){
	location.href="projectPage";
});





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