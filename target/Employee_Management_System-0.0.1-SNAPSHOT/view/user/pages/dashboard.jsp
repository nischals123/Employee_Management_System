<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page session="true" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Dashboard - Employee Management System</title>
        <style>
        /* Basic Layout */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
        }

        /* Sidebar Styling */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            width: 220px;
            background-color: #003366;
            color: white;	
            
        }
        

        .sidebar a {
            display: block;
            color: white;
            padding: 14px ;
            font-size: 15px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #002244;
        }

		.topbar{
		margin-top:0;
		}
        
        .dashboard-container {
            display: flex;
            
        }

        .main-content {
            margin-left: 220px; /* Sidebar space */
          
            width: 100%;
        }

        .dashboard-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .user-avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #004080;
        }

        .greeting {
            font-size: 26px;
            font-weight: 700;
            color: #004080;
        }

        .subtext {
            font-size: 15px;
            color: #666;
        }

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 24px;
            border-radius: 14px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .card i {
            color: #004080;
            font-size: 30px;
            margin-bottom: 10px;
        }

        .card h2 {
            font-size: 20px;
            margin-bottom: 5px;
            color: #222;
        }

        .card p {
            font-size: 15px;
            color: #555;
        }

        /* Quick Actions */
        .dashboard-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            min-width: 220px;
            background: #004080;
            color: white;
            padding: 16px;
            border-radius: 10px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: center;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #003366;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }

            .main-content {
                margin-left: 0;
                padding: 10px;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .dashboard-stats {
                grid-template-columns: 1fr;
            }

            .user-link {
                min-width: 100%;
            }
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body class="dashboard-body">
    <c:if test="${empty sessionScope.user}">
        <c:redirect url="../../login.jsp"/>
    </c:if>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <%@ include file="../includes/sidebar.jsp" %>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Top Navigation -->
            <%@ include file="../includes/topnav.jsp" %>

            <div class="dashboard-content">
                <!-- User Dashboard Content -->
                <section class="user-dashboard" aria-label="User Dashboard Overview">
                    <!-- User Header -->
                    <div class="dashboard-header">
                        <!-- <img src="https://randomuser.me/api/portraits/men/75.jpg" alt="User Profile Picture" class="user-avatar" /> -->
                        <div>
                            <h1 class="greeting">
                                Welcome back,
                                <c:out value="${sessionScope.user.name}" default="User" />
                            </h1>
                            <p class="subtext">Your performance and activity summary for this month.</p>
                        </div>
                    </div>

                    <!-- Summary Cards -->
                    <section class="dashboard-stats" aria-label="User Summary Stats">
                        <article class="card" aria-label="Attendance Summary">
                            <i class="fas fa-calendar-check fa-2x"></i>
                            <div>
                                <h2>Attendance</h2>
                                <p>22 / 30 Days</p>
                            </div>
                        </article>

                        <article class="card" role="group" aria-label="Tasks Summary">
                            <i class="fas fa-tasks fa-2x"></i>
                            <div>
                                <h2>Tasks</h2>
                                <p>3 Pending</p>
                            </div>
                        </article>

                        <article class="card" role="group" aria-label="Leave Summary">
                            <i class="fas fa-envelope-open-text fa-2x"></i>
                            <div>
                                <h2>Leaves</h2>
                                <p>2 Approved</p>
                            </div>
                        </article>
                    </section>

                    <!-- Quick Actions -->
                    <section class="dashboard-actions" aria-label="Quick Access Actions">
                        <a href="${pageContext.request.contextPath}/user/attendance" class="btn">
                            <i class="fas fa-calendar-day"></i> Mark Attendance
                        </a>
                        <a href="${pageContext.request.contextPath}/user/leave-request" class="btn">
                            <i class="fas fa-paper-plane"></i> Apply Leave
                        </a>
                        <a href="${pageContext.request.contextPath}/get-all-tasks-for-user" class="btn">
                            <i class="fas fa-clipboard-list"></i> View Tasks
                        </a>
                        <a href="${pageContext.request.contextPath}/user/profile" class="btn">
                            <i class="fas fa-user-circle"></i> View Profile
                        </a>
                    </section>
                </section>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile sidebar toggle
            const menuToggle = document.querySelector('.menu-toggle');
            const sidebar = document.querySelector('.sidebar');

            if (menuToggle) {
                menuToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('active');
                });
            }

            // Current date display for topnav if needed
            const dateElement = document.getElementById('current-date');
            if (dateElement) {
                const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                const today = new Date();
                dateElement.textContent = today.toLocaleDateString('en-US', options);
            }
        });
    </script>
</body>
</html>
