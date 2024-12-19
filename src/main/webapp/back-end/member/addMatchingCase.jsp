<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>發布案件</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f7f9fc;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
            max-width: 600px;
            background: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: bold;
            color: #333;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .text-danger {
            font-size: 0.85rem;
        }
        .is-invalid {
            border-color: #dc3545 !important;
        }
        .invalid-feedback {
            display: block;
            color: #dc3545;
        }
    </style>

    <script>
        function validateForm() {
            let isValid = true;

            // 驗證標題
            const titleInput = document.getElementById('title');
            const titleValue = titleInput.value.trim();
            const titleError = document.getElementById('titleError');
            const chineseRegex = /^[\u4e00-\u9fa5]+$/;

            if (!chineseRegex.test(titleValue)) {
                titleError.textContent = '標題只能包含中文！';
                titleInput.classList.add('is-invalid');
                isValid = false;
            } else {
                titleError.textContent = '';
                titleInput.classList.remove('is-invalid');
            }

            // 驗證描述
            const descriptionInput = document.getElementById('description');
            const descriptionValue = descriptionInput.value.trim();
            const descriptionError = document.getElementById('descriptionError');

            if (!chineseRegex.test(descriptionValue)) {
                descriptionError.textContent = '描述只能包含中文！';
                descriptionInput.classList.add('is-invalid');
                isValid = false;
            } else {
                descriptionError.textContent = '';
                descriptionInput.classList.remove('is-invalid');
            }

            // 驗證預算
            const budgetInput = document.getElementById('budget');
            const budgetValue = budgetInput.value;
            const budgetError = document.getElementById('budgetError');

            if (!budgetValue) {
                budgetError.textContent = '請選擇預算！';
                budgetInput.classList.add('is-invalid');
                isValid = false;
            } else {
                budgetError.textContent = '';
                budgetInput.classList.remove('is-invalid');
            }

            return isValid;
        }

        function updateCaseTot() {
            const budget = parseFloat(document.getElementById('budget').value);
            const caseTotField = document.getElementById('caseTot');
            if (!isNaN(budget)) {
                const caseTot = budget * 1.2; 
                caseTotField.value = caseTot.toFixed(0);
            } else {
                caseTotField.value = ''; 
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2 class="text-center">新增案件</h2>

        <c:if test="${not empty errors}">
            <div class="alert alert-danger">
                請檢查以下錯誤，然後重新提交。
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/matchingCases/add" method="post" onsubmit="return validateForm();">
            <!-- 案件標題 -->
            <div class="mb-3">
                <label for="title" class="form-label">案件標題:(最多50字)</label>
                <input type="text" id="title" name="title" class="form-control ${not empty errors.title ? 'is-invalid' : ''}"
                       value="${tempCase != null ? tempCase.title : ''}" 
                       placeholder="請輸入案件標題" maxlength="50">
                <div id="titleError" class="invalid-feedback">${errors.title}</div>
            </div>

            <!-- 案件描述 -->
            <div class="mb-3">
                <label for="description" class="form-label">案件描述:(最多300字)</label>
                <textarea id="description" name="description" class="form-control ${not empty errors.description ? 'is-invalid' : ''}" rows="4"
                          placeholder="請輸入案件描述" maxlength="300">${tempCase != null ? tempCase.description : ''}</textarea>
                <div id="descriptionError" class="invalid-feedback">${errors.description}</div>
            </div>

            <!-- 預算 -->
            <div class="mb-3">
                <label for="budget" class="form-label">預算:</label>
                <select id="budget" name="budget" class="form-control ${not empty errors.budget ? 'is-invalid' : ''}" onchange="updateCaseTot()">
                    <option value="">請選擇預算</option>
                    <option value="1000" ${tempCase != null && tempCase.budget == 1000 ? 'selected' : ''}>1000</option>
                    <option value="1200" ${tempCase != null && tempCase.budget == 1200 ? 'selected' : ''}>1200</option>
                    <option value="1500" ${tempCase != null && tempCase.budget == 1500 ? 'selected' : ''}>1500</option>
                    <option value="2000" ${tempCase != null && tempCase.budget == 2000 ? 'selected' : ''}>2000</option>
                </select>
                <div id="budgetError" class="invalid-feedback">${errors.budget}</div>
            </div>

            <!-- 案件金額 -->
            <div class="mb-3">
                <label for="caseTot" class="form-label">案件金額:</label>
                <input type="text" id="caseTot" name="caseTot" class="form-control" value="${tempCase != null ? tempCase.caseTot : ''}" readonly>
            </div>

            <button type="submit" class="btn btn-primary w-100">提交</button>
        </form>
    </div>
</body>
</html>
