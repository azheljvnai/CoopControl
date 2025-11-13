<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flock Management | Chicken Coop Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/js/toast.js"></script>
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
                
                <div class="nav-dropdown active">
                    <a href="/flocks">Management</a>
                    <div class="dropdown-menu">
                        <a href="/flocks" class="active">Flock Management</a>
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
            <h2>Flock Management</h2>
            <button onclick="openAddModal()" class="add-btn">
                <i class="fas fa-plus"></i> Add New Flock
            </button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Breed</th>
                    <th>Acquisition Date</th>
                    <th>Initial Count</th>
                    <th>Current Count</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <#list flocks as flock>
                    <tr>
                        <td>${(flock.name)!"-"}</td>
                        <td>${(flock.breed)!"-"}</td>
                        <td>${(flock.acquisitionDate)!}</td>
                        <td>${(flock.initialCount)!0}</td>
                        <td>${(flock.currentCount)!0}</td>
                        <td class="actions">
                            <button class="icon-btn edit"
                                    onclick="openEditModal(${flock.id}, '${(flock.name)?js_string}', '${(flock.breed)?js_string}', '${(flock.acquisitionDate)!}', ${(flock.initialCount)!0}, ${(flock.currentCount)!0})"
                                    title="Edit">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="icon-btn delete"
                                    onclick="deleteFlock(${flock.id})"
                                    title="Delete">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                <#else>
                    <tr>
                        <td colspan="6">No flocks found. Add one to get started!</td>
                    </tr>
                </#list>
            </tbody>
        </table>
    </main>

    <!-- Add Flock Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Flock</h2>
                <button class="close" onclick="closeAddModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/add-flock" method="post" class="data-form">
                    <div>
                        <label for="add_name">Flock Name:</label>
                        <input type="text" id="add_name" name="name" required>
                    </div>
                    <div>
                        <label for="add_breed">Breed:</label>
                        <input type="text" id="add_breed" name="breed" required>
                    </div>
                    <div>
                        <label for="add_acquisitionDate">Acquisition Date:</label>
                        <input type="date" id="add_acquisitionDate" name="acquisitionDate" required>
                    </div>
                    <div>
                        <label for="add_initialCount">Initial Count:</label>
                        <input type="number" id="add_initialCount" name="initialCount" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Flock</button>
                        <button type="button" onclick="closeAddModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Flock Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Flock</h2>
                <button class="close" onclick="closeEditModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/update-flock" method="post" class="data-form">
                    <input type="hidden" id="edit_id" name="id">
                    <div>
                        <label for="edit_name">Flock Name:</label>
                        <input type="text" id="edit_name" name="name" required>
                    </div>
                    <div>
                        <label for="edit_breed">Breed:</label>
                        <input type="text" id="edit_breed" name="breed" required>
                    </div>
                    <div>
                        <label for="edit_acquisitionDate">Acquisition Date:</label>
                        <input type="date" id="edit_acquisitionDate" name="acquisitionDate" required>
                    </div>
                    <div>
                        <label for="edit_initialCount">Initial Count:</label>
                        <input type="number" id="edit_initialCount" name="initialCount" required>
                    </div>
                    <div>
                        <label for="edit_currentCount">Current Count:</label>
                        <input type="number" id="edit_currentCount" name="currentCount" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Changes</button>
                        <button type="button" onclick="closeEditModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

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

        // Add Modal Functions
        function openAddModal() {
            document.getElementById('addModal').classList.add('active');
        }

        function closeAddModal() {
            document.getElementById('addModal').classList.remove('active');
            document.getElementById('addModal').querySelector('form').reset();
        }

        // Edit Modal Functions
        function openEditModal(id, name, breed, acquisitionDate, initialCount, currentCount) {
            document.getElementById('edit_id').value = id;
            document.getElementById('edit_name').value = name;
            document.getElementById('edit_breed').value = breed;
            document.getElementById('edit_acquisitionDate').value = acquisitionDate;
            document.getElementById('edit_initialCount').value = initialCount;
            document.getElementById('edit_currentCount').value = currentCount;
            document.getElementById('editModal').classList.add('active');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('active');
        }

        // Delete Function
        function deleteFlock(id) {
            if (confirm('Are you sure you want to delete this flock?')) {
                window.location.href = '/delete-flock/' + id;
                // Toast will be shown on next page load via URL parameter
            }
        }
        
        // Show toast if redirected from action
        const urlParams = new URLSearchParams(window.location.search);
        const action = urlParams.get('action');
        const status = urlParams.get('status');
        
        if (action === 'created' && status === 'success') {
            showSuccess('Success', 'Flock created successfully!');
            window.history.replaceState({}, document.title, window.location.pathname);
        } else if (action === 'updated' && status === 'success') {
            showSuccess('Success', 'Flock updated successfully!');
            window.history.replaceState({}, document.title, window.location.pathname);
        } else if (action === 'deleted' && status === 'success') {
            showSuccess('Success', 'Flock deleted successfully!');
            window.history.replaceState({}, document.title, window.location.pathname);
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const addModal = document.getElementById('addModal');
            const editModal = document.getElementById('editModal');
            if (event.target == addModal) {
                closeAddModal();
            }
            if (event.target == editModal) {
                closeEditModal();
            }
        }

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeAddModal();
                closeEditModal();
            }
        });
    </script>
</body>
</html>