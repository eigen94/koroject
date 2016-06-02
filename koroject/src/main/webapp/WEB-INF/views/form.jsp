<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Clip-Two CSS -->
		<link rel="stylesheet" href="/resources/assets/css/app.min.css">
		<!-- Clip-Two Theme -->
		
</head>
<body>

		<!-- start: REGISTER BOX -->
		<div class="box-register">
			<form class="form-register ng-pristine ng-valid">
				<fieldset>
					<legend>
						회원가입
					</legend>
					<p>
						Enter your personal details below:
					</p>
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
						<label class="block">
							질문
						</label>
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
				
					<div class="form-group">
						<div class="checkbox clip-check check-primary">
							<input type="checkbox" id="agree" value="agree">
							<label for="agree">
								I agree
							</label>
						</div>
					</div>
					<div class="form-actions">
						<p>
							Already have an account?
							<a ui-sref="login.signin" href="#/login/signin">
								Log-in
							</a>
						</p>
						<button type="submit" class="btn btn-primary pull-right">
							Submit
						</button>
					</div>
				</fieldset>
			</form>
		</div>
		<!-- end: REGISTER BOX -->
	</div>
</body>
</html>