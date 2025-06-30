<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* Container chính */
    .main-container {
        width: 100%;
        max-width: 600px;
        margin: 40px auto;
        padding: 24px;
        background: #ffffff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        font-family: 'Segoe UI', sans-serif;
    }

    /* Tiêu đề */
    .main-container h1 {
        font-size: 24px;
        margin-bottom: 20px;
        text-align: center;
        color: #333;
    }

    /* Nhãn */
    label {
        display: block;
        font-weight: 600;
        margin-top: 16px;
        margin-bottom: 6px;
        color: #444;
    }

    /* Input & select */
    input[type="text"],
    input[type="number"],
    input[type="file"],
    select {
        width: 100%;
        padding: 10px 12px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        transition: border 0.2s;
    }

    input:focus,
    select:focus {
        border-color: #3f51b5;
        outline: none;
    }

    /* Ảnh preview */
    img {
        margin-top: 10px;
        max-width: 100%;
        height: auto;
        border-radius: 4px;
    }

    /* Nút submit */
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
        transition: background 0.2s;
    }

    button:hover {
        background-color: #303f9f;
    }
</style>

<main class="main-container">
    <h1>Update Category</h1>

    <form action="<c:url value='/admin/category/edit' />" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category.id}" />

        <label>Name</label>
        <input type="text" name="name" value="${category.name}" required />

        <label>Description</label>
        <input type="text" name="description" value="${category.description}" />
        
        <br /><br />
        <button type="submit">Submit</button>
    </form>
</main>
