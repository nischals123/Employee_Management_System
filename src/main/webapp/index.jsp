<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.group7.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect("dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>EMS - Employee Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!--  Navbar -->
    <header class="navbar">
        <div class="navbar-container">
            <div class="logo">Employee Management System</div>
            <nav class="nav-links">
                <a href="login.jsp" class="nav-btn">Login</a>
                <a href="register.jsp" class="nav-btn outline">Register</a>
            </nav>
        </div>
    </header>

    <!--  Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>Welcome to the Employee Management System</h1>
            <p>
                Streamline your workforce management with EMS. From employee data to department roles, attendance, salary tracking, and reports — everything simplified and centralized.
            </p>
            <div class="cta-buttons">
                <a href="login.jsp" class="btn primary">Login</a>
                <a href="register.jsp" class="btn secondary">Register</a>
            </div>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="why-section" id="why-us">
        <h2>Why Choose EMS?</h2>
        <div class="features">
            <div class="feature-box">
                <img src="images/secure.svg" alt="Secure">
                <h3>Secure & Reliable</h3>
                <p>Protected with enterprise-grade encryption and strict access control policies.</p>
            </div>
            <div class="feature-box">
                <img src="images/easy.svg" alt="User Friendly">
                <h3>User-Friendly</h3>
                <p>Clean and intuitive interface for both admins and employees to use with ease.</p>
            </div>
            <div class="feature-box">
                <img src="images/analytics.svg" alt="Analytics">
                <h3>Powerful Insights</h3>
                <p>Real-time reports and dashboards to make informed HR and payroll decisions.</p>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="about-section" id="about">
        <div class="about-content">
            <h2>About Us</h2>
            <p>
                EMS is developed by a passionate group of developers from Group 7: Samir, Nischal (Leader), Debina, and Muksam.
                Our mission is to digitalize and streamline HR processes in organizations by leveraging modern technologies
                for better efficiency, accuracy, and transparency.
            </p>
        </div>
    </section>

    <!-- Footer -->
    <footer class="site-footer">
        <div class="footer-container">
            <p>&copy; 2025 EMS - Employee Management System</p>
            <p>Crafted with ❤️ by Team Group 7</p>
        </div>
    </footer>

</body>
</html>
