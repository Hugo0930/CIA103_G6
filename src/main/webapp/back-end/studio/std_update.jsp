<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>錄音室更新</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/back-end/studio/css/std_update.css">   
</head>
<body>
   	<%-- 修改錄音室表單 --%>
   	<div class="update_table_box">
	  	<div class="table">
	        <form action="${pageContext.request.contextPath}/MyStudioServlet" method="post" enctype="multipart/form-data">
            	<h2>修改錄音室</h2>
	            <table>
	                <tbody>
	                	<tr>
	                        <td>錄音室編號</td>
	                        <td><input type="text" name="studio_id" id="studio_id" readonly></td>
	                    </tr>
	                    <tr>
	                        <td>錄音室地點</td>
	                        <td><input type="text" name="studio_loc" id="studio_loc"></td>
	                    </tr>
	                    <tr>
	                        <td>錄音室名稱</td>
	                        <td><input type="text" name="studio_name" id="studio_name"></td>
	                    </tr>
	                    <tr>
	                        <td>人數</td>
	                        <td>
	                            <select name="studio_capacity" id="studio_capacity">
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
	                        <td><input type="text" name="studio_hourly_rate" id="studio_hourly_rate"></td>
	                    </tr>
	                    <tr>
	                        <td>上架日期</td>
	                        <td><input type="date" name="release_date" id="release_date"></td>
	                    </tr>
	                    <tr>
	                        <td>上傳檔案</td>
	                        <td><input type="file" name="studio_pic" accept="imgage/*"></td>
	                    </tr>
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