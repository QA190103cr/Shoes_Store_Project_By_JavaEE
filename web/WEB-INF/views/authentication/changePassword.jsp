<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đổi Mật Khẩu</title>
        <style>
            html, body {
                height: 100%;
                margin: 0;
                background: #f0f2f5;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .container {
                background: #fff;
                padding: 40px 30px;
                width: 100%;
                max-width: 400px;
                border-radius: 10px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
            }

            input[type="password"] {
                width: 100%;
                padding: 12px 15px;
                margin: 10px 0 20px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                transition: 0.3s;
                box-sizing: border-box;
            }

            input[type="password"]:focus {
                border-color: #555;
                outline: none;
            }

            button {
                width: 100%;
                padding: 12px;
                background: #000;
                color: #fff;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }

            button:hover {
                background: #333;
            }

            .message {
                text-align: center;
                margin-bottom: 15px;
                font-weight: bold;
            }

            .error {
                color: #e74c3c;
            }

            .success {
                color: #2ecc71;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Change Password</h2>

            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="message success">${success}</div>
            </c:if>

            <form action="changePassword" method="post">
                <input type="password" name="currentPassword" placeholder="Current Password" required>
                <input type="password" name="newPassword" placeholder="New Passwordi" required>
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                <button type="submit">Change</button>
            </form>
        </div>
    </body>
</html>
