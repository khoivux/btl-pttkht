 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết doanh thu khách hàng</title>
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
        .container {
            width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .customer-info {
            margin-bottom: 20px;
        }
        .customer-info p {
            margin: 5px 0;
            color: #2c3e50;
        }
        .date-info {
            margin: 20px 0;
        }
        .date-info p {
            margin: 5px 0;
            color: #2c3e50;
        }
        .section-title {
            margin: 20px 0 10px 0;
            color: #2c3e50;
            font-weight: bold;
        }
        table {
            width: 100%;
            margin: 10px 0;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .total-revenue {
            margin: 20px 0;
            text-align: right;
            font-weight: bold;
            color: #2c3e50;
        }
        .back-btn {
            padding: 5px 15px;
            background-color: #add8e6;
            color: black;
            border: 1px solid #ccc;
            cursor: pointer;
            margin-top: 20px;
        }
        .back-btn:hover {
            background-color: #95a5a6;
        }
    </style>
</head>
<body>
    <h2>CHI TIẾT DOANH THU KHÁCH HÀNG</h2>

    <div class="container">
        <div class="customer-info">
            <p><strong>Họ và tên:</strong> ${customer.fullname}</p>
            <p><strong>SĐT:</strong> ${customer.phoneNumber}</p>
            <p><strong>Email:</strong> ${customer.email}</p>
        </div>

        <div class="date-info">
            <p><strong>Ngày bắt đầu:</strong> ${startDate}</p>
            <p><strong>Ngày kết thúc:</strong> ${endDate}</p>
        </div>

        <div class="section-title">Danh sách hóa đơn</div>

        <c:if test="${not empty invoices}">
            <table>
                <tr>
                    <th>STT</th>
                    <th>Mã hóa đơn</th>
                    <th>Thời gian tạo</th>
                    <th>Tổng hóa đơn(Nghìn VNĐ))</th>
                    <th>Hành động</th>
                </tr>
                <c:forEach var="invoice" items="${invoices}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${invoice.id}</td>
                        <td>${invoice.createdTime}</td>
                        <td><fmt:formatNumber value="${invoice.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                        <td>
                            <button type="button" onclick="window.location.href='invoiceDetail?id=${invoice.id}&customerId=${customer.id}&startDate=${startDate}&endDate=${endDate}'">Xem chi tiết</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <div class="total-revenue">
                    Tổng doanh thu: <fmt:formatNumber value="${customer.totalRevenue * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
            </div>
        </c:if>

        <c:if test="${empty invoices}">
            <p style="text-align:center; color:red;">
                Không có hóa đơn nào trong khoảng thời gian từ ${startDate} đến ${endDate}
            </p>
        </c:if>

        <button class="back-btn" onclick="window.history.back()">Trở lại</button>
    </div>
</body>
</html>