<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<%-- Server-side Session Check --%>
<%
if (session.getAttribute("user") == null) {
	response.sendRedirect(request.getContextPath() + "/view/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Add Employee - Employee Management System</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/dashboard.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />


<style>
    .dashboard-content {
      background: #f8f9fc;
      padding: 40px;
      border-radius: 12px;
      margin-top: 20px;
    }

    h2 {
      text-align: center;
      font-size: 26px;
      margin-bottom: 30px;
      font-weight: bold;
    }

    .employee-form {
      max-width: 1000px;
      margin: 0 auto;
      background: #fff;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 25px 40px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    label {
      margin-bottom: 6px;
      font-weight: 500;
      color: #333;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="date"],
    select {
      padding: 10px 12px;
      border-radius: 6px;
      border: 1px solid #ccc;
      font-size: 14px;
      background-color: #f9f9f9;
      transition: border-color 0.3s ease;
    }

    input:focus,
    select:focus {
      border-color: #5b9bd5;
      outline: none;
      background-color: #fff;
    }

    .button-group {
      grid-column: 1 / -1;
      display: flex;
      justify-content: flex-end;
      gap: 20px;
      margin-top: 10px;
    }

    .submit-btn,
    .cancel-btn {
      padding: 10px 20px;
      border-radius: 6px;
      font-size: 15px;
      font-weight: 600;
      border: none;
      cursor: pointer;
    }

    .submit-btn {
      background-color: #28a745;
      color: #fff;
    }

    .submit-btn:hover {
      background-color: #218838;
    }

    .cancel-btn {
      background-color: #dc3545;
      color: #fff;
      text-decoration: none;
      text-align: center;
    }

    .cancel-btn:hover {
      background-color: #c82333;
    }

    @media (max-width: 768px) {
      .employee-form {
        grid-template-columns: 1fr;
      }

      .button-group {
        justify-content: center;
      }
    }
  </style>
</head>
<body class="dashboard-body">
	<div class="dashboard-container">
		<%@ include file="includes/sidebar.jsp"%>
		<main class="main-content">
			<%@ include file="includes/topnav.jsp"%>
			<div class="dashboard-content">
				<h2>Add New Employee</h2>
				<form action="${pageContext.request.contextPath}/employees"
					method="post" class="employee-form">
					<input type="hidden" name="action" value="add" />
					<div class="form-group">
						<label for="name">Name :</label> <input type="text" id="name"
							name="name" required />
					</div>
					<div class="form-group">
						<label for="email">Email:</label> <input type="email" id="email"
							name="email" required />
					</div>
					<div class="form-group">
						<label for="password">Password:</label> <input type="password"
							id="password" name="password" required />
					</div>
					<div class="form-group">
						<label for="phone">Phone:</label> <input type="text" id="phone"
							name="phone" />
					</div>
					<div class="form-group">
						<label for="role">Role:</label> <select id="role" name="role"
							required>
							<option value="0">Employee</option>
							<option value="1">Admin</option>
						</select>
					</div>
					<div class="form-group">
						<label for="isActive">Status:</label> <select id="isActive"
							name="isActive" required>
							<option value="true">Active</option>
							<option value="false">Inactive</option>
						</select>
					</div>
					<div class="form-group">
						<label for="departmentId">Department:</label> <select
							id="departmentId" name="departmentId" required>
							<c:forEach var="dept" items="${departments}">
								<option value="${dept.id}">${fn:escapeXml(dept.name)}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="hireDate">Hire Date:</label> <input type="date"
							id="hireDate" name="hireDate" required />
					</div>
					<button type="submit" class="submit-btn">Add Employee</button>
					<a href="${pageContext.request.contextPath}/employees"
						class="cancel-btn">Cancel</a>
				</form>
				<c:if test="${param.error == 'failed'}">
					<p class="error-message">Failed to add employee. Please try
						again.</p>
				</c:if>
			</div>
		</main>
	</div>
</body>
</html>