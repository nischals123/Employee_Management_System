<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Profile - EMS</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <style>
  .profile-page {
    padding: 20px;
    display: flex;
    justify-content: center;
  }

  .profile-card {
    background: white;
    padding: 20px;
    border-radius: 10px;
    max-width: 800px;
    width: 100%;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
  }

  .profile-card h2 {
    margin-bottom: 20px;
    font-size: 22px;
    color: #333;
    text-align: center;
  }

  .profile-info {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
  }

  .profile-info label {
    font-weight: bold;
    font-size: 14px;
    color: #555;
  }

  .profile-info input {
    width: 100%;
    padding: 6px 10px;
    margin-top: 5px;
    border-radius: 6px;
    border: 1px solid #ccc;
    background: #f5f5f5;
    font-size: 14px;
    box-sizing: border-box;
  }

  .profile-info input:disabled {
    color: #444;
    background-color: #f0f0f0;
    font-weight: 500;
  }

  @media (max-width: 768px) {
    .profile-info {
      grid-template-columns: 1fr;
    }
  }
</style>

</head>

<body class="dashboard-body">

<div class="dashboard-container">

  <%-- Sidebar --%>
  <%@ include file="includes/sidebar.jsp" %> 

  <main class="main-content">

    <%-- Top Navigation --%>
    <%@ include file="includes/topnav.jsp" %>

    <div class="dashboard-content">
      <div class="profile-page">
        <div class="profile-card">
          <h2><i class="fas fa-user"></i> My Profile</h2>

          <div class="profile-info">
            <div>
              <label>Full Name</label>
              <input type="text" value="Admin ho" disabled />
            </div>

            <div>
              <label>Email</label>
              <input type="email" value="admin2ems.com" disabled />
            </div>

            <div>
              <label>Phone</label>
              <input type="text" value="+977-9800000000" disabled />
            </div>

            <div>
              <label>Department</label>
              <input type="text" value="Computer Science" disabled />
            </div>

            <div>
              <label>Role</label>
              <input type="text" value="Admin" disabled />
            </div>

            <div>
              <label>Status</label>
              <input type="text" value="Active" disabled />
            </div>

            <div style="grid-column: 1 / -1;">
              <label>Hire Date</label>
              <input type="text" value="2025-01-15" disabled />
            </div>
          </div>
	
        </div>
      </div>
    </div>

  </main>
</div>

</body>
</html>
