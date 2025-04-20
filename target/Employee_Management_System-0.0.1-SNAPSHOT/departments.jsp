<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for departments page */
        .department-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .add-department-btn {
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
        
        .add-department-btn i {
            margin-right: 8px;
        }
        
        .add-department-btn:hover {
            background-color: #2980b9;
        }
        
        .departments-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .department-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .department-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .department-header-bg {
            height: 80px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            position: relative;
        }
        
        .department-icon {
            width: 60px;
            height: 60px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: absolute;
            bottom: -30px;
            left: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .department-icon i {
            font-size: 24px;
            color: #3498db;
        }
        
        .department-body {
            padding: 40px 20px 20px;
        }
        
        .department-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #2c3e50;
        }
        
        .department-description {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 15px;
            height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .department-stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-value {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .stat-label {
            font-size: 12px;
            color: #7f8c8d;
        }
        
        .department-manager {
            display: flex;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #ecf0f1;
        }
        
        .manager-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3498db;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            margin-right: 10px;
            overflow: hidden;
        }
        
        .manager-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .manager-info {
            flex: 1;
        }
        
        .manager-name {
            font-size: 14px;
            font-weight: 500;
            color: #2c3e50;
        }
        
        .manager-title {
            font-size: 12px;
            color: #7f8c8d;
        }
        
        .department-actions {
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
        
        /* Department colors */
        .department-card.cs .department-header-bg {
            background: linear-gradient(135deg, #3498db, #2980b9);
        }
        
        .department-card.cs .department-icon i {
            color: #3498db;
        }
        
        .department-card.electrical .department-header-bg {
            background: linear-gradient(135deg, #f39c12, #d35400);
        }
        
        .department-card.electrical .department-icon i {
            color: #f39c12;
        }
        
        .department-card.mechanical .department-header-bg {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
        }
        
        .department-card.mechanical .department-icon i {
            color: #2ecc71;
        }
        
        .department-card.civil .department-header-bg {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
        }
        
        .department-card.civil .department-icon i {
            color: #9b59b6;
        }
        
        .department-card.hr .department-header-bg {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
        }
        
        .department-card.hr .department-icon i {
            color: #e74c3c;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal.active {
            display: flex;
        }
        
        .modal-content {
            background-color: white;
            border-radius: 10px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .modal-header {
            padding: 20px;
            background-color: #3498db;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-header h3 {
            margin: 0;
            font-size: 18px;
        }
        
        .modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
        }
        
        .modal-body {
            padding: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #2c3e50;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #dfe6e9;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        
        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #ecf0f1;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .btn-cancel {
            background-color: #ecf0f1;
            color: #7f8c8d;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 14px;
            cursor: pointer;
        }
        
        .btn-save {
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 14px;
            cursor: pointer;
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
                    <li class="active">
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
                    <h1>Departments</h1>
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

            <!-- Departments Content -->
            <div class="dashboard-content">
                <div class="department-header">
                    <div class="department-info">
                        <h2>All Departments</h2>
                        <p>Manage your organization's departments</p>
                    </div>
                    
                    <button class="add-department-btn" id="add-department-btn">
                        <i class="fas fa-plus"></i> Add Department
                    </button>
                </div>
                
                <div class="departments-grid">
                    <!-- Computer Science Department -->
                    <div class="department-card cs">
                        <div class="department-header-bg">
                            <div class="department-icon">
                                <i class="fas fa-laptop-code"></i>
                            </div>
                        </div>
                        <div class="department-body">
                            <h3 class="department-name">Computer Science</h3>
                            <p class="department-description">IT and software development department responsible for all technology initiatives.</p>
                            
                            <div class="department-stats">
                                <div class="stat-item">
                                    <div class="stat-value">32</div>
                                    <div class="stat-label">Employees</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">5</div>
                                    <div class="stat-label">Projects</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">2</div>
                                    <div class="stat-label">Managers</div>
                                </div>
                            </div>
                            
                            <div class="department-manager">
                                <div class="manager-avatar">
                                    <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="John Doe">
                                </div>
                                <div class="manager-info">
                                    <div class="manager-name">John Doe</div>
                                    <div class="manager-title">Department Head</div>
                                </div>
                                <div class="department-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Electrical Department -->
                    <div class="department-card electrical">
                        <div class="department-header-bg">
                            <div class="department-icon">
                                <i class="fas fa-bolt"></i>
                            </div>
                        </div>
                        <div class="department-body">
                            <h3 class="department-name">Electrical</h3>
                            <p class="department-description">Electrical engineering department focused on power systems and electronics.</p>
                            
                            <div class="department-stats">
                                <div class="stat-item">
                                    <div class="stat-value">28</div>
                                    <div class="stat-label">Employees</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">4</div>
                                    <div class="stat-label">Projects</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">2</div>
                                    <div class="stat-label">Managers</div>
                                </div>
                            </div>
                            
                            <div class="department-manager">
                                <div class="manager-avatar">
                                    <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Jane Smith">
                                </div>
                                <div class="manager-info">
                                    <div class="manager-name">Jane Smith</div>
                                    <div class="manager-title">Department Head</div>
                                </div>
                                <div class="department-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Mechanical Department -->
                    <div class="department-card mechanical">
                        <div class="department-header-bg">
                            <div class="department-icon">
                                <i class="fas fa-cogs"></i>
                            </div>
                        </div>
                        <div class="department-body">
                            <h3 class="department-name">Mechanical</h3>
                            <p class="department-description">Mechanical engineering department specializing in design and manufacturing.</p>
                            
                            <div class="department-stats">
                                <div class="stat-item">
                                    <div class="stat-value">25</div>
                                    <div class="stat-label">Employees</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">3</div>
                                    <div class="stat-label">Projects</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">1</div>
                                    <div class="stat-label">Managers</div>
                                </div>
                            </div>
                            
                            <div class="department-manager">
                                <div class="manager-avatar">
                                    <img src="https://randomuser.me/api/portraits/men/67.jpg" alt="Robert Johnson">
                                </div>
                                <div class="manager-info">
                                    <div class="manager-name">Robert Johnson</div>
                                    <div class="manager-title">Department Head</div>
                                </div>
                                <div class="department-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Civil Department -->
                    <div class="department-card civil">
                        <div class="department-header-bg">
                            <div class="department-icon">
                                <i class="fas fa-hard-hat"></i>
                            </div>
                        </div>
                        <div class="department-body">
                            <h3 class="department-name">Civil</h3>
                            <p class="department-description">Civil engineering department focused on infrastructure and construction projects.</p>
                            
                            <div class="department-stats">
                                <div class="stat-item">
                                    <div class="stat-value">30</div>
                                    <div class="stat-label">Employees</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">2</div>
                                    <div class="stat-label">Projects</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">2</div>
                                    <div class="stat-label">Managers</div>
                                </div>
                            </div>
                            
                            <div class="department-manager">
                                <div class="manager-avatar">
                                    <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Michael Wilson">
                                </div>
                                <div class="manager-info">
                                    <div class="manager-name">Michael Wilson</div>
                                    <div class="manager-title">Department Head</div>
                                </div>
                                <div class="department-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Human Resources Department -->
                    <div class="department-card hr">
                        <div class="department-header-bg">
                            <div class="department-icon">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                        <div class="department-body">
                            <h3 class="department-name">Human Resources</h3>
                            <p class="department-description">HR department responsible for recruitment, employee relations, and benefits.</p>
                            
                            <div class="department-stats">
                                <div class="stat-item">
                                    <div class="stat-value">10</div>
                                    <div class="stat-label">Employees</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">1</div>
                                    <div class="stat-label">Projects</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">1</div>
                                    <div class="stat-label">Managers</div>
                                </div>
                            </div>
                            
                            <div class="department-manager">
                                <div class="manager-avatar">
                                    <img src="https://randomuser.me/api/portraits/women/22.jpg" alt="Emily Davis">
                                </div>
                                <div class="manager-info">
                                    <div class="manager-name">Emily Davis</div>
                                    <div class="manager-title">Department Head</div>
                                </div>
                                <div class="department-actions">
                                    <div class="action-btn view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-btn edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Add Department Modal -->
    <div class="modal" id="department-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Add New Department</h3>
                <button class="modal-close">&times;</button>
            </div>
            <div class="modal-body">
                <form id="department-form">
                    <div class="form-group">
                        <label for="department-name">Department Name</label>
                        <input type="text" id="department-name" name="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="department-description">Description</label>
                        <textarea id="department-description" name="description" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="department-manager">Department Manager</label>
                        <select id="department-manager" name="manager_id" required>
                            <option value="">Select Manager</option>
                            <option value="1">John Doe</option>
                            <option value="2">Jane Smith</option>
                            <option value="3">Robert Johnson</option>
                            <option value="4">Emily Davis</option>
                            <option value="5">Michael Wilson</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn-cancel" id="cancel-btn">Cancel</button>
                <button class="btn-save" id="save-btn">Save Department</button>
            </div>
        </div>
    </div>

    <script>
        // Display current date
        document.addEventListener('DOMContentLoaded', function() {
            const dateElement = document.getElementById('current-date');
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const today = new Date();
            dateElement.textContent = today.toLocaleDateString('en-US', options);
            
            // Modal functionality
            const modal = document.getElementById('department-modal');
            const addBtn = document.getElementById('add-department-btn');
            const closeBtn = document.querySelector('.modal-close');
            const cancelBtn = document.getElementById('cancel-btn');
            const saveBtn = document.getElementById('save-btn');
            
            addBtn.addEventListener('click', function() {
                modal.classList.add('active');
            });
            
            closeBtn.addEventListener('click', function() {
                modal.classList.remove('active');
            });
            
            cancelBtn.addEventListener('click', function() {
                modal.classList.remove('active');
            });
            
            saveBtn.addEventListener('click', function() {
                const form = document.getElementById('department-form');
                const name = document.getElementById('department-name').value;
                const description = document.getElementById('department-description').value;
                const managerId = document.getElementById('department-manager').value;
                
                if (name && description && managerId) {
                    // Here you would normally send the data to the server
                    alert(`Department "${name}" added successfully!`);
                    modal.classList.remove('active');
                    form.reset();
                } else {
                    alert('Please fill in all fields');
                }
            });
            
            // Close modal when clicking outside
            window.addEventListener('click', function(event) {
                if (event.target === modal) {
                    modal.classList.remove('active');
                }
            });
            
            // Add event listeners for action buttons
            document.querySelectorAll('.action-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const action = this.classList.contains('view') ? 'view' : 'edit';
                    const departmentName = this.closest('.department-body').querySelector('.department-name').textContent;
                    
                    if (action === 'view') {
                        alert(`View details for ${departmentName} department`);
                        // Redirect to department details page
                        // window.location.href = `department-details.jsp?id=${departmentId}`;
                    } else if (action === 'edit') {
                        alert(`Edit ${departmentName} department`);
                        // Open edit modal with department data
                        // Or redirect to edit page
                    }
                });
            });
        });
    </script>
</body>
</html>
