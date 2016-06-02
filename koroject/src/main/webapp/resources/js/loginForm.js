$(function(){
	function toggleLoingForm(obj){

		$('.login').fadeToggle('slow');
		//$(obj).toggleClass('green');	  

	}
	
	function toggleSignUpForm(){
		$('.box-register').fadeToggle('slow');
	}


	$('#loginform').click(function(){
		toggleLoingForm(this);
		$("html, body").animate({
			scrollTop: 0 },"slow");
		
	})

	/*$('.signUp').click(function(){
		toggleSignUpForm(this);
	})*/




	$('#menu').on("click",".menuLoginButton",function(){
		/* console.log("hi");
		 console.log(this);*/
		//$(this).panel({delay: 500,hideOnClick: true,hideOnSwipe: true,resetScroll: true,resetForms: true,side: 'right', visibleClass:''});
		console.log($(this).parent().parent().parent());
		$(this).parent().parent().parent().removeClass('visible');

		toggleLoingForm(this);
	})

	$('#menu').on("click",".signUp",function(){
		$(this).parent().parent().parent().removeClass('visible');
		
		toggleSignUpForm(this);
	})

	$('.loginButton').click(function(){
		location.href="index";
	});

});