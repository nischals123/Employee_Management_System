<header class="content-header">
    <div class="header-left">
        <h1>Dashboard</h1>
    </div>
    <div class="header-right">
        <div class="date-time">
            <span id="current-date"></span>
        </div>
        <div class="notifications">
            <i class="fas fa-bell"></i>
            <span class="notification-count">3</span>
        </div>
    </div>
</header>

<script>
    // Display current date
    document.addEventListener('DOMContentLoaded', function() {
        const dateElement = document.getElementById('current-date');
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const today = new Date();
        dateElement.textContent = today.toLocaleDateString('en-US', options);
    });
</script>
