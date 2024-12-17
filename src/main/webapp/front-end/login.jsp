<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>登入頁面</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords" content="Slide Login Form template Responsive, Login form web template, Flat Pricing tables, Flat Drop downs Sign up Web Templates, Flat Web Templates, Login sign up Responsive web template, SmartPhone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />


<script type="text/javascript" src="loginfile/scripts/function.js"></script>
<script type="text/javascript">
function selectname(){
	  var name = document.getElementById("selectname").value;
	  location.href='selectProductList?name='+name;
}

addEventListener("load", function () {
    setTimeout(hideURLbar, 0);
}, false);

function hideURLbar() {
    window.scrollTo(0, 1);
}
</script>

	<!-- Custom Theme files -->
	<link href="loginfile/css/stylelog.css" rel="stylesheet" type="text/css" media="all" />
	<link href="loginfile/css/fontlog-awesome.min.css" rel="stylesheet" type="text/css" media="all" />
	<!-- //Custom Theme files -->

	<!-- web font -->
	<link href="https://fonts.googleapis.com/css?family=Hind:300,400,500,600,700" rel="stylesheet">
	<!-- //web font -->
	<style>
        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
<!-- main -->

<div class="w3layouts-main"> 
	<div class="bg-layer">
	
	
	
	
	<nav class="navbar navbar-expand-lg">
			<div class="container">
				<a class="navbar-brand me-lg-5 me-0"
					href="${pageContext.request.contextPath}/front-end/jsp//index.jsp">
					首頁
				</a>
				
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav ms-lg-auto">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/about.jsp"
							style="color: white; font-size: 18px;">關於我</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: #000000; font-size: 18px;">商城</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: #000000; font-size: 18px;">錄音室</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarLightDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"
							style="color: #000000; font-size: 18px;">配音員</a>
							<ul class="dropdown-menu dropdown-menu-light"
								aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp"
									style="color: #000000;">配音員列表</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarLightDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"
							style="color: white; font-size: 18px;">案件列表</a>
							<ul class="dropdown-menu dropdown-menu-light"
								aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}">發案</a>
								</li>
								<li><a class="dropdown-item" href="#"
									style="color: white;">接案</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: white; font-size: 18px;">會員登入</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/Customer-Service.jsp"
							style="color: white; font-size: 18px;">客服中心</a></li>
					</ul>
				</div>
			</div>
		</nav>
	
	
	
	
	
	
	
	
	
		<h1>VoiceBus-聲音巴士</h1>
		<div class="header-main">
			<div class="main-icon">
				<span class="fa fa-eercast">登入</span>
			</div>
			
			<div class="header-left-bottom">
				<form id="loginForm" method="post" action="login" onsubmit="return checkForm(this)">
														
					 <% 
            			String errorMessage = (String) request.getAttribute("eMessage"); 
            			if (errorMessage != null) { 
       				 %>
            			<div class="error-message"><%= errorMessage %></div>
        			 <% 
            			} 
        			 %>
					<!--驗證碼錯誤提示 -->
					<span id="msg"></span>													
					
					<div class="icon1">
						<span class="fa fa-user"></span> 
						<input class="text" type="text" name="userName" value="<%=request.getAttribute("user") == null ? "":request.getAttribute("user")%>" required  placeholder="賬號"/>
					</div>
					
					<div class="icon1">
						<span class="fa fa-lock"></span>
						<input type="password"  name="passWord" id="passWord" value="<%=request.getAttribute("pass") == null ? "":request.getAttribute("pass")%>" required placeholder="密碼"/>
					</div>
										
					<div class="icon1">
						<span class="fa fa-lock"></span>
						<input class="text verycode" type="text" name="veryCode" placeholder="驗證碼"  onblur="Checknum(this);" required/>						
					</div>
					
<%-- 					<img id="veryCode" alt="看不清，換一張" style="cursor:hand; display: block; margin: 0 auto;" src="usernum?<%=new Date().getTime() %>" onclick="change(this)" /> --%>
<!-- 					<span onclick="change(veryCode)" ><font style=' color: blue; font-weight: bold; margin-bottom: 10px; cursor: hand;'>換一張</font></span> -->
						
						<div style="text-align: center;">
						
   							 <img id="veryCode" alt="看不清，換一張" style="cursor: pointer; display: inline-block; outline: none; background: none;" src="usernum?<%=new Date().getTime() %>" onclick="change(this)" />
    						<span onclick="change(veryCode)">
        						<font style="color: white; font-weight: bold; margin-bottom: 10px; cursor: pointer;">換一張</font>
    						</span>
						</div>
						
						
					<div class="bottom">
						<button class="btn" name="submit" id="sub" >Login</button>
<!-- 						<label class="ui-green"><input type="submit" name="submit"id="sub" value="立即登录" /></label> -->
					</div>
					
					<div class="links">
						<p><a href="#">Forgot Password?</a></p>
						<p class="right"><a href="register.jsp">新用戶？ 注冊</a></p>
						<div class="clear"></div>
					</div>
					
				</form>	
			</div>
		</div>
	</div>
</div>	
<!-- //main -->

</body>
</html>