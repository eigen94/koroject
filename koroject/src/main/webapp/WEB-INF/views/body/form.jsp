<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<style>
@import url(http://weloveiconfonts.com/api/?family=entypo);

</style>		
</head>
<body>

<%-- 		<!-- start: REGISTER BOX -->
		<div class="box-register">
			<f:form class="form-register ng-pristine ng-valid" action="insert_member" commandName="registerCommand">
				<fieldset>
					<legend>
						회원가입
					</legend>
					<p>
						Enter your personal details below:
					</p>
					<div class="form-group">
						이름 <f:input class="form-control" path="m_name" placeholder="name"/><f:errors path="m_name"/>
					</div>
					<div class="form-group">
						e-mail <f:input  class="form-control" path="m_email" placeholder="e-mail"/><f:errors path="m_email"/>
					</div>
					<div class="form-group">
						비밀번호<f:password class="form-control" path="m_pwd" placeholder="password"/><f:errors path="m_pwd"/>
					</div>
					<div class="form-group">
						비밀번호 확인<f:password class="form-control" path="m_pwdCheck" placeholder="password Again"/><f:errors path="m_pwdCheck"/>
					</div>
					<div class="form-group">
						핸드폰 번호<f:input class="form-control" path="m_phone" placeholder="phone Number"/><f:errors path="m_phone"/>
					</div>
					<div class="form-group">
						<label class="block">
							질문
						</label>
						<f:select path="m_question">
								<f:option value="1">고향은?</f:option>
								<f:option value="2">이름은?</f:option>
								<f:option value="3">주소는?</f:option>
						</f:select>
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
						<f:input class="form-control" path="m_answer" placeholder="Answer"/><f:errors path="m_answer"/>
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
						<p>
							Already have an account?
							<a ui-sref="login.signin" href="#/login/signin">
								Log-in
							</a>
						</p>
						<input type="submit" class="btn btn-primary pull-right" value="회원가입">
					</div>
				</fieldset>
			</f:form>
		</div>
		<!-- end: REGISTER BOX -->
	</div> --%>
	
	
	<div id="settingNav" style="">
<ul id="list">
  <li class="linka">
    <p class="settingP"><a href="#">마이페이지</a></p>
    <span class="entypo-user settingSpan"></span>
  </li>
  <li class="linka">
    <p class="settingP"><a href="#">쪽지</a></p>
    <span class="entypo-chat settingSpan"></span>
  </li>
  <li class="linka">
    <p class="settingP"><a href="#">메신저</a></p>
    <span class="entypo-chat settingSpan"></span>
  </li>
  <li class="linka">
    <p class="settingP"><a href="#">로그아웃</a></p>
    <span class="entypo-logout settingSpan"></span>
  </li>
</ul> 
  </div>
</body>
</html>