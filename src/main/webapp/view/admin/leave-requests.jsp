<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<%@ page import="dao.UserDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Leave Requests - EMS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        /* Global styles enhancements */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
        }

        .dashboard-content {
            padding: 20px;
            background-color: #f5f7fa;
        }

        .content-section {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 30px;
        }

        /* Header styles */
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px 25px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .header-left h1 {
            font-size: 1.7rem;
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
        }

        .header-left h1 i {
            margin-right: 10px;
            color: #3498db;
        }

        /* Section header */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eaeaea;
        }

        .section-header h2 {
            font-size: 1.4rem;
            color: #34495e;
            margin: 0;
        }

        /* Table styling */
        .table-responsive {
            overflow-x: auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        }

        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .data-table th {
            background-color: #f8f9fa;
            color: #495057;
            font-weight: 600;
            padding: 15px 10px;
            text-align: center;
            border-bottom: 2px solid #eaeaea;
        }

        .data-table td {
            padding: 14px 10px;
            text-align: center;
            border-bottom: 1px solid #eaeaea;
            color: #444;
            vertical-align: middle;
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:hover td {
            background-color: #f7fbff;
        }

        /* Leave status badges */
        .leave-status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background-color: #fff8e9;
            color: #e67e22;
            border: 1px solid rgba(230, 126, 34, 0.2);
        }

        .status-approved {
            background-color: #e8f9f0;
            color: #27ae60;
            border: 1px solid rgba(39, 174, 96, 0.2);
        }

        .status-rejected {
            background-color: #feeeec;
            color: #e74c3c;
            border: 1px solid rgba(231, 76, 60, 0.2);
        }

        /* Leave type badges */
        .leave-type {
            background-color: #ebf3ff;
            color: #3498db;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            letter-spacing: 0.3px;
            border: 1px solid rgba(52, 152, 219, 0.2);
        }

        /* Action buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .btn-approve, .btn-reject {
            border: none;
            padding: 7px 14px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .btn-approve {
            background-color: #2ecc71;
            color: #fff;
        }

        .btn-approve:hover {
            background-color: #27ae60;
            box-shadow: 0 2px 5px rgba(39, 174, 96, 0.3);
        }

        .btn-reject {
            background-color: #e74c3c;
            color: #fff;
        }

        .btn-reject:hover {
            background-color: #c0392b;
            box-shadow: 0 2px 5px rgba(192, 57, 43, 0.3);
        }

        .action-buttons i {
            margin-right: 5px;
        }

        /* Add leave button */
        .btn-add-leave {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
        }

        .btn-add-leave:hover {
            background-color: #2980b9;
            box-shadow: 0 3px 8px rgba(41, 128, 185, 0.3);
        }

        .btn-add-leave i {
            font-size: 0.9rem;
        }

        /* Modal styling */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 2000;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            width: 450px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .modal-content h3 {
            margin: 0 0 25px 0;
            color: #2c3e50;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #34495e;
            font-size: 0.9rem;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            color: #444;
            background-color: #f9f9f9;
            transition: all 0.2s ease;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
            background-color: #fff;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.95rem;
        }

        .btn-primary {
            background-color: #3498db;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            box-shadow: 0 2px 5px rgba(41, 128, 185, 0.3);
        }

        .btn-secondary {
            background-color: #e0e0e0;
            color: #333;
        }

        .btn-secondary:hover {
            background-color: #d0d0d0;
        }

        /* Responsive adjustments */
        @media screen and (max-width: 768px) {
            .content-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }

            .btn-approve, .btn-reject {
                width: 100%;
                justify-content: center;
            }

            .modal-content {
                width: 90%;
                padding: 20px;
            }

            /* Form styling for buttons */
            .btn-form {
                display: inline-block;
                margin: 0 5px;
            }

            /* Style for buttons inside forms */
            .btn-form button {
                border: none;
                padding: 7px 14px;
                border-radius: 6px;
                font-size: 0.8rem;
                font-weight: 500;
                cursor: pointer;
                display: flex;
                align-items: center;
                transition: all 0.2s ease;
                width: 100%;
            }

            .btn-approve {
                background-color: #2ecc71;
                color: #fff;
            }

            .btn-approve:hover {
                background-color: #27ae60;
                box-shadow: 0 2px 5px rgba(39, 174, 96, 0.3);
            }

            .btn-reject {
                background-color: #e74c3c;
                color: #fff;
            }

            .btn-reject:hover {
                background-color: #c0392b;
                box-shadow: 0 2px 5px rgba(192, 57, 43, 0.3);
            }

            .btn-form button i {
                margin-right: 5px;
            }
        }
    </style>
</head>
<body class="dashboard-body">

