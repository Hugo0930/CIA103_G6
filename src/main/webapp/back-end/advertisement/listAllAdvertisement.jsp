<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.advertisement.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
AdvertisementService memberSvc = new AdvertisementService();
    List<AdvertisementVO> list = advertisementSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有員工資料 - listAllAdvertisement.jsp</title>
<!--css路徑  -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/back-end/advertisement/css/listAllAdvertisement.css">


</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>	
		 <h3>所有員工資料 - listAllAdvertisement.jsp</h3>
		 <h4>
		 <a href="select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/advertisement/images/back1.gif"  width="100" height="32" border="0">回首頁</a>
		 </h4>
	</td></tr>
</table>

<div style="overflow-x: auto;"> 
<!-- 表格內容過長捲動條  -->
<table>
	<tr>
		<th>廣告編號</th>
		<th>管理員編號</th>
		<th>標題</th>
		<th>詳細內容</th>
		<th>圖片路徑</th>
		<th>跳轉路徑</th>
		<th>開始日期</th>
		<th>結束日期</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="advertisementVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${advertisementVO.advertisementId}</td>
			<td>${advertisementVO.adminId}</td>
			<td>${advertisementVO.title}</td>
			<td>${advertisementVO.descript}</td>
			<td>${advertisementVO.imgUrl}</td>
			<td>${advertisementVO.targetUrl}</td> 
			<td>${advertisementVO.strDate}</td>
			<td>${advertisementVO.endDate}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/advertisement/advertisement.do" style= "margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="advertisementId"  value="${advertisementVO.advertisementId}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/advertisement/advertisement.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="memberId"  value="${advertisementVO.advertisementId}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
</div>
<%@ include file="page2.file" %>

</body>
</html>