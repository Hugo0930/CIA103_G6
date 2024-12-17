<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/front-end/studio/css/order.css" rel="stylesheet" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/reserve/style.css">
<meta charset="UTF-8">
<title>訂單查詢</title>
</head>
<body>
    <header class="header">
        <div class="logo">VoiceBus</div>
        <nav class="nav">
            <ul>
                <li><a href="#">關於我們</a></li>
                <li><a href="#">會員</a></li>
                <li><a href="#">配音員列表</a></li>
                <li><a href="#">商城</a></li>
                <li><a href="#">購物車</a></li>
            </ul>
        </nav>
    </header>
	<div class="lookup_block">
	   	<form method="post" action="${pageContext.request.contextPath}/OrderServlet">
	   		<label for="start_date">開始日期</label>
	   		<input type="date" id="start_date" name="start_date">
	   		<label for="end_date">結束日期</label>
	   		<input type="date" id="end_date" name="end_date">
	    	<select id="sort_type" name="sort_type">
	    		<option value="asc">日期遞增排序</option>
	    		<option value="desc">日期遞減排序</option>
	    	</select>
	    	<select id="current_page" name="current_page">
	    		<option>請選擇頁數</option>
	    	</select>
	    	<input type="hidden" name="action" value="lookup">
	    	<input type="hidden" name="btn_pushed" value="btn_pushed">
	    	<button type="submit"><i class="fa-solid fa-magnifying-glass"></i> 查詢</button>
	   	</form>
   </div>
	<div class="table">
		<table class="table table-striped">
			<thead>
				<tr>
					<th scope="col">錄音室名稱</th>
					<th scope="col">錄音室地點</th>
					<th scope="col">租借時數</th>
					<th scope="col">預約日期</th>
					<th scope="col">開始時間</th>
					<th scope="col">結束時間</th>
					<th scope="col">總金額</th>
					<th scope="col">建立日期</th>
					<th scope="col">訂單狀態</th>		
				</tr>
			</thead>
			<tbody>
				<c:forEach var="order" items="${requestScope.user_order}">
				<tr>
					<td>${order.studioVO.studName}</td>
					<td>${order.studioVO.studLoc}</td>
					<td>${order.rentalHour}</td>
					<td>
						<fmt:parseDate value="${order.bookDate}" var="fmtBookDate" pattern="yyyy-MM-dd" />
						<fmt:formatDate value="${fmtBookDate}" pattern="yyyy/MM/dd" />
					</td>
					<td>${order.startTime}</td>
					<td>${order.endTime}</td>
					<td>${order.totalAmount}</td>  
					<td>
						<fmt:parseDate value="${order.orderDate}" var="fmtOrdDate" pattern="yyyy-MM-dd" />
						<fmt:formatDate value="${fmtOrdDate}" pattern="yyyy/MM/dd" />
					</td>
					<c:if test="${order.status == 0}">					
						<td style="color:red;">待處理</td>
					</c:if>
					<c:if test="${order.status == 3}">					
						<td style="color:green;">已完成</td>
					</c:if>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="pagination_block">
			<ul>
				<c:if test="${current_page - 1 > 0}">
					<li><a class="pagination_link prev" href="${pageContext.request.contextPath}/OrderServlet?action=${action}&mem_id=2&page=${current_page - 1}">&laquo;</a></li>
				</c:if>
				<c:if test="${pageQty >= first_page + 0}">
					<li><a class="pagination_link page" href="${pageContext.request.contextPath}/OrderServlet?action=${action}&mem_id=2&page=${first_page + 0}">${first_page + 0}</a></li>
				</c:if>
				<c:if test="${pageQty >= first_page + 1}">
					<li><a class="pagination_link page" href="${pageContext.request.contextPath}/OrderServlet?action=${action}&mem_id=2&page=${first_page + 1}">${first_page + 1}</a></li>
				</c:if>
				<c:if test="${pageQty >= first_page + 2}">
					<li><a class="pagination_link page" href="${pageContext.request.contextPath}/OrderServlet?action=${action}&mem_id=2&page=${first_page + 2}">${first_page + 2}</a></li>
				</c:if>
				<c:if test="${pageQty >= first_page + 3}">
					<li><a class="pagination_link page" href="${pageContext.request.contextPath}/OrderServlet?action=${action}&mem_id=2&page=${first_page + 3}">${first_page + 3}</a></li>
				</c:if>
				<c:if test="${pageQty >= first_page + 4}">
					<li><a class="pagination_link page" href="${pageContext.request.contextPath}/OrderServlet?action=${action}&mem_id=2&page=${first_page + 4}">${first_page + 4}</a></li>
				</c:if>
				<c:if test="${current_page + 1 <= pageQty}">
					<li><a class="pagination_link last" href="${pageContext.request.contextPath}/OrderServlet?action=${action}&mem_id=2&page=${current_page + 1}">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<c:set var="mem_id" value="2"></c:set>
	<c:set var="baseURL" value="${pageContext.request.contextPath}/OrderServlet"></c:set>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/155106be6f.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/back-end/vendor/jquery-3.7.1.min.js"></script>
    <script>
    	let start_date;
    	let end_date;
    	$("input#start_date").on("change",function(){
    		start_date = new Date($("input#start_date").val());
   		   	$("input#end_date").on("change",function(){
	    		end_date = new Date($("input#end_date").val());
	    		end_year = end_date.getFullYear();
	    		end_month = end_date.getMonth() + 1;
	    		end_day = end_date.getDay();
	    		//console.log(start_date);
	    		//console.log(end_date);
	    		checkDate(start_date,end_date);
    		})
    		checkDate(start_date,end_date);
  		})
    	function checkDate(start_date,end_date){
    		if(start_date != null && end_date != null){
    			if(start_date > end_date){
    				alert("日期輸入錯誤!");
    				$("input#start_date").val("");
    				$("input#end_date").val("");
    			}
    		}
    	}
    	/*
        // 取得今天的日期
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0'); // 月份補零
        const dd = String(today.getDate()).padStart(2, '0'); // 日期補零
        // 格式化為 YYYY-MM-DD
        const minDate = yyyy + "-" + mm + "-" + dd;
        //console.log(minDate);
        $("input#start_date").attr("min",minDate);
        */
        $(document).ready(function(){        	
   			//alert("ttt");
			const param = new URLSearchParams(window.location.search);
			//console.log(param);
			
			let current_page = param.get("page");
			//console.log(current_page);
			
			if(current_page){
				$("li a.page").each((index,link) => {
					//console.log(link.href.includes(`page=${current_page}`));
					//console.log(link.href);
					if(link.href.includes(`page=${current_page}`)){		
						let li_el = link.closest("li");
						li_el.classList.add("active");
					}
				})
			}else{
				$("a.page").first().closest("li").addClass("active");
			}
			
			
        })
        const ROWS_PER_PAGE = 3;
        let pageQty = parseInt(`${pageQty}`);
        //console.log(pageQty);
        //console.log(typeof(pageQty));
        for(var i = 0; i < pageQty; i++){
        	let option_page = i + 1;
        	//console.log(option_page);
        	$("select#current_page").append('<option>' + option_page + '</option>');
        }
        $("select#current_page").on("input",function(){
        	let value = $("select#current_page").val();
		    let baseURL = "${baseURL}";
		    let action = "${action}";
		    let mem_id = "${mem_id}";
		    let targetURL = baseURL + "?action=" + action + "&mem_id=" + mem_id + "&page=" + value;       	
    		//console.log(targetURL);
        	window.location.href = targetURL;
        })
    </script>
</body>
</html>