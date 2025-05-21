<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EMS - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Header & Navigation -->
    <header class="site-header">
        <div class="container">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/view/user/index.jsp">
                    <span class="logo-text">EMS</span>
                    <span class="logo-subtitle">Employee Management System</span>
                </a>
            </div>

            <nav class="main-nav">
                <ul>
                    <li><a href="#features">Features</a></li>
                    <li><a href="#benefits">Benefits</a></li>
                    <li><a href="#about">About</a></li>
                </ul>
            </nav>

            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/view/login.jsp" class="btn btn-login">Login</a>
                <a href="${pageContext.request.contextPath}/view/register.jsp" class="btn btn-register">Register</a>
            </div>

            <button class="mobile-menu-toggle">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="hero-content">
                <h1>Streamline Your <span class="highlight">Workforce Management</span></h1>
                <p>Simplify employee data, attendance tracking, leave management, and project coordination with our comprehensive platform.</p>

                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/view/register.jsp" class="btn btn-primary">Get Started <i class="fas fa-arrow-right"></i></a>
                    <a href="#features" class="btn btn-secondary">Learn More</a>
                </div>

                <div class="hero-stats">
                    <div class="stat">
                        <span class="stat-number">500+</span>
                        <span class="stat-label">Companies</span>
                    </div>
                    <div class="stat">
                        <span class="stat-number">10k+</span>
                        <span class="stat-label">Users</span>
                    </div>
                    <div class="stat">
                        <span class="stat-number">99%</span>
                        <span class="stat-label">Satisfaction</span>
                    </div>
                </div>
            </div>

            <div class="hero-image">
                <img src="${pageContext.request.contextPath}/images/hero-illustration.svg" alt="EMS Dashboard" onerror="this.src='https://cdn.pixabay.com/photo/2017/07/31/11/44/laptop-2557576_1280.jpg'; this.onerror=''">
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section" id="features">
        <div class="container">
            <div class="section-header">
                <h2>Powerful Features</h2>
                <p>Everything you need to manage your workforce efficiently</p>
            </div>

            <div class="features-grid">
                <!-- Features -->
                <div class="feature-card">
                    <div class="feature-icon blue">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>Employee Management</h3>
                    <p>Maintain comprehensive employee profiles with all essential information in one place.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon green">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3>Attendance Tracking</h3>
                    <p>Track employee attendance with check-in/out functionality and generate reports.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon purple">
                        <i class="fas fa-calendar-minus"></i>
                    </div>
                    <h3>Leave Management</h3>
                    <p>Streamline leave requests, approvals, and balance tracking for all employees.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon orange">
                        <i class="fas fa-project-diagram"></i>
                    </div>
                    <h3>Project Management</h3>
                    <p>Assign employees to projects, track progress, and manage deadlines efficiently.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon red">
                        <i class="fas fa-tasks"></i>
                    </div>
                    <h3>Task Assignment</h3>
                    <p>Create, assign, and monitor tasks with priority levels and due dates.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon teal">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3>Reports & Analytics</h3>
                    <p>Generate insightful reports on attendance, performance, and department metrics.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Benefits Section -->
    <section class="benefits-section" id="benefits">
        <div class="container">
            <div class="section-header">
                <h2>Why Choose EMS?</h2>
                <p>Benefits that make our platform stand out</p>
            </div>

            <div class="benefits-container">
                <div class="benefit-image">
                    <img src="${pageContext.request.contextPath}/images/benefits-illustration.svg" alt="EMS Benefits" onerror="this.src='https://cdn.pixabay.com/photo/2017/07/31/11/44/laptop-2557576_1280.jpg'; this.onerror=''">
                </div>

                <div class="benefit-list">
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="benefit-content">
                            <h3>Secure & Reliable</h3>
                            <p>Enterprise-grade security with data encryption and role-based access control.</p>
                        </div>
                    </div>

                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="fas fa-tachometer-alt"></i>
                        </div>
                        <div class="benefit-content">
                            <h3>Improved Efficiency</h3>
                            <p>Automate routine HR tasks and reduce administrative overhead by up to 40%.</p>
                        </div>
                    </div>

                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <div class="benefit-content">
                            <h3>Mobile Responsive</h3>
                            <p>Access the system from any device with our fully responsive design.</p>
                        </div>
                    </div>

                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="fas fa-sync"></i>
                        </div>
                        <div class="benefit-content">
                            <h3>Real-time Updates</h3>
                            <p>Get instant notifications and real-time data updates across the platform.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="about-section" id="about">
        <div class="container">
            <div class="section-header">
                <h2>About Us</h2>
                <p>The team behind the Employee Management System</p>
            </div>

            <div class="about-content">
                <div class="about-text">
                    <p>
                        EMS is developed by a passionate group of developers from Group 7: Samir, Nischal (Leader), Debina, and Muksam.
                        Our mission is to digitalize and streamline HR processes in organizations by leveraging modern technologies
                        for better efficiency, accuracy, and transparency.
                    </p>
                    <p>
                        With a combined experience in software development and HR solutions, our team is dedicated to creating
                        a platform that addresses the real challenges faced by HR departments and employees alike.
                    </p>
                    <div class="about-cta">
                        <a href="${pageContext.request.contextPath}/view/register.jsp" class="btn btn-primary">Join Us Today</a>
                    </div>
                </div>

                <div class="team-grid">
                    <div class="team-member">
                        <div class="member-avatar">
                            <span>N</span>
                        </div>
                        <h4>Nischal</h4>
                        <p>Team Leader</p>
                    </div>

                    <div class="team-member">
                        <div class="member-avatar">
                            <span>S</span>
                        </div>
                        <h4>Samir</h4>
                        <p>Developer</p>
                    </div>

                    <div class="team-member">
                        <div class="member-avatar">
                            <span>D</span>
                        </div>
                        <h4>Debina</h4>
                        <p>Developer</p>
                    </div>

                    <div class="team-member">
                        <div class="member-avatar">
                            <span>M</span>
                        </div>
                        <h4>Muksam</h4>
                        <p>Developer</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="site-footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <h3>EMS</h3>
                    <p>Employee Management System</p>
                </div>

                <div class="footer-links">
                    <div class="footer-column">
                        <h4>Product</h4>
                        <ul>
                            <li><a href="#features">Features</a></li>
                            <li><a href="#benefits">Benefits</a></li>
                            <li><a href="#">Pricing</a></li>
                        </ul>
                    </div>

                    <div class="footer-column">
                        <h4>Company</h4>
                        <ul>
                            <li><a href="#about">About Us</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Careers</a></li>
                        </ul>
                    </div>

                    <div class="footer-column">
                        <h4>Resources</h4>
                        <ul>
                            <li><a href="#">Documentation</a></li>
                            <li><a href="#">Support</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2025 EMS - Employee Management System. All rights reserved.</p>
                <p>Crafted with ❤️ by Team Group 7</p>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const menuToggle = document.querySelector('.mobile-menu-toggle');
            const mainNav = document.querySelector('.main-nav');

            menuToggle.addEventListener('click', function() {
                mainNav.classList.toggle('active');
                this.classList.toggle('active');
            });
        });
    </script>
</body>
</html>
