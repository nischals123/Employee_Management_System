<%@ page import="dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Attendance - Employee Management System</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        /* Attendance-specific styles */
        .attendance-actions { display: flex; gap: 15px; margin-bottom: 20px; }
        .attendance-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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
        .status-present { background-color: #e3f9e5; color: #2ecc71; }
        .status-absent { background-color: #fde8e8; color: #e74c3c; }
        .status-late { background-color: #fef5e7; color: #f39c12; }
        .status-half-day { background-color: #e7f3fe; color: #3498db; }
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
        .date-filter input[type="date"],
        .date-filter input[type="month"] {0
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        /* Attendance Card Styles */
        .attendance-card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 25px;
            margin-bottom: 30px;
            text-align: center;
        }

        .attendance-card .time-display {
            font-size: 3rem;
            font-weight: bold;
            color: #34495e;
            margin-bottom: 20px;
        }

        .attendance-actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .attendance-actions .btn {
            font-size: 1.1rem;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        .attendance-actions .btn-primary {
            background-color: #3498db;
            color: #fff;
        }

        .attendance-actions .btn-primary:hover {
            background-color: #2980b9;
        }

        .attendance-actions .btn-secondary {
            background-color: #95a5a6;
            color: #fff;
        }

        .attendance-actions .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        #attendance-status-message {
            margin-top: 15px;
            font-size: 1rem;
            color: #2c3e50;
        }

        /* Table Styles */
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
            background-color: #ffffff;
        }

        .data-table th, .data-table td {
            text-align: left;
            padding: 15px;
            font-size: 1rem;
        }

        .data-table th {
            background-color: #34495e;
            color: #ffffff;
            font-weight: 700;
        }

        .data-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .data-table tr:hover {
            background-color: #f1f1f1;
        }

        .data-table td {
            color: #2c3e50;
            font-weight: 500;
        }

        /* Status Badges */
        .attendance-status {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-align: center;
            display: inline-block;
        }

        .status-present {
            background-color: #dff0d8;
            color: #3c763d;
        }

        .status-absent {
            background-color: #f2dede;
            color: #a94442;
        }

        .status-late {
            background-color: #fcf8e3;
            color: #8a6d3b;
        }

        .status-half-day {
            background-color: #d9edf7;
            color: #31708f;
        }

        /* Date Filter Styles */
        .date-filter {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f4f6f9;
            border-radius: 8px;
        }

        .date-filter input[type="date"],
        .date-filter input[type="month"] {
            font-size: 1rem;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #ffffff;
        }

        .date-filter button {
            font-size: 1rem;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            background-color: #3498db;
            color: #fff;
            cursor: pointer;
        }

        .date-filter button:hover {
            background-color: #2980b9;
        }

        /* Department Attendance Table */
        .table-responsive .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .section-header h2 {
            font-size: 1.8rem;
            color: #34495e;
            font-weight: 700;
            margin: 0;
        }

        .employee-name {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .employee-avatar img {
            border-radius: 50%;
            width: 40px;
            height: 40px;
        }

    </style>
</head>
<body class="dashboard-body">

    <c:if test="${empty sessionScope.user}">
        <c:redirect url="../login.jsp"/>
    </c:if>

    <div class="dashboard-container">
        <%@ include file="includes/sidebar.jsp" %>

        <main class="main-content">
            <%@ include file="includes/topnav.jsp" %>

            <!-- Attendance Content -->
            <div class="dashboard-content">
                <div class="attendance-card">
                    <div class="time-display" id="current-time"></div>

                    <div class="attendance-actions">
                        <button class="btn btn-primary" id="check-in-btn">
                            <i class="fas fa-sign-in-alt"></i> Check In
                        </button>
                        <button class="btn btn-secondary" id="check-out-btn" disabled>
                            <i class="fas fa-sign-out-alt"></i> Check Out
                        </button>
                    </div>

                    <div id="attendance-status-message"></div>
                </div>

                <!-- My Attendance History -->
                <div class="content-section">
                    <div class="section-header">
                        <h2>Attendance History</h2>
                        <div class="date-filter">
                            <form action="${pageContext.request.contextPath}/filter-attendance" method="get">
                                <label for="month-filter">Filter by Month:</label>
                                <input type="month" id="month-filter" name="month-filter" required />
                                <button type="submit" class="btn btn-sm">Apply</button>
                            </form>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>User ID</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="attendance" items="${attendanceHistory}">
                                <tr>
                                    <td>${attendance.id}</td>
<%--                                    <td><%UserDAO.getUserById(attendance.userId);%></td>--%>
                                    <td>${UserDAO.getUserNameFromId(attendance.userId)}</td>
                                    <td>
                                        <fmt:formatDate value="${attendance.date}" pattern="yyyy-MM-dd" />
                                    </td>
                                    <td><span class="attendance-status ${attendance.status eq 'Present' ? 'status-present' : attendance.status eq 'Absent' ? 'status-absent' : 'status-late'}">
                                            ${attendance.status}
                                    </span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div   >
        </main>
    </div>

    <!-- JavaScript for Attendance -->
    <script>
        function updateTime() {
            const now = new Date();
            const options = { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
            document.getElementById('current-time').textContent = now.toLocaleTimeString('en-US', options);
        }
        updateTime();
        setInterval(updateTime, 1000);

        document.getElementById('check-in-btn').addEventListener('click', function () {
            this.disabled = true;
            document.getElementById('check-out-btn').disabled = false;
            const time = new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true });
            document.getElementById('attendance-status-message').innerHTML = `
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> Successfully checked in at ${time}</div>`;
        });

        document.getElementById('check-out-btn').addEventListener('click', function () {
            this.disabled = true;
            document.getElementById('check-in-btn').disabled = true;
            const time = new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true });
            document.getElementById('attendance-status-message').innerHTML = `
                <div class="alert alert-info"><i class="fas fa-check-circle"></i> Successfully checked out at ${time}</div>`;
        });
    </script>
</body>
</html>
