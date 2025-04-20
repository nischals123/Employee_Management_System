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
    <title>Leave Requests - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for leave requests page */
        .leave-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-pending {
            background-color: #fef5e7;
            color: #f39c12;
        }
        
        .status-approved {
            background-color: #e3f9e5;
            color: #2ecc71;
        }
        
        .status-rejected {
            background-color: #fde8e8;
            color: #e74c3c;
        }
        
        .leave-type {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            background-color: #e7f3fe;
            color: #3498db;
        }
        
        .leave-form {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .form-group {
            flex: 1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9rem;
        }
        
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn-approve {
            background-color: #2ecc71;
            color: white;
        }
        
        .btn-reject {
            background-color: #e74c3c;
            color: white;
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
                    <li>
                        <a href="attendance.jsp"><i class="fas fa-calendar-check"></i> Attendance</a>
                    </li>
                    <li class="active">
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
                    <h1><i class="fas fa-calendar-minus"></i> Leave Requests</h1>
                </div>
                <div class="header-right">
                    <div class="notification-bell">
                        <i class="far fa-bell"></i>
                        <span class="notification-count">3</span>
                    </div>
                </div>
            </header>

            <!-- Leave Requests Content -->
            <div class="dashboard-content">
                <!-- New Leave Request Form -->
                <div class="content-section">
                    <div class="section-header">
                        <h2>Submit New Leave Request</h2>
                    </div>
                    
                    <div class="leave-form">
                        <form id="leave-request-form">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="leave-type">Leave Type</label>
                                    <select id="leave-type" name="leave-type" required>
                                        <option value="">Select Leave Type</option>
                                        <option value="Annual">Annual Leave</option>
                                        <option value="Sick">Sick Leave</option>
                                        <option value="Personal">Personal Leave</option>
                                        <option value="Maternity">Maternity Leave</option>
                                        <option value="Paternity">Paternity Leave</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="start-date">Start Date</label>
                                    <input type="date" id="start-date" name="start-date" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="end-date">End Date</label>
                                    <input type="date" id="end-date" name="end-date" required>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="reason">Reason</label>
                                <textarea id="reason" name="reason" placeholder="Please provide a reason for your leave request"></textarea>
                            </div>
                            
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Submit Request</button>
                                <button type="reset" class="btn btn-secondary">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- My Leave Requests -->
                <div class="content-section">
                    <div class="section-header">
                        <h2>My Leave Requests</h2>
                        
                        <div class="filter-options">
                            <select id="status-filter">
                                <option value="all">All Statuses</option>
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
                                    <th>Leave Type</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Duration</th>
                                    <th>Reason</th>
                                    <th>Status</th>
                                    <th>Submitted On</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Sample data - would be replaced with actual data from database -->
                                <tr>
                                    <td><span class="leave-type">Annual</span></td>
                                    <td>2023-08-10</td>
                                    <td>2023-08-15</td>
                                    <td>6 days</td>
                                    <td>Family vacation</td>
                                    <td><span class="leave-status status-approved">Approved</span></td>
                                    <td>2023-07-20</td>
                                </tr>
                                <tr>
                                    <td><span class="leave-type">Sick</span></td>
                                    <td>2023-07-05</td>
                                    <td>2023-07-06</td>
                                    <td>2 days</td>
                                    <td>Fever and cold</td>
                                    <td><span class="leave-status status-approved">Approved</span></td>
                                    <td>2023-07-04</td>
                                </tr>
                                <tr>
                                    <td><span class="leave-type">Personal</span></td>
                                    <td>2023-09-20</td>
                                    <td>2023-09-20</td>
                                    <td>1 day</td>
                                    <td>Personal appointment</td>
                                    <td><span class="leave-status status-pending">Pending</span></td>
                                    <td>2023-09-10</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Pending Leave Requests (visible only to managers) -->
                <c:if test="${sessionScope.user.role.name eq 'Manager' or sessionScope.user.role.name eq 'Admin'}">
                    <div class="content-section">
                        <div class="section-header">
                            <h2>Pending Leave Requests</h2>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Employee</th>
                                        <th>Leave Type</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Duration</th>
                                        <th>Reason</th>
                                        <th>Submitted On</th>
                                        <th>Actions</th>
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
                                                <span>John Doe</span>
                                            </div>
                                        </td>
                                        <td><span class="leave-type">Annual</span></td>
                                        <td>2023-09-15</td>
                                        <td>2023-09-20</td>
                                        <td>6 days</td>
                                        <td>Family vacation</td>
                                        <td>2023-08-25</td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn btn-sm btn-approve" data-id="1">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                                <button class="btn btn-sm btn-reject" data-id="1">
                                                    <i class="fas fa-times"></i> Reject
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="employee-name">
                                                <div class="employee-avatar">
                                                    <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Jane Smith">
                                                </div>
                                                <span>Jane Smith</span>
                                            </div>
                                        </td>
                                        <td><span class="leave-type">Sick</span></td>
                                        <td>2023-09-12</td>
                                        <td>2023-09-13</td>
                                        <td>2 days</td>
                                        <td>Fever and cold</td>
                                        <td>2023-09-11</td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn btn-sm btn-approve" data-id="2">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                                <button class="btn btn-sm btn-reject" data-id="2">
                                                    <i class="fas fa-times"></i> Reject
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <!-- JavaScript for Leave Requests Page -->
    <script>
        // Form submission
        document.getElementById('leave-request-form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // In a real application, this would send an AJAX request to the server
            const leaveType = document.getElementById('leave-type').value;
            const startDate = document.getElementById('start-date').value;
            const endDate = document.getElementById('end-date').value;
            const reason = document.getElementById('reason').value;
            
            // Validate dates
            if (new Date(startDate) > new Date(endDate)) {
                alert('End date must be after start date');
                return;
            }
            
            // Show success message (in a real app, this would happen after successful server response)
            alert('Leave request submitted successfully!');
            this.reset();
        });
        
        // Status filter functionality
        document.getElementById('status-filter').addEventListener('change', function() {
            const status = this.value;
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            if (status === 'all') {
                rows.forEach(row => row.style.display = '');
                return;
            }
            
            rows.forEach(row => {
                const statusCell = row.querySelector('td:nth-child(6)');
                if (statusCell && statusCell.textContent.includes(status)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
        
        // Approve/Reject buttons (for managers)
        const approveButtons = document.querySelectorAll('.btn-approve');
        const rejectButtons = document.querySelectorAll('.btn-reject');
        
        approveButtons.forEach(button => {
            button.addEventListener('click', function() {
                const leaveId = this.getAttribute('data-id');
                // In a real application, this would send an AJAX request to the server
                alert(`Leave request #${leaveId} approved successfully!`);
                // Remove the row or update its status
                this.closest('tr').remove();
            });
        });
        
        rejectButtons.forEach(button => {
            button.addEventListener('click', function() {
                const leaveId = this.getAttribute('data-id');
                const reason = prompt('Please provide a reason for rejection:');
                if (reason !== null) {
                    // In a real application, this would send an AJAX request to the server
                    alert(`Leave request #${leaveId} rejected successfully!`);
                    // Remove the row or update its status
                    this.closest('tr').remove();
                }
            });
        });
    </script>
</body>
</html>
