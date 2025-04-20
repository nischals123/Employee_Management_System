<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for profile page */
        .profile-container {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 30px;
        }
        
        .profile-sidebar {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #3498db, #2980b9);
            padding: 30px 20px;
            text-align: center;
            color: white;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 15px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            color: #3498db;
            overflow: hidden;
            border: 4px solid rgba(255, 255, 255, 0.3);
        }
        
        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .profile-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .profile-role {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .profile-info {
            padding: 20px;
        }
        
        .info-item {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .info-item:last-child {
            margin-bottom: 0;
        }
        
        .info-icon {
            width: 36px;
            height: 36px;
            background-color: #f5f7fa;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: #3498db;
        }
        
        .info-content {
            flex: 1;
        }
        
        .info-label {
            font-size: 12px;
            color: #7f8c8d;
            margin-bottom: 3px;
        }
        
        .info-value {
            font-size: 14px;
            color: #2c3e50;
            font-weight: 500;
        }
        
        .profile-main {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }
        
        .profile-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .card-header {
            padding: 20px;
            border-bottom: 1px solid #ecf0f1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-header h2 {
            margin: 0;
            font-size: 18px;
            color: #2c3e50;
        }
        
        .card-header-actions {
            display: flex;
            gap: 10px;
        }
        
        .card-btn {
            padding: 8px 15px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }
        
        .card-btn.edit {
            background-color: #3498db;
            color: white;
            border: none;
        }
        
        .card-btn.edit:hover {
            background-color: #2980b9;
        }
        
        .card-btn.cancel {
            background-color: #ecf0f1;
            color: #7f8c8d;
            border: none;
        }
        
        .card-btn.cancel:hover {
            background-color: #bdc3c7;
        }
        
        .card-btn.save {
            background-color: #2ecc71;
            color: white;
            border: none;
        }
        
        .card-btn.save:hover {
            background-color: #27ae60;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .profile-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .form-group {
            margin-bottom: 0;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #7f8c8d;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #dfe6e9;
            border-radius: 5px;
            font-size: 14px;
            color: #2c3e50;
        }
        
        .form-group input:disabled,
        .form-group select:disabled {
            background-color: #f5f7fa;
            cursor: not-allowed;
        }
        
        .form-group.full-width {
            grid-column: span 2;
        }
        
        .password-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .activity-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .activity-item {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }
        
        .activity-icon.blue {
            background-color: #d6eaf8;
            color: #3498db;
        }
        
        .activity-icon.green {
            background-color: #d5f5e3;
            color: #2ecc71;
        }
        
        .activity-icon.orange {
            background-color: #fef9e7;
            color: #f39c12;
        }
        
        .activity-icon.red {
            background-color: #fadbd8;
            color: #e74c3c;
        }
        
        .activity-content {
            flex: 1;
        }
        
        .activity-title {
            font-size: 14px;
            font-weight: 500;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .activity-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .activity-time {
            font-size: 12px;
            color: #7f8c8d;
        }
        
        .activity-status {
            font-size: 12px;
            padding: 3px 8px;
            border-radius: 12px;
        }
        
        .activity-status.completed {
            background-color: #d5f5e3;
            color: #2ecc71;
        }
        
        .activity-status.pending {
            background-color: #fef9e7;
            color: #f39c12;
        }
        
        .activity-status.rejected {
            background-color: #fadbd8;
            color: #e74c3c;
        }
        
        /* Responsive adjustments */
        @media (max-width: 992px) {
            .profile-container {
                grid-template-columns: 1fr;
            }
            
            .profile-sidebar {
                max-width: 400px;
                margin: 0 auto;
            }
        }
        
        @media (max-width: 768px) {
            .profile-form,
            .password-form {
                grid-template-columns: 1fr;
            }
            
            .form-group.full-width {
                grid-column: span 1;
            }
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
                    <li>
                        <a href="tasks.jsp"><i class="fas fa-tasks"></i> Tasks</a>
                    </li>
                    <li class="active">
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
                    <h1>My Profile</h1>
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

            <!-- Profile Content -->
            <div class="dashboard-content">
                <div class="profile-container">
                    <!-- Profile Sidebar -->
                    <div class="profile-sidebar">
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.picturePath}">
                                        <img src="${sessionScope.user.picturePath}" alt="${sessionScope.user.name}">
                                    </c:when>
                                    <c:otherwise>
                                        ${fn:substring(sessionScope.user.name, 0, 1)}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h2 class="profile-name">${sessionScope.user.name}</h2>
                            <p class="profile-role">${sessionScope.user.role.name}</p>
                        </div>
                        
                        <div class="profile-info">
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Email</div>
                                    <div class="info-value">${sessionScope.user.email}</div>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-phone"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Phone</div>
                                    <div class="info-value">${sessionScope.user.phone}</div>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-building"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Department</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.departmentId == 1}">Computer Science</c:when>
                                            <c:when test="${sessionScope.user.departmentId == 2}">Electrical</c:when>
                                            <c:when test="${sessionScope.user.departmentId == 3}">Mechanical</c:when>
                                            <c:when test="${sessionScope.user.departmentId == 4}">Civil</c:when>
                                            <c:when test="${sessionScope.user.departmentId == 5}">Human Resources</c:when>
                                            <c:otherwise>Not Assigned</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Hire Date</div>
                                    <div class="info-value">January 15, 2023</div>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-id-badge"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Employee ID</div>
                                    <div class="info-value">EMP-${sessionScope.user.id}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Profile Main Content -->
                    <div class="profile-main">
                        <!-- Personal Information -->
                        <div class="profile-card">
                            <div class="card-header">
                                <h2>Personal Information</h2>
                                <div class="card-header-actions">
                                    <button class="card-btn edit" id="edit-profile-btn">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="card-btn save" id="save-profile-btn" style="display: none;">
                                        <i class="fas fa-save"></i> Save
                                    </button>
                                    <button class="card-btn cancel" id="cancel-profile-btn" style="display: none;">
                                        <i class="fas fa-times"></i> Cancel
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <form class="profile-form" id="profile-form">
                                    <div class="form-group">
                                        <label for="full-name">Full Name</label>
                                        <input type="text" id="full-name" name="name" value="${sessionScope.user.name}" disabled>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input type="email" id="email" name="email" value="${sessionScope.user.email}" disabled>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="phone">Phone Number</label>
                                        <input type="text" id="phone" name="phone" value="${sessionScope.user.phone}" disabled>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="department">Department</label>
                                        <select id="department" name="department" disabled>
                                            <option value="1" ${sessionScope.user.departmentId == 1 ? 'selected' : ''}>Computer Science</option>
                                            <option value="2" ${sessionScope.user.departmentId == 2 ? 'selected' : ''}>Electrical</option>
                                            <option value="3" ${sessionScope.user.departmentId == 3 ? 'selected' : ''}>Mechanical</option>
                                            <option value="4" ${sessionScope.user.departmentId == 4 ? 'selected' : ''}>Civil</option>
                                            <option value="5" ${sessionScope.user.departmentId == 5 ? 'selected' : ''}>Human Resources</option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="hire-date">Hire Date</label>
                                        <input type="date" id="hire-date" name="hireDate" value="2023-01-15" disabled>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="role">Role</label>
                                        <select id="role" name="role" disabled>
                                            <option value="1" ${sessionScope.user.role.id == 1 ? 'selected' : ''}>Admin</option>
                                            <option value="2" ${sessionScope.user.role.id == 2 ? 'selected' : ''}>Manager</option>
                                            <option value="3" ${sessionScope.user.role.id == 3 ? 'selected' : ''}>Employee</option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group full-width">
                                        <label for="profile-picture">Profile Picture</label>
                                        <input type="file" id="profile-picture" name="profilePicture" disabled>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <!-- Change Password -->
                        <div class="profile-card">
                            <div class="card-header">
                                <h2>Change Password</h2>
                            </div>
                            <div class="card-body">
                                <form class="password-form">
                                    <div class="form-group">
                                        <label for="current-password">Current Password</label>
                                        <input type="password" id="current-password" name="currentPassword" placeholder="Enter your current password">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="new-password">New Password</label>
                                        <input type="password" id="new-password" name="newPassword" placeholder="Enter new password">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="confirm-password">Confirm New Password</label>
                                        <input type="password" id="confirm-password" name="confirmPassword" placeholder="Confirm new password">
                                    </div>
                                    
                                    <div class="form-group">
                                        <button type="button" class="card-btn save" id="change-password-btn">
                                            <i class="fas fa-key"></i> Update Password
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <!-- Recent Activities -->
                        <div class="profile-card">
                            <div class="card-header">
                                <h2>Recent Activities</h2>
                            </div>
                            <div class="card-body">
                                <ul class="activity-list">
                                    <li class="activity-item">
                                        <div class="activity-icon blue">
                                            <i class="fas fa-sign-in-alt"></i>
                                        </div>
                                        <div class="activity-content">
                                            <div class="activity-title">System Login</div>
                                            <div class="activity-meta">
                                                <span class="activity-time">Today, 9:30 AM</span>
                                            </div>
                                        </div>
                                    </li>
                                    
                                    <li class="activity-item">
                                        <div class="activity-icon green">
                                            <i class="fas fa-calendar-check"></i>
                                        </div>
                                        <div class="activity-content">
                                            <div class="activity-title">Marked Attendance</div>
                                            <div class="activity-meta">
                                                <span class="activity-time">Today, 9:35 AM</span>
                                                <span class="activity-status completed">Completed</span>
                                            </div>
                                        </div>
                                    </li>
                                    
                                    <li class="activity-item">
                                        <div class="activity-icon orange">
                                            <i class="fas fa-calendar-minus"></i>
                                        </div>
                                        <div class="activity-content">
                                            <div class="activity-title">Leave Request Submitted</div>
                                            <div class="activity-meta">
                                                <span class="activity-time">Yesterday, 2:45 PM</span>
                                                <span class="activity-status pending">Pending</span>
                                            </div>
                                        </div>
                                    </li>
                                    
                                    <li class="activity-item">
                                        <div class="activity-icon red">
                                            <i class="fas fa-tasks"></i>
                                        </div>
                                        <div class="activity-content">
                                            <div class="activity-title">Task "Update Documentation" Status Changed</div>
                                            <div class="activity-meta">
                                                <span class="activity-time">3 days ago</span>
                                                <span class="activity-status completed">Completed</span>
                                            </div>
                                        </div>
                                    </li>
                                    
                                    <li class="activity-item">
                                        <div class="activity-icon blue">
                                            <i class="fas fa-project-diagram"></i>
                                        </div>
                                        <div class="activity-content">
                                            <div class="activity-title">Assigned to Project "Website Redesign"</div>
                                            <div class="activity-meta">
                                                <span class="activity-time">1 week ago</span>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
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
            
            // Profile edit functionality
            const editBtn = document.getElementById('edit-profile-btn');
            const saveBtn = document.getElementById('save-profile-btn');
            const cancelBtn = document.getElementById('cancel-profile-btn');
            const formInputs = document.querySelectorAll('#profile-form input, #profile-form select');
            let originalValues = {};
            
            // Store original values
            formInputs.forEach(input => {
                originalValues[input.id] = input.value;
            });
            
            // Enable form editing
            editBtn.addEventListener('click', function() {
                formInputs.forEach(input => {
                    input.disabled = false;
                });
                
                editBtn.style.display = 'none';
                saveBtn.style.display = 'flex';
                cancelBtn.style.display = 'flex';
            });
            
            // Cancel editing
            cancelBtn.addEventListener('click', function() {
                formInputs.forEach(input => {
                    input.value = originalValues[input.id];
                    input.disabled = true;
                });
                
                editBtn.style.display = 'flex';
                saveBtn.style.display = 'none';
                cancelBtn.style.display = 'none';
            });
            
            // Save profile changes
            saveBtn.addEventListener('click', function() {
                // Here you would normally send the form data to the server
                alert('Profile updated successfully!');
                
                // Update original values
                formInputs.forEach(input => {
                    originalValues[input.id] = input.value;
                    input.disabled = true;
                });
                
                editBtn.style.display = 'flex';
                saveBtn.style.display = 'none';
                cancelBtn.style.display = 'none';
            });
            
            // Change password
            const changePasswordBtn = document.getElementById('change-password-btn');
            
            changePasswordBtn.addEventListener('click', function() {
                const currentPassword = document.getElementById('current-password').value;
                const newPassword = document.getElementById('new-password').value;
                const confirmPassword = document.getElementById('confirm-password').value;
                
                if (!currentPassword || !newPassword || !confirmPassword) {
                    alert('Please fill in all password fields');
                    return;
                }
                
                if (newPassword !== confirmPassword) {
                    alert('New password and confirmation do not match');
                    return;
                }
                
                // Here you would normally send the password data to the server
                alert('Password changed successfully!');
                
                // Clear form
                document.getElementById('current-password').value = '';
                document.getElementById('new-password').value = '';
                document.getElementById('confirm-password').value = '';
            });
        });
    </script>
</body>
</html>
