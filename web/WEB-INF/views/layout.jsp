<%@ page import="entities.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
    <a href="../../../../Basic/web/WEB-INF/jsp/index.jsp"></a>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <title>Shoes Store</title>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
            padding: 0;
            margin: 0;
            overflow-y: auto;
            overflow-x: hidden;
            min-height: 100%;
            background-color: #f9f9f9;
        }

        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 40px;
            background-color: black;
            border-bottom: 1px solid #e0e0e0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .title {
            text-align: center;
            padding: 20px 0;
            font-size: 2rem;
            color: #333;
            background-color: #ffffff;
            margin: 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .navbar a {
            margin-right: 20px;
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .navbar a::after {
            content: "";
            position: absolute;
            width: 0;
            height: 2px;
            left: 0;
            bottom: -4px;
            background-color: #fff;
            transition: width 0.3s ease;
        }

        .navbar a:hover {
            color: #007bff;
        }

        .auth-button a {
            text-decoration: none;
        }

        .auth-button a {
            text-decoration: none;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            font-weight: 500;
            color: white;
        }

        .user-avatar {
            height: 40px;
            width: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ccc;
        }

        .user {
            position: relative;
            display: inline-block;
        }

        .user-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            min-width: 180px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            z-index: 1000;
            list-style: none;
            padding: 0;
            margin: 10px 0 0 0;
            border-radius: 6px;
        }

        .user-menu li {
            padding: 12px 16px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.2s ease;
        }

        .user-menu li:hover {
            background-color: #f8f9fa;
        }

        .login-btn {
            background-color: #ffffff;
            color: #007bff;
            padding: 8px 16px;
            font-size: 15px;
            border: 2px solid #007bff;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background-color: #007bff;
            color: white;
        }

        .main-container {
            min-height: 70vh;
            /*padding: 30px 40px;*/
            background-color: #fff;
        }

        footer {
            text-align: center;
            padding: 15px 0;
            background-color: #f1f1f1;
            color: #666;
            font-size: 14px;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <!--Header-->
    <h1 class="title"><i class="fas fa-shoe-prints"></i> Shoes Store</h1>
    <div class="header-bar">
        <div class="navbar">
            <a href="<c:url value="/" />" >Home</a>
            <a href="<c:url value="/products/products" />" >Product</a>
        </div>

        <div class="auth-button" id="auth-btn">
            <%
                User user = (User) session.getAttribute("currentUser");
                if (user != null) {
            %>
            <div class="user">
                <div class="user-info">
                    <%= user.getFullName()%>
                    <img src="<c:url value='/imgs/avatars' />/<%= user.getAvatar()%>" alt="Avatar" class="user-avatar"/>
                </div>

                <ul class="user-menu">
                    <li class="menu-item">
                        <a href="<c:url value="/profile" />" >Information</a>
                    </li>

                    <%
                        if ("admin".equals(user.getRole())) {
                    %>

                    <li class="menu-item">
                        <a href="<c:url value="/admin/product" />" >Product Management</a>
                    </li>
                    
                    <li class="menu-item">
                        <a href="<c:url value="/admin/category" />" >Category Management</a>
                    </li>
                    
                    <li class="menu-item">
                        <a href="<c:url value="/admin/brand" />" >Brand Management</a>
                    </li>

                    <li class="menu-item">
                        <a >User Management</a>
                    </li>

                    <%
                        }
                    %>

                    <li class="menu-item">
                        <a href="<c:url value='/logout' />">Logout</a>
                    </li>
                </ul>
            </div>

            <%
            } else {
            %>
            <button class="login-btn"><a href="<c:url value="/login" />">Login</a></button>
            <%
                }
            %>
        </div>
    </div>

    <!--View-->
    <div class="main-container">
        <jsp:include page="/WEB-INF/views/${folder}/${view}.jsp" />
    </div>

    <!--Footer-->
    <footer>
        &copy; 2025 HSU | Designed by You
    </footer>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>

<script>
    // Toggle dropdown
    $('.user-info').click(function (e) {
        e.stopPropagation();
        $('.user-menu').slideToggle(200);
    });

// Đóng menu nếu click ra ngoài
    $(document).click(function (e) {
        if (!$(e.target).closest('.user').length) {
            $('.user-menu').slideUp(200);
        }
    });

    $(document).ready(function () {
        $('.menu-item').click(function () {
            $(this).find('a')[0].click();
        });
    });

    $(document).ready(function () {
        $('.login-btn').click(function () {
            $(this).find('a')[0].click();
        });
    });
</script>