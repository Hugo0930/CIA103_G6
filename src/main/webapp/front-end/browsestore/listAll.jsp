<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<%@ page import="com.prodtype.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>
<%-- begin="${pageIndex}" end="${pageIndex + rowsPerPage - 1}" --%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>瀏覽商城</title>
</head>
<body>

<%-- <c:forEach var="prodVO" items="${prodVO}" > --%>
<!--     <tr> -->
<%--         <td>${prodvVO.prodId}</td> --%>
<%--         <td>${prodvVO.prodTypeId}</td> --%>
<%--         <td>${prodvVO.prodName}</td> --%>
<%--         <td>${prodvVO.prodPrice}</td> --%>
<!--     </tr> -->
<%-- </c:forEach> --%>

<table>
<!--  <tr> -->
<!--   <th>員工編號</th> -->
<!--   <th>員工姓名</th> -->
<!--   <th>職位</th> -->
<!--   <th>雇用日期</th> -->
<!--   <th>薪水</th> -->
<!--   <th>獎金</th> -->
<!--   <th>部門</th> -->
<!--   <th>修改</th> -->
<!--   <th>刪除</th> -->
<!--  </tr> -->
<%--  <%@ include file="page1.file" %>  --%>

<%-- <% --%>
<!--       ProdService prodSvc = new ProdService(); -->
<!--       List<ProdVO> list = prodSvc.getAll(); -->
<!--       pageContext.setAttribute("list",list); -->
<%-- %> --%>

<c:forEach var="prodVO" items="${prodVO}" >
    <tr>
        <td>${prodVO.prodId}</td>
        <td>${prodVO.prodTypeId}</td> 
        <td>${prodVO.prodName}</td>
        <td>${prodVO.prodPrice}</td>
    </tr>
 </c:forEach>
<!-- </table> -->






    <div>
        <!-- 商品分類按鈕 -->
        <a href="ProdServlet?category=all">全部商品</a>
        <a href="ProdServlet?category=1">錄音相關</a>
        <a href="ProdServlet?category=2">周邊</a>
    </div>

    <!-- 商品列表 -->
<!--     <div id="product-list"> -->
<%--         <c:forEach var="prod" items="${list}"> --%>
<!--             <div class="product-item"> -->
<%--                 <h3>${prod.prodName}</h3> --%>
<%--                 <p>價格: ${prod.prodPrice}</p> --%>
<!--             </div> -->
<%--         </c:forEach> --%>
<!--     </div> -->
    <script>
    	document.addEventListener("DOMContentLoaded",function(){
    		alert("ttt");
    	})
    </script>
</body>
</html>


<!-- <html> -->
<!-- <head> -->
<!-- <title>所有員工資料 - listAllEmp.jsp</title> -->

<!-- <style> -->
<!--  table#table-1 {  -->
<!--   background-color: #CCCCFF;  -->
<!--      border: 2px solid black;  -->
<!--      text-align: center;  -->
<!--    } -->
<!--    table#table-1 h4 {  -->
<!--      color: red;  -->
<!--     display: block;  -->
<!--      margin-bottom: 1px; -->
<!--    }  -->
<!--    h4 {  -->
<!--      color: blue;  -->
<!--      display: inline;  -->
<!--    }  -->
<!-- </style> -->

<!-- <style> -->
<!--   table {  -->
<!--   width: 800px;  -->
<!--  background-color: white;  -->
<!--   margin-top: 5px;  -->
<!--  margin-bottom: 5px;  -->
<!--    }  -->
<!--    table, th, td {  -->
<!--      border: 1px solid #CCCCFF;  -->
<!--    }  -->
<!--    th, td {  -->
<!--     padding: 5px;  -->
<!--      text-align: center;  -->
<!--   }  -->
<!-- </style> -->

<!-- </head> -->
<!-- <body bgcolor='white'> -->

<!-- <h4>此頁練習採用 EL 的寫法取值:</h4> -->
<!-- <table id="table-1"> -->
<!--  <tr><td> -->
<!--    <h3>所有員工資料 - listAllEmp.jsp</h3> -->
<!--    <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> -->
<!--  </td></tr> -->
<!-- </table> -->

<!-- <table> -->
<!--  <tr> -->
<!--   <th>員工編號</th> -->
<!--   <th>員工姓名</th> -->
<!--   <th>職位</th> -->
<!--   <th>雇用日期</th> -->
<!--   <th>薪水</th> -->
<!--   <th>獎金</th> -->
<!--   <th>部門</th> -->
<!--   <th>修改</th> -->
<!--   <th>刪除</th> -->
<!--  </tr> -->
<%--  <%@ include file="page1.file" %>  --%>
<%--  <c:forEach var="empVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> --%>
  
<!--   <tr> -->
<%--    <td>${empVO.empno}</td> --%>
<%--    <td>${empVO.ename}</td> --%>
<%--    <td>${empVO.job}</td> --%>
<%--    <td>${empVO.hiredate}</td> --%>
<%--    <td>${empVO.sal}</td> --%>
<%--    <td>${empVO.comm}</td>  --%>
<%--    <td>${empVO.deptno}</td> --%>
<!--    <td> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;"> --%>
<!--         <input type="submit" value="修改"> -->
<%--         <input type="hidden" name="empno"  value="${empVO.empno}"> --%>
<!--         <input type="hidden" name="action" value="getOne_For_Update"></FORM> -->
<!--    </td> -->
<!--    <td> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;"> --%>
<!--         <input type="submit" value="刪除"> -->
<%--         <input type="hidden" name="empno"  value="${empVO.empno}"> --%>
<!--         <input type="hidden" name="action" value="delete"></FORM> -->
<!--    </td> -->
<!--   </tr> -->
<%--  </c:forEach> --%>
<!-- </table> -->
<%-- <%@ include file="page2.file" %> --%>

<!-- </body> -->
<!-- </html> -->