<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.member.model.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>訂單管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/memberorders/css/homepage.css">
    
    <!-- 判斷有無登入且是否為管理員 -->
    <c:set var="memVO" value="${sessionScope.mem}" />
    <c:if test="${memVO.memberStatus != 1}">
        <script type="text/javascript">
            alert('請先登入');
            location.href="/CIA103g6/front-end/login.jsp";
        </script>
    </c:if>

    <style>
        /* 訂單管理特定樣式 */
        .tabs {
            margin: 10px 0;
            text-align: left;
        }
        .tabs button {
            padding: 8px 16px;
            margin-right: 5px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        .tabs button.active {
            background-color: #0056b3;
        }
        .order-section {
            background: white;
            padding: 15px;
            margin: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        table.main {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        table.main th, table.main td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }
        table.main th {
            background-color: #f5f5f5;
        }
        .order-status {
            padding: 5px;
            border-radius: 3px;
        }
    </style>
</head>
<body>
<%-- <jsp:include page="/back-end/homepage/homepage.jsp"/> --%>
   
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
						<form method="post"
							action="${pageContext.request.contextPath}/orders/orders.do">
							<button type="submit" class="sub_btn_func">訂單管理</button>
							<input type="hidden" name="action" value="getOrderSummary">
						</form>
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
                        <form method="post" action="${pageContext.request.contextPath}/OrderServlet">
        		            <button type="submit" class="sub_btn_func" id="studioOrder_mgnt">租借訂單管理</button>
							<input type="hidden" name="page" value="1">
	                        <input type="hidden" name="action" value="get_all_orders">
	                        <input type="hidden" name="toRent" value="toRent">
                    	</form>
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
                        <button class="sub_btn_func"><a href="${pageContext.request.contextPath}/back-end/matchingcases/select_page.jsp" class="sub_btn_name">案件管理</a></button>
                    </li>
                </ul>
            </div>
        </ul>
        <!-- 登出 -->
        <form method="post" action="${pageContext.request.contextPath}/back-end/logout">
            <button type="submit" id="log_out">登出</button>
        </form>
    </nav>

    <!-- 主要內容區域 -->
    <div class="container">
        <h2><i class="fa-solid fa-house"></i> 訂單管理</h2>
        
        <!-- 訂單狀態切換按鈕 -->
        <div class="tabs">
            <button class="${empty currentStatus || currentStatus eq 'all' ? 'active' : ''}" 
                onclick="location.href='${pageContext.request.contextPath}/orders/orders.do?action=getOrderSummary&status=all'">
                全部訂單
            </button>
            <button class="${currentStatus eq '1' ? 'active' : ''}" 
                onclick="location.href='${pageContext.request.contextPath}/orders/orders.do?action=getOrderSummary&status=1'">
                待確認訂單
            </button>
            <button class="${currentStatus eq '2' ? 'active' : ''}" 
                onclick="location.href='${pageContext.request.contextPath}/orders/orders.do?action=getOrderSummary&status=2'">
                已出貨訂單
            </button>
        </div>

        <!-- 訂單列表 -->
        <c:forEach var="order" items="${orderSummaryList}">
            <div class="order-section">
                <h5>訂單編號: ${order.ordersId}</h5>
                <p>
                    收件人: ${order.memName} | 聯絡電話: ${order.memTel} | 收件地址: ${order.ordersAdd} |
                    備註: ${order.ordersMemo}
                </p>
                <table class="main">
                    <thead>
                        <tr>
                            <th>會員編號</th>
                            <th>會員姓名</th>
                            <th>訂單日期</th>
                            <th>商品名稱</th>
                            <th>單價</th>
                            <th>數量</th>
                            <th>小計</th>
                            <th>總金額</th>
                            <th>狀態</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detail" items="${order.orderDetails}" varStatus="status">
                            <tr>
                                <td>${order.memId}</td>
                                <td>${order.memName}</td>
                                <td><fmt:formatDate value="${order.ordersDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <td>${detail.prodName}</td>
                                <td>$${detail.ordersUnitPrice}</td>
                                <td>${detail.ordersQty}</td>
                                <td>$${detail.subtotal}</td>
                                <c:if test="${status.index == 0}">
                                    <td rowspan="${fn:length(order.orderDetails)}">$${order.ordersPaid}</td>
                                    <td rowspan="${fn:length(order.orderDetails)}">
                                        <select class="order-status" data-order-id="${order.ordersId}">
                                            <option value="1" ${order.ordersStatus == 1 ? 'selected' : ''}>待確認</option>
                                            <option value="2" ${order.ordersStatus == 2 ? 'selected' : ''}>已出貨</option>
                                        </select>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:forEach>
    </div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/back-end/homepage/vendor/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/155106be6f.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/back-end/homepage/js/homepage.js"></script>
    
    <!-- 訂單狀態更新的 JavaScript -->
    <script>
        $(document).ready(function() {
            $('.order-status').change(function() {
                const orderId = $(this).data('order-id');
                const newStatus = $(this).val();

                $.ajax({
                    url: '${pageContext.request.contextPath}/orders/orders.do',
                    method: 'POST',
                    data: {
                        action: 'updateStatus',
                        orderId: orderId,
                        status: newStatus
                    },
                    success: function(response) {
                        alert('訂單狀態更新成功');
                        window.location.href = '${pageContext.request.contextPath}/orders/orders.do?action=getOrderSummary&status=' + newStatus;
                    },
                    error: function() {
                        alert('訂單狀態更新失敗');
                    }
                });
            });
        });
    </script>
</body>
</html>