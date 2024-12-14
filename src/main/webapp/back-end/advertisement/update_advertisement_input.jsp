<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.advertisement.model.*"%>

<% //見com.emp.controller.EmpServlet.java第163行存入req的empVO物件 (此為從資料庫取出的empVO, 也可以是輸入格式有錯誤時的empVO物件)
AdvertisementVO advertisementVO = (AdvertisementVO) request.getAttribute("advertisementVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>廣告資料修改 - update_advertisement_input.jsp</title>
<!--css路徑  -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/back-end/advertisement/css/update_advertisement_input.css">


</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>廣告資料修改 - update_advertisement_input.jsp</h3>
		 <h4>
		 <a href="select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/advertisement/images/back1.gif"  width="100" height="32" border="0">回首頁</a>
		 </h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="advertisement.do" name="form1">
<table>
	<tr>
		<td>廣告編號:<font color=red><b>*</b></font></td>
		<td><%=advertisementVO.getAdvertisementId()%></td>
	</tr>
	<tr>
		<td>管理員編號:</td>
		<td><input type="TEXT" name="adminId" value="<%=advertisementVO.getAdvertisementId()%>" size="5"/></td>
	</tr>
	<tr>
		<td>標題:</td>
		<td><input type="TEXT" name="title"   value="<%=advertisementVO.getAdminId()%>" size="10"/></td>
	</tr>
	<tr>
		<td>詳細描述:</td>
		<td><input type="TEXT" name="descript"   value="<%=advertisementVO.getTitle()%>" size="45"/></td>
	</tr>
	
	<tr>
		<td>圖片路徑:</td>
		<td><input type="TEXT" name="imgUrl"  value="<%=advertisementVO.getImgUrl()%>" size="45"/></td>
	</tr>
	<tr>
		<td>跳轉路徑:</td>
		<td><input type="TEXT" name="targetUrl"  value="<%=advertisementVO.getTargetUrl()%>" size="45"/></td>
	</tr>
	<tr>
		<td>開始日期:</td>
		<td><input name="strDate" id="f_date1" type="text" ></td> 
	</tr>
     
     <tr>
		<td>結束日期:</td>
		<td><input name="endDate" id="f_date2" type="text" ></td> 
	</tr>
<%-- 	<jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>部門:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="deptno"> -->
<%-- 			<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
<%-- 				<option value="${deptVO.deptno}" ${(empVO.deptno==deptVO.deptno)?'selected':'' } >${deptVO.dname} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr> -->

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="memberId" value="<%=advertisementVO.getAdvertisementId()%>">
<input type="submit" value="送出修改"></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date strDate = null;
  try {
	  strDate = advertisementVO.getStrDate();
   } catch (Exception e) {
	   strDate = new java.sql.Date(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width: 600px;   /* width:  600px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>

$(document).ready(function() {
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=strDate%>'    
		   // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
});    
        
<% 
java.sql.Date endDate = null;
try {
	endDate = advertisementVO.getEndDate();
 } catch (Exception e) {
	 endDate = new java.sql.Date(System.currentTimeMillis());
 }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
         width:  300px;   /* width:  300px; */
}
.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
         height: 151px;   /* height:  151px; */
}
</style>

<script>

$(document).ready(function() {
      $.datetimepicker.setLocale('zh');
      $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=endDate%>'    
		   // value:   new Date(),
         //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
         //startDate:	            '2017/07/10',  // 起始日
         //minDate:               '-1970-01-01', // 去除今日(不含)之前
         //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
      });
});    
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>