<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pahana Book Shop - Admin System</title>
    <style>
/* Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #1e1f29, #2b2c3a); /* dark background */
    color: #fff;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Container */
.container {
    text-align: center;
    background: #fff;
    color: #333;
    padding: 50px 40px;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.25);
    max-width: 520px;
    width: 90%;
    animation: fadeIn 0.8s ease-in-out;
}

/* Animations */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Heading */
h1 {
    font-size: 28px;
    margin-bottom: 10px;
    color: #1e1f29;
}

/* Sub-heading */
p {
    font-size: 15px;
    margin-bottom: 25px;
    color: #555;
    line-height: 1.6;
}

/* Buttons */
a {
    display: inline-block;
    margin: 10px;
    padding: 12px 28px;
    text-decoration: none;
    background: #ffcc00; /* gold highlight */
    color: #1e1f29;
    font-size: 15px;
    font-weight: 600;
    border-radius: 8px;
    transition: background 0.3s, transform 0.2s;
    min-width: 130px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.2);
}

a:hover {
    background: #e6b800;
    transform: translateY(-2px);
}

/* Secondary button */
a.secondary {
    background: #007bff; /* blue accent */
    color: #fff;
    box-shadow: 0 3px 8px rgba(0,123,255,0.3);
}

a.secondary:hover {
    background: #0056b3;
}

/* Responsive */
@media (max-width: 480px) {
    .container {
        padding: 35px 20px;
    }
    h1 {
        font-size: 22px;
    }
    p {
        font-size: 14px;
    }
    a {
        width: 100%;
        margin: 8px 0;
    }
}
    </style>
</head>
<body>
    <div class="container">
        <h1>📖 Pahana Book Shop</h1>
        <p><strong>Management System</strong><br>
           Secure access for manage customers, billing, and inventory.</p>

        <a href="login?action=login">Login</a>
        <a href="help.jsp" class="secondary">Help</a>
    </div>
</body>
</html>
