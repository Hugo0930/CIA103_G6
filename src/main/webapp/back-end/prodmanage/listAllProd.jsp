<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prodBack.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ProdService prodSvc = new ProdService();
    List<ProdVO> list = prodSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有員工資料 - listAllProd.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有商品資料 - listAllEmp.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="<%= request.getContextPath()%>/back-end/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>商品編號</th>
		<th>商品分類編號</th>
		<th>商品名稱</th>
		<th>商品描述</th>
		<th>商品價格</th>
		<th>商品品牌</th>
		<th>商品上架數量</th>
		<th>商品銷售數量</th>
		<th>商品評價總分數</th>
		<th>商品評價總次數</th>
		<th>商品瀏覽次數</th>
		<th>上架日期</th>
		<th>商品狀態</th>
		
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="prodVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${prodVO.prodId}</td>
			<td>${prodVO.prodTypeId}</td>
			<td>${prodVO.prodName}</td>
			<td>${prodVO.prodContent}</td>
			<td>${prodVO.prodPrice}</td>
			<td>${prodVO.prodBrand}</td>		
			<td>${prodVO.prodCount}</td>
			<td>${prodVO.prodSold}</td>
			<td>${prodVO.prodRateSum}</td>
			<td>${prodVO.prodRateCountSum}</td>		
			<td>${prodVO.prodViews}</td>		
			<td>${prodVO.prodRegTime}</td>
			<td>${prodVO.prodStatus}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/prodmanage/prod.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="prodId"  value="${prodVO.prodId}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/prodmanage/prod.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="prodId"  value="${prodVO.prodId}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>