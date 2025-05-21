<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance - Employee Management System</title>
    <style>
        /* General Layout Styling */
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
            padding: 14px;
            font-size: 15px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #002244;
        }

        /* Dashboard Container */
        .dashboard-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensures the container fills the full viewport height */
        }

        /* Top Navigation */
        .top-nav {
            background-color: #003366;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center; /* Center the content vertically and horizontally */
            padding: 20px;
        }

        /* Attendance Section */
        .attendance-section {
            background: white;
            border-radius: 14px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 800px;
            text-align: center;
            padding: 30px;
        }

        .attendance-section h2 {
            font-size: 26px;
            font-weight: 700;
            color: #004080;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        /* Form Styling */
        .attendance-form {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .attendance-form label {
            font-weight: 600;
            color: #333;
            text-align: left;
        }

        .attendance-form input[type="date"] {
            padding: 12px 14px;
            width: 100%;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
            background-color: #f9f9f9;
            box-sizing: border-box;
        }

        .attendance-form button {
            padding: 16px;
            background: #004080;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .attendance-form button:hover {
            background: #003366;
        }

        /* Message Styling */
        .message {
            font-size: 14px;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .message-success {
            background-color: #28a745;
            color: white;
        }

        .message-error {
            background-color: #dc3545;
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }

            .main-content {
                padding: 10px;
                width: 100%;
                min-height: calc(100vh - 60px);
            }

            .attendance-section {
                padding: 20px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
</head>
<body>
    <div class="dashboard-container">
        <!-- Top Navigation -->
        <div class="top-nav">
            Employee Management System - Attendance
        </div>

        <!-- Sidebar -->
        <%@ include file="../includes/sidebar.jsp" %>

        <!-- Main Content -->
        <main class="main-content">
            <div class="attendance-section">
                <h2><i class="fas fa-calendar-check"></i> Mark Attendance</h2>

                <!-- Display error or success messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="message message-error">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="message message-success">${successMessage}</div>
                </c:if>

                <!-- Attendance Form -->
                <form class="attendance-form" action="${pageContext.request.contextPath}/attendance" method="post">
                    <input type="hidden" name="action" value="markCheckedIn" />
                    <label for="attendanceDate">Select Date</label>
                    <input type="date" name="attendanceDate" id="attendanceDate" required value="${currentDate}" />
                    <button type="submit"><i class="fas fa-check"></i> Check In</button>
                </form>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Set max date to today for attendance
            const dateInput = document.getElementById('attendanceDate');
            if (dateInput) {
                const today = new Date().toISOString().split('T')[0];
                dateInput.setAttribute('max', today);
            }
        });
    </script>
</body>
</html>
