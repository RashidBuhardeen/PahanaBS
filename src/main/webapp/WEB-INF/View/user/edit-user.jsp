<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Edit User</h2>

    <form action="user" method="post">
        <input type="hidden" name="action" value="updateUser" />

        <div class="form-group">
            <label>User ID:</label>
            <input type="text" name="id" value="${user.id}" readonly />
        </div>

        <div class="form-group">
            <label>Username:</label>
            <input type="text" name="username" value="${user.username}" required />
        </div>

        <div class="form-group">
            <label>Password:</label>
            <input type="password" name="password" value="${user.password}" required />
        </div>

        <div class="form-group">
            <label>Role:</label>
            <select name="role" required>
                <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                <option value="CASHIER" ${user.role == 'CASHIER' ? 'selected' : ''}>Cashier</option>
                <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>User</option>
            </select>
        </div>

        <button type="submit" class="btn">Update User</button>
        <button type="button" class="btnc" onclick="this.form.reset(); history.back();">Cancel</button>
    </form>
</div>

<style>
/* Body and container */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding-top: 60px; /* avoid hiding under navbar */
    color: #222;
}

.container {
    max-width: 600px;
    margin: 30px auto;
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Heading */
.container h2 {
    color: #222;
    margin-bottom: 25px;
    text-align: center;
}

/* Form groups */
.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 6px;
    font-weight: bold;
    color: #222;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-group input:focus,
.form-group select:focus {
    border-color: #ff9800;
    box-shadow: 0 0 5px rgba(255, 152, 0, 0.5);
    outline: none;
}

.form-group input[readonly] {
    background-color: #f0f0f0;
    cursor: not-allowed;
}

/* Button */
.btn {
    background-color: #ff9800;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #e68900;
}

/* Button c */
.btnc {
    background-color: #201c16;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

.btnc:hover {
    background-color: #483f32;
}

/* Responsive */
@media (max-width: 600px) {
    .container {
        padding: 20px;
    }
}
</style>
