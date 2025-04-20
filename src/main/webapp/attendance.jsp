<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for attendance page */
        .attendance-actions {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .attendance-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .attendance-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-present {
            background-color: #e3f9e5;
            color: #2ecc71;
        }
        
        .status-absent {
            background-color: #fde8e8;
            color: #e74c3c;
        }
        
        .status-late {
            background-color: #fef5e7;
            color: #f39c12;
        }
        
        .status-half-day {
            background-color: #e7f3fe;
            color: #3498db;
        }
        
        .time-display {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin: 20px 0;
            color: #2c3e50;
        }
        
        .date-filter {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .date-filter input[type="date"] {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
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
                    <li>
                        <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
                    </li>
                    <li>
                        <a href="employees.jsp"><i class="fas fa-users"></i> Employees</a>
                    </li>
                    <li>
                        <a href="departments.jsp"><i class="fas fa-building"></i> Departments</a>
                    </li>
                    <li class="active">
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

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <header class="content-header">
                <div class="header-left">
                    <h1><i class="fas fa-calendar-check"></i> Attendance</h1>
                </div>
                <div class="header-right">
                    <div class="notification-bell">
                        <i class="far fa-bell"></i>
                        <span class="notification-count">3</span>
                    </div>
                </div>
            </header>

            <!-- Attendance Content -->
            <div class="dashboard-content">
                <!-- Current Time Display -->
                <div class="attendance-card">
                    <div class="time-display" id="current-time">
                        <!-- Time will be displayed here via JavaScript -->
                    </div>
                    
                    <div class="attendance-actions">
                        <button class="btn btn-primary" id="check-in-btn">
                            <i class="fas fa-sign-in-alt"></i> Check In
                        </button>
                        <button class="btn btn-secondary" id="check-out-btn" disabled>
                            <i class="fas fa-sign-out-alt"></i> Check Out
                        </button>
                    </div>
                    
                    <div id="attendance-status-message">
                        <!-- Status message will appear here -->
                    </div>
                </div>
                
                <!-- Attendance History -->
                <div class="content-section">
                    <div class="section-header">
                        <h2>My Attendance History</h2>
                        
                        <div class="date-filter">
                            <label for="month-filter">Filter by Month:</label>
                            <input type="month" id="month-filter" name="month-filter">
                            <button class="btn btn-sm" id="filter-btn">Apply</button>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Check In</th>
                                    <th>Check Out</th>
                                    <th>Working Hours</th>
                                    <th>Status</th>
                                    <th>Notes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Sample data - would be replaced with actual data from database -->
                                <tr>
                                    <td>2023-07-01</td>
                                    <td>09:00 AM</td>
                                    <td>05:30 PM</td>
                                    <td>8.5 hours</td>
                                    <td><span class="attendance-status status-present">Present</span></td>
                                    <td>-</td>
                                </tr>
                                <tr>
                                    <td>2023-07-02</td>
                                    <td>09:15 AM</td>
                                    <td>05:45 PM</td>
                                    <td>8.5 hours</td>
                                    <td><span class="attendance-status status-late">Late</span></td>
                                    <td>Traffic delay</td>
                                </tr>
                                <tr>
                                    <td>2023-07-03</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td><span class="attendance-status status-absent">Absent</span></td>
                                    <td>Sick leave</td>
                                </tr>
                                <tr>
                                    <td>2023-07-04</td>
                                    <td>09:00 AM</td>
                                    <td>01:30 PM</td>
                                    <td>4.5 hours</td>
                                    <td><span class="attendance-status status-half-day">Half Day</span></td>
                                    <td>Doctor's appointment</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Department Attendance (visible only to managers) -->
                <c:if test="${sessionScope.user.role.name eq 'Manager' or sessionScope.user.role.name eq 'Admin'}">
                    <div class="content-section">
                        <div class="section-header">
                            <h2>Department Attendance</h2>
                            
                            <div class="date-filter">
                                <label for="date-filter">Select Date:</label>
                                <input type="date" id="date-filter" name="date-filter">
                                <button class="btn btn-sm" id="dept-filter-btn">Apply</button>
                            </div>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Employee</th>
                                        <th>Check In</th>
                                        <th>Check Out</th>
                                        <th>Working Hours</th>
                                        <th>Status</th>
                                        <th>Notes</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Sample data - would be replaced with actual data from database -->
                                    <tr>
                                        <td>
                                            <div class="employee-name">
                                                <div class="employee-avatar">
                                                    <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="John Doe">
                                                </div>
                                                <span>Kp oli</span>
                                            </div>
                                        </td>
                                        <td>09:00 AM</td>
                                        <td>05:30 PM</td>
                                        <td>8.5 hours</td>
                                        <td><span class="attendance-status status-present">Present</span></td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="employee-name">
                                                <div class="employee-avatar">
                                                    <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Jane Smith">
                                                </div>
                                                <span>sher badhurdeuba</span>
                                            </div>
                                        </td>
                                        <td>09:15 AM</td>
                                        <td>05:45 PM</td>
                                        <td>8.5 hours</td>
                                        <td><span class="attendance-status status-late">Late</span></td>
                                        <td>Traffic delay</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="employee-name">
                                                <div class="employee-avatar">
                                                    <img src="https://randomuser.me/api/portraits/men/67.jpg" alt="Mike Johnson">
                                                </div>
                                                <span>Prachanda</span>
                                            </div>
                                        </td>
                                        <td>-</td>
                                        <td>-</td>
                                        <td>-</td>
                                        <td><span class="attendance-status status-absent">Absent</span></td>
                                        <td>Sick leave</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <!-- JavaScript for Attendance Page -->
    <script>
        // Display current time
        function updateTime() {
            const timeDisplay = document.getElementById('current-time');
            const now = new Date();
            const options = { 
                hour: '2-digit', 
                minute: '2-digit', 
                second: '2-digit',
                hour12: true
            };
            timeDisplay.textContent = now.toLocaleTimeString('en-US', options);
        }
        
        // Update time every second
        updateTime();
        setInterval(updateTime, 1000);
        
        // Check-in button functionality
        document.getElementById('check-in-btn').addEventListener('click', function() {
            // In a real application, this would send an AJAX request to the server
            this.disabled = true;
            document.getElementById('check-out-btn').disabled = false;
            
            const statusMessage = document.getElementById('attendance-status-message');
            const now = new Date();
            const options = { 
                hour: '2-digit', 
                minute: '2-digit',
                hour12: true
            };
            const timeString = now.toLocaleTimeString('en-US', options);
            
            statusMessage.innerHTML = `
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> 
                    Successfully checked in at ${timeString}
                </div>
            `;
        });
        
        // Check-out button functionality
        document.getElementById('check-out-btn').addEventListener('click', function() {
            // In a real application, this would send an AJAX request to the server
            this.disabled = true;
            document.getElementById('check-in-btn').disabled = true;
            
            const statusMessage = document.getElementById('attendance-status-message');
            const now = new Date();
            const options = { 
                hour: '2-digit', 
                minute: '2-digit',
                hour12: true
            };
            const timeString = now.toLocaleTimeString('en-US', options);
            
            statusMessage.innerHTML = `
                <div class="alert alert-info">
                    <i class="fas fa-check-circle"></i> 
                    Successfully checked out at ${timeString}
                </div>
            `;
        });
    </script>
</body>
</html>
