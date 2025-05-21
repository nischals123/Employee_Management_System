<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<%@ page import="dao.UserDAO" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tasks</title>
    <style>
        /* General Layout and Modal Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .main-content {
            margin-left: 250px; /* Adjust according to sidebar width */
            padding: 20px;
        }

        /* Sidebar Styling */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 15px;
            display: block;
            font-size: 18px;
            border-bottom: 1px solid #484848;
        }

        .sidebar a:hover {
            background-color: #575d63;
        }

        /* Navbar Styling */
        .navbar {
            position: fixed;
            top: 0;
            left: 250px;
            width: calc(100% - 250px);
            background-color: #007bff;
            color: white;
            padding: 10px;
            font-size: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
        }

        /* Task Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        .task-link {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }

        .task-link:hover {
            text-decoration: underline;
        }

        .badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-success {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-info {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .badge-warning {
            background-color: #fff3cd;
            color: #856404;
        }

        .badge-secondary {
            background-color: #e2e3e5;
            color: #383d41;
        }

        .text-center {
            text-align: center;
        }

        /* Modal Styles */
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 80%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
        }

        .close-button {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 24px;
            cursor: pointer;
            color: #666;
        }

        .close-button:hover {
            color: #000;
        }

        .task-details {
            margin-bottom: 20px;
        }

        .attachment-display {
            margin: 15px 0;
        }

        .img-preview {
            max-width: 100%;
            max-height: 200px;
            display: block;
            margin: 10px 0;
            border: 1px solid #ddd;
        }

        .attachment-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            background-color: #f5f5f5;
            border-radius: 4px;
            color: #333;
            text-decoration: none;
            margin-top: 5px;
        }

        .attachment-link:hover {
            background-color: #e9e9e9;
        }

        .task-form {
            margin-top: 20px;
        }

        .task-form label {
            display: block;
            margin-top: 10px;
            font-weight: 500;
        }

        .task-form input[type="file"],
        .task-form textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .submit-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
        }

        .btn.reject {
            background-color: #6c757d;
        }

        .content-card {
            padding: 20px;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>

<body>
    <!-- Sidebar Include -->
    <%@ include file="../includes/sidebar.jsp" %>

    

    <div class="main-content">
        <section class="content-card">
            <h2><i class="fas fa-tasks"></i> My Tasks</h2>

            <table>
                <thead>
                    <tr>
                        <th>Task</th>
                        <th>Assigned By</th>
                        <th>Deadline</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty tasks}">
                            <c:forEach var="task" items="${tasks}">
                                <tr>
                                    <td>
                                        <a href="#" class="task-link"
                                           data-title="${task.title}"
                                           data-assigned-by="${UserDAO.getUserNameFromId(task.assignedBy)}"
                                           data-deadline="${task.dueDate}"
                                           data-status="${task.status}"
                                           data-desc="${task.description}"
                                           data-task-id="${task.id}">
                                            ${task.title}
                                        </a>
                                    </td>
                                    <td>${UserDAO.getUserNameFromId(task.assignedBy)}</td>
                                    <td>${task.dueDate}</td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                              <c:when test="${task.status eq 'COMPLETED'}">badge-success</c:when>
                                              <c:when test="${task.status eq 'IN_PROGRESS'}">badge-info</c:when>
                                              <c:when test="${task.status eq 'PENDING'}">badge-warning</c:when>
                                              <c:otherwise>badge-secondary</c:otherwise>
                                            </c:choose>">
                                            ${task.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="4" class="text-center">No tasks assigned to you.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </section>
    </div>

    <!-- Task Detail Modal -->
    <div id="taskDetailModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close-button" onclick="closeTaskDetailModal()">&times;</span>
            <h3><i class="fas fa-info-circle"></i> Task Detail</h3>

            <div class="task-details">
                <p><strong>Task:</strong> <span id="taskTitleText"></span></p>
                <p><strong>Assigned By:</strong> <span id="taskAssignedBy"></span></p>
                <p><strong>Deadline:</strong> <span id="taskDeadline"></span></p>
                <p><strong>Status:</strong> <span id="taskStatus"></span></p>

                <div class="attachment-display">
                    <p><strong>Attachment:</strong></p>
                    <div id="attachmentPreview"></div>
                </div>

                <p><strong>Admin Description:</strong><br><span id="taskAdminDesc"></span></p>
            </div>

            <hr>

            <form id="taskSubmitForm" method="post" action="${pageContext.request.contextPath}/submit-task" enctype="multipart/form-data" class="task-form">
                <input type="hidden" id="taskId" name="taskId" value="" />
                <h4><i class="fas fa-upload"></i> Submit Your Work</h4>
                <label for="taskFile">Upload File</label>
                <input type="file" id="taskFile" name="taskFile" required />

                <label for="taskNote">Your Notes</label>
                <textarea id="taskNote" name="taskNote" placeholder="Add your notes or explanation..." rows="4"></textarea>

                <div class="submit-actions">
                    <button type="submit" class="btn">Submit</button>
                    <button type="button" class="btn reject" onclick="closeTaskDetailModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const taskLinks = document.querySelectorAll('.task-link');

            taskLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();

                    const title = this.getAttribute('data-title');
                    const assignedBy = this.getAttribute('data-assigned-by');
                    const deadline = this.getAttribute('data-deadline');
                    const status = this.getAttribute('data-status');
                    const desc = this.getAttribute('data-desc');
                    const taskId = this.getAttribute('data-task-id');

                    document.getElementById('taskTitleText').textContent = title;
                    document.getElementById('taskAssignedBy').textContent = assignedBy;
                    document.getElementById('taskDeadline').textContent = deadline;
                    document.getElementById('taskStatus').textContent = status;
                    document.getElementById('taskAdminDesc').textContent = desc;
                    document.getElementById('taskId').value = taskId;

                    const attachmentPreview = document.getElementById('attachmentPreview');
                    attachmentPreview.innerHTML = '';

                    // Add attachment preview logic here...

                    document.getElementById('taskDetailModal').style.display = 'block';
                });
            });
        });

        function closeTaskDetailModal() {
            document.getElementById('taskDetailModal').style.display = 'none';
            document.getElementById('taskSubmitForm').reset();
        }

        window.onclick = function(event) {
            const modal = document.getElementById('taskDetailModal');
            if (event.target == modal) {
                closeTaskDetailModal();
            }
        };
    </script>
</body>
</html>
