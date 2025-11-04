<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ quản lý</title>
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

        select {
            width: 250px;
            padding: 12px;
            font-size: 16px;
            border: 2px solid #3498db;
            border-radius: 8px;
            background-color: white;
            color: #2c3e50;
            cursor: pointer;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%233498db' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            padding-right: 32px;
        }

        select:hover {
            border-color: #2980b9;
            box-shadow: 0 0 8px rgba(52, 152, 219, 0.3);
        }

        .submit-btn {
            margin-top: 20px;
            padding: 12px 24px;
            font-size: 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #2980b9;
            transform: scale(1.03);
        }
    </style>
</head>
<body>
    <h1>Trang chủ quản lý</h1>
    <form action="customerStat" method="get">
        <select name="action" onchange="this.form.submit()">
            <option value="" disabled selected>Menu Báo cáo</option>
            <option value="customerStat">Thống kê khách hàng theo doanh thu</option>
        </select>
    </form>
</body>
</html>
