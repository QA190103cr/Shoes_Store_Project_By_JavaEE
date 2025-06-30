<%-- 
    Document   : index
    Created on : Jun 15, 2025, 3:51:52 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NIKE - Sign In</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .login-box {
                background: white;
                padding: 40px;
                width: 320px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .login-box h2 {
                text-align: center;
                margin-bottom: 25px;
            }

            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 12px;
                margin: 8px 0 20px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                width: 100%;
                background: black;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
            }

            .error {
                color: red;
                text-align: center;
                margin-bottom: 10px;
            }

            .register-link {
                text-align: center;
                margin-top: 15px;
            }

            .register-link a {
                text-decoration: none;
                color: blue;
            }
        </style>
    </head>
    <body>
        <form class="login-box" action="${pageContext.request.contextPath}/doLogin" method="post">
            <h2>Login</h2>

            <!-- Nếu có lỗi login thì hiển thị -->
            <% if (request.getAttribute("error") != null) {%>
            <p class="error"><%= request.getAttribute("error")%></p>
            <% }%>

            <input 
                type="email" 
                name="email" 
                placeholder="Email" 
                required 
                pattern="^[a-zA-Z0-9._%+-]+@gmail\.com$"
                title="Email must be a valid Gmail address"
                />
            <input type="password" name="password" placeholder="Password" required />
            <button type="submit">Sign In</button>

            <div class="register-link">
                <p>Don't have an account? <a href="<c:url value='/register' />">Register here</a></p>
            </div>
        </form>
    </body>
</html>
