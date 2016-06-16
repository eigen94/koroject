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
<h1 style="font-size: 100%;">
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
<a href="/projectBoard/${p_id }/progress">
진행상황
</a>
</li>
<li>
<a href="/projectBoard/${p_id }/checklist">
체크리스트
</a>
</li>
<li>
<a href="/projectBoard/${p_id }/essence">
에센스
</a>
</li>
<li>
<a href="/projectBoard/${p_id }/integration">
통합
</a>
</li>

<li>
<a href="/index">공지사항</a>
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
    <p class="settingP" id="settingMessenger"><a class="settingA">메신저</a></p>
    <span class="entypo-chat settingSpan"></span>
  </li>
  <li class="linka">
    <p class="settingP" id="settingLogOut"><a class="settingA" href="logout">로그아웃</a></p>
    <span class="entypo-logout settingSpan"></span>
  </li>
</ul>               
    
</c:if>

<a href="#menu">Menu</a>
</header>    


<!-- this is loginForm js -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/js/jquery.scrolly.min.js"></script>
<script src="/resources/js/skel.min.js"></script>
<script src="/resources/js/util.js"></script>
<script src="/resources/js/front.js"></script>
<script src="/resources/js/index.js"></script>
<script src="/resources/js/loginForm.js"></script>
	