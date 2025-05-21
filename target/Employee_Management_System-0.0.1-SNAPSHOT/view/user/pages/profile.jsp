<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Profile</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        .profile-section {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .profile-title {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .form-grid.password-section {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .form-grid.password-section .form-group {
            flex: 1 1 300px;
            min-width: 280px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .form-group input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .btn {
            padding: 10px 20px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #0056b3;
        }

        .message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 8px;
        }

        .success {
            background: #d4edda;
            color: #155724;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <%@ include file="../includes/sidebar.jsp" %>

    <main class="main-content">
        <%@ include file="../includes/topnav.jsp" %>

        <div class="content-card">
            <section class="profile-section">
                <h2 class="profile-title"><i class="fas fa-user"></i> My Profile</h2>

                <!-- Flash messages -->
                <c:if test="${not empty successMessage}">
                    <div class="message success">${fn:escapeXml(successMessage)}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="message error">${fn:escapeXml(errorMessage)}</div>
                </c:if>

                <!-- Profile Info -->
                <div class="form-grid">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" value="${sessionScope.user.name}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" value="${sessionScope.user.email}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" value="${sessionScope.user.phone}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Joining Date</label>
                        <input type="text" value="<fmt:formatDate value='${sessionScope.user.hireDate}' pattern='yyyy-MM-dd'/>" disabled />
                    </div>
                    <div class="form-group">
                        <label>Department</label>
                        <input type="text" value="${sessionScope.user.department.name}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" value="${fn:escapeXml(employee.roleName != null ? employee.roleName : (employee.role == 1 ? 'Admin' : 'User'))}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Basic Salary</label>
                        <input type="text" value="Rs. ${employee.salary != null ? employee.salary : '0.00'}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Employment Status</label>
                        <input type="text" value="${sessionScope.user.active ? 'Active' : 'Inactive'}" disabled />
                    </div>
                </div>

                <!-- Change Password -->
                <h3 class="profile-title" style="margin-top: 40px;"><i class="fas fa-key"></i> Change Password</h3>
                <form class="profile-container" action="${pageContext.request.contextPath}/user/profile" method="post" style="margin-top: 20px;">
                    <div class="form-grid password-section">
                        <div class="form-group">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" required />
                        </div>
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" required />
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required />
                        </div>
                    </div>
                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn">
                            <i class="fas fa-save"></i> Update Password
                        </button>
                    </div>
                </form>
            </section>
        </div>
    </main>
</body>
</html>
	