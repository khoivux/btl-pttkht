<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê khách hàng theo doanh thu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding-top: 60px;
            background-color: #f6f8fa;
        }

        /* 🔹 Navbar cố định */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 45px;
            background-color: #3498db;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        .navbar-title {
            font-size: 18px;
            font-weight: bold;
        }
        .navbar-user {
            font-size: 15px;
        }

        /* 🔹 Container chính */
        .container {
            width: 1200px;
            margin: 30px auto;
            background: white;
            padding: 20px 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        /* 🔹 Form tìm kiếm */
        .form-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 15px;
        }
        label {
            color: #34495e;
            font-weight: normal;
        }
        input[type="date"] {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 7px 15px;
            border: none;
            border-radius: 4px;
            background-color: #3498db;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
        .back-btn {
            background-color: #95a5a6;
        }
        .back-btn:hover {
            background-color: #7f8c8d;
        }

        /* 🔹 Bảng */
        .table-wrapper {
            max-height: 400px;
            overflow-y: auto;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border-bottom: 1px solid #ddd;
            padding: 10px 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
            z-index: 2;
        }
        tr:nth-child(even) {
            background-color: #fafafa;
        }
        tr:hover {
            background-color: #ecf0f1;
        }

        .view-btn {
            background-color: #27ae60;
            color: white;
            padding: 6px 10px;
            border-radius: 5px;
            text-decoration: none;
        }
        .view-btn:hover {
            background-color: #219150;
        }

        /* 🔹 Tổng doanh thu */
        .total-revenue {
            text-align: right;
            font-weight: bold;
            color: #2c3e50;
            margin-top: 15px;
        }

        /* 🔹 Thông báo */
        .no-data {
            text-align: center;
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-title">Thống kê khách hàng theo doanh thu</div>
    <div class="navbar-user">
        Xin chào, <strong>${user.fullname}</strong>
    </div>
</div>

<!-- Container -->
<div class="container">
    <h2>THỐNG KÊ KHÁCH HÀNG</h2>

    <!-- Form tìm kiếm -->
    <form action="customerStat" method="get">
        <div class="form-row">
            <label>Ngày bắt đầu:</label>
            <input type="date" name="startDate" value="${startDate}">
            <label>Ngày kết thúc:</label>
            <input type="date" name="endDate" value="${endDate}">
            <button type="submit" name="action" value="getstat">Thống kê</button>
            <button type="button" class="back-btn" onclick="window.history.back()">Trở lại</button>
        </div>
    </form>

    <!-- Bảng dữ liệu -->
    <c:if test="${not empty customers}">
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã KH</th>
                        <th>Tên khách hàng</th>
                        <th>Doanh thu</th>
                        <th>Xem chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}" varStatus="loop">
                        <tr>
                            <td style="text-align:center;">${loop.index + 1}</td>
                            <td>${customer.customerId}</td>
                            <td>
                                <a href="invoiceList?action=view&customerId=${customer.id}&startDate=${startDate}&endDate=${endDate}"
                                   style="text-decoration: none; color: #2c3e50;">
                                    ${customer.fullname}
                                </a>
                            </td>
                            <td style="text-align:right;">
                                <fmt:formatNumber value="${customer.totalRevenue * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
                            </td>
                            <td style="text-align:center;">
                                <a href="invoiceList?action=view&customerId=${customer.id}&startDate=${startDate}&endDate=${endDate}" 
                                   class="view-btn">Xem chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="total-revenue">
            Tổng doanh thu: 
            <fmt:formatNumber value="${totalRevenue * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
        </div>
    </c:if>

    <c:if test="${empty customers && startDate != null}">
        <p class="no-data">
            Không có dữ liệu thống kê trong khoảng thời gian từ ${startDate} đến ${endDate}
        </p>
    </c:if>
</div>

</body>
</html>
