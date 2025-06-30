<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .main-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 30px;
        text-align: center;
    }

    h1 {
        text-align: center;
        margin-bottom: 30px;
        color: #2c3e50;
    }

    .create-wrapper {
        width: 100%;
        max-width: 1200px;
        display: flex;
        justify-content: flex-start;
        margin-bottom: 15px;
    }

    a.create-link {
        display: inline-block;
        margin-bottom: 20px;
        padding: 10px 20px;
        background-color: #3498db;
        color: #fff;
        text-decoration: none;
        border-radius: 6px;
        transition: background-color 0.2s;
    }

    a.create-link:hover {
        background-color: #2980b9;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }

    table th, table td {
        padding: 12px;
        border: 1px solid #ddd;
    }

    table th {
        background-color: #f1f1f1;
        color: #333;
    }

    table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .action-links a {
        margin: 0 5px;
        color: #3498db;
        text-decoration: none;
    }

    .action-links a:hover {
        text-decoration: underline;
        color: #21618c;
    }
</style>

<main class="main-container">
    <h1>Product Variant List</h1>

    <div class="create-wrapper">
        <a href="<c:url value="/admin/product_variant/create?productId=${param.productId}" />" class="create-link">Create</a>
    </div>

    <table border="1" cellspacing="0" cellpadding="4">
        <tr>
            <th>No.</th>
            <th>Id</th>
            <th>Size</th>
            <th>Color</th>
            <th>Stock</th>
            <th>Operations</th>
        </tr>
        <c:forEach var="productVariant" items="${productVariantList}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td>${productVariant.id}</td>
                <td>${productVariant.size}</td>
                <td>${productVariant.color}</td>
                <td>${productVariant.stockQuantity}</td>
                <td class="action-links">
                    <a href="<c:url value="/admin/product_variant/edit?id=${productVariant.id}&productId=${param.productId}" />">Edit</a> | 
                    <a href="<c:url value="/admin/product_variant/delete?id=${productVariant.id}&productId=${param.productId}" />">Delete</a> 
                </td>
            </tr>
        </c:forEach>
    </table>
</main>