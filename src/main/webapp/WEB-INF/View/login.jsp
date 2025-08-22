<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pahana Edu | Login</title>
</head>
<style>
/* Body */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

/* Login container */
.login-container {
    background-color: #fff;
    padding: 40px 50px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 400px;
    text-align: center;
    box-sizing: border-box;
}

/* Heading */
.login-container h2 {
    margin-bottom: 25px;
    color: #222;
}

/* Error message */
.error {
    color: #d32f2f;
    background-color: #ffdede;
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-size: 14px;
    width: 100%;
    box-sizing: border-box;
}

/* Form */
.form-group {
    margin-bottom: 20px;
    width: 100%;
}

.form-group label {
    display: block;
    margin-bottom: 6px;
    font-weight: bold;
    text-align: left;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
    box-sizing: border-box;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-group input:focus {
    border-color: #ff9800;
    box-shadow: 0 0 5px rgba(255,152,0,0.5);
    outline: none;
}

/* Button */
.btn {
    width: 100%;
    padding: 12px;
    background-color: #ff9800;
    color: #fff;
    font-size: 16px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s;
    box-sizing: border-box;
}

.btn:hover {
    background-color: #e68900;
}

/* Responsive */
@media (max-width: 480px) {
    .login-container {
        padding: 30px 20px;
    }
}
</style>

<body>

<div class="login-container">
    <h2>Login</h2>

    <!-- Error message from LoginController -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username"
                   value="${param.username}" required />
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required />
        </div>

        <button type="submit" class="btn">Login</button>
    </form>
</div>


</body>
</html>
