<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Departments - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <style>
        /* Add these styles to your CSS file or in the style tag in your JSP */
        .department-table-container {
            overflow-x: auto;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .department-table {
            width: 100%;
            border-collapse: collapse;
        }

        .department-table th,
        .department-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        .department-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        .department-table tr:hover {
            background-color: #f6f9ff;
        }

        .department-table td.actions {
            display: flex;
            gap: 5px;
        }

        .action-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 5px;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .action-btn:hover {
            background-color: #f1f1f1;
        }

        .action-btn.view {
            color: #3498db;
        }

        .action-btn.edit {
            color: #f39c12;
        }

        .action-btn.delete {
            color: #e74c3c;
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

            <!-- Departments Content -->
                <div class="dashboard-content">
                    <div class="department-header">
                        <div class="department-info">
                            <h2>All Departments</h2>
                            <p>Manage your organization's departments</p>
                        </div>
                        
                    </div>

                    <div class="department-table-container">
                        <table class="department-table">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Department Name</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="department" items="${departments}">
                                <tr>
                                    <td>${department.id}</td>
                                    <td>${department.name}</td>
                                    <td class="actions">
                                        <button class="action-btn view" title="View Department">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn edit" title="Edit Department">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn delete" title="Delete Department">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
        </main>
    </div>

  
    <script>
        // Date & modal logic
        document.addEventListener('DOMContentLoaded', function () {
            const dateElement = document.getElementById('current-date');
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const today = new Date();
            dateElement.textContent = today.toLocaleDateString('en-US', options);

            const modal = document.getElementById('department-modal');
            const addBtn = document.getElementById('add-department-btn');
            const closeBtn = document.querySelector('.modal-close');
            const cancelBtn = document.getElementById('cancel-btn');
            const saveBtn = document.getElementById('save-btn');

            addBtn.addEventListener('click', () => modal.classList.add('active'));
            closeBtn.addEventListener('click', () => modal.classList.remove('active'));
            cancelBtn.addEventListener('click', () => modal.classList.remove('active'));

            saveBtn.addEventListener('click', function () {
                const name = document.getElementById('department-name').value;
                const desc = document.getElementById('department-description').value;
                if (name && desc) {
                    alert(`Department "${name}" added successfully!`);
                    modal.classList.remove('active');
                    document.getElementById('department-form').reset();
                } else {
                    alert("Please fill in all fields");
                }
            });

            window.addEventListener('click', function (event) {
                if (event.target === modal) {
                    modal.classList.remove('active');
                }
            });

            document.querySelectorAll('.action-btn').forEach(btn => {
                btn.addEventListener('click', function () {
                    const action = this.classList.contains('view') ? 'view' : 'edit';
                    const deptName = this.closest('.department-body').querySelector('.department-name').textContent;
                    if (action === 'view') {
                        alert(`View details for ${deptName} department`);
                    } else {
                        alert(`Edit ${deptName} department`);
                    }
                });
            });
        });
    </script>
</body>
</html>
