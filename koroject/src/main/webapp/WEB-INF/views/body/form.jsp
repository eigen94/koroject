<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
	label{
		font-size:18px;
		margin-left:10px;
	}
	.example{
		padding-bottom:10px;
	}
	
	.bb {
			width:100px;
			height:18px;
			border: 3px dotted #666666;
			display: inline-block;
			cursor:pointer;
			color: #9b0e0e;
			position:relative;
		}

		.bt {
			width:100px;
			font-size: 18px;
			font-family: verdana;
			position:relative;
			top:-5px;
			text-align:center;
			border: 2px solid #9b0e0e;
			-moz-transform: rotate(-5deg);
			-webkit-transform: rotate(-5deg);
			-o-transform: rotate(-5deg);
			-ms-transform: rotate(-5deg);
			transform: rotate(-5deg);
			position:absolute;
		}

		.bb.disabled {
			border: 3px dotted #898989;
			background:#ededed;
		}

		.bt.disabled {
			color: #898989;
			border: 2px solid #898989;
		}
	
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="/resources/js/betterCheckbox.js"></script>
 <script type="text/javascript">
    jQuery(document).ready(function(){ 
		
		$('#b').betterCheckbox({boxClass: 'bb', tickClass: 'bt', tickInnerHTML: "approved"});
		$('#b-dis').betterCheckbox({boxClass: 'bb', tickClass: 'bt', tickInnerHTML: "approved"});
		$('#b-dis').betterCheckbox('disable');
		
	});
	</script>


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
	
	<h2>stamp</h2>
	<div class="example"><input id="b" checked="checked" type="checkbox" name="b" value="b" style="display: none;"><div class="bb" style="-webkit-user-select: none;"><div class="bt">approved</div></div> <label for="b">Enabled</label></div>
	<div class="example"><input id="b-dis" checked="checked" type="checkbox" disabled="" name="b" value="b" style="display: none;"><div class="bb disabled" style="-webkit-user-select: none;"><div class="bt disabled">approved</div></div> <label for="b-dis">Disabled</label></div>

</body>
</html>