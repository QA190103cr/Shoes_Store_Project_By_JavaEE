<%-- 
    Document   : create
    Created on : Jun 17, 2025, 2:25:55 PM
    Author     : ASUS
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .main-container {
        text-align: center
    }

    .form-container {
        max-width: 450px;
        margin: 30px auto;
        padding: 20px;
        background: #f9f9f9;
        border-radius: 10px;
        font-family: Arial, sans-serif;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .form-container label {
        margin-top: 10px;
        margin-bottom: 4px;
        font-weight: bold;
        display: block;
    }

    .form-container input,
    .form-container select,
    .form-container button {
        padding: 10px;
        font-size: 14px;
        border-radius: 6px;
        border: 1px solid #ccc;
        width: 100%;
        margin-bottom: 15px;
        box-sizing: border-box;
    }

    .form-container button {
        background-color: #2e86de;
        color: white;
        border: none;
        cursor: pointer;
    }

    .form-container button:hover {
        background-color: #1b4f72;
    }
</style>

<main class="main-container">
    <h1>Create New Product Variant</h1>

    <form action="<c:url value='/admin/product_variant/create' />" method="post" class="form-container">
        <input type="hidden" name="productId" value="${productId}" />

        <label for="size">Size</label>
        <input type="text" id="size" name="size" required />

        <label for="color">Color</label>
        <input type="text" id="color" name="color" required />

        <label for="stockQuantity">Stock Quantity</label>
        <input type="number" id="stockQuantity" name="stockQuantity" required />

        <button type="submit">Create</button>
    </form>
</main>