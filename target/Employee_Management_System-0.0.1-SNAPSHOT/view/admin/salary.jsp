<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<%@page import="dao.UserDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Salary Management - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        /* Salary management specific styles */
        .salary-table-container {
            overflow-x: auto;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .salary-table {
            width: 100%;
            border-collapse: collapse;
        }

        .salary-table th,
        .salary-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        .salary-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        .salary-table tr:hover {
            background-color: #f6f9ff;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-paid {
            background-color: #d4edda;
            color: #155724;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .salary-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .salary-info h2 {
            margin: 0;
            font-size: 1.5rem;
        }

        .salary-info p {
            margin: 5px 0 0;
            color: #6c757d;
        }

        .add-salary-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: background-color 0.2s;
        }

        .add-salary-btn:hover {
            background-color: #0069d9;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal.active {
            display: block;
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 0;
            width: 500px;
            max-width: 90%;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s ease;
        }

        @keyframes modalSlideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #e0e0e0;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 1.25rem;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #6c757d;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #e0e0e0;
            text-align: right;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 1rem;
        }

        .btn-cancel {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-save {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .actions {
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

        <!-- Salary Management Content -->
        <div class="dashboard-content">
            <div class="salary-header">
                <div class="salary-info">
                    <h2>Salary Management</h2>
                    <p>Manage employee salaries and payment status</p>
                </div>
                <button class="add-salary-btn" id="add-salary-btn">
                    <i class="fas fa-plus"></i> Add Salary
                </button>
            </div>

            <div class="salary-table-container">
                <table class="salary-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Employee</th>
                        <th>Month</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="salary" items="${salaries}">
                        <tr>
                            <td>${salary.id}</td>
                            <td data-user-id="${salary.userId}">${UserDAO.getUserNameFromId(salary.userId)}</td>
                            <td data-month-value="${salary.month}">${salary.month}</td>
                            <td>$${salary.amount}</td>
                            <td>
            <span class="status-badge
                ${salary.status == 'PAID' ? 'status-paid' :
                  salary.status == 'PENDING' ? 'status-pending' : 'status-rejected'}">
                    ${salary.status}
            </span>
                            </td>
                            <td class="actions">

                                <button class="action-btn edit" title="Edit Salary">
                                    <i class="fas fa-edit"></i>
                                </button>

                                <form action="${pageContext.request.contextPath}/delete-salary?id=${salary.id}" method="post">
                                    <button type="submit" class="action-btn delete" title="Delete Salary">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>

                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<!-- Add Salary Modal -->
<div class="modal" id="salary-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Add New Salary</h3>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="salary-form" action="${pageContext.request.contextPath}/add-salary" method="post">
                <input type="hidden" id="salary-id" name="id" value="" />
                <div class="form-group">
                    <label for="employee">Employee</label>
                    <select id="employee" name="user_id" required>
                        <option value="">Select Employee</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}">${user.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="month">Month</label>
                    <input type="month" id="month" name="month" required />
                </div>
                <div class="form-group">
                    <label for="amount">Amount</label>
                    <input type="number" id="amount" name="amount" step="0.01" min="0" required />
                </div>
                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" required>
                        <option value="">Select Status</option>
                        <option value="PAID">Paid</option>
                        <option value="PENDING">Pending</option>
                        <option value="REJECTED">Rejected</option>
                    </select>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn-cancel" id="cancel-btn">Cancel</button>
            <button class="btn-save" id="save-btn">Save Salary</button>
        </div>
    </div>
</div>

<!-- Add this new modal form for editing salaries after your existing add salary modal -->
<!-- Edit Salary Modal -->
<div class="modal" id="edit-salary-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Edit Salary</h3>
            <button class="modal-close" id="edit-modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="edit-salary-form" action="${pageContext.request.contextPath}/update-salary" method="post">
                <input type="hidden" id="edit-salary-id" name="id" value="" />
                <div class="form-group">
                    <label for="edit-employee">Employee</label>
                    <select id="edit-employee" name="user_id" required>
                        <option value="">Select Employee</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}">${user.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="edit-month">Month</label>
                    <input type="month" id="edit-month" name="month" required />
                </div>
                <div class="form-group">
                    <label for="edit-amount">Amount</label>
                    <input type="number" id="edit-amount" name="amount" step="0.01" min="0" required />
                </div>
                <div class="form-group">
                    <label for="edit-status">Status</label>
                    <select id="edit-status" name="status" required>
                        <option value="">Select Status</option>
                        <option value="PAID">Paid</option>
                        <option value="PENDING">Pending</option>
                        <option value="REJECTED">Rejected</option>
                    </select>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn-cancel" id="edit-cancel-btn">Cancel</button>
            <button class="btn-save" id="edit-save-btn">Update Salary</button>
        </div>
    </div>
</div>
<script>
    // Date display & modal logic
    document.addEventListener('DOMContentLoaded', function () {
        // Current date display
        const dateElement = document.getElementById('current-date');
        if (dateElement) {
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const today = new Date();
            dateElement.textContent = today.toLocaleDateString('en-US', options);
        }

        // Add Salary Modal functionality
        const addModal = document.getElementById('salary-modal');
        const addBtn = document.getElementById('add-salary-btn');
        const closeAddBtn = document.querySelector('#salary-modal .modal-close');
        const cancelAddBtn = document.getElementById('cancel-btn');
        const saveAddBtn = document.getElementById('save-btn');
        const salaryForm = document.getElementById('salary-form');

        // Edit Salary Modal functionality
        const editModal = document.getElementById('edit-salary-modal');
        const closeEditBtn = document.querySelector('#edit-salary-modal .modal-close');
        const cancelEditBtn = document.getElementById('edit-cancel-btn');
        const saveEditBtn = document.getElementById('edit-save-btn');
        const editSalaryForm = document.getElementById('edit-salary-form');

        // Add new salary button
        addBtn.addEventListener('click', () => {
            salaryForm.reset();
            addModal.classList.add('active');
        });

        // Edit salary buttons
        document.querySelectorAll('.action-btn.edit').forEach(btn => {
            btn.addEventListener('click', function() {
                const row = this.closest('tr');
                const id = row.querySelector('td:nth-child(1)').textContent;
                const userId = row.querySelector('td:nth-child(2)').getAttribute('data-user-id');
                const month = row.querySelector('td:nth-child(3)').getAttribute('data-month-value');
                const amount = row.querySelector('td:nth-child(4)').textContent.replace('$', '');
                const statusElement = row.querySelector('td:nth-child(5) .status-badge');
                const status = statusElement.textContent.trim();

                // Update edit form with salary data
                document.getElementById('edit-salary-id').value = id;
                document.getElementById('edit-employee').value = userId;
                document.getElementById('edit-month').value = month;
                document.getElementById('edit-amount').value = amount;
                document.getElementById('edit-status').value = status;

                // Show edit modal
                editModal.classList.add('active');
            });
        });

        // Close add modal buttons
        closeAddBtn.addEventListener('click', () => addModal.classList.remove('active'));
        cancelAddBtn.addEventListener('click', () => addModal.classList.remove('active'));

        // Close edit modal buttons
        closeEditBtn.addEventListener('click', () => editModal.classList.remove('active'));
        cancelEditBtn.addEventListener('click', () => editModal.classList.remove('active'));

        // Save add button
        saveAddBtn.addEventListener('click', function() {
            if (salaryForm.checkValidity()) {
                salaryForm.submit();
            } else {
                const submitEvent = new Event('submit', {
                    'bubbles': true,
                    'cancelable': true
                });
                salaryForm.dispatchEvent(submitEvent);
            }
        });

        // Save edit button
        saveEditBtn.addEventListener('click', function() {
            if (editSalaryForm.checkValidity()) {
                editSalaryForm.submit();
            } else {
                const submitEvent = new Event('submit', {
                    'bubbles': true,
                    'cancelable': true
                });
                editSalaryForm.dispatchEvent(submitEvent);
            }
        });

        // Close modals when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === addModal) {
                addModal.classList.remove('active');
            }
            if (event.target === editModal) {
                editModal.classList.remove('active');
            }
        });

        // Confirm delete action
        document.querySelectorAll('.action-btn.delete').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (!confirm('Are you sure you want to delete this salary record?')) {
                    e.preventDefault();
                }
            });
        });
    });
</script>
</body>
</html>