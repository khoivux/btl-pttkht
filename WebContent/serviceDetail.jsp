<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thông tin dịch vụ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f6f8fa;
        }
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }
        .service-detail {
            width: 500px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .detail-row {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .detail-label {
            font-weight: bold;
            color: #34495e;
            min-width: 120px;
        }
        .detail-value {
            color: #2c3e50;
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 4px;
            flex: 1;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        button {
            padding: 8px 20px;
            margin: 0 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
        .error-message {
            color: #e74c3c;
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <h2>Chi tiết thông tin dịch vụ</h2>

    <c:if test="${not empty error}">
        <div class="error-message">
            ${error}
        </div>
    </c:if>

    <c:if test="${not empty service}">
        <div class="service-detail">
            <div class="detail-row">
                <div class="detail-label">Mã:</div>
                <div class="detail-value">${service.id}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Tên:</div>
                <div class="detail-value">${service.name}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Đơn giá:</div>
                <div class="detail-value"><fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Mô tả:</div>
                <div class="detail-value">${service.des}</div>
            </div>

            <div class="button-container">
                <button onclick="window.location.href='service'">Trở lại</button>
                <button onclick="window.location.href='customerMainView.jsp'">Thoát</button>
            </div>
        </div>
    </c:if>
</body>
</html>