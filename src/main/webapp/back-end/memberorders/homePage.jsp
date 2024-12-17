<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>客服Q&A</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/back-end/memberorders/css/homepage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/back-end/memberorders/css/customer.css">
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
			<a href="#"><img
				src="${pageContext.request.contextPath}/back-end/images/韓國瑜.jpg"
				alt="沒有圖片"></a>
		</div>
		<!-- 首頁 -->
		<div class="project_name">
			<a href="homePage.jsp">Voice Bus</a>
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
						<button class="sub_btn_func">
							<a href="./employee_mgmt.html" class="sub_btn_name">員工帳號管理</a>
						</button>
					</li>
					<li class="emp_sub_item">
						<button class="sub_btn_func">
							<a href="./permission_mgmt.html" class="sub_btn_name">員工權限管理</a>
						</button>
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
						<button class="sub_btn_func">
							<a href="./member_mgmt.html" class="sub_btn_name">會員帳號管理</a>
						</button>
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
						<button class="sub_btn_func">
							<a href="./advertising_mgmt.html" class="sub_btn_name">廣告資訊管理</a>
						</button>
					</li>
					<li class="web_sub_item">
						<button class="sub_btn_func">
							<a href="./notification.mgmt.html" class="sub_btn_name">通知公告管理</a>
						</button>
					</li>
					<li class="web_sub_item">
						<form method="post"
							action="<%=request.getContextPath()%>/CustomerServiceServlet">
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
						<button class="sub_btn_func">
							<a href="./product_mgmt.html" class="sub_btn_name">商品管理</a>
						</button>
					</li>
					<li class="shop_sub_item">
						<form method="post"
							action="${pageContext.request.contextPath}/orders/orders.do">
							<button type="submit" class="sub_btn_func">訂單管理</button>
							<input type="hidden" name="action" value="getOrderSummary">
						</form>
					</li>
					<li class="shop_sub_item">
						<button class="sub_btn_func">
							<a href="./report_mgmt.html" class="sub_btn_name">評價檢舉管理</a>
						</button>
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
						<button class="sub_btn_func">
							<a href="./rental_record_mgmt.html" class="sub_btn_name">租借記錄管理</a>
						</button>
					</li>
					<li class="rent_sub_item">
						<form method="post"
							action="<%=request.getContextPath()%>/MyStudioServlet">
							<button type="submit" class="sub_btn_func" id="studio_mgmt">場地管理</button>
							<input type="hidden" name="page" value="1"> <input
								type="hidden" name="action" value="get_all">
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
						<button class="sub_btn_func">
							<a href="./complaint_case_mgmt.html" class="sub_btn_name">申訴案件管理</a>
						</button>
					</li>
					<li class="match_sub_item">
						<button class="sub_btn_func">
							<a href="./case_mgmt.html" class="sub_btn_name">案件管理</a>
						</button>
					</li>
				</ul>
			</div>
		</ul>
		<!-- 登出 -->
		<button type="button" id="log_out">登出</button>
	</nav>
	<!-- 現在位置 -->
	<div class="container">
		<h2>
			<i class="fa-solid fa-house"></i>訂單管理
		</h2>
		<hr>
		<!--         <div class="lookup"> -->
		<%-- 	        <form action="${pageContext.request.contextPath}/CustomerServiceServlet" method="post"> --%>
		<!-- 		        <input type="text" name="caseId" placeholder="請輸入案件編號" id="inputId"> -->
		<!-- 		        <button type="button" id="lookup_btn">搜尋</button> -->
		<!-- 		        <button type="button" id="no_reply">未回覆信件</button> -->
		<!-- 		        <button type="button" id="reply">已回覆信件</button> -->
		<!-- 		        <button type="button" id="get_all">查看所有信件</button> -->

		<%-- 		        <input type="hidden" id="last_state" value="${last_state}"> --%>
		<!-- 	        </form> -->
		<!-- 	        <select id="sort_type"> -->
		<!-- 	        	<option>請選擇排序方式</option> -->
		<!-- 	        	<option>遞增排序</option> -->
		<!-- 	        	<option>遞減排序</option> -->
		<!-- 	        </select> -->
		<!--         </div> -->
		<!--         <table class="main"> -->
		<!--         	<thead> -->
		<!--         		<tr> -->
		<!--         			<th>案件編號</th> -->
		<!--         			<th>會員編號</th> -->
		<!--         			<th>信件主旨</th> -->
		<!--         			<th>案件類型</th> -->
		<!--         			<th>問題類型</th> -->
		<!--         			<th>問題內容</th> -->
		<!--         			<th>回覆內容</th> -->
		<!--         			<th>案件狀態</th> -->
		<!--         			<th>更新時間</th> -->
		<!--         			<th>建立時間</th> -->
		<!--         			<th>查看</th> -->
		<!--         			<th>回覆</th> -->
		<!--         		</tr> -->
		<!--         	</thead> -->
		<!--         	<tbody> -->
		<%--         		<c:forEach var="userCase" items="${requestScope.resultList}"> --%>
		<!-- 	        		<tr> -->
		<%-- 	        			<td>${userCase.cusCnId}</td> --%>
		<%-- 	        			<td>${userCase.memId}</td> --%>
		<%-- 	        			<td>${userCase.subject}</td> --%>
		<%-- 	        			<td>${userCase.type}</td> --%>
		<%-- 	        			<td>${userCase.questionType}</td> --%>
		<%-- 	        			<td>${userCase.question}</td> --%>
		<%-- 	        			<td>${userCase.reply}</td> --%>
		<%-- 	        			<td><b>${userCase.state}</b></td> --%>
		<!-- 						<td> -->
		<%-- 							<fmt:parseDate value="${userCase.updatedAt}" var="fmtDate1" pattern="yyyy-MM-dd HH:mm:ss" /> --%>
		<%-- 							<fmt:formatDate value="${fmtDate1}" pattern="yyyy/MM/dd HH:mm:ss" /> --%>
		<!-- 						</td> -->
		<!-- 	        			<td> -->
		<%-- 						    <fmt:parseDate value="${userCase.createdAt}" var="fmtDate2" pattern="yyyy-MM-dd HH:mm:ss" /> --%>
		<%-- 							<fmt:formatDate value="${fmtDate2}" pattern="yyyy/MM/dd HH:mm:ss" /> --%>
		<!-- 	        			</td> -->
		<!-- 	        			<td><button type="submit" class="lookup_btn">查看</button></td> -->
		<!-- 	        			<td><button type="submit" class="reply_btn">回覆</button></td> -->
		<!-- 	        		</tr> -->
		<%-- 				</c:forEach> --%>
		<!--         	</tbody> -->
		<!--         </table> -->
		<%-- 		<%-- 回覆頁面 --%>
		<!-- 	    <div class="reply_view" > -->
		<%-- 	    	<form action="${pageContext.request.contextPath}/CustomerServiceServlet" method="post"> --%>
		<!-- 		    	<table> -->
		<!-- 		    		<tr> -->
		<!-- 		    			<td> -->
		<!-- 		    				<label for="caseId">案件編號</label> -->
		<!-- 		    				<input type="text" id="caseId" name="caseId" readonly="readonly"> -->
		<!-- 		   				</td> -->
		<!-- 		    		</tr> -->
		<!-- 		    		<tr> -->
		<!-- 						<td> -->
		<!-- 		    				<label for="memId">會員編號</label> -->
		<!-- 		    				<input type="text" id="memId" name="memId" readonly="readonly"> -->
		<!-- 		   				</td> -->
		<!-- 		    		</tr> -->
		<!-- 		    		<tr> -->
		<!-- 		    			<td> -->
		<!-- 			    			<label for="subject">信件主旨</label> -->
		<!-- 		    				<input type="text" id="subject" name="subject" readonly="readonly"> -->
		<!-- 	    				</td> -->
		<!-- 		    		</tr> -->
		<!-- 		    		<tr> -->
		<!-- 	 					<td> -->
		<!-- 			    			<label for="type">案件類型</label> -->
		<!-- 								<select id="typeInput" name="type"> -->
		<!-- 									<option value="案件媒合">案件媒合</option> -->
		<!-- 						        	<option value="場地租借">場地租借</option> -->
		<!-- 						        	<option value="購物商城">購物商城</option> -->
		<!-- 								</select> -->
		<!-- 	    				</td> -->
		<!-- 	    			</tr> -->
		<!-- 		    		<tr> -->
		<!-- 					   	<td> -->
		<!-- 			    			<label for="state">案件狀態</label> -->
		<!-- 		    				<input type="text" id="stateInput" name="state" list="state"> -->
		<!-- 	 						<datalist id="state"> -->
		<!-- 						        <option value="已回覆"> -->
		<!-- 						        <option value="未回覆"> -->
		<!-- 						    </datalist> -->
		<!-- 	    				</td> -->
		<!-- 		    		</tr> -->
		<!-- 		    		<tr> -->
		<!-- 		    			<td> -->
		<!-- 	    					<label for="replay">回覆內容</label> -->
		<!-- 	    					<textarea id="reply" rows="10" cols="20" name="reply"></textarea> -->
		<!-- 	    				</td> -->
		<!-- 		    		</tr> -->
		<!-- 		    	</table> -->
		<!-- 		    	<div class="btn_block"> -->
		<!-- 			    	<button type="submit" id="submit_btn">送出</button> -->
		<!-- 			    	<button type="reset" id="rest_btn">清空</button> -->
		<!-- 			    	<button type="button" id="close_btn">關閉</button> -->
		<!-- 		    	</div> -->
		<!-- 		    	<input type="hidden" name="action" value="update_cs_case"> -->
		<!-- 	    	</form> -->
		<!-- 	    </div> -->
		<%-- 	    查看頁面 --%>
		<!-- 	    <div class="see_view"> -->
		<!-- 	    	<table> -->
		<!--  		    	<tr> -->
		<!-- 	    			<td>案件編號 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!--  		 		<tr> -->
		<!-- 	    			<td>會員編號 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 	    		<tr> -->
		<!-- 	    			<td>信件主旨 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 	    		 <tr> -->
		<!-- 	    			<td>案件類型 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 	    		<tr> -->
		<!-- 	    			<td>問題類型 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 	    		<tr> -->
		<!-- 	    			<td>問題內容 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 		    	<tr> -->
		<!-- 	    			<td>回覆內容 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 	    		<tr> -->
		<!-- 	    			<td>案件狀態 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 	    		<tr> -->
		<!-- 	    			<td>更新時間 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!--     			<tr> -->
		<!-- 	    			<td>建立時間 : </td> -->
		<!-- 	    			<td></td> -->
		<!-- 	    		</tr> -->
		<!-- 	    	</table> -->
		<!--    		    <div class="btn_block"> -->
		<!-- 		    	<button type="button" id="close_btn2">關閉</button> -->
		<!-- 	    	</div> -->
		<!-- 	    </div> -->
	</div>
	<script src="https://kit.fontawesome.com/155106be6f.js"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/back-end/memberorders/vendor/jquery-3.7.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/back-end/memberorders/js/homepage.js"></script>
	<script
		src="${pageContext.request.contextPath}/back-end/memberorders/js/customer.js"></script>
</body>
</html>