(function($) {
	
	var modalContents = $(".modal-contents");
	 var check = 0;
	 $('.onlyAlphabetAndNumber').keyup(function(event){
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
             var inputVal = $(this).val();
             $(this).val($(this).val().replace(/[^_a-z0-9]/gi,'')); //_(underscore), 영어, 숫자만 가능
         }
     });
      
     $(".onlyHangul").keyup(function(event){
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
             var inputVal = $(this).val();
             $(this).val(inputVal.replace(/[a-z0-9]/gi,''));
         }
     });
  
     $("#phoneNumber").keyup(function(event){
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
             var inputVal = $(this).val();
             $(this).val(inputVal.replace(/[^0-9]/gi,''));
         }
     });
	
     $("#emailCheck").on('click',function(){
    	 var email = $("#email").val();
    	 var emailCheck = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    	
    	 $.ajax({
    		 url: '/emailCheck?email='+email,
    		 success:function(data){
    			 if(!(emailCheck.test(email))){
    				 alert('이메일 형식이 아닙니다.')
    			 }else if(data == ""){
    				 alert('사용 가능한 이메일 입니다.')
    				 check=1;
    			 }else if(email == ""){
    				 alert('이메일을 입력 해주세요.')
    			 }else if(email == data){
    				 alert('중복된 이메일 입니다.')	 
    			 }
    	      }
    	 })

     })
     
     $( "form" ).submit(function( event ) {
         var divPassword = $('#divPassword');
         var divPasswordCheck = $('#divPasswordCheck');
         var divName = $('#divName');
         var divEmail = $('#divEmail');
         var divPhoneNumber = $('#divPhoneNumber');
         var divAnswer = $('#divAnswer');
         var regExp = /^010?([0-9]{7,8})$/; 
         
         
         //이름
         if($('#name').val()==""){
             modalContents.text("이름을 입력하여 주시기 바랍니다.");
           
              
             divName.removeClass("has-success");
             divName.addClass("has-error");
             $('#name').focus();
             return false;
         }else{
             divName.removeClass("has-error");
             divName.addClass("has-success");
         }
          
         //이메일
         if($('#email').val()==""){
             modalContents.text("이메일을 입력하여 주시기 바랍니다.");
            
              
             divEmail.removeClass("has-success");
             divEmail.addClass("has-error");
             $('#email').focus();
             return false;
         }else{
             divEmail.removeClass("has-error");
             divEmail.addClass("has-success");
         }
         
         //이메일 중복 체크 확인 여부
         if(check==0){
        	 alert('이메일 중복 체크를 확인해 주세요.')
         }
         
       //패스워드 검사
         if($('#password').val()==""){
             modalContents.text("패스워드를 입력하여 주시기 바랍니다.");

              
             divPassword.removeClass("has-success");
             divPassword.addClass("has-error");
             $('#password').focus();
             return false;
         }else{
             divPassword.removeClass("has-error");
             divPassword.addClass("has-success");
         }
          
         //패스워드 확인
         if($('#passwordCheck').val()==""){
             modalContents.text("패스워드 확인을 입력하여 주시기 바랍니다.");
            
              
             divPasswordCheck.removeClass("has-success");
             divPasswordCheck.addClass("has-error");
             $('#passwordCheck').focus();
             return false;
         }else{
             divPasswordCheck.removeClass("has-error");
             divPasswordCheck.addClass("has-success");
         }
          
         //패스워드 비교
         if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
             modalContents.text("패스워드가 일치하지 않습니다.");
      
              
             divPasswordCheck.removeClass("has-success");
             divPasswordCheck.addClass("has-error");
             $('#passwordCheck').focus();
             return false;
         }else{
             divPasswordCheck.removeClass("has-error");
             divPasswordCheck.addClass("has-success");
         }
         //휴대폰 번호
         if($('#phoneNumber').val()==""){
             modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
          
              
             divPhoneNumber.removeClass("has-success");
             divPhoneNumber.addClass("has-error");
             $('#phoneNumber').focus();
             return false;
         }else{
             divPhoneNumber.removeClass("has-error");
             divPhoneNumber.addClass("has-success");
         }
         //휴대폰 번호가 맞나
         if(!(regExp.test($('#phoneNumber').val()))){
        	 modalContents.text('010으로 시작하는 10~11자리 숫자를 입력하여 주세요.')
        	 
        	  divPhoneNumber.removeClass("has-success");
             divPhoneNumber.addClass("has-error");
             $('#phoneNumber').focus();
             return false;
         }else{
             divPhoneNumber.removeClass("has-error");
             divPhoneNumber.addClass("has-success");
         }
         
         
         //답변
         if($('#answer').val()==""){
             modalContents.text("답변을 입력하여 주시기 바랍니다.");
             
             divAnswer.removeClass("has-success");
             divAnswer.addClass("has-error");
             $('#answer').focus();
             return false;
         }else{
             divPhoneNumber.removeClass("has-error");
             divPhoneNumber.addClass("has-success");
         }
         
     });
		
})(jQuery);