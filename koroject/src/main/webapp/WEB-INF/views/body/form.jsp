<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- Clip-Two CSS -->
		<link rel="stylesheet" href="/resources/assets/css/app.min.css">
		<!-- Clip-Two Theme -->

<style>
@import url(http://weloveiconfonts.com/api/?family=entypo);
*{
-webkit-font-smoothing:antialiased;
color:inherit;
text-decoration:none;}
/* entypo */
[class*="entypo-"]:before {
  font-family: 'entypo', sans-serif;
}
/*Main Colors*/
$color-alpha: #1abc9c;
$color-beta: #eee;
$color-gamma:#95a5a6;
$color-delta:#34495e;
$color-epsilon:#2c3e50;
$color-zeta:#16a085;
/* Change base color for each links*/
$color-alpha-2: #2ecc71;
$color-zeta-2 : #27ae60;
$color-alpha-3: #3498db;
$color-zeta-3 : #2980b9; 
$color-alpha-4: #e67e22;
$color-zeta-4 : #d35400;
$color-alpha-5: #e74c3c;
$color-zeta-5 : #c0392b;


$shade-1:rgba(0,0,0,.05);

$time-1: .4s;
$time-2: ($time-1/1.54); 




#list{
width:400px;
margin:100px auto;}
.linka{
  background:$color-delta;
  width:400px;
  height:60px;
  box-shadow:1em 0px  $color-epsilon,inset 0 1px 0 $shade-1;
  cursor:pointer;
  display:block ;
  transition:box-shadow $time-1 ease,padding $time-2 ease;
}
.linka .settingSpan{
  display:block;
  width:80px;
  height:60px;
  background:#eee;
  float:left;
  font-size:2.5em;
  line-height:1.5em;
  margin:-1.48em auto;  
  text-align:center;
  color:$color-delta;
  position:relative;
  z-index:2;
  box-shadow:.5em 0px  $color-epsilon,inset 0 1px 0 $shade-1;
  transform:rotate(0deg);
  transition:z-index 0s ease $time-2;
}
.linka .settingP:before{
  content:'';
  position:absolute;
  z-index:1;
  display:block;
  width:20px;
  height:20px;
  margin:1em -1.7em;
 background:$color-epsilon;
transform:rotate(-45deg);
  opacity:0;
}
.linka .settingP{
  font-size:1.4em;
  width:300px; 
  display:block;
  float:left;
  padding-left:5em;
  padding-top:0;
  margin:0;
  line-height:2.7;
  color:$color-beta;
  font-family:helvetica;
  transition: $time-1 ease;
}

.linka:hover{
 background:$color-zeta;
  box-shadow:1em 0px  $color-alpha,inset 0 1px 0 $shade-1;
  padding-right:1em;
  .settingSpan{
    color:$color-zeta;
   box-shadow:.5em 0px $color-alpha;
    z-index:0;
  }
  .settingP{
    padding-left:6em;
    
    color:#ecf0f1;
    &:before{
      background:$color-alpha;
      margin:1em -2.7em;
        opacity:1
      }
   }
}


.linka:nth-child(2):hover{
 background:$color-zeta-2;
  box-shadow:1em 0px  $color-alpha-2,inset 0 1px 0 $shade-1;
  .settingSpan{
    color:$color-zeta-2;
   box-shadow:.5em 0px $color-alpha-2;
  }
  .settingP:before{
      background:$color-alpha-2;
      }
}
.linka:nth-child(3):hover{
 background:$color-zeta-3;
  box-shadow:1em 0px  $color-alpha-3,inset 0 1px 0 $shade-1;
  .settingSpan{
    color:$color-zeta-3;
   box-shadow:.5em 0px $color-alpha-3;
  }
  .settingP:before{
      background:$color-alpha-3;
      }
}
.linka:nth-child(4):hover{
 background:$color-zeta-4;
  box-shadow:1em 0px  $color-alpha-4,inset 0 1px 0 $shade-1;
  .settingSpan{
    color:$color-zeta-4;
   box-shadow:.5em 0px $color-alpha-4;
  }
  .settingP:before{
      background:$color-alpha-4;
      }
}
.linka:nth-child(5):hover{
 background:$color-zeta-5;
  box-shadow:1em 0px  $color-alpha-5,inset 0 1px 0 $shade-1;
  .settingSpan{
    color:$color-zeta-5;
   box-shadow:.5em 0px $color-alpha-5;
  }
  .settingP:before{
      background:$color-alpha-5;
      }
}
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