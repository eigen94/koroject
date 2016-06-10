$(function(){
	function login(data){
		$.ajax({
			type: "post",
			url:'/login?m_email='+data.m_email,
			success:function(){
				alert('성공');
			},error:function(){
				alert('fuck')
			}
			
		})
	}
	
	
	$("#login").submit(function(event){
		var email = $('#loginEmail').val();
		var pwd = $('#loginPwd').val();
		$.ajax({
			url: '/loginCheck?email='+email+'&pwd='+pwd,
			dataType: "json",
			 success:function(data){
				 if(data.m_email == "noEmail"){
					 alert('이메일 또는 비밀번호가 잘 못 됐습니다.');
					 return false;
				 }else{
					 alert('로그인성공ㅎㅎ');
					 login(data);
				 }
			 },error:function(){
				 alert('실패')
			 }
		})
		
	});
	
	
	
	
});