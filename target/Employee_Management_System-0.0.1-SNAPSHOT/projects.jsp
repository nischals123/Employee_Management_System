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
    <title>Projects - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for projects page */
        .project-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.2s ease;
        }
        
        .project-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .project-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        
        .project-title {
            margin: 0;
            font-size: 1.2rem;
            color: #2c3e50;
        }
        
        .project-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-not-started {
            background-color: #e7f3fe;
            color: #3498db;
        }
        
        .status-in-progress {
            background-color: #fef5e7;
            color: #f39c12;
        }
        
        .status-on-hold {
            background-color: #fdebd0;
            color: #e67e22;
        }
        
        .status-completed {
            background-color: #e3f9e5;
            color: #2ecc71;
        }
        
        .status-cancelled {
            background-color: #fde8e8;
            color: #e74c3c;
        }
        
        .project-details {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .project-detail {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.9rem;
            color: #7f8c8d;
        }
        
        .project-description {
            margin-bottom: 15px;
            color: #34495e;
        }
        
        .project-team {
            display: flex;
            gap: 5px;
        }
        
        .team-member {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            overflow: hidden;
            border: 2px solid white;
            margin-left: -10px;
        }
        
        .team-member:first-child {
            margin-left: 0;
        }
        
        .team-member img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .project-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 15px;
        }
        
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .project-form {
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
        
        .progress-bar {
            height: 6px;
            background-color: #ecf0f1;
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 5px;
        }
        
        .progress-fill {
            height: 100%;
            background-color: #3498db;
        }
        
        .progress-text {
            font-size: 0.8rem;
            color: #7f8c8d;
            text-align: right;
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
                    <li class="active">
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
                    <h1><i class="fas fa-project-diagram"></i> Projects</h1>
                </div>
                <div class="header-right">
                    <div class="notification-bell">
                        <i class="far fa-bell"></i>
                        <span class="notification-count">3</span>
                    </div>
                </div>
            </header>

            <!-- Projects Content -->
            <div class="dashboard-content">
                <!-- Create New Project (visible only to managers) -->
                <c:if test="${sessionScope.user.role.name eq 'Manager' or sessionScope.user.role.name eq 'Admin'}">
                    <div class="content-section">
                        <div class="section-header">
                            <h2>Create New Project</h2>
                            <button class="btn btn-sm" id="toggle-project-form">
                                <i class="fas fa-plus"></i> New Project
                            </button>
                        </div>
                        
                        <div class="project-form" id="new-project-form" style="display: none;">
                            <form id="create-project-form">
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="project-name">Project Name</label>
                                        <input type="text" id="project-name" name="project-name" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="project-department">Department</label>
                                        <select id="project-department" name="project-department" required>
                                            <option value="">Select Department</option>
                                            <option value="1">Computer Science</option>
                                            <option value="2">Human Resources</option>
                                            <option value="3">Marketing</option>
                                            <option value="4">Finance</option>
                                            <option value="5">Operations</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="project-start-date">Start Date</label>
                                        <input type="date" id="project-start-date" name="project-start-date" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="project-end-date">End Date</label>
                                        <input type="date" id="project-end-date" name="project-end-date" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="project-status">Status</label>
                                        <select id="project-status" name="project-status" required>
                                            <option value="Not Started">Not Started</option>
                                            <option value="In Progress">In Progress</option>
                                            <option value="On Hold">On Hold</option>
                                            <option value="Completed">Completed</option>
                                            <option value="Cancelled">Cancelled</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="project-description">Description</label>
                                    <textarea id="project-description" name="project-description" required></textarea>
                                </div>
                                
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">Create Project</button>
                                    <button type="button" class="btn btn-secondary" id="cancel-project">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
                
                <!-- Project Filters -->
                <div class="content-section">
                    <div class="section-header">
                        <h2>All Projects</h2>
                        
                        <div class="filter-options">
                            <select id="department-filter">
                                <option value="all">All Departments</option>
                                <option value="1">Computer Science</option>
                                <option value="2">Human Resources</option>
                                <option value="3">Marketing</option>
                                <option value="4">Finance</option>
                                <option value="5">Operations</option>
                            </select>
                            
                            <select id="status-filter">
                                <option value="all">All Statuses</option>
                                <option value="Not Started">Not Started</option>
                                <option value="In Progress">In Progress</option>
                                <option value="On Hold">On Hold</option>
                                <option value="Completed">Completed</option>
                                <option value="Cancelled">Cancelled</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Projects Grid -->
                    <div class="projects-grid">
                        <!-- Sample project cards - would be replaced with actual data from database -->
                        <div class="project-card" data-department="1" data-status="In Progress">
                            <div class="project-header">
                                <h3 class="project-title">Website Redesign</h3>
                                <span class="project-status status-in-progress">In Progress</span>
                            </div>
                            
                            <div class="project-details">
                                <div class="project-detail">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span>Jul 15, 2023 - Oct 30, 2023</span>
                                </div>
                                <div class="project-detail">
                                    <i class="fas fa-building"></i>
                                    <span>Computer Science</span>
                                </div>
                            </div>
                            
                            <div class="project-description">
                                Redesign and develop the company website with modern UI/UX principles and improved functionality.
                            </div>
                            
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 65%;"></div>
                            </div>
                            <div class="progress-text">65% Complete</div>
                            
                            <div class="project-team">
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="John Doe">
                                </div>
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Jane Smith">
                                </div>
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/men/67.jpg" alt="Mike Johnson">
                                </div>
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/women/33.jpg" alt="Sarah Williams">
                                </div>
                            </div>
                            
                            <div class="project-actions">
                                <button class="btn btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <button class="btn btn-sm">
                                    <i class="fas fa-tasks"></i> Tasks
                                </button>
                            </div>
                        </div>
                        
                        <div class="project-card" data-department="3" data-status="Not Started">
                            <div class="project-header">
                                <h3 class="project-title">Q4 Marketing Campaign</h3>
                                <span class="project-status status-not-started">Not Started</span>
                            </div>
                            
                            <div class="project-details">
                                <div class="project-detail">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span>Oct 1, 2023 - Dec 31, 2023</span>
                                </div>
                                <div class="project-detail">
                                    <i class="fas fa-building"></i>
                                    <span>Marketing</span>
                                </div>
                            </div>
                            
                            <div class="project-description">
                                Plan and execute the Q4 marketing campaign focusing on new product launches and holiday promotions.
                            </div>
                            
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 0%;"></div>
                            </div>
                            <div class="progress-text">0% Complete</div>
                            
                            <div class="project-team">
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/women/22.jpg" alt="Emily Davis">
                                </div>
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Robert Wilson">
                                </div>
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/women/67.jpg" alt="Lisa Brown">
                                </div>
                            </div>
                            
                            <div class="project-actions">
                                <button class="btn btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <button class="btn btn-sm">
                                    <i class="fas fa-tasks"></i> Tasks
                                </button>
                            </div>
                        </div>
                        
                        <div class="project-card" data-department="4" data-status="Completed">
                            <div class="project-header">
                                <h3 class="project-title">Q2 Financial Audit</h3>
                                <span class="project-status status-completed">Completed</span>
                            </div>
                            
                            <div class="project-details">
                                <div class="project-detail">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span>Apr 1, 2023 - Jun 30, 2023</span>
                                </div>
                                <div class="project-detail">
                                    <i class="fas fa-building"></i>
                                    <span>Finance</span>
                                </div>
                            </div>
                            
                            <div class="project-description">
                                Complete the Q2 financial audit and prepare reports for stakeholders and regulatory compliance.
                            </div>
                            
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 100%;"></div>
                            </div>
                            <div class="progress-text">100% Complete</div>
                            
                            <div class="project-team">
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/men/55.jpg" alt="David Clark">
                                </div>
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/women/76.jpg" alt="Jennifer Lee">
                                </div>
                            </div>
                            
                            <div class="project-actions">
                                <button class="btn btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <button class="btn btn-sm">
                                    <i class="fas fa-file-alt"></i> Report
                                </button>
                            </div>
                        </div>
                        
                        <div class="project-card" data-department="2" data-status="On Hold">
                            <div class="project-header">
                                <h3 class="project-title">Employee Training Program</h3>
                                <span class="project-status status-on-hold">On Hold</span>
                            </div>
                            
                            <div class="project-details">
                                <div class="project-detail">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span>Jun 1, 2023 - Aug 31, 2023</span>
                                </div>
                                <div class="project-detail">
                                    <i class="fas fa-building"></i>
                                    <span>Human Resources</span>
                                </div>
                            </div>
                            
                            <div class="project-description">
                                Develop and implement a comprehensive training program for new and existing employees.
                            </div>
                            
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 40%;"></div>
                            </div>
                            <div class="progress-text">40% Complete</div>
                            
                            <div class="project-team">
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/women/33.jpg" alt="Sarah Williams">
                                </div>
                                <div class="team-member">
                                    <img src="https://randomuser.me/api/portraits/men/22.jpg" alt="Thomas Anderson">
                                </div>
                            </div>
                            
                            <div class="project-actions">
                                <button class="btn btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <button class="btn btn-sm">
                                    <i class="fas fa-tasks"></i> Tasks
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- JavaScript for Projects Page -->
    <script>
        // Toggle new project form
        document.getElementById('toggle-project-form').addEventListener('click', function() {
            const form = document.getElementById('new-project-form');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        });
        
        document.getElementById('cancel-project').addEventListener('click', function() {
            document.getElementById('new-project-form').style.display = 'none';
            document.getElementById('create-project-form').reset();
        });
        
        // Project form submission
        document.getElementById('create-project-form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // In a real application, this would send an AJAX request to the server
            const projectName = document.getElementById('project-name').value;
            const department = document.getElementById('project-department').value;
            const startDate = document.getElementById('project-start-date').value;
            const endDate = document.getElementById('project-end-date').value;
            const status = document.getElementById('project-status').value;
            const description = document.getElementById('project-description').value;
            
            // Validate dates
            if (new Date(startDate) > new Date(endDate)) {
                alert('End date must be after start date');
                return;
            }
            
            // Show success message (in a real app, this would happen after successful server response)
            alert('Project created successfully!');
            this.reset();
            document.getElementById('new-project-form').style.display = 'none';
        });
        
        // Department filter functionality
        document.getElementById('department-filter').addEventListener('change', function() {
            filterProjects();
        });
        
        // Status filter functionality
        document.getElementById('status-filter').addEventListener('change', function() {
            filterProjects();
        });
        
        function filterProjects() {
            const departmentFilter = document.getElementById('department-filter').value;
            const statusFilter = document.getElementById('status-filter').value;
            const projects = document.querySelectorAll('.project-card');
            
            projects.forEach(project => {
                const departmentMatch = departmentFilter === 'all' || project.getAttribute('data-department') === departmentFilter;
                const statusMatch = statusFilter === 'all' || project.getAttribute('data-status') === statusFilter;
                
                if (departmentMatch && statusMatch) {
                    project.style.display = '';
                } else {
                    project.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>
