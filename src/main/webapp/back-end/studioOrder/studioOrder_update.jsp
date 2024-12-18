<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單更新</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/studio_order/css/std_update.css">   
</head>
<body>
   	<%-- 修改錄音室表單 --%>
   	<div class="update_table_box">
	  	<div class="table">
	        <form action="${pageContext.request.contextPath}/OrderServlet" method="post" enctype="multipart/form-data">
            	<h2>修改訂單</h2>
	            <table>
	               <tbody>
						    <!-- 訂單編號 (STUD_ORDER_ID) -->
						    <tr>
						        <td>訂單編號</td>
						        <td><input type="text" name="stud_order_id" id="stud_order_id" readonly></td>
						    </tr>
						
						    <!-- 會員編號 (MEM_ID) -->
						    <tr>
						        <td>會員編號</td>
						        <td><input type="text" name="mem_id" id="mem_id" class="mem_id"></td>
						    </tr>
						
						    <!-- 錄音室編號 (STUD_ID) -->
						    <tr>
						        <td>錄音室編號</td>
						        <td><input type="text" name="stud_id" id="stud_id" class="stud_id"></td>
						    </tr>
						
						    <!-- 訂單狀態 (ORDER_STATUS) -->
						    <tr>
						        <td>訂單狀態</td>
						        <td>
						            <select name="order_status" id="order_status">
						                <option value="0">PENDING (待處理)</option>
						                <option value="1">CONFIRMED (確認)</option>
						                <option value="2">CANCELLED (取消)</option>
						                <option value="3">COMPLETED (完成)</option>
						            </select>
						        </td>
						    </tr>
						
						    <!-- 超時狀態 (OVERTIME_STATUS) -->
<!-- 						    <tr> -->
<!-- 						        <td>超時狀態</td> -->
<!-- 						        <td> -->
<!-- 						            <select name="overtime_status" id="overtime_status"> -->
<!-- 						                <option value="0">FALSE (未超時)</option> -->
<!-- 						                <option value="1">TRUE (超時)</option> -->
<!-- 						            </select> -->
<!-- 						        </td> -->
<!-- 						    </tr> -->
						
						    <!-- 訂單金額 (ORDER_AMOUNT) -->
						    <tr>
						        <td>訂單金額</td>
						        <td><input type="number" step="0.1" name="order_amount" id="order_amount"></td>
						    </tr>
						
						    <!-- 租借時數 (RENTAL_HOUR) -->
						    <tr>
						        <td>租借時數</td>
						        <td><input type="number" name="rental_hour" id="rental_hour"></td>
						    </tr>
						
						    <!-- 超時時數 (OVERTIME_DURATION) -->
<!-- 						    <tr> -->
<!-- 						        <td>超時時數</td> -->
<!-- 						        <td><input type="number" name="overtime_duration" id="overtime_duration"></td> -->
<!-- 						    </tr> -->
						
						    <!-- 開始時間 (START_TIME) -->
						    <tr>
						        <td>開始時間</td>
						        <td><input type="datetime-local" name="start_time" id="start_time"></td>
						    </tr>
						
						    <!-- 結束時間 (END_TIME) -->
						    <tr>
						        <td>結束時間</td>
						        <td><input type="datetime-local" name="end_time" id="end_time"></td>
						    </tr>
						
						    <!-- 訂單日期 (ORDER_DATE) -->
						    <tr>
						        <td>訂單日期</td>
						        <td><input type="date" name="order_date" id="order_date"></td>
						    </tr>
						</tbody>
	               
	            </table>
	            <div class="update_btn_block">
	                <button type="button" id="update_submit_btn">送出</button>
	                <button type="reset">清除</button>
            	    <button id="update_btn_close" type="button">關閉</button>
	            </div>
	            <input type="hidden" name="action" value="update">
	        </form>
	    </div>
   	</div>
</body>
</html>