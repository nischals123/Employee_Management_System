<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>EMS - User Panel</title>

  <!-- External CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/view/user/css/style.css" />

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <script src="js/script.js" defer></script>

  <meta name="description" content="Employee Management System - User Dashboard" />
</head>
<body>

  <!-- Top Navigation -->
  <div id="topnav-placeholder" role="navigation" aria-label="Top navigation bar">

  </div>

  <div class="container">
    <!-- Sidebar -->
    <div id="sidebar-placeholder" role="navigation" aria-label="Sidebar menu">
      <%@include file="includes/sidebar.jsp"%>
    </div>

    <!-- Main Content -->
    <main id="main-content" class="main-content" aria-live="polite" tabindex="-1">
      <h2>Welcome to EMS</h2>
      <p>Please choose an option from the sidebar to get started.</p>
    </main>
  </div>
</body>
</html>
