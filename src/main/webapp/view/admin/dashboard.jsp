<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body class="dashboard-body">

    <!-- Redirect if not logged in -->
    <c:if test="${empty sessionScope.user}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <div class="dashboard-container">
        <%@ include file="/view/admin/includes/sidebar.jsp" %>

        <main class="main-content">
            <%@ include file="/view/admin/includes/topnav.jsp" %>

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

                <!-- Recent Activity & My Tasks -->
                <div class="dashboard-grid">
                    <!-- Recent Activity -->
                    <div class="dashboard-card">
                        <div class="card-header"><h2>Recent Activity</h2></div>
                        <div class="card-body">
                            <ul class="activity-list">
                                <li class="activity-item">
                                    <div class="activity-icon green"><i class="fas fa-user-plus"></i></div>
                                    <div class="activity-details">
                                        <p>New employee kp oli joined</p>
                                        <span class="activity-time">2 hours ago</span>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon blue"><i class="fas fa-project-diagram"></i></div>
                                    <div class="activity-details">
                                        <p>Project "Website Redesign" created</p>
                                        <span class="activity-time">Yesterday</span>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon orange"><i class="fas fa-calendar-check"></i></div>
                                    <div class="activity-details">
                                        <p>sher badhurdeuba marked attendance</p>
                                        <span class="activity-time">Yesterday</span>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon red"><i class="fas fa-calendar-minus"></i></div>
                                    <div class="activity-details">
                                        <p>prachanda requested leave</p>
                                        <span class="activity-time">2 days ago</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- My Tasks -->
                    <div class="dashboard-card">
                        <div class="card-header"><h2>My Tasks</h2></div>
                        <div class="card-body">
                            <ul class="task-list">
                                <li class="task-item">
                                    <div class="task-checkbox"><input type="checkbox" id="task1"><label for="task1"></label></div>
                                    <div class="task-details">
                                        <h4>Complete project proposal</h4><p>Due: Today</p>
                                    </div>
                                    <div class="task-priority high">High</div>
                                </li>
                                <li class="task-item">
                                    <div class="task-checkbox"><input type="checkbox" id="task2"><label for="task2"></label></div>
                                    <div class="task-details">
                                        <h4>Review employee performance</h4><p>Due: Tomorrow</p>
                                    </div>
                                    <div class="task-priority medium">Medium</div>
                                </li>
                                <li class="task-item">
                                    <div class="task-checkbox"><input type="checkbox" id="task3"><label for="task3"></label></div>
                                    <div class="task-details">
                                        <h4>Schedule team meeting</h4><p>Due: 3 days</p>
                                    </div>
                                    <div class="task-priority low">Low</div>
                                </li>
                                <li class="task-item">
                                    <div class="task-checkbox"><input type="checkbox" id="task4" checked><label for="task4"></label></div>
                                    <div class="task-details completed">
                                        <h4>Update department budget</h4><p>Completed</p>
                                    </div>
                                    <div class="task-priority medium">Medium</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Department Overview -->
                <div class="dashboard-card full-width">
                    <div class="card-header"><h2>Department Overview</h2></div>
                    <div class="card-body">
                        <div class="department-grid">
                            <div class="department-card">
                                <div class="department-icon"><i class="fas fa-laptop-code"></i></div>
                                <h3>Computer Science</h3>
                                <p>32 Employees</p>
                                <div class="department-stats"><span>5 Projects</span><span>2 Employee</span></div>
                            </div>
                            <div class="department-card">
                                <div class="department-icon"><i class="fas fa-bolt"></i></div>
                                <h3>Electrical</h3>
                                <p>28 Employees</p>
                                <div class="department-stats"><span>4 Projects</span><span>2 Employee</span></div>
                            </div>
                            <div class="department-card">
                                <div class="department-icon"><i class="fas fa-cogs"></i></div>
                                <h3>Mechanical</h3>
                                <p>25 Employees</p>
                                <div class="department-stats"><span>3 Projects</span><span>1 Employee</span></div>
                            </div>
                            <div class="department-card">
                                <div class="department-icon"><i class="fas fa-hard-hat"></i></div>
                                <h3>Civil</h3>
                                <p>30 Employees</p>
                                <div class="department-stats"><span>2 Projects</span><span>2 Employee</span></div>
                            </div>
                            <div class="department-card">
                                <div class="department-icon"><i class="fas fa-users"></i></div>
                                <h3>Human Resources</h3>
                                <p>10 Employees</p>
                                <div class="department-stats"><span>1 Project</span><span>1 Employee</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End of Dashboard Content -->
        </main>
    </div>
</body>
</html>
