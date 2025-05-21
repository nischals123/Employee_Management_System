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
    <title>Task Management - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        /* Task management specific styles */
        .task-table-container {
            overflow-x: auto;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .task-table {
            width: 100%;
            border-collapse: collapse;
        }

        .task-table th,
        .task-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        .task-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        .task-table tr:hover {
            background-color: #f6f9ff;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-PENDING {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-IN_PROGRESS {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .status-COMPLETED {
            background-color: #d4edda;
            color: #155724;
        }

        .task-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .task-info h2 {
            margin: 0;
            font-size: 1.5rem;
        }

        .task-info p {
            margin: 5px 0 0;
            color: #6c757d;
        }

        .add-task-btn {
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

        .add-task-btn:hover {
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
        .form-group select,
        .form-group textarea {
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

        /* Description truncation and read more styling */
        .description-text {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            display: inline-block;
        }

        .read-more-btn {
            color: #007bff;
            background: none;
            border: none;
            padding: 0;
            font-size: 12px;
            cursor: pointer;
            text-decoration: underline;
            margin-left: 5px;
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

        <!-- Task Management Content -->
        <div class="dashboard-content">
            <div class="task-header">
                <div class="task-info">
                    <h2>Task Management</h2>
                    <p>Manage and assign tasks to employees</p>
                </div>
                <button class="add-task-btn" id="add-task-btn">
                    <i class="fas fa-plus"></i> Add Task
                </button>
            </div>

            <div class="task-table-container">
                <table class="task-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Assigned By</th>
                        <th>Assigned To</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Due Date</th>
                        <th>Status</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="task" items="${tasks}">
                        <tr data-task-id="${task.id}">
                            <td>${task.id}</td>
                            <td>${UserDAO.getUserNameFromId(task.assignedBy)}</td>
                            <td data-user-id="${task.assignedTo}">${UserDAO.getUserNameFromId(task.assignedTo)}</td>
                            <td>${task.title}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:length(task.description) > 30}">
                                        <span class="description-text">${fn:substring(task.description, 0, 30)}</span>...
                                        <button class="read-more-btn" onclick="showDescription('${fn:escapeXml(task.description)}')">
                                            Read More
                                        </button>
                                        <span class="full-description" style="display:none">${task.description}</span>
                                    </c:when>
                                    <c:otherwise>
                                        ${task.description}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${task.dueDate}</td>
                            <td>
                                <span class="status-badge status-${task.status}">
                                        ${task.status}
                                </span>
                            </td>
                            <td>${task.createdAt}</td>
                            <td class="actions">
                                <button class="action-btn edit" title="Edit Task" onclick="editTask(${task.id})">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <form action="${pageContext.request.contextPath}/delete-task" method="post">
                                    <input type="hidden" name="id" value="${task.id}">
                                    <button type="submit" class="action-btn delete" title="Delete Task" onclick="return confirm('Are you sure you want to delete this task?')">
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

<!-- Add Task Modal -->
<div class="modal" id="task-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Add New Task</h3>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="task-form" action="${pageContext.request.contextPath}/add-task" method="post">
                <input type="hidden" name="assignedBy" value="${sessionScope.user.id}" />
                <input type="hidden" name="status" value="PENDING" />
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" required />
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="assignedTo">Assign To</label>
                    <select id="assignedTo" name="assignedTo" required>
                        <option value="">Select Employee</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}">${user.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dueDate">Due Date</label>
                    <input type="date" id="dueDate" name="dueDate" min="${today}" required />
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn-cancel" id="cancel-btn">Cancel</button>
            <button class="btn-save" id="save-btn">Save Task</button>
        </div>
    </div>
</div>

<!-- Edit Task Modal -->
<div class="modal" id="edit-task-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Edit Task</h3>
            <button class="modal-close" id="edit-modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="edit-task-form" action="${pageContext.request.contextPath}/update-task" method="post">
                <input type="hidden" id="edit-task-id" name="id" />
                <div class="form-group">
                    <label for="edit-title">Title</label>
                    <input type="text" id="edit-title" name="title" required />
                </div>
                <div class="form-group">
                    <label for="edit-description">Description</label>
                    <textarea id="edit-description" name="description" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="edit-assignedTo">Assign To</label>
                    <select id="edit-assignedTo" name="assignedTo" required>
                        <option value="">Select Employee</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}">${user.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="edit-dueDate">Due Date</label>
                    <input type="date" id="edit-dueDate" name="dueDate" required />
                </div>
                <div class="form-group">
                    <label for="edit-status">Status</label>
                    <select id="edit-status" name="status" required>
                        <option value="PENDING">Pending</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="COMPLETED">Completed</option>
                    </select>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn-cancel" id="edit-cancel-btn">Cancel</button>
            <button class="btn-save" id="edit-save-btn">Update Task</button>
        </div>
    </div>
</div>

<!-- Description Modal -->
<div class="modal" id="description-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Task Description</h3>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <p id="full-description"></p>
        </div>
        <div class="modal-footer">
            <button class="btn-cancel" onclick="closeDescriptionModal()">Close</button>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Task Modal Elements
        const addTaskModal = document.getElementById('task-modal');
        const addTaskBtn = document.getElementById('add-task-btn');
        const closeAddTaskBtn = document.querySelector('#task-modal .modal-close');
        const cancelAddTaskBtn = document.getElementById('cancel-btn');
        const saveTaskBtn = document.getElementById('save-btn');
        const taskForm = document.getElementById('task-form');

        // Edit Modal Elements
        const editTaskModal = document.getElementById('edit-task-modal');
        const closeEditTaskBtn = document.getElementById('edit-modal-close');
        const cancelEditTaskBtn = document.getElementById('edit-cancel-btn');
        const saveEditTaskBtn = document.getElementById('edit-save-btn');
        const editTaskForm = document.getElementById('edit-task-form');

        // Description Modal Elements
        const descriptionModal = document.getElementById('description-modal');
        const closeDescriptionBtn = document.querySelector('#description-modal .modal-close');

        // Add Task Button Click
        addTaskBtn.addEventListener('click', function() {
            taskForm.reset();
            addTaskModal.classList.add('active');
        });

        // Close Add Task Modal
        closeAddTaskBtn.addEventListener('click', function() {
            addTaskModal.classList.remove('active');
        });

        cancelAddTaskBtn.addEventListener('click', function() {
            addTaskModal.classList.remove('active');
        });

        // Close Edit Task Modal
        closeEditTaskBtn.addEventListener('click', function() {
            editTaskModal.classList.remove('active');
        });

        cancelEditTaskBtn.addEventListener('click', function() {
            editTaskModal.classList.remove('active');
        });

        // Close Description Modal
        closeDescriptionBtn.addEventListener('click', function() {
            descriptionModal.classList.remove('active');
        });

        // Save Task Button Click
        saveTaskBtn.addEventListener('click', function() {
            if (taskForm.checkValidity()) {
                taskForm.submit();
            } else {
                taskForm.reportValidity();
            }
        });

        // Save Edit Task Button Click
        saveEditTaskBtn.addEventListener('click', function() {
            if (editTaskForm.checkValidity()) {
                editTaskForm.submit();
            } else {
                editTaskForm.reportValidity();
            }
        });

        // Close modals when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === addTaskModal) {
                addTaskModal.classList.remove('active');
            }
            if (event.target === editTaskModal) {
                editTaskModal.classList.remove('active');
            }
            if (event.target === descriptionModal) {
                descriptionModal.classList.remove('active');
            }
        });
    });

    // Function to show full description modal
    function showDescription(description) {
        const fullDescriptionElement = document.getElementById('full-description');
        fullDescriptionElement.textContent = description;
        document.getElementById('description-modal').classList.add('active');
    }

    // Function to close description modal
    function closeDescriptionModal() {
        document.getElementById('description-modal').classList.remove('active');
    }

    // Function to open edit task modal with task data
    function editTask(taskId) {
        // Find the row with the matching task ID
        const taskRow = document.querySelector(`tr[data-task-id="${taskId}"]`);

        if (!taskRow) {
            console.error('Task row not found for ID:', taskId);
            return;
        }

        // Get data from the row
        const title = taskRow.cells[3].textContent.trim();
        const dueDate = taskRow.cells[5].textContent.trim();
        const statusElement = taskRow.querySelector('.status-badge');
        const status = statusElement ? statusElement.textContent.trim() : 'PENDING';
        const assignedToCell = taskRow.cells[2];
        const assignedToId = assignedToCell.getAttribute('data-user-id');

        // Get full description (from hidden span if available)
        let description = '';
        const descCell = taskRow.cells[4];
        const fullDescSpan = descCell.querySelector('.full-description');

        if (fullDescSpan) {
            description = fullDescSpan.textContent;
        } else {
            // If no hidden span, try getting visible text
            const descText = descCell.querySelector('.description-text');
            if (descText) {
                description = descText.textContent;
            } else {
                description = descCell.textContent.trim();
            }
        }

        // Set values in the edit form
        document.getElementById('edit-task-id').value = taskId;
        document.getElementById('edit-title').value = title;
        document.getElementById('edit-description').value = description;
        document.getElementById('edit-dueDate').value = formatDate(dueDate);
        document.getElementById('edit-status').value = status;

        // Set assigned to dropdown
        if (assignedToId) {
            document.getElementById('edit-assignedTo').value = assignedToId;
        }

        // Show the edit modal
        document.getElementById('edit-task-modal').classList.add('active');
    }

    // Helper function to format date for the date input
    function formatDate(dateString) {
        try {
            dateString = dateString.trim();

            // Try direct ISO conversion first
            const isoDate = new Date(dateString).toISOString().split('T')[0];
            if (isoDate !== 'Invalid Date' && isoDate !== undefined) {
                return isoDate;
            }

            // If that fails, try to parse different formats
            let date;

            // Check for date formats with slashes or dashes
            if (dateString.includes('/') || dateString.includes('-')) {
                const separator = dateString.includes('/') ? '/' : '-';
                const parts = dateString.split(separator);

                if (parts.length === 3) {
                    // Determine if format is MM/DD/YYYY, DD/MM/YYYY or YYYY/MM/DD
                    if (parts[0].length === 4) {
                        // YYYY-MM-DD
                        date = new Date(parts[0], parseInt(parts[1]) - 1, parts[2]);
                    } else if (parseInt(parts[0]) > 12) {
                        // DD-MM-YYYY
                        date = new Date(parts[2], parseInt(parts[1]) - 1, parts[0]);
                    } else {
                        // MM-DD-YYYY (default US format)
                        date = new Date(parts[2], parseInt(parts[0]) - 1, parts[1]);
                    }
                }
            } else {
                // Try to parse as a standard date string
                date = new Date(dateString);
            }

            if (isNaN(date.getTime())) {
                console.error('Invalid date:', dateString);
                return '';
            }

            // Format as YYYY-MM-DD
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');

            return `${year}-${month}-${day}`;
        } catch (e) {
            console.error('Error formatting date:', e);
            return '';
        }
    }
</script>
</body>
</html>