<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
    <head>
        <title>Sản phẩm nổi bật</title>
        <style>
            .container {
                width: 100%;
                padding: 40px 16px 0 16px;
            }

            .title {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 30px;
            }

            .main-container {
                display: flex;
            }

            .filter-container {
                width: 20%;
                display: flex;
                flex-direction: column;
            }

            .filter-container {
                width: 20%;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
                margin-right: 20px;
            }

            .filter-form {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .filter-item {
                font-size: 16px;
                display: block;
                align-items: center;
                gap: 8px;
                margin-bottom: 8px;
            }

            .search-bar {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 24px;
            }

            .search-bar input[type="text"] {
                flex: 1;
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }

            .search-bar button {
                padding: 8px 14px;
                background-color: #0056d2;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }

            .search-bar button:hover {
                background-color: #003f9e;
            }

            .filter-button {
                margin-top: 16px;
                padding: 8px 12px;
                background-color: #0056d2;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
            }

            .filter-button:hover {
                background-color: #003f9e;
            }

            .clear-button {
                margin-top: 16px;
                padding: 8px 12px;
                background-color: #ccc;
                color: black;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                text-decoration: none;
                text-align: center;
                display: inline-block;
            }

            .clear-button:hover {
                background-color: #aaa;
            }

            .product-container {
                width: 80%;
                display: flex;
                flex-wrap: wrap;
                gap: 30px;
                justify-content: start;
            }

            .product-card {
                width: 30%;
                height: 500px;
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
                transition: transform 0.2s ease;
            }

            .product-card:hover {
                transform: translateY(-5px);
            }

            .product-image img {
                width: 100%;
                height: 250px;
                object-fit: cover;
            }

            .product-info {
                padding: 16px;
            }

            .label {
                color: #e74c3c;
                font-size: 14px;
                font-weight: bold;
            }

            .product-name {
                font-size: 18px;
                margin: 8px 0;
                font-weight: bold;
                color: #0056d2;
                text-decoration: none;
                display: inline-block;
            }

            .product-name:hover {
                text-decoration: underline;
            }

            .product-type, .product-color {
                font-size: 14px;
                color: #777;
                margin: 4px 0;
            }

            .product-price {
                font-size: 16px;
                font-weight: bold;
                margin-top: 8px;
            }

            .product-info a {
                color: #0056d2;
                text-decoration: none;
            }

            .product-info a:hover {
                text-decoration: underline;
            }
        </style>
        <script>
            function clearAllFilters() {
                // Uncheck all checkboxes
                const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                checkboxes.forEach(checkbox => {
                    checkbox.checked = false;
                });

                // Redirect to clean URL without parameters
                window.location.href = '${pageContext.request.contextPath}/products/products';
            }
        </script>
    </head>
    <body>
        <div class="container">
            <form method="get" action="<c:url value="/products/products" />" class="search-bar">
                <input type="text" name="search" placeholder="Tìm theo tên sản phẩm" value="${param.search}" />
                <button type="submit">Search</button>
            </form>

            <h2 class="title">Sản phẩm nổi bật</h2>

            <div class="main-container">
                <div class="filter-container">
                    <h2>Filter List</h2>

                    <form method="get" action="<c:url value="/products/products" />" class="filter-form">
                        <h3>Gender</h3>
                        <label class="filter-item">
                            <input type="checkbox" name="gender" value="male"
                                   <c:if test="${fn:contains(paramValues.gender, 'male')}">checked</c:if>> Male
                            </label>

                            <label class="filter-item">
                                <input type="checkbox" name="gender" value="female"
                                <c:if test="${fn:contains(paramValues.gender, 'female')}">checked</c:if>> Female
                            </label>

                            <label class="filter-item">
                                <input type="checkbox" name="gender" value="unisex"
                                <c:if test="${fn:contains(paramValues.gender, 'unisex')}">checked</c:if>> Unisex
                            </label>

                            <h4>Category</h4>
                        <c:forEach var="c" items="${categories}">
                            <label class="filter-item">
                                <input type="checkbox" name="category" value="${c.id}"
                                       <c:if test="${paramValues.category != null && fn:contains(paramValues.category, c.id.toString())}">checked</c:if> />
                                ${c.name}
                            </label>
                        </c:forEach>

                        <h4>Brand</h4>
                        <c:forEach var="b" items="${brands}">
                            <label class="filter-item">
                                <input type="checkbox" name="brand" value="${b.id}"
                                       <c:if test="${paramValues.brand != null && fn:contains(paramValues.brand, b.id.toString())}">checked</c:if> />
                                ${b.name}
                            </label>
                        </c:forEach>

                        <!-- Thay đổi từ input reset thành button với JavaScript -->
                        <button type="button" onclick="clearAllFilters()" class="clear-button">Clear Form</button>
                        <button type="submit" class="filter-button">Apply Filter</button>
                    </form>

                    <!-- Hoặc sử dụng link đơn giản hơn -->
                    <!-- <a href="${pageContext.request.contextPath}/products/products" class="clear-button">Clear All Filters</a> -->
                </div>

                <div class="product-container">
                    <c:forEach var="p" items="${list}">
                        <div class="product-card">
                            <div class="product-image">
                                <a href="${pageContext.request.contextPath}/products/product-detail?id=${p.id}">
                                    <img src="${pageContext.request.contextPath}/imgs/product-images/${p.images}" alt="${p.name}">
                                </a>
                            </div>
                            <div class="product-info">
                                <p class="label">Promo Exclusion</p>

                                <a class="product-name" href="${pageContext.request.contextPath}/products/product-detail?id=${p.id}">
                                    ${p.name}
                                </a>

                                <p class="product-type">
                                    <c:choose>
                                        <c:when test="${p.forGender == 'male'}">Men's Shoes</c:when>
                                        <c:when test="${p.forGender == 'female'}">Women's Shoes</c:when>
                                        <c:otherwise>Unisex Shoes</c:otherwise>
                                    </c:choose>
                                </p>

                                <p class="product-color">1 Colour</p>

                                <p class="product-price">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" />₫
                                </p>

                                <a href="${pageContext.request.contextPath}/products/product-detail?id=${p.id}">
                                    Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </body>
</html>