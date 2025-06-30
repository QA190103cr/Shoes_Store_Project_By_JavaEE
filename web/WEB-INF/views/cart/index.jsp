<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Bag</title>
        <style>
            .main-container {
                font-family: Arial, sans-serif;
                width: 100%;
                background: #fff;
                margin: 0;
                padding: 40px;
                display: flex;
                justify-content: space-between;
            }

            .cart-left {
                flex: 2;
            }

            .cart-item {
                display: flex;
                padding: 20px 0;
                border-bottom: 1px solid #eee;
                gap: 20px;
            }

            .cart-item img {
                width: 150px;
                height: 150px;
                object-fit: cover;
                border-radius: 10px;
            }

            .cart-info {
                flex: 1;
            }

            .cart-info h3 {
                margin: 0 0 8px 0;
                font-size: 18px;
            }

            .cart-info p {
                margin: 2px 0;
                color: #666;
            }

            .cart-actions {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-top: 10px;
            }

            .cart-actions form {
                display: inline-block;
            }

            .qty-btn {
                padding: 6px 12px;
                font-size: 16px;
            }

            .remove-btn {
                border: none;
                background: none;
                cursor: pointer;
                font-size: 18px;
            }

            .cart-right {
                flex: 1;
                margin-left: 40px;
                padding: 20px;
            }

            .summary {
                font-size: 16px;
            }

            .summary-total {
                margin-top: 10px;
                font-weight: bold;
                font-size: 18px;
            }

            .checkout-button {
                margin-top: 20px;
                width: 100%;
                background: black;
                color: white;
                padding: 14px;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }

            .back-link {
                margin-top: 20px;
                display: inline-block;
                color: #0056d2;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            .empty-msg {
                color: gray;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <main class="main-container">

            <div class="cart-left">
                <h2>Bag</h2>

                <c:if test="${empty cart}">
                    <p class="empty-msg">Your cart is empty.</p>
                </c:if>

                <c:if test="${not empty cart}">
                    <c:set var="total" value="0" />
                    <c:forEach var="entry" items="${cart}">
                        <c:set var="item" value="${entry.value}" />
                        <c:set var="product" value="${item.product}" />
                        <c:set var="size" value="${item.size}" />
                        <c:set var="color" value="${item.color}" />
                        <c:set var="quantity" value="${item.quantity}" />
                        <c:set var="itemTotal" value="${product.price * quantity}" />
                        <c:set var="total" value="${total + itemTotal}" />

                        <div class="cart-item">
                            <img src="${pageContext.request.contextPath}/imgs/product-images/${product.images}" alt="${product.name}">
                            <div class="cart-info">
                                <h3>${product.name}</h3>
                                <p>
                                    <c:choose>
                                        <c:when test="${product.forGender == 'male'}">Men's Shoes</c:when>
                                        <c:when test="${product.forGender == 'female'}">Women's Shoes</c:when>
                                        <c:otherwise>Unisex Shoes</c:otherwise>
                                    </c:choose>
                                </p>
                                <p>Color: ${color}</p>
                                <p>Size: ${size}</p>
                                <p><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" />₫</p>

                                <div class="cart-actions">
                                    <!-- Xóa -->
                                    <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                                        <input type="hidden" name="productId" value="${product.id}" />
                                        <input type="hidden" name="size" value="${size}" />
                                        <input type="hidden" name="color" value="${color}" />
                                        <button type="submit" class="remove-btn" title="Remove">🗑</button>
                                    </form>

                                    <!-- Giảm -->
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post">
                                        <input type="hidden" name="productId" value="${product.id}" />
                                        <input type="hidden" name="size" value="${size}" />
                                        <input type="hidden" name="color" value="${color}" />
                                        <input type="hidden" name="quantity" value="${quantity - 1}" />
                                        <button type="submit" class="qty-btn">-</button>
                                    </form>

                                    ${quantity}

                                    <!-- Tăng -->
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post">
                                        <input type="hidden" name="productId" value="${product.id}" />
                                        <input type="hidden" name="size" value="${size}" />
                                        <input type="hidden" name="color" value="${color}" />
                                        <input type="hidden" name="quantity" value="${quantity + 1}" />
                                        <button type="submit" class="qty-btn">+</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>

            <div class="cart-right">
                <div class="summary">
                    <p><strong>Subtotal:</strong> <fmt:formatNumber value="${total}" type="currency" currencySymbol="" />₫</p>
                    <p>Estimated Delivery & Handling: <strong>Free</strong></p>
                    <p class="summary-total">Total: <fmt:formatNumber value="${total}" type="currency" currencySymbol="" />₫</p>
                    <button class="checkout-button">Thanh toán</button>
                    <a class="back-link" href="${pageContext.request.contextPath}/products/products">← Tiếp tục mua sắm</a>
                </div>
            </div>
        </main>

    </body>
</html>