<div class="dashboard-container">
    <%@ include file="includes/sidebar.jsp" %>
    <main class="main-content">
        <%@ include file="includes/topnav.jsp" %>
        <header class="content-header">
            <div class="header-left">
                <h1><i class="fas fa-calendar-minus"></i> Leave Requests</h1>
            </div>
            <div class="header-right">
                <button class="btn-add-leave" onclick="openLeaveModal()">
                    <i class="fas fa-plus"></i> Add Leave Manually
                </button>
            </div>
        </header>
        <div class="dashboard-content">
            <div class="content-section">
                <div class="section-header">
                    <h2>Pending Leave Requests</h2>
                    <div class="filter-controls">
                        <select class="filter-select" id="statusFilter">
                            <option value="all">All Status</option>
                            <option value="Pending">Pending</option>
                            <option value="Approved">Approved</option>
                            <option value="Rejected">Rejected</option>
                        </select>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Employee</th>
                            <th>Leave Type</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Days</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="leaveRequest" items="${leaveRequests}">
                            <tr>
                                <!-- Employee Name -->
                                <td>${UserDAO.getUserNameFromId(leaveRequest.userId)}</td>

                                <!-- Leave Type -->
                                <td><span class="leave-type">${leaveRequest.leaveType}</span></td>

                                <!-- Start Date -->
                                <td><fmt:formatDate value="${leaveRequest.startDate}" pattern="yyyy-MM-dd" /></td>

                                <!-- End Date -->
                                <td><fmt:formatDate value="${leaveRequest.endDate}" pattern="yyyy-MM-dd" /></td>

                                <!-- Total Days -->
                                <td>
                                    <strong>${leaveRequest.getTotalDays()}</strong>
                                </td>

                                <!-- Reason -->
                                <td>${fn:escapeXml(leaveRequest.reason)}</td>

                                <!-- Status -->
                                <td>
                                    <span class="leave-status
                                        <c:choose>
                                            <c:when test="${leaveRequest.status eq 'Pending'}">status-pending</c:when>
                                            <c:when test="${leaveRequest.status eq 'Approved'}">status-approved</c:when>
                                            <c:when test="${leaveRequest.status eq 'Rejected'}">status-rejected</c:when>
                                        </c:choose>
                                    ">
                                            ${leaveRequest.status}
                                    </span>
                                </td>

                                <!-- Actions -->
                                <td class="action-buttons">
                                    <form action="${pageContext.request.contextPath}/leave-request-action" method="post" class="btn-form">
                                        <input type="hidden" name="id" value="${leaveRequest.id}">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="btn-approve" title="Approve Leave Request">
                                            <i class="fas fa-check"></i> Approve
                                        </button>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/leave-request-action" method="post" class="btn-form">
                                        <input type="hidden" name="id" value="${leaveRequest.id}">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="btn-reject" title="Reject Leave Request"
                                                onclick="return confirm('Are you sure you want to reject this leave request?')">
                                            <i class="fas fa-times"></i> Reject
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Modal: Manual Leave Form -->
<div class="modal" id="leaveModal">
    <div class="modal-content">
        <h3>Add Leave Request</h3>
        <form   action="${pageContext.request.contextPath}/create-manual-leave" method="post">
            <div class="form-group">
                <label for="employee">Employee Name</label>
                <input type="text" id="employee" name="employee" required />
            </div>
            <div class="form-group">
                <label for="leaveType">Leave Type</label>
                <select id="leaveType" name="leaveType" required>
                    <option value="">Select Leave Type</option>
                    <option value="Annual">Annual Leave</option>
                    <option value="Sick">Sick Leave</option>
                    <option value="Personal">Personal Leave</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="startDate">Start Date</label>
                <input type="date" id="startDate" name="fromDate" required />
            </div>
            <div class="form-group">
                <label for="endDate">End Date</label>
                <input type="date" id="endDate" name="tillDate" required />
            </div>
            <div class="form-group">
                <label for="leaveReason">Reason</label>
                <textarea id="leaveReason" name="reason" rows="3" required></textarea>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">Submit</button>
                <button type="button" class="btn btn-secondary" onclick="closeLeaveModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Function to open the modal
    function openLeaveModal() {
        document.getElementById('leaveModal').classList.add('active');
        // Set default date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('startDate').value = today;
    }

    // Function to close the modal
    function closeLeaveModal() {
        document.getElementById('leaveModal').classList.remove('active');
    }

    // Form submission handler
    // document.getElementById('manualLeaveForm').addEventListener('submit', function(e) {
    //     e.preventDefault();
    //
    //     // Validate end date is after or equal to start date
    //     const startDate = new Date(document.getElementById('startDate').value);
    //     const endDate = new Date(document.getElementById('endDate').value);
    //
    //     if (endDate < startDate) {
    //         alert('End date cannot be before start date');
    //         return;
    //     }
    //
    //     // Show success message
    //     // alert('Manual leave request submitted successfully!');
    //     // closeLeaveModal();
    //     // this.reset();
    //
    //     // TODO: Add AJAX submission logic
    // });

    // Status filter functionality
    document.getElementById('statusFilter').addEventListener('change', function() {
        const filterValue = this.value.toLowerCase();
        const rows = document.querySelectorAll('.data-table tbody tr');

        rows.forEach(row => {
            const status = row.querySelector('.leave-status').textContent.trim().toLowerCase();
            if (filterValue === 'all' || status === filterValue.toLowerCase()) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Close modal if clicked outside
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('leaveModal');
        if (event.target === modal) {
            closeLeaveModal();
        }
    });
</script>
</body>
</html>