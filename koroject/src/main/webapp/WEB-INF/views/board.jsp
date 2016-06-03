<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a class="sidebar-mobile-toggler pull-left hidden-md hidden-lg" ng-click="toggle('sidebar')" href="#">
<i class="ti-align-justify"></i>
</a>
<a class="navbar-brand" ui-sref="app.dashboard" href="#/app/dashboard">
<img alt="Clip-Two" ng-src="assets/images/logo.png" src="assets/images/logo.png">
</a>
<a class="sidebar-toggler pull-right visible-md visible-lg" ng-click="app.layout.isSidebarClosed = !app.layout.isSidebarClosed" href="#">
<i class="ti-align-justify"></i>
</a>
<a id="menu-toggler" class="pull-right menu-toggler visible-xs-block" ng-click="navbarCollapsed = !navbarCollapsed">
<span class="sr-only">Toggle navigation</span>
<i class="ti-view-grid"></i>
</a>
</div>

<div id="app" class="ng-scope app-navbar-fixed app-sidebar-fixed" ng-class="{'app-mobile' : app.isMobile, 'app-navbar-fixed' : app.layout.isNavbarFixed, 'app-sidebar-fixed' : app.layout.isSidebarFixed, 'app-sidebar-closed':app.layout.isSidebarClosed, 'app-footer-fixed':app.layout.isFooterFixed}" ui-view="" style="">
<div id="toast-container" class="ng-scope toast-top-right" ng-class="[config.position, config.animation]" toaster-options="{'position-class': 'toast-top-right', 'close-button':true}"></div>
<div id="sidebar" class="sidebar app-aside hidden-print ng-scope" parent-active-class="app-slide-off" toggleable="">
<div class="sidebar-container ps-container ps-active-y" suppress-scroll-x="true" wheel-propagation="false" perfect-scrollbar="" data-ps-id="fe14d788-2c65-f827-6d24-4879d68474f1">
<div ng-transclude="">
<div class="ng-scope" data-ng-include=" 'assets/views/partials/sidebar.html' " style="">
<nav class="ng-scope" data-ng-include=" 'assets/views/partials/nav.html' " style="">
<div class="search-form ng-scope">
<a class="s-open" href="#">
<i class="ti-search"></i>
</a>
<form class="navbar-form ng-pristine ng-valid" role="search">
<a class="s-remove" target=".navbar-form" ng-toggle-class="search-open" href="#">
<i class="ti-close"></i>
</a>
<div class="form-group">
<input class="form-control" type="text" placeholder="Search...">
<button class="btn search-button" type="submit">
<i class="ti-search"></i>
</button>
</div>
</form>
</div>
<div class="navbar-title ng-scope">
<span class="ng-scope" translate="sidebar.heading.NAVIGATION">Main Navigation</span>
</div>
<ul class="main-navigation-menu ng-scope">
<li class="active" ui-sref-active="active">
<a ui-sref="app.dashboard" href="#/app/dashboard">
<div class="item-content">
<div class="item-media">
<i class="ti-home"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.dashboard.MAIN">Dashboard</span>
</div>
</div>
</a>
</li>
<li ng-class="{'active open':$state.includes('app.ui')}">
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-settings"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.element.MAIN">UI Elements</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu">
<li ui-sref-active="active">
<a ui-sref="app.ui.elements" href="#/app/ui/elements">
<span class="title ng-scope" translate="sidebar.nav.element.ELEMENTS">Elements</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.buttons" href="#/app/ui/buttons">
<span class="title ng-scope" translate="sidebar.nav.element.BUTTONS">Buttons</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.links" href="#/app/ui/links">
<span class="title ng-scope" translate="sidebar.nav.element.LINKS">Link Effects</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.icons" href="#/app/ui/icons">
<span class="title ng-scope" translate="sidebar.nav.element.FONTAWESOME">Font Awesome Icons</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.lineicons" href="#/app/ui/line-icons">
<span class="title ng-scope" translate="sidebar.nav.element.LINEARICONS">Linear Icons</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.modals" href="#/app/ui/modals">
<span class="title ng-scope" translate="sidebar.nav.element.MODALS">Modals</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.toggle" href="#/app/ui/toggle">
<span class="title ng-scope" translate="sidebar.nav.element.TOGGLE">Toggle</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.tabs_accordions" href="#/app/ui/accordions">
<span class="title ng-scope" translate="sidebar.nav.element.TABS">Tabs & Accordions</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.panels" href="#/app/ui/panels">
<span class="title ng-scope" translate="sidebar.nav.element.PANELS">Panels</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.notifications" href="#/app/ui/notifications">
<span class="title ng-scope" translate="sidebar.nav.element.NOTIFICATIONS">Notifications</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.treeview" href="#/app/ui/treeview">
<span class="title ng-scope" translate="sidebar.nav.element.TREEVIEW">TreeView</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.media" href="#/app/ui/media">
<span class="title ng-scope" translate="sidebar.nav.element.MEDIA">Media</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.nestable" href="#/app/ui/nestable2">
<span class="title ng-scope" translate="sidebar.nav.element.NESTABLE">Nestable List</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.ui.typography" href="#/app/ui/typography">
<span class="title ng-scope" translate="sidebar.nav.element.TYPOGRAPHY">Typography</span>
</a>
</li>
</ul>
</li>
<li ng-class="{'active open':$state.includes('app.table')}">
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-layout-grid2"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.tables.MAIN">Tables</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu">
<li ui-sref-active="active">
<a ui-sref="app.table.basic" href="#/app/table/basic">
<span class="title ng-scope" translate="sidebar.nav.tables.BASIC">Basic Tables</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.table.responsive" href="#/app/table/responsive">
<span class="title ng-scope" translate="sidebar.nav.tables.RESPONSIVE">Responsive Tables</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.table.dynamic" href="#/app/table/dynamic">
<span class="title ng-scope" translate="sidebar.nav.tables.DYNAMIC">Dynamic Tables</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.table.data" href="#/app/table/data">
<span class="title ng-scope" translate="sidebar.nav.tables.DATA">ngTable</span>
</a>
</li>
</ul>
</li>
<li ng-class="{'active open':$state.includes('app.form')}">
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-pencil-alt"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.forms.MAIN">Forms</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu">
<li ui-sref-active="active">
<a ui-sref="app.form.elements" href="#/app/form/elements">
<span class="title ng-scope" translate="sidebar.nav.forms.ELEMENTS">Form Elements</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.form.xeditable" href="#/app/form/xeditable">
<span class="title ng-scope" translate="sidebar.nav.forms.XEDITABLE">X-Editable Elements</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.form.texteditor" href="#/app/form/editor">
<span class="title ng-scope" translate="sidebar.nav.forms.TEXTEDITOR">Text Editor</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.form.wizard" href="#/app/form/wizard">
<span class="title ng-scope" translate="sidebar.nav.forms.WIZARD">Form Wizard</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.form.validation" href="#/app/form/validation">
<span class="title ng-scope" translate="sidebar.nav.forms.VALIDATION">Form Validation</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.form.cropping" href="#/app/form/image-cropping">
<span class="title ng-scope" translate="sidebar.nav.forms.CROPPING">Image Cropping</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.form.upload" href="#/app/form/file-upload">
<span class="title ng-scope" translate="sidebar.nav.forms.UPLOAD">Multiple File Upload</span>
</a>
</li>
</ul>
</li>
<li ng-class="{'active open':$state.includes('login')}">
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-user"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.login.MAIN">Login</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu">
<li ui-sref-active="active">
<a ui-sref="login.signin" href="#/login/signin">
<span class="title ng-scope" translate="sidebar.nav.login.LOGIN">Login Form</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="login.registration" href="#/login/registration">
<span class="title ng-scope" translate="sidebar.nav.login.REGISTRATION">Registration Form</span>
</a>
</li>
<li ui-sref-active="active">
<a class="ng-scope" translate="sidebar.nav.login.FORGOT" ui-sref="login.forgot" href="#/login/forgot">Forgot Password Form</a>
</li>
<li ui-sref-active="active">
<a class="ng-scope" translate="sidebar.nav.login.LOCKSCREEN" ui-sref="login.lockscreen" href="#/login/lock">Lock Screen</a>
</li>
</ul>
</li>
<li ng-class="{'active open':$state.includes('app.pages')}">
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-layers-alt"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.pages.MAIN">Pages</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu">
<li ui-sref-active="active">
<a ui-sref="app.pages.user" href="#/app/pages/user">
<span class="title ng-scope" translate="sidebar.nav.pages.USERPROFILE">User Profile</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.pages.invoice" href="#/app/pages/invoice">
<span class="title ng-scope" translate="sidebar.nav.pages.INVOICE">Invoice</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.pages.timeline" href="#/app/pages/timeline">
<span class="title ng-scope" translate="sidebar.nav.pages.TIMELINE">Timeline</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.pages.calendar" href="#/app/pages/calendar">
<span class="title ng-scope" translate="sidebar.nav.pages.CALENDAR">Calendar</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.pages.messages" href="#/app/pages/messages">
<span class="title ng-scope" translate="sidebar.nav.pages.MESSAGES">Messages</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.pages.blank" href="#/app/pages/blank">
<span class="title ng-scope" translate="sidebar.nav.pages.BLANKPAGE">Starter Page</span>
</a>
</li>
</ul>
</li>
<li class="open" ng-class="{'active open':$state.includes('app.utilities')}">
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-package"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.utilities.MAIN">Utilities</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu" style="display: block;">
<li ui-sref-active="active">
<a ui-sref="app.utilities.search" href="#/app/utilities/search">
<span class="title ng-scope" translate="sidebar.nav.utilities.SEARCHRESULT">Search Results</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="error.404" href="#/error/404">
<span class="title ng-scope" translate="sidebar.nav.utilities.ERROR404">Error 404</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="error.500" href="#/error/500">
<span class="title ng-scope" translate="sidebar.nav.utilities.ERROR500">Error 500</span>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.utilities.pricing" href="#/app/utilities/pricing">
<span class="title ng-scope" translate="sidebar.nav.utilities.PRICING">Pricing Table</span>
</a>
</li>
</ul>
</li>
<li>
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-folder"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.3level.MAIN">3 Level Menu</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu">
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.3level.Item1.MAIN">Item 1</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item1.LINK1" href="#">Sample Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item1.LINK2" href="#">Sample Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item1.LINK3" href="#">Sample Link 3</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.3level.Item2.MAIN">Item 2</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item2.LINK1" href="#">Sample Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item2.LINK1" href="#">Sample Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item2.LINK1" href="#">Sample Link 1</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.3level.Item3.MAIN">Item 3</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item3.LINK1" href="#">Sample Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item3.LINK1" href="#">Sample Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.3level.Item3.LINK1" href="#">Sample Link 1</a>
</li>
</ul>
</li>
</ul>
</li>
<li>
<a href="javascript:void(0)">
<div class="item-content">
<div class="item-media">
<i class="ti-menu-alt"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.4level.MAIN">4 Level Menu</span>
<i class="icon-arrow"></i>
</div>
</div>
</a>
<ul class="sub-menu">
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item1.MAIN">Item 1</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item1.link1.MAIN">Sample Link 1</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link1.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link1.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link1.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item1.link2.MAIN">Sample Link 2</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link2.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link2.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link2.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item1.link3.MAIN">Sample Link 3</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link3.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link3.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item1.link3.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item2.MAIN">Item 2</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item2.link1.MAIN">Sample Link 1</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link1.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link1.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link1.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item2.link2.MAIN">Sample Link 2</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link2.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link2.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link2.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item2.link3.MAIN">Sample Link 3</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link3.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link3.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item2.link3.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item3.MAIN">Item 3</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item3.link1.MAIN">Sample Link 1</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link1.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link1.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link1.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item3.link2.MAIN">Sample Link 2</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link2.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link2.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link2.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
<li>
<a href="javascript:;">
<span class="ng-scope" translate="sidebar.nav.4level.Item3.link3.MAIN">Sample Link 3</span>
<i class="icon-arrow"></i>
</a>
<ul class="sub-menu">
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link3.LINK1" href="#">Link 1</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link3.LINK2" href="#">Link 2</a>
</li>
<li>
<a class="ng-scope" translate="sidebar.nav.4level.Item3.link3.LINK3" href="#">Link 3</a>
</li>
</ul>
</li>
</ul>
</li>
</ul>
</li>
<li ui-sref-active="active">
<a ui-sref="app.maps" href="#/app/maps">
<div class="item-content">
<div class="item-media">
<i class="ti-location-pin"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.maps.MAIN">Maps</span>
</div>
</div>
</a>
</li>
<li ui-sref-active="active">
<a ui-sref="app.charts" href="#/app/charts">
<div class="item-content">
<div class="item-media">
<i class="ti-pie-chart"></i>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.charts.MAIN">Charts</span>
</div>
</div>
</a>
</li>
</ul>
<div class="navbar-title ng-scope">
<span class="ng-scope" translate="sidebar.heading.FEATURES">Core Features</span>
</div>
<ul class="folders ng-scope">
<li>
<a ui-sref="app.pages.calendar" href="#/app/pages/calendar">
<div class="item-content">
<div class="item-media">
<span class="fa-stack">
<i class="fa fa-square fa-stack-2x"></i>
<i class="fa fa-terminal fa-stack-1x fa-inverse"></i>
</span>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.pages.CALENDAR">Calendar</span>
</div>
</div>
</a>
</li>
<li>
<a ui-sref="app.pages.messages" href="#/app/pages/messages">
<div class="item-content">
<div class="item-media">
<span class="fa-stack">
<i class="fa fa-square fa-stack-2x"></i>
<i class="fa fa-folder-open-o fa-stack-1x fa-inverse"></i>
</span>
</div>
<div class="item-inner">
<span class="title ng-scope" translate="sidebar.nav.pages.MESSAGES">Messages</span>
</div>
</div>
</a>
</li>
</ul>
<div class="wrapper ng-scope">
<a class="button-o" ui-sref="app.documentation" href="#/app/documentation">
<i class="ti-help"></i>
<span class="ng-scope" translate="sidebar.heading.DOCUMENTATION">Documentation</span>
</a>
</div>
</nav>
</div>
</div>
<div class="ps-scrollbar-x-rail" style="left: 0px; bottom: -618px; display: block;">
<div class="ps-scrollbar-x" style="left: 0px; width: 0px;"></div>
</div>
<div class="ps-scrollbar-y-rail" style="top: 621px; right: 3px; display: block; height: 266px;">
<div class="ps-scrollbar-y" style="top: 187px; height: 79px;"></div>
</div>
</div>
</div>


</body>
</html>