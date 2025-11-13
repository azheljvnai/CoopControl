<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Mortality Record | Chicken Coop Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                <a href="/">Dashboard</a>
                <a href="/flocks">Flock Management</a>
                <a href="/inventory">Inventory</a>
                <a href="/financials">Financials</a>
                <a href="/egg-production">Egg Production</a>
                <a href="/health-records">Health Records</a>
                <a href="/mortality" class="active">Mortality</a>
                <a href="/reports">Reports</a>
            </nav>
        </div>
    </header>
    <main>
        <div class="page-header">
            <h2>Edit Mortality Record</h2>
        </div>

        <form action="/update-mortality" method="post" class="data-form">
            <input type="hidden" name="id" value="${mortality.id}">
            <div>
                <label for="flock">Flock:</label>
                <select id="flock" name="flock.id" required>
                    <option value="">Select a Flock</option>
                    <#list flocks as flock>
                        <option value="${flock.id}" ${(mortality.flock.id == flock.id)?then('selected', '')}>${flock.name} (${flock.breed})</option>
                    </#list>
                </select>
            </div>
            <div>
                <label for="deathDate">Death Date:</label>
                <input type="date" id="deathDate" name="deathDate" 
                       value="${(mortality.deathDate)!}" required>
            </div>
            <div>
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" min="1" 
                       value="${(mortality.quantity)!0}" required>
            </div>
            <div>
                <label for="cause">Cause:</label>
                <input type="text" id="cause" name="cause" maxlength="200"
                       value="${(mortality.cause)!}">
            </div>
            <div>
                <label for="notes">Notes:</label>
                <textarea id="notes" name="notes" rows="4" maxlength="500">${(mortality.notes)!}</textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn">Save Changes</button>
                <a href="/mortality" class="btn-secondary">Cancel</a>
            </div>
        </form>
    </main>

    <footer>
        <p>&copy; 2025 Coop Control by Group 10</p>
    </footer>

    <script>
        // Hamburger menu toggle
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
                
                const closeBtn = document.getElementById('menuCloseBtn');
                if (closeBtn) {
                    closeBtn.addEventListener('click', function(e) {
                        e.stopPropagation();
                        closeMenu();
                    });
                }
            }
        });
    </script>
</body>
</html>

