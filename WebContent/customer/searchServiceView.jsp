<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm thông tin dịch vụ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f6f8fa;
        }
        h2 {
        padding-top: 20px;
            text-align: center;
            color: #2c3e50;
        }
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 8px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 4px;
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
        a {
            text-decoration: none;
            color: inherit;
            cursor: pointer;
        }
        a:hover {
            text-decoration: underline;
        }

        /* ✅ Khung chứa bảng để có scrollbar */
        .table-container {
            width: 70%;
            margin: 0 auto;
            max-height: 515px;      /* Giới hạn chiều cao */
            overflow-y: auto;       /* Tự động hiện scrollbar */
            border: 1px solid #ccc;
            border-radius: 4px;
            background: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px 12px;
            text-align: left;
        }

        /* ✅ Header cố định khi cuộn */
        th {
            background-color: #3498db;
            color: white;
            position: sticky;
            top: 0;
            z-index: 2;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .back-btn {
            background-color: #95a5a6;
            margin-left: 10px;
        }
        .back-btn:hover {
            background-color: #7f8c8d;
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
		
    </style>
    <script>
        function showServiceDetail(index) {
            document.getElementById('detailForm' + index).submit();
        }
    </script>
</head>
<body>
  <div class="navbar">
	    <div class="navbar-user">
	        Xin chào, <strong>${user.fullname}</strong>
	    </div>
	</div>

    <h2>TÌM KIẾM THÔNG TIN DỊCH VỤ</h2>

    <form action="service" method="get">
        <input type="hidden" name="action" value="search">
        <input type="text" name="keyword" placeholder="Nhập tên dịch vụ..." value="${keyword}">
        <button type="submit">Tìm kiếm</button>
        <button type="button" class="back-btn" onclick="window.location.href='customerMainView.jsp'">Trở lại</button>
    </form>

    <c:if test="${not empty services}">
        <!-- ✅ Bảng có scrollbar -->
        <div class="table-container">
            <table>
                <tr>
                    <th>Số thứ tự</th>
                    <th>Tên dịch vụ</th>
                    <th>Giá</th>
                    <th>Hành động</th>
                </tr>

                <c:forEach var="service" items="${services}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>
                            <a href="serviceDetail?id=${service.id}">${service.name}</a>
                        </td>
                        <td>
                            <fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
                        </td>
                        <td>
                            <button type="button"
                                    onclick="window.location.href='serviceDetail?id=${service.id}'">
                                Xem chi tiết
                            </button>
                        </td>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </c:if>

    <c:if test="${empty services}">
        <p style="text-align:center; color:red;">
            Không tìm thấy dịch vụ nào phù hợp với từ khóa "<b>${keyword}</b>".
        </p>
    </c:if>

</body>
</html>
