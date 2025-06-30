<%-- 
    Document   : delete
    Created on : Jun 17, 2025, 2:26:03 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .main-container {
        max-width: 500px;
        margin: 80px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        text-align: center;
    }

    .main-container h1 {
        font-size: 24px;
        margin-bottom: 20px;
        color: #e74c3c;
    }

    .main-container form {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .main-container form p {
        font-size: 18px;
        color: #333;
    }

    .main-container button {
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .main-container button[name="op"][value="yes"] {
        background-color: #e74c3c;
        color: white;
    }

    .main-container button[name="op"][value="yes"]:hover {
        background-color: #c0392b;
    }

    .main-container button[name="op"][value="no"] {
        background-color: #bdc3c7;
        color: #2c3e50;
    }

    .main-container button[name="op"][value="no"]:hover {
        background-color: #95a5a6;
    }

</style>

<main class="main-container">
    <h1>Delete Product Variant</h1>

    <form action="<c:url value="/admin/product_variant/delete" />" method="post">
        Are you sure to delete the product variant with id = ${id}?
        <input type="hidden" name="id" value="${id}" />
        <input type="hidden" name="productId" value="${productId}" />
        <button type="submit" name="op" value="yes">Yes</button>
        <button type="submit" name="op" value="no">No</button>
    </form>
</main>
