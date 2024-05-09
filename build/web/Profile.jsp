<%-- 
    Document   : profile
    Created on : Feb 27, 2024, 9:40:11 PM
    Author     : FPTSHOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            position: relative;
        }

        h1 {
            color: #333;
            text-align: center;
            border-bottom: 2px solid #ccc;
            padding-bottom: 10px;
        }

        .customer-info {
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 10px;
            position: relative;
        }

        .customer-info p {
            margin: 10px 0;
        }

        a {
            display: inline-block;
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #45a049;
        }

        .container::before {
            content: "";
            background: url('background.jpg') center/cover no-repeat fixed;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: -1;
            opacity: 0.5;
            animation: backgroundAnimation 30s infinite linear;
        }

    </style>

    <body>
        <div class="container">
            <h1>Thông tin của bạn:</h1>
            <div class="customer-info">
                <p><strong>Tên:</strong> </p>
                <p><strong>SĐT:</strong> </p>
                <p><strong>Địa chỉ nhà:</strong> </p>
                <a href="updateprofile.jsp">Update Profile</a>
            </div>
        </div> 


    </body>
</html>