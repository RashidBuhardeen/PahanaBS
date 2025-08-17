<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
  <style>
/* Reset and body styling */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f4f4f9;
    color: #333;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Container */
.container {
    text-align: center;
    background: #fff;
    padding: 50px 40px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    max-width: 500px;
    width: 90%;
}

/* Heading */
h1 {
    font-size: 28px;
    margin-bottom: 20px;
}

/* Paragraph */
p {
    font-size: 16px;
    margin-bottom: 30px;
    color: #555;
}

/* Buttons */
a {
    display: inline-block;
    margin: 10px;
    padding: 12px 25px;
    text-decoration: none;
    background: #007BFF;
    color: #fff;
    font-size: 16px;
    border-radius: 8px;
    transition: background 0.3s, transform 0.2s;
    min-width: 120px;
}

a:hover {
    background: #0056b3;
    transform: translateY(-2px);
}

/* Responsive */
@media (max-width: 480px) {
    .container {
        padding: 30px 20px;
    }
    h1 {
        font-size: 24px;
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
        <h1>Welcome to Our Web Application</h1>

        <a href="login?action=login">Login</a>
    </div>
</body>
</html>
