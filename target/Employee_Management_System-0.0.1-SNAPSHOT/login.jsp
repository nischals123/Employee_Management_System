<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login - EMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="navbar">
    <div class="navbar-container">
        <div class="logo">EMS</div>
        <nav class="nav-links">
            <a href="index.jsp" class="nav-btn">Home</a>
            <a href="register.jsp" class="nav-btn outline">Register</a>
        </nav>
    </div>
</header>

<div class="login-container">
    <div class="form-box">
        <h2>Welcome Back</h2>

        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>

        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</div>

</body>
</html>
