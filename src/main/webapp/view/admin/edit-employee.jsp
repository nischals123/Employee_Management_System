<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page isELIgnored="false"%>

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
<title>Edit Employee - Employee Management System</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/dashboard.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />

<style>
.form-row {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	gap: 20px;
}

.left-form-section, .right-form-section {
	flex: 1 1 45%;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	font-size: 14px;
	margin-bottom: 6px;
}

input[type="text"], input[type="email"], input[type="date"], select {
	width: 100%;
	padding: 8px 12px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

.button-group {
	margin-top: 20px;
	display: flex;
	gap: 10px;
}

.submit-btn, .cancel-btn {
	padding: 6px 16px;
	font-size: 13px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.submit-btn {
	background-color: #4CAF50;
	color: white;
}

.submit-btn:hover {
	background-color: #45a049;
}

.cancel-btn {
	background-color: #f44336;
	color: white;
	text-decoration: none;
	display: inline-block;
	line-height: 26px;
}

.cancel-btn:hover {
	background-color: #d32f2f;
}

.error-message {
	color: red;
	font-size: 14px;
	margin-top: 10px;
}
</style>
</head>
<body class="dashboard-body">
	<div class="dashboard-container">
		<%@ include file="includes/sidebar.jsp"%>
		<main class="main-content">
			<%@ include file="includes/topnav.jsp"%>
			<div class="dashboard-content">
				<h2>Edit Employee</h2>
				<form action="${pageContext.request.contextPath}/employees"
					method="post" class="employee-form">
					<input type="hidden" name="action" value="edit" /> <input
						type="hidden" name="id" value="${employee.id}" />

					<div class="form-row">
						<div class="left-form-section">
							<div class="form-group">
								<label for="name">Name:</label> <input type="text" id="name"
									name="name" value="${fn:escapeXml(employee.name)}" required />
							</div>
							<div class="form-group">
								<label for="email">Email:</label> <input type="email" id="email"
									name="email" value="${fn:escapeXml(employee.email)}" required />
							</div>
							<div class="form-group">
								<label for="phone">Phone:</label> <input type="text" id="phone"
									name="phone" value="${fn:escapeXml(employee.phone)}" />
							</div>
						</div>

						<div class="right-form-section">
							<div class="form-group">
								<label for="role">Role:</label> <select id="role" name="role"
									required>
									<option value="0" ${employee.role == 0 ? 'selected' : ''}>Employee</option>
									<option value="1" ${employee.role == 1 ? 'selected' : ''}>Admin</option>
								</select>
							</div>
							<div class="form-group">
								<label for="isActive">Status:</label> <select id="isActive"
									name="isActive" required>
									<option value="true" ${employee.active ? 'selected' : ''}>Active</option>
									<option value="false" ${!employee.active ? 'selected' : ''}>Inactive</option>
								</select>
							</div>
							<div class="form-group">
								<label for="departmentId">Department:</label> <select
									id="departmentId" name="departmentId" required>
									<c:forEach var="dept" items="${departments}">
										<option value="${dept.id}"
											${dept.id == employee.departmentId ? 'selected' : ''}>
											${fn:escapeXml(dept.name)}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label for="hireDate">Hire Date:</label> <input type="date"
									id="hireDate" name="hireDate" value="${employee.hireDate}"
									required />
							</div>
						</div>
					</div>

					<div class="button-group">
						<button type="submit" class="submit-btn">Update Employee</button>
						<a href="${pageContext.request.contextPath}/employees"
							class="cancel-btn">Cancel</a>
					</div>
				</form>

				<c:if test="${param.error == 'failed'}">
					<p class="error-message">Failed to update employee. Please try
						again.</p>
				</c:if>
			</div>
		</main>
	</div>
</body>
</html>
