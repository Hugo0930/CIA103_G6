<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.studio.model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>場地管理</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/homepage/css/homepage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/studio/css/std_mgmt.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/studio/css/std_add.css">   
</head>
<%
	List resultList = (List)request.getAttribute("resultList");
	pageContext.setAttribute("resultList", resultList);
%>

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
            <a href="#"><img src="back-end/images/韓國瑜.jpg" alt="沒有圖片"></a>
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
                        <button class="sub_btn_func"><a href="./member_mgmt.html" class="sub_btn_name">會員帳號管理</a></button>
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
                        <button class="sub_btn_func"><a href="./advertising_mgmt.html" class="sub_btn_name">廣告資訊管理</a></button>
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
                        <button class="sub_btn_func"><a href="./product_mgmt.html" class="sub_btn_name">商品管理</a></button>
                    </li>
                    <li class="shop_sub_item">
                        <button class="sub_btn_func"><a href="./order_mgmt.html" class="sub_btn_name">訂單管理</a></button>
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
                        <button class="sub_btn_func"><a href="./complaint_case_mgmt.html" class="sub_btn_name">申訴案件管理</a></button>
                    </li>
                    <li class="match_sub_item">
                        <button class="sub_btn_func"><a href="./case_mgmt.html" class="sub_btn_name">案件管理</a></button>
                    </li>
                </ul>
            </div>
        </ul>
        <!-- 登出 -->
        <button type="button" id="log_out">登出</button>
    </nav>
    <!-- 現在位置 -->
    <div class="container">
        <h2><i class="fa-solid fa-house"></i>場地管理</h2>
        <hr>
        <div id="lookup_block">
	        <select id="sort_type" style="position:absolute; top:115px; right:210px; height:20px; text-align:center">
	        	<option>篩選方式</option>
	        	<option value="std_on">僅顯示上架</option>
	        	<option value="std_off">僅顯示下架</option>
	        	<option value="std_all">顯示所有</option>
	        </select>
        </div>
        <button type="submit"  id="btn_add"><i class="fa-solid fa-plus"></i>新增錄音室</button>
        <h3>總共${pageQty}頁，現在第${currentPage}頁</h3>
	   	<table>
	     	<thead>
	     		<tr>
		        	<th scope="col" id="id">編號</th>
		        	<th scope="col" id="img">圖片</th>
		        	<th scope="col" id="loc">地點</th>
		        	<th scope="col" id="name">名稱</th>
		        	<th scope="col" id="capacity">人數</th>
		        	<th scope="col" id="rent">租金</th>
		        	<th scope="col">操作</th>
	     		</tr>
	        </thead>
	        <tbody>
				<c:forEach var="std" items="${resultList}">
		        	<tr>
		        		<td>${std.studId}</td>
		        		<td>
		      			    <c:if test = "${std.imgBase64 != null}">
		      			    	<div class="img">
				        			<img src="data:image/*;base64,${std.imgBase64}" alt="No Image Available">
		      			    	</div>
		      				</c:if>
		      				<c:if test="${std.imgBase64 == null}">
		      					<div class="no_img">
		     						<img src="back-end/images/查無圖片.png" style="height:100px">
		      					</div>      				
		      				</c:if>
		       			</td>
		        		<td>${std.studLoc}</td>
			        	<td>${std.studName}</td>
			        	<td>${std.capacity}</td>
			        	<td>
			        		<fmt:formatNumber value="${std.hourlyRate}" type="number" maxFractionDigits="0" />
			        	</td>
		 	        	<td>
		 	        		<fmt:parseNumber  var="parsedNumber" value="${std.hourlyRate}"/>
		 	        		<div class="btn_block">		 	        		
		        				<input type="submit" value="修改" class="update_btn" 
			        				                                data-id="${std.studId}" 
									                                data-loc="${std.studLoc}" 
									                                data-name="${std.studName}" 
									                                data-capacity="${std.capacity}" 
									                                data-rate="${parsedNumber}" 
									                                data-img="${std.imgBase64}">
			        			<form method="post" action="${pageContext.request.contextPath}/MyStudioServlet"> 
     				                <c:if test="${std.state == '上架'}">
				                        <!-- 如果錄音室是上架狀態，顯示下架按鈕 -->
				                        <input type="submit" value="下架" class="off_btn">
				                        <input type="hidden" name="action" value="std_off">
				                        <input type="hidden" name="page" value="${currentPage}">
				                    </c:if>
				                    <c:if test="${std.state == '下架'}">
				                        <!-- 如果錄音室是下架狀態，顯示上架按鈕 -->
				                        <input type="submit" value="上架" class="on_btn">
				                        <input type="hidden" name="action" value="std_on">
				                        <input type="hidden" name="page" value="${currentPage}">
				                    </c:if> 
				                    <input type="hidden" name="studio_id" value="${std.studId}">
			        			</form> 
		 	        		</div>
		       			</td>
		        	</tr>
				</c:forEach>
	        </tbody>
		</table>
		<div class=page_block>
			<c:if test="${currentPage - 1 > 0 }">
				<div class="page">
					<a href="${pageContext.request.contextPath}/MyStudioServlet?action=${action}&page=${currentPage - 1}"><i class="fa-solid fa-arrow-left"></i></a>
				</div>
			</c:if>
	      	<c:if test="${pageQty >= firstPage + 0}">
	      		<div class="page">
			    	<a href="${pageContext.request.contextPath}/MyStudioServlet?action=${action}&page=${firstPage + 0}">${firstPage + 0}</a>
	      		</div>
	      	</c:if>
		    <c:if test="${pageQty >= firstPage + 1}">
		    	<div class="page">
			    	<a href="${pageContext.request.contextPath}/MyStudioServlet?action=${action}&page=${firstPage + 1}">${firstPage + 1}</a>
		    	</div>    
		    </c:if>
		    <c:if test="${pageQty >= firstPage + 2}">
		    	<div class="page">
			    	<a href="${pageContext.request.contextPath}/MyStudioServlet?action=${action}&page=${firstPage + 2}">${firstPage + 2}</a>
		    	</div>    
		    </c:if>
   			<c:if test="${currentPage + 1 <= pageQty }">
				<div class="page">
					<a href="${pageContext.request.contextPath}/MyStudioServlet?action=${action}&page=${currentPage + 1}"><i class="fa-solid fa-arrow-right"></i></a>
				</div>
			</c:if>
		</div>
    </div>
   	<%-- 新增錄音室表單 --%>
   	<div class="table_box">
	  	<div class="table">
	        <form action="${pageContext.request.contextPath}/MyStudioServlet" method="post" enctype="multipart/form-data">
            	<h2>新增錄音室</h2>
	            <table>
	                <tbody>
	                    <tr>
	                        <td>錄音室地點</td>
	                        <td><input type="text" name="studio_loc" class="loc"></td>
	                    </tr>
	                    <tr>
	                        <td>錄音室名稱</td>
	                        <td><input type="text" name="studio_name" class="name"></td>
	                    </tr>
	                    <tr>
	                        <td>人數</td>
	                        <td>
	                            <select name="studio_capacity" class="capacity">
	                                <option value="1">1</option>
	                                <option value="2">2</option>
	                                <option value="3">3</option>
	                                <option value="4">4</option>
	                                <option value="5">5</option>
	                            </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td>租金</td>
	                        <td><input type="text" name="studio_hourly_rate" class="hourly_rate"></td>
	                    </tr>
	                    <tr>
	                        <td>上架日期</td>
	                        <td><input type="date" name="release_date" class="date"></td>
	                    </tr>
	                    <tr>
	                        <td>上傳檔案</td>
	                        <td><input type="file" name="studio_pic" accept="image/*" class="image"></td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="add_btn_block">
	                <button type="button" id="submit_btn">送出</button>
	                <button type="reset">清除</button>
            	    <button id="btn_close" type="button">關閉</button>
	            </div>
	            <input type="hidden" name="action" value="add">
	        </form>
	    </div>
   	</div>
   	<%-- 修改錄音室表單 --%>
 	<jsp:include page="/back-end/studio/std_update.jsp"/>
    <script src="https://kit.fontawesome.com/155106be6f.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/back-end/vendor/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/back-end/homepage/js/homepage.js"></script>
    <script src="${pageContext.request.contextPath}/back-end/studio/js/std_mgmt.js"></script>
</body>
</html>