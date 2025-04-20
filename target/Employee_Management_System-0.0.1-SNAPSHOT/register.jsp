<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Employee Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/auth.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="auth-body">

    <div class="auth-container">
        <div class="auth-left">
            <div class="auth-logo">
                <h1>EMS</h1>
                <p>Employee Management System</p>
            </div>
            <div class="auth-image">
                <img src="images/register-illustration.svg" alt="Register Illustration" onerror="this.src='https://cdn.pixabay.com/photo/2017/07/31/11/44/laptop-2557576_1280.jpg'; this.onerror=''">
            </div>
            <div class="auth-features">
                <div class="feature">
                    <i class="fas fa-users"></i>
                    <span>Employee Management</span>
                </div>
                <div class="feature">
                    <i class="fas fa-calendar-check"></i>
                    <span>Attendance Tracking</span>
                </div>
                <div class="feature">
                    <i class="fas fa-project-diagram"></i>
                    <span>Project Management</span>
                </div>
            </div>
        </div>

        <div class="auth-right register-form">
            <div class="auth-form-container">
                <div class="auth-header">
                    <h2>Create an Account</h2>
                    <p>Join our employee management platform</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-msg">
                        <i class="fas fa-exclamation-circle"></i>
                        ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data" class="auth-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name"><i class="fas fa-user"></i> Full Name</label>
                            <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                        </div>

                        <div class="form-group">
                            <label for="email"><i class="fas fa-envelope"></i> Email</label>
                            <input type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password"><i class="fas fa-lock"></i> Password</label>
                            <input type="password" id="password" name="password" placeholder="Create a password" required>
                        </div>

                        <div class="form-group">
                            <label for="phone"><i class="fas fa-phone"></i> Phone Number</label>
                            <input type="text" id="phone" name="phone" placeholder="Enter your phone number" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="department"><i class="fas fa-building"></i> Department</label>
                            <select id="department" name="department" required>
                                <option value="">Select Department</option>
                                <option value="1">Computer Science</option>
                                <option value="2">Electrical</option>
                                <option value="3">Mechanical</option>
                                <option value="4">Civil</option>
                                <option value="5">Human Resources</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="role"><i class="fas fa-user-tag"></i> Role</label>
                            <select id="role" name="role" required>
                                <option value="3">Employee</option>
                                <option value="2">Manager</option>
                                <option value="1">Admin</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group file-upload">
                        <label for="photo"><i class="fas fa-image"></i> Profile Picture</label>
                        <input type="file" id="photo" name="photo" accept="image/*" required>
                        <div class="file-upload-info">Upload a profile picture (JPG, PNG)</div>
                    </div>

                    <button type="submit" class="auth-button">Register <i class="fas fa-user-plus"></i></button>
                </form>

                <div class="auth-footer">
                    <p>Already have an account? <a href="login.jsp">Login here</a></p>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
