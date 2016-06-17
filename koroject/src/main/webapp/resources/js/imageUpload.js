$(function(){
	$('#imgForm').submit(function(){
		var img = $('#image').val();
		var imgName = img.split('.');
		if(imgName[1]=='jpg' || imgName[1]=='png'){
			
		}else{
			alert('이미지 파일이 아닙니다.');
			return false;
		}
	})
	
	$('#delete').on('click',function(){
		var email = $('#ck').val();
		$.ajax({
			url: '/proDelete?email='+email,
			success:function(data){
				 window.location.href = "/myPage"
			}
		})
	})
	
	$('#deleteMember').on('click',function(){
		var email = $('#ck').val();
		var pwd = $('#memberPwd').val();
		$.ajax({
			url: '/deleteMember?m_email='+email+'&m_pwd='+pwd,
			success:function(data){
				if(data == 1){
					window.location.href = "/index"
				}else if(data==0){
					window.location.href="/myPage"
				}
			}
		})
		
	})
	
});
