<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 
<%@ page import="com.member.model.*"%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>後台首頁</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/homepage/css/homepage.css">  
  <!-- 判斷有無登入且是否為管理員 -->
<c:set var="memVO" value="${sessionScope.mem}" />

<c:if test="${memVO.memberStatus != 1}">
<script type="text/javascript">
	alert('請先登入');
	location.href="/CIA103g6/front-end/login.jsp";

</script>
</c:if>
<!--  -->
</head>
<body>
    <!-- 漢堡 -->
    <div class="shadow"></div>
    <div class="top_side">
        <div class="hamburger active">
            <div class="bar top"></div>
            <div class="bar middle"></div>
            <div class="bar bottom"></div>
        </div>
        <!-- 大頭貼 -->
        <div class="head_shot">
            <a href="#"><img src="${pageContext.request.contextPath}/back-end/homepage/user/user.png" alt="沒有圖片"></a>
        </div>
        <!-- 首頁 -->
        <div class="project_name">
            <a href="${pageContext.request.contextPath}/back-end/homepage/homepage.jsp">Voice Bus</a>
        </div>
    </div>
    <nav class="right_slide">
        <ul class="func_name">
            <!-- 員工帳號管理 -->
            <li class="main_item emp">
                <button class="btn_func" id="emp_btn">
                    <i class="fa-solid fa-user"></i><span class="btn_name">員工管理</span>
                </button>
            </li>
            <div class="emp_btn_block">
                <ul class="sub_func_name">
                    <li class="emp_sub_item">
                        <button class="sub_btn_func"><a href="./employee_mgmt.html" class="sub_btn_name">員工帳號管理</a ></button>
                    </li>
                    <li class="emp_sub_item">
                        <button class="sub_btn_func"><a href="./permission_mgmt.html" class="sub_btn_name">員工權限管理</a ></button>
                    </li>
                </ul>
            </div>
            <!-- 會員帳號管理 -->
            <li class="main_item member">
                <button class="btn_func" id="member_btn">
                    <i class="fa-solid fa-users"></i><span class="btn_name">會員管理</span>
                </button>
            </li>
            <div class="member_btn_block">
                <ul class="sub_func_name">
                    <li class="member_sub_item">
                        <button class="sub_btn_func"><a href="${pageContext.request.contextPath}/back-end/membermanage/select_page.jsp" class="sub_btn_name">會員帳號管理</a></button>
                    </li>
                </ul>
            </div>
            <!-- 網頁管理 -->
            <li class="main_item web">
                <button class="btn_func" id="web_btn">
                    <i class="fa-regular fa-window-restore"></i><span class="btn_name">網頁管理</span>
                </button>
            </li>
            <div class="web_btn_block">
                <ul class="sub_func_name">
                    <li class="web_sub_item">
                        <button class="sub_btn_func"><a href="${pageContext.request.contextPath}/back-end/advertisement/select_page.jsp" class="sub_btn_name">廣告資訊管理</a></button>
                    </li>
                    <li class="web_sub_item">
                        <button class="sub_btn_func"><a href="./notification.mgmt.html"class="sub_btn_name">通知公告管理</a></button>
                    </li>
                    <li class="web_sub_item">
                        <form method="post" action="${pageContext.request.contextPath}/CustomerServiceServlet">
	                        <button type="submit" class="sub_btn_func">客服Q&A</button>
	                        <input type="hidden" name="action" value="get_all_case">
                    	</form>
                    </li>
                </ul>
            </div>
            <!-- 商城管理 -->
            <li class="main_item shop">
                <button class="btn_func" id="shop_btn">
                    <i class="fa-brands fa-shopify"></i><span class="btn_name">商城管理</span>
                </button>
            </li>
            <div class="shop_btn_block">
                <ul class="sub_func_name">
                    <li class="shop_sub_item">
                        <button class="sub_btn_func"><a href="<%=request.getContextPath()%>/back-end/prodmanage/product_mgmt.jsp"  class="sub_btn_name">商品管理</a></button>
                    </li>
                    <li class="shop_sub_item">
                        <button class="sub_btn_func"><a href="${pageContext.request.contextPath}/back-end/memberorders/memberorders.jsp" class="sub_btn_name">訂單管理</a></button>
                    </li>
                    <li class="shop_sub_item">
                        <button class="sub_btn_func"><a href="./report_mgmt.html" class="sub_btn_name">評價檢舉管理</a></button>
                    </li>
                </ul>
            </div>
            <!-- 租借管理 -->
            <li class="main_item rent">
                <button class="btn_func" id="rent_btn">
                    <i class="fa-solid fa-microphone-lines"></i><span class="btn_name">租借管理</span>
                </button>
            </li>
            <div class="rent_btn_block">
                <ul class="sub_func_name">
                    <li class="rent_sub_item">
                        <button class="sub_btn_func"><a href="./rental_record_mgmt.html" class="sub_btn_name">租借記錄管理</a></button>
                    </li>
                    <li class="rent_sub_item">
                    	<form method="post" action="${pageContext.request.contextPath}/MyStudioServlet">
        		            <button type="submit" class="sub_btn_func" id="studio_mgmt">場地管理</button>
							<input type="hidden" name="page" value="1">
	                        <input type="hidden" name="action" value="get_all">
                    	</form>
                    </li>
                </ul>
            </div>
            <!-- 媒合管理 -->
            <li class="main_item">
                <button class="btn_func" id="match_btn">
                    <i class="fa-brands fa-studiovinari"></i><span class="btn_name">媒合管理</span>
                </button>
            </li>
            <div class="match_btn_block">
                <ul class="sub_func_name">
                    <li class="match_sub_item">
                        <button class="sub_btn_func"><a href="${pageContext.request.contextPath}/back-end/complaint/select_page.jsp" class="sub_btn_name">申訴案件管理</a></button>
                    </li>
                    <li class="match_sub_item">
                        <button class="sub_btn_func"><a href="${pageContext.request.contextPath}/back-end/apply/select_page.jsp" class="sub_btn_name">案件管理</a></button>
                    </li>
                </ul>
            </div>
        </ul>
        <!-- 登出 -->
        <button type="button" id="log_out">登出</button>
    </nav>
    <!-- 現在位置 -->
    <div class="container">
        <h2><i class="fa-solid fa-house"></i>首頁</h2>     
        <hr>
        <h2><c:if test="${memVO!=null}">歡迎管理員:${memVO.memberName}</c:if></h2>
    </div>
    <script src="https://kit.fontawesome.com/155106be6f.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/back-end/homepage/vendor/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/back-end/homepage/js/homepage.js"></script>
	
</body>
</html>