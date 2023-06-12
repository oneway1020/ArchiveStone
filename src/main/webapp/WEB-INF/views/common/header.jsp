<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

   <!-- datepick 사용하기 위해 추가 -->
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
   <!-- end -->
	
	<!-- icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/52943f354a.js" crossorigin="anonymous"></script>



<style>
	header {
		min-width: 600px;
	}
	.tool_a i {
		color: black;
	}
	.tool_a:hover {
		cursor: pointer; 
	}

	
	#logo {
		display: inline-block;
	}
	#logo img {
		width: 285;
		height: 64;
	}
	#search {
		display: inline-block;
		padding: 30px 0px;
	}
	#searchGall {
	    border-left-width: 0;
	    border-right-width: 0;
	    border-top-width: 0;
	    border-bottom-width: 3;
	    border-color: black;
	}
	.tool_a {
		margin-right: 5px;
	}
	#category{
		width: 100%;
	    display: flex;
   		justify-content: space-between;
   		margin: 0px;
   		padding: 0px;
   		color: black;
   		list-style: none;
	}
	#category > li {
		text-align: center;
   		font-size: 1.5em;
	}
	
	#category li a, #category li a:hover, #category li a:link, #category li a:active, #category li a:visited {
		color: black;
		text-decoration: none;
	}
	
	#category > li > a {
		display: block;
		padding: 0px 15px;
	}
	.drop {
		position: relative;
	}
	.drop-menu {
		display: none;
		position: absolute;
		left: -40px;
		background-color: #F9F9F9;
		min-width: 160px;
		padding: 0px;
		box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		margin-top: 2px;
		list-style: none;
		z-index: 1; /*다른 요소들보다 앞에 배치*/
	}
	.drop-menu a{
		display: block;
		padding: 5px;
	}
	.drop:hover .drop-menu { display: block; }
	
	#searchGall:focus {
		outline:none;
	}
</style>

<header class="container">
	<div style="padding: 50px 0px; text-align: center;">
		<div id="logo">
			<a href="/" title="logo">
				<img src="/resources/images/ArchiveStone.png"/>
			</a>
		</div>
		<div id="search">
			<!-- 해당 내용으로 검색 -->
			<form id="searchForm">
				<input id="searchGall" name="searchGall" size="35" maxlength="35" onkeypress="fnEnterkey();"/>
				<a class="tool_a" onclick="searchgall();">
					<i id="searchIcon" class="bi bi-search fs-5"></i>
				</a>
			</form>
		</div>
	</div>
	<nav style="padding: 10px 0; border: 3px solid rgba(220, 220, 220, 1); border-left: none; border-right: none">
		<div class="container">
			<div class="row">
				<ul id="category">
					<li>
						<a href="/board/lists">게시판</a>
					</li>
					<li class="drop">
						<a href="/product/남성">남성</a>
						<ul class="drop-menu">
							<li>
								<a class="dropdown-item" href="/product/남성?detail=outer">아우터</a>
							</li>
							<li>
								<a class="dropdown-item" href="/product/남성?detail=top">상의</a>
							</li>
							<li>
								<a class="dropdown-item" href="/product/남성?detail=bottom">바지</a>
							</li>		
						</ul>
					</li>
					<li>
						<a href="/product/myInfo">내정보</a>
					</li>
					<li>
						<a href="/board/Q&A">Q&A</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</header>
<div class="clear"></div>

<script src="/resources/js/searchgall.js"></script>