<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<style type="text/css">
#progressArea {
	
}

#chatting {
	position: fixed;
	
	right: 0;
	height: 400px;
	border:1px;
	width: 250px;
}
</style>

<script type="text/javascript">
	$(function(){
/* 		$('#btn button').on('click', function(){
			
			var m_email = $('#btn #m_email').val();
			var p_id = $('#btn #p_id').val();
			
			$('#iframeLink').attr("src","http://localhost:7777/?email=" + m_email + "&p_id=" + p_id);
			
			  
			location.href = "http://localhost:7777/?email=" + m_email + "&p_id=" + p_id;
			  
		}) */
			var numberP_id=window.location.href;
			var regExp = /(\/\d+)/g;
			var p_id = (regExp.exec(numberP_id)[0]).replace("/","");
			
			var m_email = $('#btn #m_email').val();
			
			$('#iframeLink').attr("src","http://localhost:7777/?email=" + m_email + "&p_id=" + p_id);
			
			 /* 
			location.href = "http://localhost:7777/?email=" + m_email + "&p_id=" + p_id;
			  */


	})
</script>
<footer id="footer">
	<div id="progressArea">
		<div id="btn">
			<input type="hidden" id="m_email" value="${member.m_email}">
		</div>
		
		<div id="chatting" style="z-index: 1">
			<iframe id="iframeLink" src="" width="250" height="400"></iframe>
		</div>
	</div>
<div class="inner">
<section class="about">
<h4 class="major">Magna Aliquam Feugiat</h4>
<p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum nulla arcu. Maecenas vulputate faucibus, convallis ligula ipsum dolor feugiat tempus adipiscing.</p>
<ul class="actions">
<li>
<a class="button">Learn more</a>
</li>
</ul>
</section>
<section class="contact-info">
<h4 class="major">Get in Touch</h4>
<ul class="contact">
<li class="fa-phone">(000) 000-0000</li>
<li class="fa-envelope">
<a href="#">information@untitled.tld</a>
</li>
<li class="fa-twitter">
<a href="#">@untitled-tld</a>
</li>
<li class="fa-facebook">
<a href="#">facebook.com/untitled</a>
</li>
</ul>
<ul class="contact">
<li class="fa-home">
Untitled Corp
<br>
1234 Fictional Road
<br>
Suite 5432
<br>
Nashville, TN 00000
<br>
USA
</li>
</ul>
</section>
</div>
<div class="copyright">
<p>© Untitled Corp. All rights reserved.</p>
</div>
</footer>