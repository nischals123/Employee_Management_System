<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="dashboard-body">

    <!-- Check if user is logged in -->
    <c:if test="${empty sessionScope.user}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <div class="dashboard-container">
        <!-- Sidebar Navigation -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>EMS</h2>
            </div>
            
            <div class="user-profile">
                <div class="user-avatar">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.picturePath}">
                            <img src="${sessionScope.user.picturePath}" alt="${sessionScope.user.name}">
                        </c:when>
                        <c:otherwise>
                            <div class="avatar-placeholder">
                                ${fn:substring(sessionScope.user.name, 0, 1)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="user-info">
                    <h3>${sessionScope.user.name}</h3>
                    <p>${sessionScope.user.role.name}</p>
                </div>
            </div>
            
            <nav class="sidebar-nav">
                <ul>
                    <li class="active">
                        <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
                    </li>
                    <li>
                        <a href="employees.jsp"><i class="fas fa-users"></i> Employees</a>
                    </li>
                    <li>
                        <a href="departments.jsp"><i class="fas fa-building"></i> Departments</a>
                    </li>
                    <li>
                        <a href="attendance.jsp"><i class="fas fa-calendar-check"></i> Attendance</a>
                    </li>
                    <li>
                        <a href="leave-requests.jsp"><i class="fas fa-calendar-minus"></i> Leave Requests</a>
                    </li>
                    <li>
                        <a href="projects.jsp"><i class="fas fa-project-diagram"></i> Projects</a>
                    </li>
                    <li>
                        <a href="tasks.jsp"><i class="fas fa-tasks"></i> Tasks</a>
                    </li>
                    <li>
                        <a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a>
                    </li>
                    <li>
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content Area -->
        <main class="main-content">
            <header class="content-header">
                <div class="header-left">
                    <h1>Dashboard</h1>
                </div>
                <div class="header-right">
                    <div class="date-time">
                        <span id="current-date"></span>
                    </div>
                    <div class="notifications">
                        <i class="fas fa-bell"></i>
                        <span class="notification-count">3</span>
                    </div>
                </div>
            </header>

            <!-- Dashboard Content -->
            <div class="dashboard-content">
                <!-- Stats Cards -->
                <div class="stats-cards">
                    <div class="stat-card">
                        <div class="stat-card-icon blue">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-card-info">
                            <h3>Total Employees</h3>
                            <p class="stat-number">125</p>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-card-icon green">
                            <i class="fas fa-building"></i>
                        </div>
                        <div class="stat-card-info">
                            <h3>Departments</h3>
                            <p class="stat-number">5</p>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-card-icon orange">
                            <i class="fas fa-project-diagram"></i>
                        </div>
                        <div class="stat-card-info">
                            <h3>Active Projects</h3>
                            <p class="stat-number">12</p>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-card-icon red">
                            <i class="fas fa-calendar-minus"></i>
                        </div>
                        <div class="stat-card-info">
                            <h3>Leave Requests</h3>
                            <p class="stat-number">8</p>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity and Tasks -->
                <div class="dashboard-grid">
                    <!-- Recent Activity -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h2>Recent Activity</h2>
                        </div>
                        <div class="card-body">
                            <ul class="activity-list">
                                <li class="activity-item">
                                    <div class="activity-icon green">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p>New employee John Doe joined</p>
                                        <span class="activity-time">2 hours ago</span>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon blue">
                                        <i class="fas fa-project-diagram"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p>Project "Website Redesign" created</p>
                                        <span class="activity-time">Yesterday</span>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon orange">
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p>Sarah Johnson marked attendance</p>
                                        <span class="activity-time">Yesterday</span>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon red">
                                        <i class="fas fa-calendar-minus"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p>Mike Smith requested leave</p>
                                        <span class="activity-time">2 days ago</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- My Tasks -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h2>My Tasks</h2>
                        </div>
                        <div class="card-body">
                            <ul class="task-list">
                                <li class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task1">
                                        <label for="task1"></label>
                                    </div>
                                    <div class="task-details">
                                        <h4>Complete project proposal</h4>
                                        <p>Due: Today</p>
                                    </div>
                                    <div class="task-priority high">
                                        High
                                    </div>
                                </li>
                                <li class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task2">
                                        <label for="task2"></label>
                                    </div>
                                    <div class="task-details">
                                        <h4>Review employee performance</h4>
                                        <p>Due: Tomorrow</p>
                                    </div>
                                    <div class="task-priority medium">
                                        Medium
                                    </div>
                                </li>
                                <li class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task3">
                                        <label for="task3"></label>
                                    </div>
                                    <div class="task-details">
                                        <h4>Schedule team meeting</h4>
                                        <p>Due: 3 days</p>
                                    </div>
                                    <div class="task-priority low">
                                        Low
                                    </div>
                                </li>
                                <li class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task4" checked>
                                        <label for="task4"></label>
                                    </div>
                                    <div class="task-details completed">
                                        <h4>Update department budget</h4>
                                        <p>Completed</p>
                                    </div>
                                    <div class="task-priority medium">
                                        Medium
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Department Overview -->
                <div class="dashboard-card full-width">
                    <div class="card-header">
                        <h2>Department Overview</h2>
                    </div>
                    <div class="card-body">
                        <div class="department-grid">
                            <div class="department-card">
                                <div class="department-icon">
                                    <i class="fas fa-laptop-code"></i>
                                </div>
                                <h3>Computer Science</h3>
                                <p>32 Employees</p>
                                <div class="department-stats">
                                    <span>5 Projects</span>
                                    <span>2 Managers</span>
                                </div>
                            </div>
                            
                            <div class="department-card">
                                <div class="department-icon">
                                    <i class="fas fa-bolt"></i>
                                </div>
                                <h3>Electrical</h3>
                                <p>28 Employees</p>
                                <div class="department-stats">
                                    <span>4 Projects</span>
                                    <span>2 Managers</span>
                                </div>
                            </div>
                            
                            <div class="department-card">
                                <div class="department-icon">
                                    <i class="fas fa-cogs"></i>
                                </div>
                                <h3>Mechanical</h3>
                                <p>25 Employees</p>
                                <div class="department-stats">
                                    <span>3 Projects</span>
                                    <span>1 Manager</span>
                                </div>
                            </div>
                            
                            <div class="department-card">
                                <div class="department-icon">
                                    <i class="fas fa-hard-hat"></i>
                                </div>
                                <h3>Civil</h3>
                                <p>30 Employees</p>
                                <div class="department-stats">
                                    <span>2 Projects</span>
                                    <span>2 Managers</span>
                                </div>
                            </div>
                            
                            <div class="department-card">
                                <div class="department-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h3>Human Resources</h3>
                                <p>10 Employees</p>
                                <div class="department-stats">
                                    <span>1 Project</span>
                                    <span>1 Manager</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Display current date
        document.addEventListener('DOMContentLoaded', function() {
            const dateElement = document.getElementById('current-date');
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const today = new Date();
            dateElement.textContent = today.toLocaleDateString('en-US', options);
        });
    </script>
</body>
</html>
