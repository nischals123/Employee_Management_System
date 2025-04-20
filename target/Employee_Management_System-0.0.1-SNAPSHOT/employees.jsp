<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employees - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for employees page */
        .employee-filters {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .search-box {
            display: flex;
            align-items: center;
            background-color: white;
            border-radius: 8px;
            padding: 8px 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            width: 300px;
        }
        
        .search-box input {
            border: none;
            outline: none;
            padding: 5px;
            width: 100%;
            font-size: 14px;
        }
        
        .search-box i {
            color: #7f8c8d;
            margin-right: 10px;
        }
        
        .filter-options {
            display: flex;
            gap: 10px;
        }
        
        .filter-options select {
            padding: 8px 15px;
            border: 1px solid #dfe6e9;
            border-radius: 8px;
            background-color: white;
            font-size: 14px;
            color: #2c3e50;
        }
        
        .add-employee-btn {
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: background-color 0.3s ease;
        }
        
        .add-employee-btn i {
            margin-right: 8px;
        }
        
        .add-employee-btn:hover {
            background-color: #2980b9;
        }
        
        .employees-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .employees-table th {
            background-color: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .employees-table td {
            padding: 15px;
            border-bottom: 1px solid #ecf0f1;
            color: #2c3e50;
        }
        
        .employees-table tr:last-child td {
            border-bottom: none;
        }
        
        .employees-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .employee-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3498db;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            overflow: hidden;
        }
        
        .employee-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .employee-name {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .employee-status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-active {
            background-color: #e8f5e9;
            color: #2ecc71;
        }
        
        .status-inactive {
            background-color: #ffebee;
            color: #e74c3c;
        }
        
        .employee-actions {
            display: flex;
            gap: 10px;
        }
        
        .action-btn {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .action-btn:hover {
            background-color: #f5f7fa;
        }
        
        .action-btn.edit {
            color: #3498db;
        }
        
        .action-btn.delete {
            color: #e74c3c;
        }
        
        .action-btn.view {
            color: #2ecc71;
        }
        
        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            gap: 5px;
        }
        
        .pagination-btn {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: white;
            border: 1px solid #dfe6e9;
            color: #2c3e50;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .pagination-btn:hover {
            background-color: #f5f7fa;
        }
        
        .pagination-btn.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .pagination-btn.disabled {
            opacity: 0.5;
            cursor: not-allowed;
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
                    <li class="active">
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
                    <h1>Employees</h1>
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

            <!-- Employees Content -->
            <div class="dashboard-content">
                <!-- Filters and Search -->
                <div class="employee-filters">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search employees...">
                    </div>
                    
                    <div class="filter-options">
                        <select>
                            <option value="">All Departments</option>
                            <option value="1">Computer Science</option>
                            <option value="2">Electrical</option>
                            <option value="3">Mechanical</option>
                            <option value="4">Civil</option>
                            <option value="5">Human Resources</option>
                        </select>
                        
                        <select>
                            <option value="">All Roles</option>
                            <option value="1">Admin</option>
                            <option value="2">Manager</option>
                            <option value="3">Employee</option>
                        </select>
                        
                        <select>
                            <option value="">All Status</option>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                    
                    <button class="add-employee-btn">
                        <i class="fas fa-plus"></i> Add Employee
                    </button>
                </div>
                
                <!-- Employees Table -->
                <table class="employees-table">
                    <thead>
                        <tr>
                            <th>Employee</th>
                            <th>Department</th>
                            <th>Role</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
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
                            <td>Computer Science</td>
                            <td>Manager</td>
                            <td>john.doe@example.com</td>
                            <td>+1 234-567-8901</td>
                            <td><span class="employee-status status-active">Active</span></td>
                            <td>
                                <div class="employee-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-btn delete" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </div>
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
                            <td>Human Resources</td>
                            <td>Admin</td>
                            <td>jane.smith@example.com</td>
                            <td>+1 234-567-8902</td>
                            <td><span class="employee-status status-active">Active</span></td>
                            <td>
                                <div class="employee-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-btn delete" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="employee-name">
                                    <div class="employee-avatar">
                                        <img src="https://randomuser.me/api/portraits/men/67.jpg" alt="Robert Johnson">
                                    </div>
                                    <span>Robert Johnson</span>
                                </div>
                            </td>
                            <td>Electrical</td>
                            <td>Employee</td>
                            <td>robert.johnson@example.com</td>
                            <td>+1 234-567-8903</td>
                            <td><span class="employee-status status-active">Active</span></td>
                            <td>
                                <div class="employee-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-btn delete" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="employee-name">
                                    <div class="employee-avatar">
                                        <img src="https://randomuser.me/api/portraits/women/22.jpg" alt="Emily Davis">
                                    </div>
                                    <span>Emily Davis</span>
                                </div>
                            </td>
                            <td>Mechanical</td>
                            <td>Employee</td>
                            <td>emily.davis@example.com</td>
                            <td>+1 234-567-8904</td>
                            <td><span class="employee-status status-inactive">Inactive</span></td>
                            <td>
                                <div class="employee-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-btn delete" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="employee-name">
                                    <div class="employee-avatar">
                                        <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Michael Wilson">
                                    </div>
                                    <span>Michael Wilson</span>
                                </div>
                            </td>
                            <td>Civil</td>
                            <td>Manager</td>
                            <td>michael.wilson@example.com</td>
                            <td>+1 234-567-8905</td>
                            <td><span class="employee-status status-active">Active</span></td>
                            <td>
                                <div class="employee-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-btn delete" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                
                <!-- Pagination -->
                <div class="pagination">
                    <div class="pagination-btn disabled">
                        <i class="fas fa-chevron-left"></i>
                    </div>
                    <div class="pagination-btn active">1</div>
                    <div class="pagination-btn">2</div>
                    <div class="pagination-btn">3</div>
                    <div class="pagination-btn">
                        <i class="fas fa-chevron-right"></i>
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
            
            // Add event listeners for action buttons
            document.querySelectorAll('.action-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const action = this.classList.contains('view') ? 'view' : 
                                  this.classList.contains('edit') ? 'edit' : 'delete';
                    const employeeName = this.closest('tr').querySelector('.employee-name span').textContent;
                    
                    if (action === 'view') {
                        alert(`View details for ${employeeName}`);
                        // Redirect to employee details page
                        // window.location.href = `employee-details.jsp?id=${employeeId}`;
                    } else if (action === 'edit') {
                        alert(`Edit ${employeeName}`);
                        // Redirect to employee edit page
                        // window.location.href = `edit-employee.jsp?id=${employeeId}`;
                    } else if (action === 'delete') {
                        if (confirm(`Are you sure you want to delete ${employeeName}?`)) {
                            alert(`${employeeName} deleted successfully!`);
                            // Send delete request to server
                            // And remove row from table on success
                        }
                    }
                });
            });
            
            // Add event listener for add employee button
            document.querySelector('.add-employee-btn').addEventListener('click', function() {
                alert('Add new employee');
                // Redirect to add employee page
                // window.location.href = 'add-employee.jsp';
            });
        });
    </script>
</body>
</html>
