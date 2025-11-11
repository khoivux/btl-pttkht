<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

        /* 🔹 Container rộng hơn */
        .container {
            width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 10px 20px 20px 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            margin-top: 0;
            text-align: center;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .info-group {
            width: 48%;
        }

        .info-group p {
            margin: 14px 0 0 0;
        }

        .section-title {
            font-weight: bold;
            margin-top: 0;
            padding-top: 10px;
            border-top: 3px solid #3498db;
        }

        .lists {
            display: flex;
            gap: 20px;
            align-items: flex-start;
            margin-top: 10px;
        }

        .list-box {
            flex: 1;
            background: #fff;
            border-radius: 4px;
            padding: 10px;
            box-shadow: 0 0 6px rgba(0,0,0,0.03);
            min-width: 0; /* giúp 2 box chia đều không bị tràn */
        }

        .table-wrapper {
        	padding: 0;
            max-height: 230px;
            overflow-y: auto;
            margin-top: 8px;
            border: 1px solid #e6e6e6;
            border-radius: 4px;
        }

        .table-wrapper table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
            display: block;
        }
		
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 10px 0;
            table-layout: fixed; /* đảm bảo các cột có kích thước ổn định */
        }

        /* 🔹 Điều chỉnh chiều rộng các cột để đều và đẹp hơn */
        th, td {
            border: 1px solid #ccc;
            padding: 10px 12px;
            text-align: left;
            word-wrap: break-word;
        }

        th {
            background-color: #f2f2f2;
        }

        table th:nth-child(1),
        table td:nth-child(1) {
            width: 8%; /* STT */
            text-align: center;
        }

        table th:nth-child(2),
        table td:nth-child(2) {
            width: 35%; /* Tên */
            text-align: left;
        }

        table th:nth-child(3),
        table td:nth-child(3) {
            width: 25%; /* Đơn giá */
            text-align: right;
        }

        table th:nth-child(4),
        table td:nth-child(4) {
            width: 6%; /* Số lượng */
            text-align: right;
        }

        table th:nth-child(5),
        table td:nth-child(5) {
            width: 26%; /* Thành tiền */
            text-align: right;
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
	            padding: 8px 15px;
	            background-color: #3498db;
	            color: white;
	            border: none;
	            border-radius: 4px;
	            cursor: pointer;
	        }
        button:hover {
            background-color: #2980b9;
        }
        
        /* Giữ header đứng yên khi cuộn */
		.table-wrapper th {
		 	margin: 0; 
		  	border-bottom: 1px solid #ccc;
		    position: sticky;
		    top: 0;
		    background-color: #f2f2f2; /* Màu nền để không bị trong suốt khi cuộn */
		    z-index: 2; /* đảm bảo header nằm trên các dòng khác */
		    box-shadow: 0 2px 2px rgba(0,0,0,1);
		}
		
		/* 🔹 Navbar cố định trên cùng */
		.navbar {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 40px;
		    background-color: #3498db;
		    color: white;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 0 20px; 
		    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		    z-index: 1000;
		}
		
		/* Tiêu đề bên trái */
		.navbar-title {
		    font-size: 20px;
		    font-weight: bold;
		}
		
		/* Phần "Xin chào, username" bên phải */
		.navbar-user {
		    font-size: 16px;
		    margin-right: 50px;
		}
		
		/* Để nội dung không bị navbar che mất */
		body {
		    margin: 0;
		    padding-top: 60px; /* đẩy phần nội dung xuống dưới navbar */
		    font-family: Arial, sans-serif;
		    background-color: #f6f8fa;
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

<div class="container">
    <h2>CHI TIẾT HÓA ĐƠN</h2>

    <div class="info-row three-cols">
        <div class="info-group"><p><strong>Mã hóa đơn:</strong> ${invoice.id}</p></div>
        <div class="info-group"><p><strong>Thời gian lập:</strong> <fmt:formatDate value="${invoice.createdTime}" pattern="HH:mm:ss dd-MM-yyyy"/></p></div>
        <div class="info-group"><p><strong>Nhân viên bán hàng:</strong> ${invoice.saleStaff.fullname}</p></div>
    </div>

    <div class="section-title">Thông tin khách hàng</div>
    <div class="info-row four-cols">
        <div class="info-group"><p><strong>Họ và tên:</strong> ${invoice.customer.fullname}</p></div>
        <div class="info-group"><p><strong>Biển số xe:</strong> ${invoice.licensePlate}</p></div>
        <div class="info-group"><p><strong>SĐT:</strong> ${invoice.customer.phoneNumber}</p></div>
        <div class="info-group"><p><strong>Email:</strong> ${invoice.customer.email}</p></div>
    </div>

    <!-- Danh sách song song -->
    <div class="lists">
        <!-- Dịch vụ -->
        <div class="list-box">
            <div class="section-title">Danh sách dịch vụ</div>
            <c:choose>
                <c:when test="${fn:length(invoice.serviceList) > 4}">
                    <div class="table-wrapper">
                        <table>
                            <tr>
                                <th>STT</th>
                                <th>Tên</th>
                                <th>Đơn giá</th>
                                <th>SL</th>
                                <th>Thành tiền</th>
                            </tr>
                            <c:forEach var="service" items="${invoice.serviceList}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${service.service.name}</td>
                                    <td><fmt:formatNumber value="${service.salePrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                    <td>${service.quantity}</td>
                                    <td><fmt:formatNumber value="${service.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Đơn giá</th>
                            <th>SL</th>
                            <th>Thành tiền</th>
                        </tr>
                        <c:forEach var="service" items="${invoice.serviceList}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${service.service.name}</td>
                                <td><fmt:formatNumber value="${service.salePrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                <td>${service.quantity}</td>
                                <td><fmt:formatNumber value="${service.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
            <div class="total-row">
                Tổng: <fmt:formatNumber value="${invoice.servicePrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
            </div>
        </div>

        <!-- Phụ tùng -->
        <div class="list-box">
            <div class="section-title">Danh sách phụ tùng</div>
            <c:choose>
                <c:when test="${fn:length(invoice.sparePartList) > 4}">
                    <div class="table-wrapper">
                        <table>
                            <tr>
                                <th>STT</th>
                                <th>Tên</th>
                                <th>Đơn giá</th>
                                <th>SL</th>
                                <th>Thành tiền</th>
                            </tr>
                            <c:forEach var="sparePart" items="${invoice.sparePartList}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${sparePart.sparePart.name}</td>
                                    <td><fmt:formatNumber value="${sparePart.salePrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                    <td>${sparePart.quantity}</td>
                                    <td><fmt:formatNumber value="${sparePart.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Đơn giá</th>
                            <th>SL</th>
                            <th>Thành tiền</th>
                        </tr>
                        <c:forEach var="sparePart" items="${invoice.sparePartList}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${sparePart.sparePart.name}</td>
                                <td><fmt:formatNumber value="${sparePart.salePrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                                <td>${sparePart.quantity}</td>
                                <td><fmt:formatNumber value="${sparePart.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
            <div class="total-row">
                Tổng: <fmt:formatNumber value="${invoice.sparePartPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
            </div>
        </div>
    </div>

    <div class="total-row">Tổng hóa đơn: <fmt:formatNumber value="${invoice.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</div>
    <div class="total-row">
	    Trạng thái thanh toán:
	    <c:choose>
	        <c:when test="${invoice.status == 'PAID'}">
	            Đã thanh toán
	        </c:when>
	        <c:otherwise>
	            ${invoice.status}
	        </c:otherwise>
	    </c:choose>
	</div>

    <div class="button-group">
        <button onclick="window.history.back()">Trở lại</button>
        <button onclick="window.location.href='customerMainView.jsp'">Thoát</button>
    </div>
</div>
</body>
</html>
