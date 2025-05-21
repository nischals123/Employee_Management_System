<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>View Employee - Employee Management System</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/dashboard.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />

<style>
.employee-details-container {
	max-width: 850px;
	margin: 40px auto;
	background-color: #ffffff;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	padding: 40px 50px;
	color: #333;
}

.employee-details-container h2 {
	text-align: center;
	margin-bottom: 35px;
	color: #2c3e50;
	font-size: 28px;
	font-weight: 700;
}

.employee-details {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 20px;
}

.detail-box {
	background-color: #f9f9f9;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 16px 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.03);
}

.detail-box strong {
	display: block;
	font-weight: 600;
	margin-bottom: 6px;
	color: #2c3e50;
	font-size: 15px;
}

.detail-box span {
	font-size: 14px;
	color: #555;
}

.status-active {
	color: #27ae60;
}

.status-inactive {
	color: #e74c3c;
}

.back-btn {
	display: inline-block;
	margin-top: 35px;
	padding: 10px 22px;
	background-color: #3498db;
	color: white;
	text-decoration: none;
	border-radius: 6px;
	transition: 0.3s;
	font-size: 15px;
}

.back-btn i {
	margin-right: 6px;
}

.back-btn:hover {
	background-color: #2c80b4;
}
</style>
</head>

<body class="dashboard-body">
	<div class="dashboard-container">
		<%@ include file="includes/sidebar.jsp"%>
		<main class="main-content">
			<%@ include file="includes/topnav.jsp"%>

			<div class="dashboard-content">
				<div class="employee-details-container">
					<h2>Employee Details</h2>

					<div class="employee-details">
						<div class="detail-box">
							<strong>Name:</strong> <span>${employee.name}</span>
						</div>
						<div class="detail-box">
							<strong>Email:</strong> <span>${employee.email}</span>
						</div>
						<div class="detail-box">
							<strong>Phone:</strong> <span>${employee.phone}</span>
						</div>
						<div class="detail-box">
							<strong>Role:</strong> <span> <c:choose>
									<c:when test="${employee.role == 1}">Admin</c:when>
									<c:otherwise>Employee</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="detail-box">
							<strong>Status:</strong> <span
								class="${employee.active ? 'status-active' : 'status-inactive'}">
								<c:choose>
									<c:when test="${employee.active}">Active</c:when>
									<c:otherwise>Inactive</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="detail-box">
							<strong>Department:</strong> <span>${employee.department.name}</span>
						</div>
						<div class="detail-box">
							<strong>Hire Date:</strong> <span><fmt:formatDate
									value="${employee.hireDate}" pattern="dd MMM yyyy" /></span>
						</div>
						<div class="detail-box">
							<strong>Created At:</strong> <span><fmt:formatDate
									value="${employee.createdAt}" pattern="dd MMM yyyy" /></span>
						</div>
					</div>

					<a href="${pageContext.request.contextPath}/employees"
						class="back-btn"> <i class="fas fa-arrow-left"></i> Back to
						List
					</a>
				</div>
			</div>
		</main>
	</div>
</body>
</html>
