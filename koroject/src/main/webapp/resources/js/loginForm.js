$(function(){
	function toggleLoingForm(obj){
		
	  $('.login').fadeToggle('slow');
	  $(obj).toggleClass('green');	  
			
	}

	$('#loginform').click(function(){
		toggleLoingForm(this);
		});
	
	
	$('#menu').on("click",".menuLoginButton",function(){
		 console.log("hi");
		 console.log(this);
		//$(this).panel({delay: 500,hideOnClick: true,hideOnSwipe: true,resetScroll: true,resetForms: true,side: 'right', visibleClass:''});
		console.log($(this).parent().parent().parent());
		$(this).parent().parent().parent().removeClass('visible');
		
		 toggleLoingForm(this);
		 
	
		})
	
});
$(function(){
	function toggleLoingForm(obj){
		
	  $('.login').fadeToggle('slow');
	  $(obj).toggleClass('green');	  
			
	}

	$('#loginform').click(function(){
		toggleLoingForm(this);
		});
	
	
	$('#menu').on("click",".menuLoginButton",function(){
		 console.log("hi");
		 console.log(this);
		//$(this).panel({delay: 500,hideOnClick: true,hideOnSwipe: true,resetScroll: true,resetForms: true,side: 'right', visibleClass:''});
		console.log($(this).parent().parent().parent());
		$(this).parent().parent().parent().removeClass('visible');
		
		 toggleLoingForm(this);
		 
	
		})
		
		$('.loginButton').click(function(){
			location.href="index";
			});
	
});