<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.advertisement.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
AdvertisementVO advertisementVO = (AdvertisementVO) request.getAttribute("advertisementVO"); //AdvertisementServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>會員資料 - listOneAdvertisement.jsp</title>
<!-- css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/back-end/advertisement/css/listOneAdvertisement.css">


</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>會員資料 - listOneAdvertisement.jsp</h3>
		 <a href="select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/advertisement/images/back1.gif"  width="100" height="32" border="0">回首頁</a>
	</td></tr>
</table>

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
	</tr>
	<tr>
		<td><%=advertisementVO.getAdvertisementId()%></td>
		<td><%=advertisementVO.getAdminId()%></td>
		<td><%=advertisementVO.getTitle()%></td>
		<td><%=advertisementVO.getDescript()%></td>
		<td><%=advertisementVO.getImgUrl()%></td>
		<td><%=advertisementVO.getTargetUrl()%></td>
		<td><%=advertisementVO.getStrDate()%></td>
		<td><%=advertisementVO.getEndDate()%></td>
		
	</tr>
</table>

</body>
</html>