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
						Sign Up
					</legend>
					<p>
						Enter your personal details below:
					</p>
					<div class="form-group">
						이름 <input type="text" class="form-control" name="name" placeholder="name">
					</div>
					<div class="form-group">
						e-mail <input type="text" class="form-control" name="e-mail" placeholder="e-mail">
					</div>
					<div class="form-group">
						비밀번호<input type="text" class="form-control" name="password" placeholder="password">
					</div>
					<div class="form-group">
						비밀번호 확인<input type="text" class="form-control" name="passwordCheck" placeholder="passwordCheck">
					</div>
					<div class="form-group">
						<label class="block">
							Gender
						</label>
						<div class="clip-radio radio-primary">
							<input type="radio" id="rg-female" name="gender" value="female">
							<label for="rg-female">
								Female
							</label>
							<input type="radio" id="rg-male" name="gender" value="male">
							<label for="rg-male">
								Male
							</label>
						</div>
					</div>
					<p>
						Enter your account details below:
					</p>
					<div class="form-group">
						<span class="input-icon">
							<input type="email" class="form-control" name="email" placeholder="Email">
							<i class="fa fa-envelope"></i> </span>
					</div>
					<div class="form-group">
						<span class="input-icon">
							<input type="password" class="form-control" id="password" name="password" placeholder="Password">
							<i class="fa fa-lock"></i> </span>
					</div>
					<div class="form-group">
						<span class="input-icon">
							<input type="password" class="form-control" name="password_again" placeholder="Password Again">
							<i class="fa fa-lock"></i> </span>
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
							Submit <i class="fa fa-arrow-circle-right"></i>
						</button>
					</div>
				</fieldset>
			</form>
			<!-- start: COPYRIGHT -->
			<div class="copyright ng-binding">
				2016 © Clip-Two by ClipTheme.
			</div>
			<!-- end: COPYRIGHT -->
		</div>
		<!-- end: REGISTER BOX -->
	</div>
</body>
</html>