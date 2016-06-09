$(function(){
	function toggleLoingForm(obj){

		$('.login').fadeToggle('slow');
		//$(obj).toggleClass('green');	  

	}
	
	function toggleSignUpForm(){
		
		$('.box-register').fadeToggle('slow');
	}


	$('#loginform').click(function(e){
		e.preventDefault();
		toggleLoingForm(this);
		
		//top으로 가기 
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
		$(this).parent().parent().parent().removeClass('visible');
		//이벤트 중지
		/*this.stopPropagation();*/
		toggleLoingForm(this);
	})

	$('#menu').on("click",".signUp",function(){
		$(this).parent().parent().parent().removeClass('visible');	
		toggleSignUpForm(this);
	})


	

	
	//특정영역 제외한 곳 클릭하면 사라지기 
	$("body").click(function(e){
		if($(".box-register").css("display")=="block"){
			if(!$(".box-register").has(e.target).length){
				$(".box-register").fadeToggle("slow");
			}
			
		}
	})
	
	
	//클릭하면 값 없어지게 
	$('input').on('click', function() {
		$(this).val('');
	});

});