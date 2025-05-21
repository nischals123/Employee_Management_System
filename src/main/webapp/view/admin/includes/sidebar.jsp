<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    String uri = request.getRequestURI();
%>

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
            <p>
                <c:choose>
                    <c:when test="${sessionScope.user.role == 1}">Admin</c:when>
                    <c:otherwise>User</c:otherwise>
                </c:choose>
            </p>
        </div>
    </div>
    
    <nav class="sidebar-nav">
        <ul>
            <li class="<%= uri.contains("dashboard.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-home"></i> Dashboard</a>
            </li>
            <li class="<%= uri.contains("employees.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/employees"><i class="fas fa-users"></i> Employees</a>
            </li>

            <li class="<%= uri.contains("salary.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/admin/salaries" ><i class="fas fa-users"></i> Salary</a>
            </li>

            <li class="<%= uri.contains("tasks.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/admin/tasks" ><i class="fas fa-users"></i> Tasks</a>
            </li>

            <li class="<%= uri.contains("departments.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/get-all-departments"><i class="fas fa-building"></i> Departments</a>
            </li>
            <li class="<%= uri.contains("attendance.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/attendance"><i class="fas fa-calendar-check"></i> Attendance</a>
            </li>
            <li class="<%= uri.contains("leave-requests.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/admin-leave-request"><i class="fas fa-calendar-minus"></i> Leave Requests</a>
            </li>
            <li class="<%= uri.contains("profile.jsp") ? "active" : "" %>">
			    <a href="${pageContext.request.contextPath}/view/admin/profile.jsp">
			        <i class="fas fa-user-circle"></i> My Profile
			    </a>
			</li>
            <li>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </li>
        </ul>
    </nav>
</aside>
