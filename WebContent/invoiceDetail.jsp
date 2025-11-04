<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết hóa đơn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f6f8fa;
        }
        .container {
            width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .info-group {
            width: 48%;
        }
        .section-title {
            font-weight: bold;
            margin: 20px 0 10px 0;
            padding-bottom: 5px;
            border-bottom: 2px solid #3498db;
        }
        /* layout for service & spare lists to sit side-by-side */
        .lists {
            display: flex;
            gap: 20px;
            align-items: flex-start;
            margin-top: 10px;
        }
        .list-box {
            flex: 1;
            min-width: 0; /* allow children to shrink properly */
            background: #fff;
            border-radius: 4px;
            padding: 10px;
            box-shadow: 0 0 6px rgba(0,0,0,0.03);
        }
        /* scrollable area for table bodies; approx height for 5 rows */
        .table-wrapper {
            max-height: 260px;
            overflow-y: auto;
            margin-top: 8px;
            border: 1px solid #e6e6e6;
            border-radius: 4px;
        }
        /* ensure table fills wrapper */
        .table-wrapper table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 10px 0;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .total-row {
            text-align: right;
            font-weight: bold;
            margin: 10px 0;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        button {
            padding: 8px 20px;
            background-color: #add8e6;
            color: black;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #95a5a6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>CHI TIẾT HÓA ĐƠN</h2>

        <div class="info-row">
            <div class="info-group">
                <p><strong>Mã hóa đơn:</strong> ${invoice.id}</p>
                <p><strong>Nhân viên bán hàng:</strong> ${invoice.saleStaff.fullname}</p>
            </div>
            <div class="info-group">
                <p><strong>Thời gian lập:</strong> ${invoice.createdTime}</p>
            </div>
        </div>

        <div class="section-title">Thông tin KH</div>
        <div class="info-row">
            <div class="info-group">
                <p><strong>Họ và tên:</strong> ${invoice.customer.fullname}</p>
                <p><strong>Biển số xe:</strong> ${invoice.licensePlate}</p>
            </div>
            <div class="info-group">
                <p><strong>SĐT:</strong> ${invoice.customer.phoneNumber}</p>
                <p><strong>Email:</strong> ${invoice.customer.email}</p>
            </div>
        </div>

        <div class="lists">
            <div class="list-box">
                <div class="section-title">Danh sách dịch vụ</div>
                <div class="table-wrapper">
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                        <c:forEach var="service" items="${invoice.serviceList}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${service.service.name}</td>
                                <td><fmt:formatNumber value="${service.unitPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                <td>${service.quantity}</td>
                                <td><fmt:formatNumber value="${service.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="total-row">Tổng: <fmt:formatNumber value="${invoice.servicePrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</div>
            </div>

            <div class="list-box">
                <div class="section-title">Danh sách phụ tùng</div>
                <div class="table-wrapper">
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                        <c:forEach var="sparePart" items="${invoice.sparePartList}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${sparePart.sparePart.name}</td>
                                <td><fmt:formatNumber value="${sparePart.unitPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                <td>${sparePart.quantity}</td>
                                <td><fmt:formatNumber value="${sparePart.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="total-row">Tổng: <fmt:formatNumber value="${invoice.sparePartPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</div>
            </div>
        </div>

    <div class="total-row">Tổng hóa đơn: <fmt:formatNumber value="${invoice.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</div>
        <div class="total-row">Trạng thái thanh toán: ${invoice.status}</div>

        <div class="button-group">
            <button onclick="window.history.back()">Trở lại</button>
            <button onclick="window.location.href='customerMainView.jsp'">Thoát</button>
        </div>
    </div>
</body>
</html>
