<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Check if user is logged in --%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<nav>
  <div class="navbar">
    <a href="navigate?action=dashboard" class="brand">Pahana BS</a>

    <!-- Hamburger Menu -->
    <div class="menu-toggle" id="menu-toggle">&#9776;</div>

    <ul class="nav-links" id="nav-links">
      <li><a href="navigate?action=dashboard">Dashboard</a></li>
      <li><a href="navigate?action=customers">Customers</a></li>
      <li><a href="navigate?action=items">Items</a></li>
      <li><a href="navigate?action=bills">Bills</a></li>
      <li><a href="logout?action=logout">Logout</a></li>
    </ul>
  </div>
</nav>

<style>
  /* Reset */
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: Arial, sans-serif;
    padding-top: 60px; /* Avoid content hiding under navbar */
  }

  nav {
    background: #222;
    color: #fff;
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1000;
    box-shadow: 0 2px 5px rgba(0,0,0,0.3);
  }

  .navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 20px;
    max-width: 1200px;
    margin: auto;
  }

  .brand {
    font-size: 22px;
    font-weight: bold;
    color: #fff;
    text-decoration: none;
    letter-spacing: 1px;
  }

  .nav-links {
    list-style: none;
    display: flex;
  }

  .nav-links li {
    margin-left: 20px;
  }

  .nav-links a {
    text-decoration: none;
    color: #fff;
    font-size: 16px;
    transition: color 0.3s ease;
  }

  .nav-links a:hover {
    color: #ff9800;
  }

  /* Hamburger button (hidden on desktop) */
  .menu-toggle {
    display: none;
    font-size: 26px;
    cursor: pointer;
  }

  /* Responsive (mobile) */
  @media (max-width: 768px) {
    .menu-toggle {
      display: block;
    }

    .nav-links {
      position: absolute;
      top: 60px;
      right: 0;
      width: 200px;
      height: auto;
      background: #333;
      flex-direction: column;
      display: none;
      padding: 15px 0;
      box-shadow: 0 4px 6px rgba(0,0,0,0.4);
    }

    .nav-links li {
      margin: 15px 0;
      text-align: center;
    }

    .nav-links.active {
      display: flex;
    }
  }
</style>

<script>
  // Toggle mobile menu
  const menuToggle = document.getElementById("menu-toggle");
  const navLinks = document.getElementById("nav-links");

  menuToggle.addEventListener("click", () => {
    navLinks.classList.toggle("active");
  });
</script>

