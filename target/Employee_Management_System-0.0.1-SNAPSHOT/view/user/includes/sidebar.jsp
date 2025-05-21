<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<aside class="sidebar">
  <div class="sidebar-header">
    <h2>EMS</h2>
  </div>

  <div class="user-profile">	
    <div class="user-avatar">
      <c:choose>
        <c:when test="${not empty sessionScope.user.picturePath}">
 			<img src="${pageContext.request.contextPath}/${sessionScope.user.picturePath}" alt="${sessionScope.user.name}" />
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
        Role:
        <c:choose>
          <c:when test="${sessionScope.user.role == 1}">Admin</c:when>
          <c:otherwise>User</c:otherwise>
        </c:choose>
      </p>
    </div>
  </div>

  <nav class="sidebar-nav">
    <ul>
    
      <li>
        <a href="${pageContext.request.contextPath}/view/user/pages/dashboard.jsp" class="user-link" data-page="dashboard.jsp">
          <i class="fas fa-home"></i> Dashboard
        </a>
      </li>
      
      <li>
        <a href="${pageContext.request.contextPath}/view/user/pages/attendance.jsp" class="user-link" data-page="attendance.jsp">
          <i class="fas fa-calendar-check"></i> Attendance
        </a>
 
      </li>
      
      <li>
        <a href="${pageContext.request.contextPath}/LeaveRequestServlet" class="user-link" data-page="leave-request.jsp">
          <i class="fas fa-envelope"></i> Leave Request
        </a>
      </li>
      
      <li>
        <a href="${pageContext.request.contextPath}/get-all-tasks-for-user" class="user-link" data-page="tasks.jsp">
          <i class="fas fa-tasks"></i> My Tasks
        </a>
      </li>
      
      <li>
        <a href="${pageContext.request.contextPath}/view/user/pages/profile.jsp" class="user-link" data-page="profile.jsp">
          <i class="fas fa-user-circle"></i> My Profile
        </a>
      </li>
      
      <li>
        <a href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </li>
      
    </ul>
  </nav>
</aside>
