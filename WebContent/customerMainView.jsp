<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ khách hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        h1 {
            color: #2c3e50;
            margin-bottom: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 250px;
        }

        .button-container form {
            width: 100%;
            margin-bottom: 20px; /* ← tạo khoảng cách giữa 2 nút */
        }

        button {
            width: 100%;
            padding: 15px 0;
            font-size: 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
            transform: scale(1.03);
        }
    </style>
</head>
<body>

    <h1>Trang chủ khách hàng</h1>

    <div class="button-container">
        <!-- Nút tìm kiếm dịch vụ -->
        <form action="service" method="get">
            <button type="submit">🔧 Tìm kiếm dịch vụ</button>
        </form>

        <!-- Nút tìm kiếm phụ tùng -->
        <form action="sparepart" method="get">
            <button type="submit">⚙️ Tìm kiếm phụ tùng</button>
        </form>
    </div>

</body>
</html>
