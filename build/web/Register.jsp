<%-- 
    Document   : register.jsp
    Created on : Mar 7, 2024, 11:01:04 PM
    Author     : FPTSHOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
    <title>Đăng ký tài khoản</title>
</head>
<body>
    <form action="register" method="post">
        <h3 class="error-message">${requestScope.error}</h3>
        <label for="customerName">Tên của bạn:</label>
        <input type="text" id="customerName" name="customerName" required><br>
        <label for="customerPhone">Số điện thoại:</label>
        <input type="text" id="customerPhone" name="customerPhone" required><br>
        <label for="customerAddress">Địa chỉ:</label>
        <input type="text" id="customerAddress" name="customerAddress" required><br>  
        <input type="hidden" name="userID" value="5">
        <label for="userName">Tên đăng nhập:</label>
        <input type="text" id="userName" name="userName" required><br>
        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required><br>
        <input type="hidden" name="role" value="Customer">
        <input type="submit" value="Register">
    </form>
</body>
</body>
</html>