$(function(){
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
			 }
		})
	});
	
	function login(data){
		alert("갓태광 집에가자");
		alert(data.m_email);
		$.ajax({
			type: "post",
			url:'/loginMember',
			data:data,
			success:function(){
				location.href="loginMember2";
			}
			
		})
	}
	/*$('#login').on('click', function(){
		alert('aaaa');
		return false;
	})*/
	
	
});