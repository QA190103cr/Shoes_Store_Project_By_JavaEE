<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Sản phẩm nổi bật</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 100%;
            padding: 40px 16px 0 16px;
        }

        .title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .sort-bar {
            margin-bottom: 30px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
        }

        .sort-bar select {
            padding: 6px 12px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: flex-end;
        }

        .product-card {
            width: 300px;
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
</head>
<body>
<div class="container">
    <h2 class="title">Sản phẩm nổi bật</h2>

    <!-- ✅ Sort bar -->
    <div class="sort-bar">
        <form method="get" action="${pageContext.request.contextPath}/products">
            <label for="sort-select">Sort by:</label>
            <select id="sort-select" name="sort" onchange="this.form.submit()">
                <option value="">-- Select --</option>
                <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Newest</option>
                <option value="oldest" ${param.sort == 'oldest' ? 'selected' : ''}>Oldest</option>
                <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Price: Low to High</option>
                <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Price: High to Low</option>
            </select>
        </form>
    </div>

    <!-- ✅ Product grid -->
    <div class="product-grid" id="product-list">
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
</body>
</html>