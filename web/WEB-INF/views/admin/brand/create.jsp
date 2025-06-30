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
    <h1>Create New Brand</h1>

    <form action="<c:url value='/admin/brand/create' />" method="post" enctype="multipart/form-data" accept-charset="UTF-8" class="form-container">
        <label for="name">Name</label>
        <input type="text" id="name" name="name" required />

        <label for="logo">Logo</label>
        <input type="file" name="imageFile" accept="image/*" required />

        <button type="submit">Create</button>
    </form>
</main>