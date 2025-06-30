<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .main-container {
        width: 100%;
        max-width: 500px;
        margin: 40px auto;
        padding: 24px;
        background: #ffffff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        font-family: 'Segoe UI', sans-serif;
    }

    .main-container h1 {
        font-size: 22px;
        margin-bottom: 20px;
        text-align: center;
        color: #333;
    }

    label {
        display: block;
        font-weight: 600;
        margin-top: 16px;
        margin-bottom: 6px;
        color: #444;
    }

    input[type="text"],
    input[type="number"] {
        width: 100%;
        padding: 10px 12px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
    }

    button {
        width: 100%;
        margin-top: 24px;
        padding: 10px 12px;
        font-size: 16px;
        background-color: #3f51b5;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
    }

    button:hover {
        background-color: #303f9f;
    }

    .product-name {
        font-style: italic;
        color: #777;
        font-size: 14px;
        margin-bottom: 10px;
    }
</style>

<main class="main-container">
    <h1>Update Product Variant</h1>

    <p class="product-name">Product: ${product.name}</p>

    <form action="<c:url value='/admin/product_variant/edit' />" method="post">
        <input type="hidden" name="id" value="${productVariant.id}" />
        <input type="hidden" name="productId" value="${productId}" />

        <label for="size">Size</label>
        <input type="text" id="size" name="size" value="${productVariant.size}" required />

        <label for="color">Color</label>
        <input type="text" id="color" name="color" value="${productVariant.color}" required />

        <label for="stockQuantity">Stock Quantity</label>
        <input type="number" id="stockQuantity" name="stockQuantity" value="${productVariant.stockQuantity}" required />

        <button type="submit">Update</button>
    </form>

    <c:if test="${not empty error}">
        <div style="color: red; font-weight: bold;">${error}</div>
    </c:if>
</main>
