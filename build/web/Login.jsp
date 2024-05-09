<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }

            .login-container {
                max-width: 400px;
                margin: 0 auto;
                margin-top: 100px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            }
            .card-head{
                margin-top: 20px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="card">
                <div class="card-head">
                    <h2>Đăng Nhập</h2>
                </div>
                <div class="card-body">
                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                    <%
                        }
                    %>
                    <form action="login1" method="post">
                        <div class="form-group">
                            <label for="username">Nhập Tài Khoản</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Nhập Mật Khẩu</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" name="submit" class="btn btn-primary btn-block">Đăng Nhập</button>
                    </form>
                    <div class="text-center mt-3">
                        Chưa Có Tài Khoản ? <a href="Register.jsp">Đăng Ký</a>
                    </div>
                    
                    <div class="text-center mt-3">
                        <a href="#">Quên Mật Khẩu</a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>