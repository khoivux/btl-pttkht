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
      
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 15px;
            margin-top: 10px
        }
        .container {
            width: 700px;
            margin: 0 auto;
            background: white;
            padding-top: 10px;
            padding-left: 30px;
            padding-right: 30px;
            padding-bottom: 20px;
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
           /* Căn giữa cột 1 (STT) */
		table th:nth-child(1),
		table td:nth-child(1) {
		    text-align: center;
		}
		
		/* Căn trái cột 2 (Mã hóa đơn) */
		table th:nth-child(2),
		table td:nth-child(2) {
		    text-align: left;
		}
		
		/* Căn giữa cột 3 (Thời gian tạo) */
		table th:nth-child(3),
		table td:nth-child(3) {
		    text-align: center;
		}
		
		/* Căn phải cột 4 (Tổng hóa đơn/Tiền tệ) */
		table th:nth-child(4),
		table td:nth-child(4) {
		    text-align: right;
		}
		table th:nth-child(5),
		table td:nth-child(5) {
		    text-align: center;
		}
		
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
		
		.customer-info {
		    display: flex;
		    justify-content: space-between; /* căn đều 3 cột */
		    align-items: center;
		    margin-bottom: 20px;
		    gap: 20px; /* khoảng cách giữa các mục */
		}
		
		.customer-info p {
		    margin: 0;
		    color: #2c3e50;
		    flex: 1; /* mỗi phần chiếm đều 1/3 hàng */
		    white-space: nowrap; /* không xuống dòng nếu tên dài */
		}
		.section-title.list{
            font-weight: bold;
            margin-top: 0;
            padding-top: 10px;
            border-top: 3px solid #3498db;
           text-align: center; 
        }
        
       /* Khung bao bảng để tạo vùng cuộn */
		.table-container {
			padding: 0;
            max-height: 305px;
            overflow-y: auto;
            margin-top: 0px;
            border: 1px solid #e6e6e6;
            border-radius: 4px;
	
		}
		
		/* Cấu trúc bảng chuẩn */
		.table-container table {
		     width: 100%;
		     
            border-collapse: collapse;
            margin: 0;

		}
		
		/* Dòng và ô */
		th, td {
		    border: 1px solid #ccc;
		    padding: 10px 12px;
		    text-align: left;
		}
		
		/* Header bảng dính trên cùng khi cuộn */
		.table-container th {
		    margin: 0; 
		  	border-bottom: 1px solid #ccc;
		    position: sticky;
		    top: 0;
		    background-color: #f2f2f2; /* Màu nền để không bị trong suốt khi cuộn */
		    z-index: 2; /* đảm bảo header nằm trên các dòng khác */
		    box-shadow: 0 2px 2px rgba(0,0,0,1);
		}

        
    </style>
</head>
<body>
	  <div class="navbar">
	    <div class="navbar-title">Thống kê khách hàng theo doanh thu</div>
	    <div class="navbar-user">
	        Xin chào, <strong>${user.fullname}</strong>
	    </div>
	</div>


    <div class="container">
    	 <h2>CHI TIẾT DOANH THU KHÁCH HÀNG</h2>
    	 <div class="section-title">Thông tin khách hàng</div>
        <div class="customer-info">
            <p><strong>Họ và tên:</strong> ${customer.fullname}</p>
            <p><strong>SĐT:</strong> ${customer.phoneNumber}</p>
            <p><strong>Email:</strong> ${customer.email}</p>
        </div>
		<div class="section-title list">DANH SÁCH HÓA ĐƠN</div>
        <div class="date-info" style="font-weight: normal; font-style: italic; color: #2c3e50;">
		    <c:choose>
		        <c:when test="${not empty startDate and not empty endDate}">
		            <p>Thống kê từ ngày 
		                <fmt:formatDate value="${startDate}" pattern="dd-MM-yyyy"/> 
		                đến ngày 
		                <fmt:formatDate value="${endDate}" pattern="dd-MM-yyyy"/>
		            </p>
		        </c:when>
		        <c:when test="${not empty startDate and empty endDate}">
		            <p>Thống kê từ ngày 
		                <fmt:formatDate value="${startDate}" pattern="dd-MM-yyyy"/>
		            </p>
		        </c:when>
		        <c:when test="${empty startDate and not empty endDate}">
		            <p>Thống kê đến ngày 
		                <fmt:formatDate value="${endDate}" pattern="dd-MM-yyyy"/>
		            </p>
		        </c:when>
		        <c:otherwise>
		            <p>Thống kê tất cả các hóa đơn của khách hàng</p>
		        </c:otherwise>
		    </c:choose>
		</div>

        <c:if test="${not empty invoices}">
		    <div class="table-container">
		        <table>
		            <tr>
		                <th>STT</th>
		                <th>Mã hóa đơn</th>
		                <th>Thời gian tạo</th>
		                <th>Tổng hóa đơn</th>
		                <th>Hành động</th>
		            </tr>
		            <c:forEach var="invoice" items="${invoices}" varStatus="loop">
		                <tr>
		                    <td>${loop.index + 1}</td>
		                    <td>${invoice.id}</td>
		                    <td>
		                        <fmt:formatDate value="${invoice.createdTime}" pattern="HH:mm:ss dd-MM-yyyy"/>
		                    </td>
		                    <td>
		                        <fmt:formatNumber value="${invoice.totalPrice * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
		                    </td>
		                    <td>
		                        <button type="button" onclick="window.location.href='invoiceDetail?id=${invoice.id}&customerId=${customer.id}&startDate=${startDate}&endDate=${endDate}'">Xem chi tiết</button>
		                    </td>
		                </tr>
		            </c:forEach>
		        </table>
		    </div>
		
		    <div class="total-revenue">
		        Tổng doanh thu:
		        <fmt:formatNumber value="${customer.totalRevenue * 1000}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
		    </div>
		</c:if>


        <c:if test="${empty invoices}">
            <p style="text-align:center; color:red;">
                Không có hóa đơn nào trong khoảng thời gian từ ${startDate} đến ${endDate}
            </p>
        </c:if>

        <button class="button" onclick="window.history.back()">Trở lại</button>
    </div>
</body>
</html>