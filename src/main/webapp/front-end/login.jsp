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
              
   .nav-links {
    display: flex; /* 使用 Flexbox */
    justify-content: center; /* 對齊至右邊 */
    gap: 20px; /* 設定各項之間的間隔 */
    padding: 10px; /* 預留內邊距 */
  }

  .nav-links a {
    color: white; /* 設定字體顏色 */
    font-size: 23px; /* 字體大小 */
    text-decoration: none; /* 移除底線 */
    transition: color 0.3s; /* 顏色變化效果 */
  }

  .nav-links a:hover {
    color: lightgray; /* 滑鼠懸停時顏色變淺 */
  }
          
    </style>
</head>

<body>
<!-- main -->

<div class="w3layouts-main"> 
	<div class="bg-layer">
	
	

	<div class="nav-links">
  		<a href="${pageContext.request.contextPath}/index.jsp">首頁</a>
  		<a href="${pageContext.request.contextPath}/front-end/jsp/about.jsp">關於我</a>
  		<a href="#">商城</a>
  		<a href="#">錄音室</a>
  		<a href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp">配音員列表</a>
  		<a href="${pageContext.request.contextPath}/front-end/login.jsp">登入</a>
  		<a href="${pageContext.request.contextPath}/front-end/register.jsp">注冊</a>
  		<a href="${pageContext.request.contextPath}/front-end/jsp/Customer-Service.jsp">客服中心</a>
	</div>
	
			
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