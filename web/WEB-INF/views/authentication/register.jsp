<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>NIKE - Register</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .register-box {
                background: white;
                padding: 40px;
                width: 320px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .register-box h2 {
                text-align: center;
                margin-bottom: 25px;
            }

            input, select {
                width: 100%;
                padding: 12px;
                margin: 8px 0 20px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .dob-group {
                display: flex;
                gap: 5px;
            }

            .dob-group input {
                flex: 1;
            }

            button {
                width: 100%;
                background: black;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
            }

            .error {
                color: red;
                text-align: center;
                margin-bottom: 10px;
            }

            .success {
                color: green;
                text-align: center;
                margin-bottom: 10px;
            }

            .login-link {
                text-align: center;
            }

            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }

            .field-error {
                color: red;
                font-size: 12px;
                margin-top: -15px;
                margin-bottom: 15px;
                display: block;
            }
        </style>
    </head>
    <body>

        <form class="register-box" action="${pageContext.request.contextPath}/doRegister" method="post" id="registerForm">
            <h2>Đăng Ký</h2>

            <!-- Hiển thị thành công nếu có -->
            <c:if test="${not empty message}">
                <p class="success">${message}</p>
            </c:if>

            <!-- Email -->
            <label>Email*</label>
            <input type="email" name="email" id="email" placeholder="Email" required />
            <span class="field-error"><c:out value="${emailError}" /></span>

            <!-- Password -->
            <label>Password*</label>
            <input type="password" name="password" id="password" placeholder="Mật khẩu" required />

            <!-- Confirm Password -->
            <label>Confirm Password*</label>
            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Xác nhận mật khẩu" required />
            <span class="field-error"><c:out value="${passwordError}" /></span>

            <!-- Họ tên -->
            <label>Full Name*</label>
            <input type="text" name="fullName" placeholder="Họ tên" required />

            <!-- Số điện thoại -->
            <label>Phone*</label>
            <input type="text" name="phone" placeholder="Số điện thoại" required />

            <!-- Shopping Preference -->
            <label>Shopping Preference*</label>
            <select name="gender" required>
                <option value="">-- Select --</option>
                <option value="male">Men's</option>
                <option value="female">Women's</option>
                <option value="other">Other</option>
            </select>

            <!-- Date of Birth -->
            <label>Date of Birth</label>
            <div class="dob-group">
                <input type="number" name="day" id="day" placeholder="Day*" min="1" required />
                <input type="number" name="month" id="month" placeholder="Month*" min="1" required />
                <input type="number" name="year" id="year" placeholder="Year*" min="1900" required />
            </div>

            <button type="submit">Register</button>

            <div class="login-link">
                <p>Have an account? <a href="<c:url value='/login' />">Login</a></p>
            </div>

        </form>

        <!-- JavaScript: kiểm soát DOB + Email + Confirm Password khi bấm Register -->
        <script>
            const dayInput = document.getElementById('day');
            const monthInput = document.getElementById('month');
            const yearInput = document.getElementById('year');

            const today = new Date();
            const currentYear = today.getFullYear();
            const currentMonth = today.getMonth() + 1;
            const currentDay = today.getDate();

            function handleMaxAndFocus(input, getMax, nextInput) {
                input.addEventListener('input', () => {
                    let val = parseInt(input.value) || '';
                    const max = getMax();
                    if (val > max) {
                        input.value = max;
                        if (nextInput) {
                            nextInput.focus();
                        }
                    } else {
                        if (input.value.length >= 2 && nextInput) {
                            nextInput.focus();
                        }
                    }
                });
            }

            function getMaxYear() {
                return currentYear;
            }

            function getMaxMonth() {
                let y = parseInt(yearInput.value) || 0;
                return (y === currentYear) ? currentMonth : 12;
            }

            function getMaxDay() {
                let y = parseInt(yearInput.value) || 0;
                let m = parseInt(monthInput.value) || 0;

                if (y === currentYear && m === currentMonth) {
                    return currentDay;
                }

                if (m >= 1 && m <= 12) {
                    return new Date(y || 2000, m, 0).getDate();
                }
                return 31;
            }

            handleMaxAndFocus(dayInput, getMaxDay, monthInput);
            handleMaxAndFocus(monthInput, getMaxMonth, yearInput);
            handleMaxAndFocus(yearInput, getMaxYear, null);
        </script>

    </body>
</html>
