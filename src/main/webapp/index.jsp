<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Pahana Edu Bookshop</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9fafb;
            color: #333;
        }
        header {
            background-color: #2c3e50;
            padding: 15px 30px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        header .logo {
            font-size: 1.8em;
            font-weight: bold;
            letter-spacing: 2px;
            cursor: default;
        }
        nav {
            display: flex;
            gap: 20px;
        }
        nav a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            padding: 8px 15px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        nav a:hover {
            background-color: #1abc9c;
        }
        nav .login-btn {
            background-color: #1abc9c;
            font-weight: bold;
        }
        nav .login-btn:hover {
            background-color: #16a085;
        }
        .hero {
            background: url('images/bookshop-hero.jpg') no-repeat center center/cover;
            height: 400px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-shadow: 1px 1px 6px rgba(0,0,0,0.7);
            text-align: center;
            padding: 0 20px;
        }
        .hero h1 {
            font-size: 3em;
            margin: 0;
        }
        .hero p {
            font-size: 1.3em;
            margin-top: 10px;
        }
        .content {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .content h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-weight: 700;
        }
        .categories {
            display: flex;
            gap: 25px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .category-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            width: 220px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
            cursor: default;
        }
        .category-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .category-card img {
            width: 100%;
            height: 140px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .category-card h3 {
            margin: 0;
            color: #1abc9c;
            font-weight: 700;
        }
        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 18px 20px;
            margin-top: 60px;
            font-size: 0.9em;
        }
        @media(max-width: 650px) {
            .categories {
                flex-direction: column;
                align-items: center;
            }
            .category-card {
                width: 90%;
            }
            .hero h1 {
                font-size: 2em;
            }
        }
    </style>
</head>
<body>

<header>
    <div class="logo">Pahana Edu Bookshop</div>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="#books">Books</a>
        <a href="#about">About</a>
        <a href="#contact">Contact</a>
        <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
    </nav>
</header>

<section class="hero">
    <div>
        <h1>Your Gateway to Knowledge</h1>
        <p>Discover thousands of books and educational resources at Pahana Edu</p>
    </div>
</section>

<div class="content">
    <h2 id="about">Why Choose Pahana Edu?</h2>
    <p style="text-align:center; max-width:700px; margin: 0 auto 50px auto; line-height:1.6;">
        At Pahana Edu Bookshop, we are committed to providing high-quality educational materials,  
        affordable prices, and exceptional customer service. Whether you’re a student, teacher, or lifelong learner,  
        find the perfect books to enrich your knowledge and fuel your passion for learning.
    </p>

    <h2>Popular Categories</h2>
    <div class="categories">
        <div class="category-card">
            <img src="images/academic-books.jpg" alt="Academic Books" />
            <h3>Academic Books</h3>
            <p>Textbooks and reference materials for all grade levels.</p>
        </div>
        <div class="category-card">
            <img src="images/fiction-books.jpg" alt="Fiction Books" />
            <h3>Fiction</h3>
            <p>Novels, short stories, and literary works for every reader.</p>
        </div>
        <div class="category-card">
            <img src="images/stationery.jpg" alt="Stationery" />
            <h3>Stationery</h3>
            <p>Quality notebooks, pens, and supplies for your study needs.</p>
        </div>
    </div>
</div>

<footer id="contact">
    <p>Contact us: info@pahanaedu.lk | +94 11 234 5678 | Colombo, Sri Lanka</p>
    <p>&copy; 2025 Pahana Edu. All Rights Reserved.</p>
</footer>

</body>
</html>
