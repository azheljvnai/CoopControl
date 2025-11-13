<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mortality Records | Chicken Coop Management System</title>
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
                        <a href="/flocks">Flock Management</a>
                        <a href="/egg-production">Egg Production</a>
                        <a href="/health-records">Health Records</a>
                        <a href="/mortality" class="active">Mortality</a>
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
            <h2>Mortality Records</h2>
            <button onclick="openAddModal()" class="add-btn">
                <i class="fas fa-plus"></i> Add Mortality Record
            </button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Flock</th>
                    <th>Death Date</th>
                    <th>Quantity</th>
                    <th>Cause</th>
                    <th>Notes</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <#list mortalityRecords as mortality>
                    <tr>
                        <td>${(mortality.flock.name)!"-"}</td>
                        <td>${(mortality.deathDate)!}</td>
                        <td>${(mortality.quantity)!0}</td>
                        <td>${(mortality.cause)!"-"}</td>
                        <td>${(mortality.notes)!"-"}</td>
                        <td class="actions">
                            <button class="icon-btn edit"
                                    onclick="openEditModal(${mortality.id}, '${(mortality.flock.id)!}', '${(mortality.deathDate)!}', ${(mortality.quantity)!0}, '${(mortality.cause?js_string)!}', '${(mortality.notes?js_string)!}')"
                                    title="Edit">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="icon-btn delete"
                                    onclick="deleteMortality(${mortality.id})"
                                    title="Delete">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                <#else>
                    <tr>
                        <td colspan="6">No mortality records found. Add one to get started!</td>
                    </tr>
                </#list>
            </tbody>
        </table>
    </main>

    <!-- Add Mortality Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add Mortality Record</h2>
                <button class="close" onclick="closeAddModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/add-mortality" method="post" class="data-form">
                    <div>
                        <label for="add_flock">Flock:</label>
                        <select id="add_flock" name="flock.id" required>
                            <option value="">Select a Flock</option>
                            <#list flocks as flock>
                                <option value="${flock.id}">${flock.name} (${flock.breed})</option>
                            </#list>
                        </select>
                    </div>
                    <div>
                        <label for="add_deathDate">Death Date:</label>
                        <input type="date" id="add_deathDate" name="deathDate" required>
                    </div>
                    <div>
                        <label for="add_quantity">Quantity:</label>
                        <input type="number" id="add_quantity" name="quantity" min="1" required>
                    </div>
                    <div>
                        <label for="add_cause">Cause:</label>
                        <input type="text" id="add_cause" name="cause" maxlength="200">
                    </div>
                    <div>
                        <label for="add_notes">Notes:</label>
                        <textarea id="add_notes" name="notes" rows="4" maxlength="500"></textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Record</button>
                        <button type="button" onclick="closeAddModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Mortality Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Mortality Record</h2>
                <button class="close" onclick="closeEditModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/update-mortality" method="post" class="data-form">
                    <input type="hidden" id="edit_id" name="id">
                    <div>
                        <label for="edit_flock">Flock:</label>
                        <select id="edit_flock" name="flock.id" required>
                            <option value="">Select a Flock</option>
                            <#list flocks as flock>
                                <option value="${flock.id}">${flock.name} (${flock.breed})</option>
                            </#list>
                        </select>
                    </div>
                    <div>
                        <label for="edit_deathDate">Death Date:</label>
                        <input type="date" id="edit_deathDate" name="deathDate" required>
                    </div>
                    <div>
                        <label for="edit_quantity">Quantity:</label>
                        <input type="number" id="edit_quantity" name="quantity" min="1" required>
                    </div>
                    <div>
                        <label for="edit_cause">Cause:</label>
                        <input type="text" id="edit_cause" name="cause" maxlength="200">
                    </div>
                    <div>
                        <label for="edit_notes">Notes:</label>
                        <textarea id="edit_notes" name="notes" rows="4" maxlength="500"></textarea>
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
                
                document.addEventListener('keydown', function(event) {
                    if (event.key === 'Escape' && nav.classList.contains('active')) {
                        closeMenu();
                    }
                });
            }
        });

        // Modal Functions
        function openAddModal() {
            document.getElementById('addModal').classList.add('active');
        }

        function closeAddModal() {
            document.getElementById('addModal').classList.remove('active');
            document.getElementById('addModal').querySelector('form').reset();
        }

        function openEditModal(id, flockId, deathDate, quantity, cause, notes) {
            document.getElementById('edit_id').value = id;
            document.getElementById('edit_flock').value = flockId;
            document.getElementById('edit_deathDate').value = deathDate;
            document.getElementById('edit_quantity').value = quantity;
            document.getElementById('edit_cause').value = cause || '';
            document.getElementById('edit_notes').value = notes || '';
            document.getElementById('editModal').classList.add('active');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('active');
        }

        function deleteMortality(id) {
            if (confirm('Are you sure you want to delete this mortality record?')) {
                window.location.href = '/delete-mortality/' + id;
            }
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

        // Show toast if redirected from action
        const urlParams = new URLSearchParams(window.location.search);
        const action = urlParams.get('action');
        const status = urlParams.get('status');
        
        if (action === 'created' && status === 'success') {
            showSuccess('Success', 'Mortality record created successfully!');
            window.history.replaceState({}, document.title, window.location.pathname);
        } else if (action === 'updated' && status === 'success') {
            showSuccess('Success', 'Mortality record updated successfully!');
            window.history.replaceState({}, document.title, window.location.pathname);
        } else if (action === 'deleted' && status === 'success') {
            showSuccess('Success', 'Mortality record deleted successfully!');
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    </script>
</body>
</html>
