<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page isELIgnored="false"%>

<%
if (session.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/view/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Employees - Employee Management System</title>

    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- Inline Styling for Dashboard Look -->
    <style>
        .dashboard-content {
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.06);
            margin-top: 20px;
        }

        .employee-filters {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 20px;
        }

        .search-box {
            display: flex;
            align-items: center;
            background-color: #f3f4f6;
            padding: 8px 12px;
            border-radius: 8px;
            width: 260px;
        }

        .search-box i {
            margin-right: 8px;
            color: #555;
        }

        .search-box input {
            border: none;
            background: transparent;
            outline: none;
            font-size: 14px;
            width: 100%;
        }

        .filter-options select {
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f9f9f9;
        }

        .add-employee-btn {
            background-color: #1f8f4c;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: background-color 0.3s ease;
        }

        .add-employee-btn:hover {
            background-color: #15703a;
        }

        .employees-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .employees-table th, .employees-table td {
            padding: 12px 16px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        .employees-table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
        }

        .employees-table tr:hover {
            background-color: #f1f1f1;
        }

        .employee-name span {
            font-weight: 500;
            color: #222;
        }

        .status-active {
            color: #2e7d32;
            font-weight: bold;
        }

        .status-inactive {
            color: #c62828;
            font-weight: bold;
        }

        .action-btn {
            margin-right: 8px;
            color: #555;
            font-size: 16px;
            transition: color 0.2s ease;
        }

        .action-btn.view:hover {
            color: #007bff;
        }

        .action-btn.edit:hover {
            color: #f0ad4e;
        }

        .action-btn.delete:hover {
            color: #dc3545;
        }
    </style>
</head>

<body class="dashboard-body">
    <div class="dashboard-container">
        <%@ include file="includes/sidebar.jsp" %>

        <main class="main-content">
            <%@ include file="includes/topnav.jsp" %>

            <div class="dashboard-content">
                <!-- Filters and Search -->
                <div class="employee-filters">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search employees..." />
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
                            <option value="3">Employee</option>
                        </select>
                        <select>
                            <option value="">All Status</option>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>

                    <a class="add-employee-btn" href="${pageContext.request.contextPath}/employees?action=add">
                        <i class="fas fa-plus"></i> Add Employee
                    </a>
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
                        <c:forEach var="emp" items="${employeeList}">
                            <tr>
                                <td class="employee-name"><span>${emp.name}</span></td>
                                <td>${emp.department.name}</td>
                                <td>${emp.role}</td>
                                <td>${emp.email}</td>
                                <td>${emp.phone}</td>
                                <td>
                                    <span class="${emp.active == 'active' ? 'status-active' : 'status-inactive'}">
                                        ${emp.active}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/employees?action=view&id=${emp.id}" class="action-btn view" title="View">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/employees?action=edit&id=${emp.id}" class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/employees?action=delete&id=${emp.id}"
                                       onclick="return confirm('Are you sure you want to delete ${emp.name}?')"
                                       class="action-btn delete" title="Delete">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const dateElement = document.getElementById('current-date');
            if (dateElement) {
                const options = {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                };
                const today = new Date();
                dateElement.textContent = today.toLocaleDateString('en-US', options);
            }
        });
    </script>
</body>
</html>
