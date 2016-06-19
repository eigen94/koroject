<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
<link
	href="http://fonts.googleapis.com/css?family=Lato:300,400,400italic,600,700|Raleway:300,400,500,600,700|Crete+Round:400italic"
	rel="stylesheet" type="text/css" />
<style type="text/css">
legend {
	color: #ef7f5b;
	font-weight: bold;
	margin-top: 80px;
}

.myPagefiledset {
	border: 1px solid #e6e8e8;
	border-radius: 10px;
	margin: 40px 0px 40px 12%;
	height: 80%;
	padding: 25px;
	width: 100%;
}

label {
	font-weight: 400;
	color: #858585;
}

input[type=text]:hover {
	border: 1px solid #ef7f5b;
}

input[type=text], input[type=email], input[type=password], select {
	background-color: #FFF !important;
	background-image: none !important;
	border: 1px solid #c8c7cc !important;
	border-radius: 0 !important;
	color: #5b5b60 !important;
	font-family: inherit !important;
	font-size: 14px !important;
	line-height: 1.2 !important;
	padding: 5px 4px !important;
	transition-duration: .1s !important;
	box-shadow: none !important;
	width: 100%;
	margin-bottom: 7px;
	margin-top: 3px;
}

.thumbnailMyPage {
	margin-top: 5px;
	border: 1px solid #c8c7cc;
	width: 200px;
	height: 200px;
}

.leftMyPage {
	position: relative;
	float: left;
	width: 50%;
}

.rightMyPage {
	border:1px solid #e6e8e8;
	width: 35%;
	position: relative;
	float: right;
	margin-left: 30px;
	margin-right: 20px;
}

.thumbnailMyPageUpdate {
	background: #007aff;
	border: 0px solid #c8c7cc !important;
	border-radius: 0px !important;
	height: 30px;
	margin-top: 5px;
	font-weight: bold;
	/* background-image: url("/images/pencil02.jpg"); */
	background-repeat: no-repeat;
}

.thumbnailMyPageDelete {
	background: #d43f3a;
	border: 0px solid #c8c7cc !important;
	border-radius: 0px !important;
	height: 30px;
	margin-top: 5px;
	font-weight: bold;
	/* background-image: url("/images/minus01.jpg"); */
	background-repeat: no-repeat;
	
}

.MyPageButton {
	border: 1px solid #c8c7cc !important;
	border-radius: 0px !important;
	height: 10px;
	margin-top: 20px;
	float:left;
	font-weight: bold;
}
</style>

</head>
<body style="background:#e6e8e8; min-height:800px; ;">
<div style="width: 80%; height: 100%;">

	<div class="tab-pane ng-scope active">
		
			<fieldset class="myPagefiledset" style="background: white; margin-bottom: 60px; height: 10%;">
				<legend style="margin-left:180px; font-size: 23px;"> 마이페이지 </legend>
				<div class="row">
					<div class="leftMyPage">
					<form id="form" class="ng-pristine ng-valid ng-scope ng-valid-email" role="form" action="memberModify" method="post" style="margin-bottom: 3px;">
						<div class="form-group">
						<input type="hidden" name="m_id" value="${member.m_id }">
						<input type="hidden" name="m_email" value="${member.m_email }">
							<label class="control-label" style="margin-bottom: 2px;"> 이 름 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_name" value="${member.m_name }">
						</div>
						<div class="form-group">
							<label class="control-label" style="margin-bottom: 2px;"> 현재 비밀번호 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="password" name="m_pwd">
						</div>
						<div class="form-group">
							<label class="control-label" style="margin-bottom: 2px;"> 변경할 비밀번호 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="password" name="m_pwdCheck">
						</div>
					
						<div class="form-group">
							<label class="control-label" style="margin-bottom: 2px;"> 핸드폰 번호 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_phone" value="${member.m_phone }">
						</div>
						<div class="form-group">
							<label class="control-label" style="margin-bottom: 2px;" >질문</label><select
								name="m_question">
								<option value="1">고향은?</option>
								<option value="2">이름은?</option>
								<option value="3">주소는?</option>
							</select>
						</div>
					
							<label class="control-label" style="margin-bottom: 2px;">답변</label><input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_answer" value="${ member.m_answer}"><br>
								<p>${pwdFalse }</p>
					
						<input class="MyPageButton" type="submit" value="수정" style="margin-top: 0px;">
						</form>
					</div>
					<!-- 왼쪽 div 끝 -->

					<div class="rightMyPage">

						<div class="form-group">
							<label> 프로필 이미지 </label>
							<div class="ng-scope">
								<div class="user-image">
									<div class="thumbnail margin-bottom-5">
									<c:if test="${member.m_image == null }">
										<img class="ng-scope" alt="" src="/images/defaultImage.jpg">
									</c:if>
									<c:if test="${member.m_image != null }">
										<img class="ng-scope" alt="" src="/profile/${member.m_image }">
										
									</c:if>
									</div>
								</div>
								<div class="user-image-buttons-edit ng-scope">
									<p>JPG파일만 사용가능</p>
									<form id="imgForm" action="proImg" method="POST" enctype="multipart/form-data">
										<input id="ck" name="tae" type="hidden" value="${member.m_email }">
										<input type="file" id="image" name="file"><br> 
										<input class="thumbnailMyPageUpdate" type="submit" value="수정">
										<input id="delete" class="thumbnailMyPageDelete" type="button" value="삭제">
										
										<label>회원 탈퇴</label>
										<input id="memberPwd" type="password" placeholder="비밀번호를 입력하시오">
										<p>${message}</p>
										<input id="deleteMember" type="button" value="회원탈퇴">
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- right div 끝 -->
				</div>
			</fieldset>
	</div>
</div>
	<script src="/resources/js/jquery.min.js"></script>
	<script src="/resources/js/jquery.scrolly.min.js"></script>
	<script src="/resources/js/imageUpload.js"></script>
</body>
</html>