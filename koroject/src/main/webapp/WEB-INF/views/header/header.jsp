<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/assets/css/app.min.css">
<link rel="stylesheet" href="/resources/css/header.css">
<style>
@import url(http://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css);@import url("https://fonts.googleapis.com/css?family=Raleway:300,700");/*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/ 
@import url(http://weloveiconfonts.com/api/?family=entypo);
</style>

<header id="header">
<h1>
<a href="/">
koroject
<span>by kosta</span>
</a>
</h1>

<!-- todo  -->
<!-- 로그아웃 기능에 맞게 수정할것 -->
<c:if test="${member !=null }">

	<%-- <a href="logout" id="settingLogin">${member.m_name}님 </a> 반갑 습니다. --%>
	<!-- 여기에 쪽지 링크 주소 요청 할것 -->
	<a id="temp">${member.m_name}님 </a> 안녕하세요.
	  <nav id="menu">
<ul class="links">
<li>
<a href="/projectBoard">Project관리</a>
</li>

<li>
<a href="generic.html">공지사항</a>
</li>
<li>
<a href="/note/main">쪽지</a>
</li>
</ul>
<ul class="actions vertical">
<li>
</li>
<li>
<a class="button fit menuLogOutButton" href="logout">Log Out</a>

</li>
</ul>
<a class="close" href="#menu"></a>
</nav>


<!-- 로그인 세팅폼-->
<ul id="list" style="display:none;">
  <li class="linka">
    <p class="settingP" id="settingMypage"><a class="settingA" href="#">마이페이지</a></p>
    <span class="entypo-user settingSpan"></span>
  </li>
  <li class="linka">
    <p class="settingP" id="settingNote"><a class="settingA" href="/note/main">쪽지</a></p>
    <span class="entypo-chat settingSpan"></span>
  </li>
  <li class="linka">
    <p class="settingP" id="settingMessenger"><a class="settingA" href="#">메신저</a></p>
    <span class="entypo-chat settingSpan"></span>
  </li>
  <li class="linka">
    <p class="settingP" id="settingLogOut"><a class="settingA" href="logout">로그아웃</a></p>
    <span class="entypo-logout settingSpan"></span>
  </li>
</ul> 

  
  
        
                
    
</c:if>
<c:if test="${member==null }">
	<a href="#login" id="loginform">Log In!!</a>
	
	
	  <nav id="menu">
<ul class="links">
<li>
<a href="projectPage">Project</a>
</li>
<li>
<a href="generic.html">Generic</a>
</li>
<li>
<a href="elements.html">Elements</a>
</li>
</ul>
<ul class="actions vertical">
<li>
<a class="button fit special signUp" href="#">Sign Up</a>
</li>
<li>
<a class="button fit menuLoginButton" href="#">Log In</a>

</li>
</ul>
<a class="close" href="#menu"></a>
</nav>
    
</c:if>

<a href="#menu">Menu</a>
</header>    


<!-- 로그인 폼 -->
<div id="navthing">
      <!-- <h2><a href="#" id="loginform">Login</a> | <a href="#">Register</a></h2> -->
    <div class="login">
      <div class="arrow-up"></div>
      <div class="formholder">
        <div class="randompad">
        <form id="login" action="login" method="post">
             <label name="email" style="margin-bottom: 0px;">Email</label>
             <input type="email" id="loginEmail" name="m_email" placeholder="example@example.com" style="margin-top: 0px;" />
             <label name="password" style="margin-bottom: 0px;">Password</label>
             <input type="password" id="loginPwd" name="m_pwd" placeholder="password" style="margin-top: 0px;" />
             <input type="submit" value="Login" />
             <div style="margin-bottom: 0px; margin-top: 10px;">
             <a class="searchID">아이디</a>를 잊어버렸나요?
             </div>
             
         </form>
        </div>
      </div>
    </div>
  </div>
  

    		<!-- start: REGISTER BOX -->
		<div class="box-register">
			<form id="register" action="insert_member" class="form-register ng-pristine ng-valid">
				<fieldset class="signUpfieldset">
					<legend>
						회원가입
					</legend>
						Enter your personal details below:
					<div class="form-group">
						이름 <input type="text" class="form-control" id="name" name="m_name" placeholder="name">
					</div>
					<div class="form-group">
						e-mail <input type="email" class="form-control" id="email" name="m_email" placeholder="e-mail">
						<button id="emailCheck">이메일 중복 확인</button>
					</div>
					<div class="form-group">
						비밀번호<input type="password" class="form-control" id="password" name="m_pwd" placeholder="password">
					</div>
					<div class="form-group">
						비밀번호 확인<input type="password" class="form-control" id="passwordCheck" name="m_pwdCheck" placeholder="password Again">
					</div>
					<div class="form-group">
						핸드폰 번호<input type="text" class="form-control" id="phoneNumber" name="m_phone" placeholder="숫자만 입력 가능합니다.">
					</div>
					<div class="form-group">
						질문
						<select name="m_question">
								<option value="1">고향은?</option>
								<option value="2">이름은?</option>
								<option value="3">주소는?</option>
						</select>
						<!-- <div class="clip-radio radio-primary">
							<input type="radio" id="rg-female" name="gender" value="female">
							<label for="rg-female">
								Female
							</label>
							<input type="radio" id="rg-male" name="gender" value="male">
							<label for="rg-male">
								Male
							</label>
						</div> -->
					</div>
					
					<div class="form-group">
						<input type="text" class="form-control" id="answer" name="m_answer" placeholder="Answer">
					</div>
				
			<!-- 		<div class="form-group">
						<div class="checkbox clip-check check-primary">
							<input type="checkbox" id="agree" value="agree">
							<label for="agree">
								I agree
							</label>
						</div>
					</div> -->
					<div class="form-actions">
							이미 계정이 있으신 가요?
							<a ui-sref="login.signin" href="#/login/signin">
								Log-in
							</a>
						<button type="submit" class="btn btn-primary pull-right">
							회원가입
						</button>
					</div>
					<p class="modal-contents"></p>
				</fieldset>
			</form>
		</div>
		<!-- end: REGISTER BOX -->


<!-- this is loginForm js -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/js/jquery.scrolly.min.js"></script>
<script src="/resources/js/skel.min.js"></script>
<script src="/resources/js/util.js"></script>
<script src="/resources/js/front.js"></script>
<script src="/resources/js/index.js"></script>
<script src="/resources/js/loginForm.js"></script>
<script src="/resources/js/register.js"></script>
<!-- <script src="/resources/js/login.js"></script> -->

	