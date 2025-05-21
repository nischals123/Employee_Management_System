<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Request</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        .leave-section {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        #leaveForm {
            background: #f9fbfd;
            padding: 24px;
            border: 1px solid #ddd;
            border-radius: 12px;
        }

        .leave-form .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
        }

        .leave-form label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            display: block;
        }

        .leave-form input,
        .leave-form select,
        .leave-form textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            background-color: #f9f9f9;
        }

        #submitLeaveRequest {
            background-color: #004080;
            color: white;
            padding: 12px 24px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            margin-top: 20px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #submitLeaveRequest:hover {
            background-color: #003366;
        }

        .leave-section table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .leave-section th,
        .leave-section td {
            padding: 14px 18px;
            border-bottom: 1px solid #eee;
        }

        .leave-section th {
            background-color: #004080;
            color: white;
            font-weight: 600;
            text-align: left;
        }

        .leave-section td:last-child {
            text-align: center;
        }

        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 500;
        }

        .badge-success {
            background-color: #28a745;
            color: white;
        }

        .badge-warning {
            background-color: #ffc107;
            color: #222;
        }

        .badge-danger {
            background-color: #dc3545;
            color: white;
        }

        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 10px;
        }

        .success-message {
            color: #28a745;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Include Sidebar -->
    <%@ include file="../includes/sidebar.jsp" %>

    <main class="main-content">
        <!-- Include Top Navigation -->
        <%@ include file="../includes/topnav.jsp" %>

        <div class="dashboard-content">
            <div class="card">
<section class="content-card">
    <section class="leave-section">
        <h2><i class="fas fa-envelope"></i> Leave Request</h2>

        <!-- Display error or success messages -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>

        <!-- Leave Form -->
        <form class="leave-form" id="leaveForm" action="${pageContext.request.contextPath}/LeaveRequestServlet" method="post">
            <input type="hidden" name="action" value="submit">
            <input type="hidden" name="userId" value="${sessionScope.user.id}">
            <div class="form-grid">
                <div>
                    <label for="fromDate">From Date</label>
                    <input type="date" id="fromDate" name="fromDate" required />
                </div>
                <div>
                    <label for="tillDate">Till Date</label>
                    <input type="date" id="tillDate" name="tillDate" required />
                </div>
                <div>
                    <label for="leaveType">Leave Type</label>
                    <select id="leaveType" name="leaveType" required>
                        <option value="">Select Type</option>
                        <option value="Sick">Sick Leave</option>
                        <option value="Casual">Casual Leave</option>
                        <option value="Emergency">Emergency</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div style="grid-column: 1 / -1;">
                    <label for="leaveReason">Reason</label>
                    <textarea id="leaveReason" name="reason" rows="4" placeholder="Write your reason..." required></textarea>
                </div>
            </div>
            <button type="submit" id="submitLeaveRequest">
                <i class="fas fa-paper-plane"></i> Submit Request
            </button>
        </form>

        <!-- Leave History Table -->
        <h3>My Leave History</h3>
        <table>
            <thead>
            <tr>
                <th>From</th>
                <th>Till</th>
                <th>Type</th>
                <th>Reason</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="leave" items="${leaveRequests}">
                <tr>
                    <td><fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd" /></td>
                    <td>${leave.leaveType}</td>
                    <td>${leave.reason}</td>
                    <td>
                        <span class="badge 
                            ${leave.status == 'Approved' ? 'badge-success' : 
                              leave.status == 'Pending' ? 'badge-warning' : 'badge-danger'}">
                            ${leave.status}
                        </span>
                    </td>
                    <td>${leave.approver != null ? leave.approver.name : '—'}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty leaveRequests}">
                <tr>
                    <td colspan="6" style="text-align: center;">No leave requests found.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </section>
</section>

<!-- Client-side Validation -->
<script>
    document.getElementById("leaveForm").addEventListener("submit", function (e) {
        const from = document.getElementById("fromDate").value;
        const till = document.getElementById("tillDate").value;

        if (new Date(till) < new Date(from)) {
            e.preventDefault();
            alert("❌ 'Till Date' must be after 'From Date'");
        }
    });
</script>
</body>
</html>
