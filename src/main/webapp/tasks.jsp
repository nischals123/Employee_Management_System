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
    <title>Tasks - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for tasks page */
        .task-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 15px;
            margin-bottom: 15px;
            transition: transform 0.2s ease;
            border-left: 4px solid #3498db;
        }
        
        .task-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .task-card.priority-low {
            border-left-color: #3498db;
        }
        
        .task-card.priority-medium {
            border-left-color: #f39c12;
        }
        
        .task-card.priority-high {
            border-left-color: #e67e22;
        }
        
        .task-card.priority-urgent {
            border-left-color: #e74c3c;
        }
        
        .task-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }
        
        .task-title {
            margin: 0;
            font-size: 1.1rem;
            color: #2c3e50;
        }
        
        .task-status {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-todo {
            background-color: #e7f3fe;
            color: #3498db;
        }
        
        .status-in-progress {
            background-color: #fef5e7;
            color: #f39c12;
        }
        
        .status-review {
            background-color: #fdebd0;
            color: #e67e22;
        }
        
        .status-completed {
            background-color: #e3f9e5;
            color: #2ecc71;
        }
        
        .task-details {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 10px;
        }
        
        .task-detail {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85rem;
            color: #7f8c8d;
        }
        
        .task-description {
            margin-bottom: 15px;
            color: #34495e;
            font-size: 0.9rem;
        }
        
        .task-project {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            background-color: #eee;
            color: #555;
            margin-bottom: 10px;
        }
        
        .task-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .task-form {
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
        
        .tasks-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .task-column {
            background-color: #f5f7fa;
            border-radius: 10px;
            padding: 15px;
        }
        
        .column-header {
            margin-top: 0;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
            font-size: 1rem;
            color: #2c3e50;
        }
        
        .task-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 20px;
            height: 20px;
            background-color: #3498db;
            color: white;
            border-radius: 50%;
            font-size: 0.7rem;
            margin-left: 5px;
        }
        
        .priority-badge {
            display: inline-block;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        .priority-low {
            background-color: #e7f3fe;
            color: #3498db;
        }
        
        .priority-medium {
            background-color: #fef5e7;
            color: #f39c12;
        }
        
        .priority-high {
            background-color: #fdebd0;
            color: #e67e22;
        }
        
        .priority-urgent {
            background-color: #fde8e8;
            color: #e74c3c;
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
                    <li>
                        <a href="leave-requests.jsp"><i class="fas fa-calendar-minus"></i> Leave Requests</a>
                    </li>
                    <li>
                        <a href="projects.jsp"><i class="fas fa-project-diagram"></i> Projects</a>
                    </li>
                    <li class="active">
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
                    <h1><i class="fas fa-tasks"></i> Tasks</h1>
                </div>
                <div class="header-right">
                    <div class="notification-bell">
                        <i class="far fa-bell"></i>
                        <span class="notification-count">3</span>
                    </div>
                </div>
            </header>

            <!-- Tasks Content -->
            <div class="dashboard-content">
                <!-- Create New Task (visible to managers and project leads) -->
                <c:if test="${sessionScope.user.role.name eq 'Manager' or sessionScope.user.role.name eq 'Admin'}">
                    <div class="content-section">
                        <div class="section-header">
                            <h2>Create New Task</h2>
                            <button class="btn btn-sm" id="toggle-task-form">
                                <i class="fas fa-plus"></i> New Task
                            </button>
                        </div>
                        
                        <div class="task-form" id="new-task-form" style="display: none;">
                            <form id="create-task-form">
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="task-title">Task Title</label>
                                        <input type="text" id="task-title" name="task-title" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="task-project">Project</label>
                                        <select id="task-project" name="task-project" required>
                                            <option value="">Select Project</option>
                                            <option value="1">Website Redesign</option>
                                            <option value="2">Q4 Marketing Campaign</option>
                                            <option value="3">Q2 Financial Audit</option>
                                            <option value="4">Employee Training Program</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="task-assignee">Assign To</label>
                                        <select id="task-assignee" name="task-assignee" required>
                                            <option value="">Select Employee</option>
                                            <option value="1">kp oli</option>
                                            <option value="2">Sher badhurdeuba</option>
                                            <option value="3">Prachanda</option>
                                            <option value="4">Balen Shah</option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="task-due-date">Due Date</label>
                                        <input type="date" id="task-due-date" name="task-due-date" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="task-priority">Priority</label>
                                        <select id="task-priority" name="task-priority" required>
                                            <option value="Low">Low</option>
                                            <option value="Medium" selected>Medium</option>
                                            <option value="High">High</option>
                                            <option value="Urgent">Urgent</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="task-description">Description</label>
                                    <textarea id="task-description" name="task-description" required></textarea>
                                </div>
                                
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">Create Task</button>
                                    <button type="button" class="btn btn-secondary" id="cancel-task">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
                
                <!-- Task Filters -->
                <div class="content-section">
                    <div class="section-header">
                        <h2>My Tasks</h2>
                        
                        <div class="filter-options">
                            <select id="project-filter">
                                <option value="all">All Projects</option>
                                <option value="1">Website Redesign</option>
                                <option value="2">Q4 Marketing Campaign</option>
                                <option value="3">Q2 Financial Audit</option>
                                <option value="4">Employee Training Program</option>
                            </select>
                            
                            <select id="priority-filter">
                                <option value="all">All Priorities</option>
                                <option value="Low">Low</option>
                                <option value="Medium">Medium</option>
                                <option value="High">High</option>
                                <option value="Urgent">Urgent</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Tasks Kanban Board -->
                    <div class="tasks-container">
                        <!-- To Do Column -->
                        <div class="task-column">
                            <h3 class="column-header">To Do <span class="task-badge">2</span></h3>
                            
                            <div class="task-card priority-medium" data-project="1" data-priority="Medium">
                                <div class="task-header">
                                    <h4 class="task-title">Create mobile responsive design</h4>
                                    <span class="task-status status-todo">To Do</span>
                                </div>
                                
                                <div class="task-project">
                                    <i class="fas fa-project-diagram"></i> Website Redesign
                                </div>
                                
                                <div class="task-description">
                                    Implement responsive design for mobile devices following the approved mockups.
                                </div>
                                
                                <div class="task-details">
                                    <div class="task-detail">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Due: Sep 15, 2023</span>
                                    </div>
                                    <div class="task-detail">
                                        <i class="fas fa-flag"></i>
                                        <span class="priority-badge priority-medium">Medium</span>
                                    </div>
                                </div>
                                
                                <div class="task-actions">
                                    <button class="btn btn-sm btn-secondary">
                                        <i class="fas fa-arrow-right"></i> Start
                                    </button>
                                </div>
                            </div>
                            
                            <div class="task-card priority-low" data-project="2" data-priority="Low">
                                <div class="task-header">
                                    <h4 class="task-title">Research competitor campaigns</h4>
                                    <span class="task-status status-todo">To Do</span>
                                </div>
                                
                                <div class="task-project">
                                    <i class="fas fa-project-diagram"></i> Q4 Marketing Campaign
                                </div>
                                
                                <div class="task-description">
                                    Research and analyze competitor marketing campaigns for the holiday season.
                                </div>
                                
                                <div class="task-details">
                                    <div class="task-detail">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Due: Oct 5, 2023</span>
                                    </div>
                                    <div class="task-detail">
                                        <i class="fas fa-flag"></i>
                                        <span class="priority-badge priority-low">Low</span>
                                    </div>
                                </div>
                                
                                <div class="task-actions">
                                    <button class="btn btn-sm btn-secondary">
                                        <i class="fas fa-arrow-right"></i> Start
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <!-- In Progress Column -->
                        <div class="task-column">
                            <h3 class="column-header">In Progress <span class="task-badge">2</span></h3>
                            
                            <div class="task-card priority-high" data-project="1" data-priority="High">
                                <div class="task-header">
                                    <h4 class="task-title">Implement user authentication</h4>
                                    <span class="task-status status-in-progress">In Progress</span>
                                </div>
                                
                                <div class="task-project">
                                    <i class="fas fa-project-diagram"></i> Website Redesign
                                </div>
                                
                                <div class="task-description">
                                    Implement secure user authentication system with password reset functionality.
                                </div>
                                
                                <div class="task-details">
                                    <div class="task-detail">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Due: Sep 10, 2023</span>
                                    </div>
                                    <div class="task-detail">
                                        <i class="fas fa-flag"></i>
                                        <span class="priority-badge priority-high">High</span>
                                    </div>
                                </div>
                                
                                <div class="task-actions">
                                    <button class="btn btn-sm btn-secondary">
                                        <i class="fas fa-check"></i> Complete
                                    </button>
                                </div>
                            </div>
                            
                            <div class="task-card priority-urgent" data-project="4" data-priority="Urgent">
                                <div class="task-header">
                                    <h4 class="task-title">Prepare training materials</h4>
                                    <span class="task-status status-in-progress">In Progress</span>
                                </div>
                                
                                <div class="task-project">
                                    <i class="fas fa-project-diagram"></i> Employee Training Program
                                </div>
                                
                                <div class="task-description">
                                    Create comprehensive training materials for the new employee onboarding process.
                                </div>
                                
                                <div class="task-details">
                                    <div class="task-detail">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Due: Aug 20, 2023</span>
                                    </div>
                                    <div class="task-detail">
                                        <i class="fas fa-flag"></i>
                                        <span class="priority-badge priority-urgent">Urgent</span>
                                    </div>
                                </div>
                                
                                <div class="task-actions">
                                    <button class="btn btn-sm btn-secondary">
                                        <i class="fas fa-check"></i> Complete
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Review Column -->
                        <div class="task-column">
                            <h3 class="column-header">Review <span class="task-badge">1</span></h3>
                            
                            <div class="task-card priority-medium" data-project="1" data-priority="Medium">
                                <div class="task-header">
                                    <h4 class="task-title">Design homepage layout</h4>
                                    <span class="task-status status-review">Review</span>
                                </div>
                                
                                <div class="task-project">
                                    <i class="fas fa-project-diagram"></i> Website Redesign
                                </div>
                                
                                <div class="task-description">
                                    Create a modern and user-friendly homepage design with improved navigation.
                                </div>
                                
                                <div class="task-details">
                                    <div class="task-detail">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Due: Sep 5, 2023</span>
                                    </div>
                                    <div class="task-detail">
                                        <i class="fas fa-flag"></i>
                                        <span class="priority-badge priority-medium">Medium</span>
                                    </div>
                                </div>
                                
                                <div class="task-actions">
                                    <button class="btn btn-sm btn-secondary">
                                        <i class="fas fa-check"></i> Approve
                                    </button>
                                    <button class="btn btn-sm">
                                        <i class="fas fa-redo"></i> Revise
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Completed Column -->
                        <div class="task-column">
                            <h3 class="column-header">Completed <span class="task-badge">1</span></h3>
                            
                            <div class="task-card priority-high" data-project="3" data-priority="High">
                                <div class="task-header">
                                    <h4 class="task-title">Prepare financial statements</h4>
                                    <span class="task-status status-completed">Completed</span>
                                </div>
                                
                                <div class="task-project">
                                    <i class="fas fa-project-diagram"></i> Q2 Financial Audit
                                </div>
                                
                                <div class="task-description">
                                    Prepare and review Q2 financial statements for the audit team.
                                </div>
                                
                                <div class="task-details">
                                    <div class="task-detail">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Due: Jun 15, 2023</span>
                                    </div>
                                    <div class="task-detail">
                                        <i class="fas fa-flag"></i>
                                        <span class="priority-badge priority-high">High</span>
                                    </div>
                                    <div class="task-detail">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Completed: Jun 14, 2023</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- JavaScript for Tasks Page -->
    <script>
        // Toggle new task form
        document.getElementById('toggle-task-form').addEventListener('click', function() {
            const form = document.getElementById('new-task-form');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        });
        
        document.getElementById('cancel-task').addEventListener('click', function() {
            document.getElementById('new-task-form').style.display = 'none';
            document.getElementById('create-task-form').reset();
        });
        
        // Task form submission
        document.getElementById('create-task-form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // In a real application, this would send an AJAX request to the server
            const taskTitle = document.getElementById('task-title').value;
            const project = document.getElementById('task-project').value;
            const assignee = document.getElementById('task-assignee').value;
            const dueDate = document.getElementById('task-due-date').value;
            const priority = document.getElementById('task-priority').value;
            const description = document.getElementById('task-description').value;
            
            // Show success message (in a real app, this would happen after successful server response)
            alert('Task created successfully!');
            this.reset();
            document.getElementById('new-task-form').style.display = 'none';
        });
        
        // Project filter functionality
        document.getElementById('project-filter').addEventListener('change', function() {
            filterTasks();
        });
        
        // Priority filter functionality
        document.getElementById('priority-filter').addEventListener('change', function() {
            filterTasks();
        });
        
        function filterTasks() {
            const projectFilter = document.getElementById('project-filter').value;
            const priorityFilter = document.getElementById('priority-filter').value;
            const tasks = document.querySelectorAll('.task-card');
            
            tasks.forEach(task => {
                const projectMatch = projectFilter === 'all' || task.getAttribute('data-project') === projectFilter;
                const priorityMatch = priorityFilter === 'all' || task.getAttribute('data-priority') === priorityFilter;
                
                if (projectMatch && priorityMatch) {
                    task.style.display = '';
                } else {
                    task.style.display = 'none';
                }
            });
            
            // Update task count badges
            updateTaskCounts();
        }
        
        function updateTaskCounts() {
            const columns = document.querySelectorAll('.task-column');
            
            columns.forEach(column => {
                const visibleTasks = column.querySelectorAll('.task-card[style=""]').length;
                const badge = column.querySelector('.task-badge');
                badge.textContent = visibleTasks;
            });
        }
    </script>
</body>
</html>
