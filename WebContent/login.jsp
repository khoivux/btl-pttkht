<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f4f6f8; }
        .box { width:360px; margin:120px auto; background:white; padding:20px; border-radius:6px; box-shadow:0 2px 8px rgba(0,0,0,0.1);} 
        h2{ text-align:center; margin-bottom:16px }
        label{ display:block; margin-top:8px }
        input[type=text], input[type=password]{ width:100%; padding:8px; margin-top:4px; box-sizing:border-box }
        .actions{ margin-top:12px; display:flex; gap:8px }
        button{ flex:1; padding:10px; background:#3498db; color:white; border:none; border-radius:4px; cursor:pointer }
        .error{ color:#c0392b; text-align:center; margin-bottom:8px }
    </style>
</head>
<body>
    <div class="box">
        <h2>Đăng nhập hệ thống</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="login" method="post">
            <label for="username">Tên đăng nhập</label>
            <input id="username" name="username" type="text" required />

            <label for="password">Mật khẩu</label>
            <input id="password" name="password" type="password" required />

            <div class="actions">
                <button type="submit">Đăng nhập</button>
            </div>
        </form>
    </div>
</body>
</html>
