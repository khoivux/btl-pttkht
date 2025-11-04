<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê khách hàng theo doanh thu</title>
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
        .search-container {
            width: 500px;
            margin: 0 auto 30px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-row {
            display: grid;
            grid-template-columns: 120px 150px auto;
            gap: 10px;
            margin-bottom: 15px;
            align-items: center;
        }
        .form-row label {
            color: #34495e;
            font-weight: normal;
        }
        input[type="date"] {
            padding: 5px;
            border: 1px solid #ccc;
            width: 130px;
        }
        button {
            padding: 5px 15px;
            background-color: #add8e6;
            color: black;
            border: 1px solid #ccc;
            cursor: pointer;
            margin-left: 10px;
        }
        button:hover {
            background-color: #2980b9;
        }
        table {
            width: 70%;
            margin: 0 auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .total-revenue {
            width: 70%;
            margin: 20px auto;
            text-align: right;
            font-weight: bold;
            color: #2c3e50;
            font-size: 1.1em;
        }
        .back-btn {
            background-color: #95a5a6;
        }
        .back-btn:hover {
            background-color: #7f8c8d;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>
   
</head>
<body>
    <h2>THỐNG KÊ KHÁCH HÀNG THEO DOANH THU</h2>

    <div class="search-container">
        <form action="customerStat" method="get">
            <div class="form-row">
                <label>Ngày bắt đầu:</label>
                <input type="date" name="startDate" value="${startDate}">
                <button type="submit" name="action" value="getstat">Thống kê</button>
            </div>
            <div class="form-row">
                <label>Ngày kết thúc:</label>
                <input type="date" name="endDate" value="${endDate}">
                <button type="button" onclick="window.history.back()">Trở lại</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty customers}">
        <table>
            <tr>
                <th>STT</th>
                <th>Mã KH</th>
                <th>Tên KH</th>
                <th>Doanh thu (Nghìn VNĐ)</th>
            </tr>
            <c:forEach var="customer" items="${customers}" varStatus="loop">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td>${customer.customerId}</td>
                    <td>
                        <a href="invoiceList?action=view&customerId=${customer.id}&startDate=${startDate}&endDate=${endDate}" 
                           style="text-decoration: none; color: #2c3e50;">
                            ${customer.fullname}
                        </a>
                    </td>
                    <td>${customer.totalRevenue}</td>
                </tr>
            </c:forEach>
        </table>

        <div class="total-revenue">
            Tổng doanh thu: ${totalRevenue} Nghìn VNĐ
        </div>
    </c:if>

    <c:if test="${empty customers && startDate != null}">
        <p style="text-align:center; color:red;">
            Không có dữ liệu thống kê trong khoảng thời gian từ ${startDate} đến ${endDate}
        </p>
    </c:if>
</body>
</html>