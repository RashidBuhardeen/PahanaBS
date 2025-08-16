<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pahana Edu | Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>

<div class="login-container">
    <h2>Login</h2>

    <!-- Error message from LoginController -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="<%= request.getContextPath() %>/login" method="post">
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
