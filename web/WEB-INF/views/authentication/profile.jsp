<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Profile</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                padding: 40px;
            }
            .box {
                background: white;
                padding: 30px;
                width: 500px;
                margin: auto;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
            }
            .field {
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .label {
                font-weight: bold;
                width: 120px;
            }
            .value {
                flex: 1;
            }
            .field form {
                flex: 1;
                display: none;
            }
            .field input,
            .field select {
                width: 100%;
                padding: 6px;
            }
            button {
                margin-left: 10px;
                padding: 6px 10px;
            }
            .success {
                color: green;
                text-align: center;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>

        <div class="box">
            <h2>Profile</h2>

            <c:if test="${not empty success}">
                <p class="success">${success}</p>
            </c:if>

            <!-- Full Name -->
            <div class="field">
                <label class="label">Full Name:</label>
                <span id="fullNameText" class="value">${user.fullName}</span>
                <form id="fullNameForm" action="updateFullName" method="post">
                    <input type="text" name="fullName" value="${user.fullName}" required />
                    <button type="submit">Save</button>
                    <button type="button" onclick="hideEdit('fullName')">Cancel</button>
                </form>
                <button onclick="showEdit('fullName')">Edit</button>
            </div>

            <!-- Phone Number -->
            <div class="field">
                <label class="label">Phone Number:</label>
                <span id="phoneNumberText" class="value">${user.phoneNumber}</span>
                <form id="phoneNumberForm" action="updatePhoneNumber" method="post">
                    <input type="text" name="phoneNumber" value="${user.phoneNumber}" />
                    <button type="submit">Save</button>
                    <button type="button" onclick="hideEdit('phoneNumber')">Cancel</button>
                </form>
                <button onclick="showEdit('phoneNumber')">Edit</button>
            </div>

            <!-- Gender -->
            <div class="field">
                <label class="label">Gender:</label>
                <span id="genderText" class="value">${user.gender}</span>
                <form id="genderForm" action="updateGender" method="post">
                    <select name="gender">
                        <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                    <button type="submit">Save</button>
                    <button type="button" onclick="hideEdit('gender')">Cancel</button>
                </form>
                <button onclick="showEdit('gender')">Edit</button>
            </div>

            <!-- Date of Birth -->
            <div class="field">
                <label class="label">Date of Birth:</label>
                <span id="dateOfBirthText" class="value">
                    <fmt:formatDate value="${user.dateOfBirth}" pattern="yyyy-MM-dd"/>
                </span>
                <form id="dateOfBirthForm" action="updateDateOfBirth" method="post">
                    <input type="date" name="dateOfBirth"
                           value="<fmt:formatDate value='${user.dateOfBirth}' pattern='yyyy-MM-dd'/>" />
                    <button type="submit">Save</button>
                    <button type="button" onclick="hideEdit('dateOfBirth')">Cancel</button>
                </form>
                <button onclick="showEdit('dateOfBirth')">Edit</button>
            </div>

        </div>

        <script>
            function showEdit(field) {
                document.getElementById(field + "Text").style.display = "none";
                document.getElementById(field + "Form").style.display = "flex";
            }

            function hideEdit(field) {
                document.getElementById(field + "Text").style.display = "inline";
                document.getElementById(field + "Form").style.display = "none";
            }
        </script>

    </body>
</html>
