<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*" %>
<%@ page import="com.prodBack.model.*"%>


<% 
   ProdVO prodVO = (ProdVO) request.getAttribute("prodVO");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品更新</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/prodmanage/prodfile/css/std_update.css">   
</head>
<body>
   	<%-- 修改表單 --%>
   	<div class="update_table_box">
	  	<div class="table">
	        <form action="<%=request.getContextPath()%>/back-end/prodmanage/prodBack.do" method="post">
            	<h2>修改商品</h2>
            	
            	<c:if test="${not empty errorMsgs}">
            	
					<font style="color:red">請修正以下錯誤:</font>
					<ul>
					<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
					</c:forEach>
					</ul>
				</c:if>
				
	            <table>
	                <tbody>
	                
	                	<tr>
	                  
							<td>商品編號:</td>
							<td><input type="text" name="prodId" id="prodId" style="border-style:none" readonly ></td>
					   </tr>
	                
	                
	                   <tr>
	                  
							<td>商品名稱:</td>
							<td><input type="TEXT" name="prodName" id="prodName"
									   onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')"  required/></td>
					   </tr>
					   
					   <tr>
							<td>商品分類:</td>
	                        <td>
	                            <select name="prodTypeId" id="prodTypeId">
	                                <option value="1">錄音相關</option>
	                                <option value="2">周邊</option>                   
	                            </select>
	                        </td>
					   </tr>
					 					   									   
					   <tr>
							<td>品牌:</td>
							<td><input type="TEXT" name="prodBrand" id="prodBrand"
							           onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')"  required/></td>
					   </tr>
					   
					   <tr>
							<td>商品價格:</td>
							<td><input type="TEXT" name="prodPrice" id="prodPrice"  
									   onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')" required/></td>
					   </tr>
					   
					   <tr>
							<td>上架數量:</td>
							<td><input type="TEXT" name="prodCount" id="prodCount"
									   onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')" required/></td>
					   </tr>
					   
					   <tr>		   
							<td>上架日期:</td>
							<td><input name="prodRegTime" id="prodRegTime" type="date" required readonly></td>
				       </tr>	                   
	                         
	                   <tr>
							<td>商品描述:</td>
							<td><input type="TEXT" name="prodContent" id="prodContent"
									   onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')" required/></td>
					   </tr>      
					   
					   <tr>
							<td>商品狀態</td>
	                        <td>
	                            <select name="prodStatus" id="prodStatus">
	                                <option value="0">未上架</option>
	                                <option value="1">上架中</option>                   
	                            </select>
	                        </td>
					   </tr> 
					   
	                                    
<!-- 	                    <tr> -->
<!-- 	                        <td>上傳檔案</td> -->
<!-- 	                        <td><input type="file" name="studio_pic" accept="imgage/*"></td> -->
<!-- 	                    </tr> -->
	                </tbody>
	            </table>            
	            <div class="update_btn_block">
	                <button type="submit">送出</button>
	                <button type="reset">清除</button>
            	    <button id="update_btn_close" type="button">關閉</button>
	            </div>
	            <input type="hidden" name="action" value="update">
	        </form>
	    </div>
   	</div>
</body>
</html>