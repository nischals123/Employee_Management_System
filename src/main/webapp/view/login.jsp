<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
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
                <img src="${pageContext.request.contextPath}/images/login-illustration.svg"
                     alt="Login Illustration"
                     onerror="this.src='https://cdn.pixabay.com/photo/2017/07/31/11/44/laptop-2557576_1280.jpg'; this.onerror=''">
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

        <div class="auth-right">
            <div class="auth-form-container">
                <div class="auth-header">
                    <h2>Welcome Back</h2>
                    <p>Please login to your account</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-msg">
                        <i class="fas fa-exclamation-circle"></i>
                        ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>

                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <div class="form-options">
                        <div class="remember-me">
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember">Remember me</label>
                        </div>
                        <a href="${pageContext.request.contextPath}/view/forgot-password.jsp" class="forgot-password">Forgot Password?</a>
                    </div>

                    <button type="submit" class="auth-button">Login <i class="fas fa-sign-in-alt"></i></button>
                </form>

                <div class="auth-footer">
                    <p>Don't have an account? 
                       <a href="${pageContext.request.contextPath}/view/register.jsp">Register here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
