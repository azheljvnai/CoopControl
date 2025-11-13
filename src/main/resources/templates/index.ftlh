<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Chicken Coop Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="/js/toast.js"></script>
    <style>
        .charts-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 1.25rem;
            margin-top: 1.25rem;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }

        canvas {
            max-height: 280px;
            width: 100% !important;
            max-width: 100%;
        }
    </style>
</head>
<body>
    <div class="sidebar-backdrop" id="sidebarBackdrop"></div>
    <header>
        <div class="header-container">
            <h1>
                <a href="/" class="logo-container">
                    <img src="/images/cclogo.png" alt="Coop Control Logo" class="logo-img">
                </a>
            </h1>
            <button class="hamburger-menu" id="hamburgerMenu" aria-label="Toggle navigation">
                <span></span>
                <span></span>
                <span></span>
            </button>
            <nav id="mainNav">
                <button class="menu-close-btn" id="menuCloseBtn" aria-label="Close menu">
                    <i class="fas fa-times"></i>
                </button>
                <a href="/" class="active">Dashboard</a>
                
                <div class="nav-dropdown">
                    <a href="/flocks">Management</a>
                    <div class="dropdown-menu">
                        <a href="/flocks">Flock Management</a>
                        <a href="/egg-production">Egg Production</a>
                        <a href="/health-records">Health Records</a>
                        <a href="/mortality">Mortality</a>
                    </div>
                </div>
                
                <div class="nav-dropdown">
                    <a href="/inventory">Operations</a>
                    <div class="dropdown-menu">
                        <a href="/inventory">Inventory</a>
                        <a href="/financials">Financials</a>
                    </div>
                </div>
                
                <a href="/reports">Reports</a>
            </nav>
        </div>
    </header>
    <main>
        <div class="page-header">
            <h2>Dashboard</h2>
        </div>

        <div class="dashboard-grid">
            <div class="card">
                <h3><i class="fas fa-layer-group"></i> Total Flocks</h3>
                <p>${totalFlocks}</p>
            </div>
            <div class="card">
                <h3><i class="fas fa-dove"></i> Total Birds</h3>
                <p>${totalBirds}</p>
            </div>
            <div class="card">
                <h3><i class="fas fa-egg"></i> Total Eggs</h3>
                <p>${(totalEggs)!0}</p>
            </div>
            <div class="card">
                <h3><i class="fas fa-heartbeat"></i> Health Records</h3>
                <p>${(totalHealthRecords)!0}</p>
            </div>
            <div class="card">
                <h3><i class="fas fa-skull"></i> Total Mortality</h3>
                <p>${(totalMortality)!0}</p>
            </div>
            <div class="card">
                <h3><i class="fas fa-seedling"></i> Feed Stock (kg)</h3>
                <p>${(totalFeedStock)!0?string("0.0")}</p>
            </div>
            <div class="card">
                <h3><i class="fas fa-box"></i> Total Supplies</h3>
                <p>${(totalSupplies)!0?string("0.0")}</p>
            </div>
            <div class="card">
                <h3><i class="fas fa-pills"></i> Total Medicine</h3>
                <p>${(totalMedicine)!0?string("0.0")}</p>
            </div>
            <div class="card profit">
                <h3><i class="fas fa-dollar-sign"></i> Total Revenue</h3>
                <p>₱${totalRevenue?string("0.00")}</p>
            </div>
            <div class="card expense">
                <h3><i class="fas fa-money-bill-wave"></i> Total Expenses</h3>
                <p>₱${totalExpenses?string("0.00")}</p>
            </div>
            <div class="card profit">
                <h3><i class="fas fa-chart-line"></i> Net Profit</h3>
                <p>₱${netProfit?string("0.00")}</p>
            </div>
        </div>

        <div class="charts-section">
            <div class="chart-container">
                <h3>Financial Overview</h3>
                <canvas id="financialChart"></canvas>
            </div>

            <div class="chart-container">
                <h3>Flock Capacity Overview</h3>
                <canvas id="flockChart"></canvas>
            </div>
        </div>
    </main>
    <footer>
        <p>&copy; 2025 Coop Control by Group 10</p>
    </footer>

    <script>
        // Hamburger menu toggle with slide-in sidebar
        document.addEventListener('DOMContentLoaded', function() {
            const hamburger = document.getElementById('hamburgerMenu');
            const nav = document.getElementById('mainNav');
            const backdrop = document.getElementById('sidebarBackdrop');
            const body = document.body;
            
            function openMenu() {
                hamburger.classList.add('active');
                nav.classList.add('active');
                if (backdrop) backdrop.classList.add('active');
                body.style.overflow = 'hidden';
            }
            
            function closeMenu() {
                hamburger.classList.remove('active');
                nav.classList.remove('active');
                if (backdrop) backdrop.classList.remove('active');
                body.style.overflow = '';
            }
            
            if (hamburger && nav) {
                hamburger.addEventListener('click', function(e) {
                    e.stopPropagation();
                    if (nav.classList.contains('active')) {
                        closeMenu();
                    } else {
                        openMenu();
                    }
                });

                if (backdrop) {
                    backdrop.addEventListener('click', function() {
                        closeMenu();
                    });
                }

                document.addEventListener('click', function(event) {
                    if (nav.classList.contains('active')) {
                        if (!hamburger.contains(event.target) && !nav.contains(event.target) && (!backdrop || !backdrop.contains(event.target))) {
                            closeMenu();
                        }
                    }
                });

                const navLinks = nav.querySelectorAll('a');
                navLinks.forEach(link => {
                    link.addEventListener('click', function() {
                        closeMenu();
                    });
                });
                
                // Close menu when clicking close button
                const closeBtn = document.getElementById('menuCloseBtn');
                if (closeBtn) {
                    closeBtn.addEventListener('click', function(e) {
                        e.stopPropagation();
                        closeMenu();
                    });
                }
                
                document.addEventListener('keydown', function(event) {
                    if (event.key === 'Escape' && nav.classList.contains('active')) {
                        closeMenu();
                    }
                });
            }
        });

        // Chart scripts
        // Parse values safely - use parseFloat to handle FreeMarker output
        const totalRevenue = parseFloat('${(totalRevenue)!0}') || 0;
        const totalExpenses = parseFloat('${(totalExpenses)!0}') || 0;
        const netProfit = parseFloat('${(netProfit)!0}') || 0;
        const totalBirds = parseInt('${(totalBirds)!0}') || 0;
        const totalFlocks = parseInt('${(totalFlocks)!0}') || 0;

        // Financial Overview Bar Chart
        const financialCtx = document.getElementById('financialChart').getContext('2d');
        new Chart(financialCtx, {
            type: 'bar',
            data: {
                labels: ['Revenue', 'Expenses', 'Net Profit'],
                datasets: [{
                    label: 'Amount (₱)',
                    data: [totalRevenue, totalExpenses, netProfit],
                    backgroundColor: [
                        'rgba(40, 167, 69, 0.8)',   // Green for Revenue #28A745
                        'rgba(220, 53, 69, 0.8)',   // Red for expenses
                        'rgba(244, 199, 199, 0.8)'  // Hover Highlight #F4C7C7
                    ],
                    borderColor: [
                        'rgba(40, 167, 69, 1)',
                        'rgba(220, 53, 69, 1)',
                        'rgba(244, 199, 199, 1)'
                    ],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return '₱' + context.parsed.y.toLocaleString('en-PH', {minimumFractionDigits: 2, maximumFractionDigits: 2});
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return '₱' + value.toLocaleString('en-PH');
                            }
                        }
                    }
                }
            }
        });

        // Flock Distribution Doughnut Chart
        const flockCtx = document.getElementById('flockChart').getContext('2d');

        // Calculate actual capacity based on current birds + 20% buffer
        const totalCapacity = Math.ceil(totalBirds * 1.2);
        const availableCapacity = Math.max(0, totalCapacity - totalBirds);

        new Chart(flockCtx, {
            type: 'doughnut',
            data: {
                labels: ['Current Birds', 'Available Capacity'],
                datasets: [{
                    data: [totalBirds, availableCapacity],
                    backgroundColor: [
                        'rgba(178, 58, 72, 0.8)',   // Primary Red #B23A48
                        'rgba(255, 245, 228, 0.5)'  // Background Soft #FFF5E4
                    ],
                    borderColor: [
                        'rgba(178, 58, 72, 1)',
                        'rgba(255, 245, 228, 1)'
                    ],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed || 0;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                if (total === 0) {
                                    return label + ': 0 (0%)';
                                }
                                const percentage = ((value / total) * 100).toFixed(1);
                                return label + ': ' + value + ' (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>