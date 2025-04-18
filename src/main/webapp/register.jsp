<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration - EMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!--  Navbar -->
    <header class="navbar">
        <div class="navbar-container">
            <div class="logo">Employee Management System</div>
            <nav class="nav-links">
                <a href="index.jsp" class="nav-btn">Home</a>
                <a href="login.jsp" class="nav-btn outline">Login</a>
            </nav>
        </div>
    </header>

    <!-- Register Form -->
    <div class="register-container">
        <div class="form-box">
            <h2>Create an Account</h2>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="error-msg"><%= error %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                <input type="text" name="name" placeholder="Full Name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>
                <input type="text" name="phone" placeholder="Phone Number" required>
               <select name="department" required>
				    <option value="">Select Department</option>
				    <option value="1">Computer Science</option>
				    <option value="2">Electrical</option>
				    <option value="3">Mechanical</option>
				    <option value="4">Civil</option>
				</select>
                <select name="role" required>
                    <option value="0">User</option>
                    <option value="1">Admin</option>
                </select>
                <label for="photo">Upload Profile Picture</label>
                <input type="file" name="photo" id="photo" accept="image/*" required>
                <input type="submit" value="Register">
            </form>

            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>

</body>
</html>
