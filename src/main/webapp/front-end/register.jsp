<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">



<head>
<title>注冊頁面</title>
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
	<link href="loginfile/css/stylereg.css" rel="stylesheet" type="text/css" media="all" />
	<link href="loginfile/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all" />
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
				<span class="fa fa-eercast">注冊</span>
			</div>
			
			<div class="header-left-bottom">
				
				<form id="regForm" method="post" action="register" onsubmit="return checkForm(this);">
				
		<div class="form-container">				
			
			<div class="form-column">							
					<div class="icon1">
						<font>賬號：</font>
						<input class="text" type="text" name="userName" onblur="CheckItem(this); check(this.value);" onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')" required />						
						<div id="sp"></div>
					</div>
										
					<div class="icon1">
						密碼:
						<input class="text" type="password" id="passWord" name="passWord" onblur="CheckItem(this);" onfocus="FocusItem(this)" required /><span></span>
					</div>
															
					<div class="icon1">
						確認密碼:
						<input class="text" type="password" name="rePassWord" onblur="CheckItem(this);"  onfocus="FocusItem(this)"  required /><span></span>
					</div>
										
					<div class="icon1">
						姓名：	
						<input type="text" class="text" name="name" required/>
					</div>
					
					<div class="icon1">
						身份證字號：
						<input type="text" class="text" name="uId" required/>
					</div>
									
					<div class="icon1">	
						驗證碼：
						<input class="text verycode" type="text" name="veryCode" onfocus="FocusItem(this)" onblur="Checknum(this);" required/>
						<span id="msg"></span>
					</div>
									
			</div>
	
	
			<div class="form-column">			
					<div class="icon1">
						性別：
						<div id="sex_block">
							<input type="radio" name="sex" value=1  checked/>男
							<input type="radio" name="sex" value=2 />女
						</div>
					</div>
					
					<div class="icon1">
						生日：
						<input type="date" name="birthday" required/>
					</div>
					
					<div class="icon1">
						電子郵件：
						<input type="text" class="text" name="email" value="" required/>
					</div>
									
					<div class="icon1">
						手機電話：
						<input type="text" class="text" name="mobile" value="" required/>
					</div>
									
					<div class="icon1">				
						地址：
						<input type="text" class="text" name="address" value="" required/>
					</div>
					
					<img id="veryCode" alt="看不清,换一张" style="cursor:pointer;" src="usernum?<%=new Date().getTime() %>" onclick="change(this)" />
					<span onclick="change(veryCode)">
        				<font style="color: white; font-weight: bold; margin-bottom: 10px; cursor: pointer; font-size: 20px">換一張</font>
    				</span>		
			</div>					
	</div>					
																													
					<div class="bottom">
						<button name="submit" id="sub" class="btn">注冊</button>
					</div>
					
					
					<div class="links">
						<p><a href="#">Forgot Password?</a></p>
						<p class="right"><a href="#">New User? Register</a></p>
						<div class="clear"></div>																	
					</div>
					
				</form>	
			</div>
			
		</div>
			
			
		<!-- copyright -->
		<div class="copyright">
			<p>© 2019 Slide Login Form . All rights reserved |你好 <a target="_blank" href="http://www.mobanwang.com/" title="网页模板"></a></p>
		</div>
		<!-- //copyright --> 
	</div>
	

</div>	
<!-- //main -->

</body>
</html>