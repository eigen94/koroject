$(function(){
	$('#imgForm').submit(function(){
		var img = $('#image').val();
		var imgName = img.split('.');
		alert(imgName[1])
		if(imgName[1]=='jpg' || imgName[1]=='png'){
			
		}else{
			alert('이미지 파일이 아닙니다.');
			return false;
		}
	})
	
});