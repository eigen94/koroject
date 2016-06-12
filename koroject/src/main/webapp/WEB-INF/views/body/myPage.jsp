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
	font-size: 20px;
	font-weight: bold;
}

.myPagefiledset {
	border: 1px solid #e6e8e8;
	border-radius: 10px;
	margin: 20px 0;
	padding: 25px;
	width: 64%;
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
	border: 1px solid;
	position: relative;
	float: left;
	width: 50%;
}

.rightMyPage {
	border: 1px solid;
	width: 35%;
	position: relative;
	float: right;
	margin-left: 30px;
	margin-right: 20px;
}

.thumbnailMyPageUpdate {
	background: #007aff;
	border: 1px solid #c8c7cc !important;
	border-radius: 5px !important;
	height: 30px;
	margin-top: 5px;
	color: white;
	font-weight: bold;
}

.thumbnailMyPageDelete {
	background: #d43f3a;
	border: 1px solid #c8c7cc !important;
	border-radius: 5px !important;
	height: 30px;
	margin-top: 5px;
	color: white;
	font-weight: bold;
}

.MyPageButton {
	border: 1px solid #c8c7cc !important;
	border-radius: 5px !important;
	height: 30px;
	margin-top: 100px;
	margin-left: 360px;
	color: white;
	font-weight: bold;
	background: #ef7f5b
}
</style>
</head>
<body>
	<%-- 
	<div class="tab-pane ng-scope active" style="">
		<form id="form" class="ng-pristine ng-valid ng-scope ng-valid-email"
			role="form" action="#" id="formMy">
			<fieldset>
			<input type="hidden" id="m_id" name="m_id" value="${member.m_id }">
				<legend> 회원 정보 </legend>
				<div class="row">
					<div class="leftMyPage">
						<div class="form-group">
							<label class="control-label">이름 </label><br> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_name" value="${member.m_name }">
						</div>
						<div class="form-group">
							<label class="control-label">이메일</label><br> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="email" name="m_email" value="${member.m_email }">
						</div>
						<div class="form-group">
							<label class="control-label">비밀번호 </label><br> <input
								class="form-control ng-pristine ng-untouched ng-valid ng-valid-email"
								type="password" name="m_pwd">
						</div>
						<div class="form-group">
							<label class="control-label">핸드폰 번호</label><Br> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_phone" value="${member.m_phone }">
						</div>
						<div class="form-group">
							<label class="control-label">질문</label><br> <select
								name="m_question">
								<option value="1">고향은?</option>
								<option value="2">이름은?</option>
								<option value="3">주소는?</option>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">답변</label><Br> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_answer" value="${ member.m_answer}">
						</div>
					</div>
				</div>

				
						 <input class="MyPageButton" type="button" value="submit">
	</div>
	
	</fieldset>
	</form>
	
	<form id="imgForm" action="proImg" method="POST" enctype="multipart/form-data">
		<div class="rightMyPage">
			<div class="form-group">
				<label> 프로필 사진 </label>
				<div class="ng-scope">
					<div class="user-image">
						<div class="thumbnailMyPage">
							<img class="ng-scope" alt="" src="/images/defaultImage.jpg">
						</div>
					</div>
					<div class="user-image-buttons-edit ng-scope">
						<p>JPG파일만 사용가능</p>
						<input type="file" id="image" name="file"><br> <input
							class="thumbnailMyPageUpdate" type="submit" value="프로필사진 수정">
						<input class="thumbnailMyPageDelete" type="button"
							value="프로필사진 삭제">
					</div>
				</div>
			</div>
		</div>
	</form>
	
	</div> --%>

	<div class="tab-pane ng-scope active" style="">
		
			<fieldset class="myPagefiledset">
				<legend> 마이페이지 </legend>
				<div class="row">
					<div class="leftMyPage">
					<form id="form" class="ng-pristine ng-valid ng-scope ng-valid-email" role="form" action="memberModify" method="post">
						<div class="form-group">
						<input type="hidden" name="m_id" value="${member.m_id }">
							<label class="control-label"> 이 름 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_name" value="${member.m_name }">
						</div>
						<div class="form-group">
							<label class="control-label"> 이메일 </label> <label>${member.m_email }</label>
								<input class="form-control ng-pristine ng-untouched ng-valid ng-valid-email"
								type="hidden" name="m_email" value="${member.m_email }">
						</div>
						<div class="form-group">
							<label class="control-label"> 현재 비밀번호 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="password" name="m_pwd">
						</div>
						<div class="form-group">
							<label class="control-label"> 변경할 비밀번호 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="password" name="m_pwdCheck">
						</div>
					
						<div class="form-group">
							<label class="control-label"> 핸드폰 번호 </label> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_phone" value="${member.m_phone }">
						</div>
						<div class="form-group">
							<label class="control-label">질문</label><br> <select
								name="m_question">
								<option value="1">고향은?</option>
								<option value="2">이름은?</option>
								<option value="3">주소는?</option>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">답변</label><Br> <input
								class="form-control ng-pristine ng-untouched ng-valid"
								type="text" name="m_answer" value="${ member.m_answer}">
						</div>
						<input class="MyPageButton" type="submit" value="마이페이지 수정">
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
									<form action="proImg" method="POST"	enctype="multipart/form-data">
										<input type="file" id="image" name="file"><br> <input
											class="thumbnailMyPageUpdate" type="submit" value="수정">
										<input class="thumbnailMyPageDelete" type="button" value="삭제">
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- right div 끝 -->

				</div>
				
			</fieldset>
	
	</div>
	<script src="/resources/js/jquery.min.js"></script>
	<script src="/resources/js/jquery.scrolly.min.js"></script>
	<script src="/resources/js/imageUpload.js"></script>
</body>
</html>