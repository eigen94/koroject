<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header id="header">
<h1>
<a href="index.html">
koroject
<span>by kosta</span>
</a>
</h1>

<!-- todo  -->
<!-- 로그아웃 기능에 맞게 수정할것 -->
<c:if test="${member !=null }">

	<%-- <a href="logout" id="settingLogin">${member.m_name}님 </a> 반갑 습니다. --%>
	<a href="logout" id="settingLogin">${member.m_name}님 </a> 반갑 습니다.
	  <nav id="menu">
<ul class="links">
<li>
<a href="projectPage">Project</a>
</li>
<li>
프로젝트1
</li>
<li>
프로젝트2
</li>

<li>
<a href="generic.html">공지사항</a>
</li>
<li>
<a href="elements.html">Elements</a>
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
<div class="settingNav" style="display:none;">
    <div class="loginSetting">
        <div class="randompad">
             <label name="SettingMyPage">마이페이지</label>
             <label name="SettingNote">쪽지</label>
             <label name="SettingLogOut">로그아웃</label>
        </div>
    </div>
  </div>
  
  
        
                
    
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
        <form id="login" action="/login" method="post">
             <label name="email">Email</label>
             <input type="text" name="m_email" value="example@example.com" />
             <label name="password">Password</label>
             <input type="password" name="m_pwd" />
             <input class="loginButton" type="submit" value="Loginaaa" />
          </form>
        </div>
      </div>
    </div>
  </div>
  

    		<!-- start: REGISTER BOX -->
		<div class="box-register">
			<form action="insert_member" class="form-register ng-pristine ng-valid">
				<fieldset class="signUpfieldset">
					<legend>
						회원가입
					</legend>
						Enter your personal details below:
					<div class="form-group">
						이름 <input type="text" class="form-control" name="m_name" placeholder="name">
					</div>
					<div class="form-group">
						e-mail <input type="text" class="form-control" name="m_email" placeholder="e-mail">
					</div>
					<div class="form-group">
						비밀번호<input type="text" class="form-control" name="m_pwd" placeholder="password">
					</div>
					<div class="form-group">
						비밀번호 확인<input type="text" class="form-control" name="m_pwdCheck" placeholder="password Again">
					</div>
					<div class="form-group">
						핸드폰 번호<input type="text" class="form-control" name="m_phone" placeholder="phone Number">
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
						<input type="text" class="form-control" name="m_answer" placeholder="Answer">
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
						<button type="submit" class="btn btn-primary pull-right registerSubmit">
							Submit
						</button>
					</div>
				</fieldset>
			</form>
		</div>
		<!-- end: REGISTER BOX -->

	