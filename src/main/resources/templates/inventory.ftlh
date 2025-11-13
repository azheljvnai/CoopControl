<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management | Chicken Coop Management System</title>
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
                
                <div class="nav-dropdown">
                    <a href="/flocks">Management</a>
                    <div class="dropdown-menu">
                        <a href="/flocks">Flock Management</a>
                        <a href="/egg-production">Egg Production</a>
                        <a href="/health-records">Health Records</a>
                        <a href="/mortality">Mortality</a>
                    </div>
                </div>
                
                <div class="nav-dropdown active">
                    <a href="/inventory">Operations</a>
                    <div class="dropdown-menu">
                        <a href="/inventory" class="active">Inventory</a>
                        <a href="/financials">Financials</a>
                    </div>
                </div>
                
                <a href="/reports">Reports</a>
            </nav>
        </div>
    </header>
    <main>
        <div class="page-header">
            <h2>Inventory Management</h2>
        </div>

        <!-- Tabs -->
        <div class="inventory-tabs">
            <button class="tab active" onclick="switchTab('feed')">Feed</button>
            <button class="tab" onclick="switchTab('supplies')">Supplies</button>
            <button class="tab" onclick="switchTab('medicine')">Medicine</button>
        </div>

        <!-- Feed Tab -->
        <div id="feed-tab" class="tab-content active">
            <div class="page-header">
                <h3>Feed Inventory</h3>
                <button onclick="openAddModal('feed')" class="add-btn">
                    <i class="fas fa-plus"></i> Add Feed Entry
                </button>
            </div>

            <div class="summary-cards">
                <div class="summary-card">
                    <h3>Total Feed Stock</h3>
                    <p>${totalFeedStock?string("0.0")} kg</p>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Purchase Date</th>
                        <th>Feed Type</th>
                        <th>Quantity (kg)</th>
                        <th>Cost</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <#list feedEntries as entry>
                        <tr>
                            <td>${(entry.purchaseDate)!}</td>
                            <td>${(entry.feedType)!"-"}</td>
                            <td>${(entry.quantityKg)!0?string("0.0")}</td>
                            <td>₱${(entry.cost)!0?string("0.00")}</td>
                            <td class="actions">
                                <button class="icon-btn edit"
                                        onclick="openEditModal('feed', ${entry.id}, '${(entry.purchaseDate)!}', '${(entry.feedType)?js_string}', ${(entry.quantityKg)!0}, ${(entry.cost)!0})"
                                        title="Edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="icon-btn delete"
                                        onclick="deleteEntry('feed', ${entry.id})"
                                        title="Delete">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    <#else>
                        <tr>
                            <td colspan="5">No feed entries found.</td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </div>

        <!-- Supplies Tab -->
        <div id="supplies-tab" class="tab-content">
            <div class="page-header">
                <h3>Supplies Inventory</h3>
                <button onclick="openAddModal('supplies')" class="add-btn">
                    <i class="fas fa-plus"></i> Add Supply Entry
                </button>
            </div>

            <div class="summary-cards">
                <div class="summary-card">
                    <h3>Total Items</h3>
                    <p>${totalSupplies!0}</p>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Purchase Date</th>
                        <th>Item Name</th>
                        <th>Quantity</th>
                        <th>Unit</th>
                        <th>Cost</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <#list supplyEntries as entry>
                        <tr>
                            <td>${(entry.purchaseDate)!}</td>
                            <td>${(entry.itemName)!"-"}</td>
                            <td>${(entry.quantity)!0}</td>
                            <td>${(entry.unit)!"-"}</td>
                            <td>₱${(entry.cost)!0?string("0.00")}</td>
                            <td class="actions">
                                <button class="icon-btn edit"
                                        onclick="openEditModal('supplies', ${entry.id}, '${(entry.purchaseDate)!}', '${(entry.itemName)?js_string}', ${(entry.quantity)!0}, ${(entry.cost)!0}, '${(entry.unit)?js_string}')"
                                        title="Edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="icon-btn delete"
                                        onclick="deleteEntry('supply', ${entry.id})"
                                        title="Delete">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    <#else>
                        <tr>
                            <td colspan="6">No supply entries found.</td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </div>

        <!-- Medicine Tab -->
        <div id="medicine-tab" class="tab-content">
            <div class="page-header">
                <h3>Medicine Inventory</h3>
                <button onclick="openAddModal('medicine')" class="add-btn">
                    <i class="fas fa-plus"></i> Add Medicine Entry
                </button>
            </div>

            <div class="summary-cards">
                <div class="summary-card">
                    <h3>Total Items</h3>
                    <p>${totalMedicine!0}</p>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Purchase Date</th>
                        <th>Medicine Name</th>
                        <th>Quantity</th>
                        <th>Unit</th>
                        <th>Expiry Date</th>
                        <th>Cost</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <#list medicineEntries as entry>
                        <tr>
                            <td>${(entry.purchaseDate)!}</td>
                            <td>${(entry.medicineName)!"-"}</td>
                            <td>${(entry.quantity)!0}</td>
                            <td>${(entry.unit)!"-"}</td>
                            <td>${(entry.expiryDate)!"-"}</td>
                            <td>₱${(entry.cost)!0?string("0.00")}</td>
                            <td class="actions">
                                <button class="icon-btn edit"
                                        onclick="openEditModal('medicine', ${entry.id}, '${(entry.purchaseDate)!}', '${(entry.medicineName)?js_string}', ${(entry.quantity)!0}, ${(entry.cost)!0}, '${(entry.unit)?js_string}', '${(entry.expiryDate)!}')"
                                        title="Edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="icon-btn delete"
                                        onclick="deleteEntry('medicine', ${entry.id})"
                                        title="Delete">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    <#else>
                        <tr>
                            <td colspan="7">No medicine entries found.</td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Add Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="addModalTitle">Add Entry</h2>
                <button class="close" onclick="closeAddModal()">&times;</button>
            </div>
            <div class="modal-body">
                <!-- Feed Form -->
                <form id="addFeedForm" action="/add-feed" method="post" class="data-form">
                    <div>
                        <label for="add_feed_purchaseDate">Purchase Date:</label>
                        <input type="date" id="add_feed_purchaseDate" name="purchaseDate" required>
                    </div>
                    <div>
                        <label for="add_feed_feedType">Feed Type:</label>
                        <input type="text" id="add_feed_feedType" name="feedType" placeholder="e.g., Starter, Grower" required>
                    </div>
                    <div>
                        <label for="add_feed_quantityKg">Quantity (kg):</label>
                        <input type="number" step="0.1" id="add_feed_quantityKg" name="quantityKg" required>
                    </div>
                    <div>
                        <label for="add_feed_cost">Total Cost:</label>
                        <input type="number" step="0.01" id="add_feed_cost" name="cost" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Entry</button>
                        <button type="button" onclick="closeAddModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>

                <!-- Supplies Form -->
                <form id="addSuppliesForm" action="/add-supply" method="post" class="data-form" style="display:none;">
                    <div>
                        <label for="add_supply_purchaseDate">Purchase Date:</label>
                        <input type="date" id="add_supply_purchaseDate" name="purchaseDate" required>
                    </div>
                    <div>
                        <label for="add_supply_itemName">Item Name:</label>
                        <input type="text" id="add_supply_itemName" name="itemName" placeholder="e.g., Feeders, Drinkers" required>
                    </div>
                    <div>
                        <label for="add_supply_quantity">Quantity:</label>
                        <input type="number" step="0.1" id="add_supply_quantity" name="quantity" required>
                    </div>
                    <div>
                        <label for="add_supply_unit">Unit:</label>
                        <input type="text" id="add_supply_unit" name="unit" placeholder="e.g., pieces, boxes" required>
                    </div>
                    <div>
                        <label for="add_supply_cost">Total Cost:</label>
                        <input type="number" step="0.01" id="add_supply_cost" name="cost" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Entry</button>
                        <button type="button" onclick="closeAddModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>

                <!-- Medicine Form -->
                <form id="addMedicineForm" action="/add-medicine" method="post" class="data-form" style="display:none;">
                    <div>
                        <label for="add_medicine_purchaseDate">Purchase Date:</label>
                        <input type="date" id="add_medicine_purchaseDate" name="purchaseDate" required>
                    </div>
                    <div>
                        <label for="add_medicine_medicineName">Medicine Name:</label>
                        <input type="text" id="add_medicine_medicineName" name="medicineName" placeholder="e.g., Antibiotics, Vitamins" required>
                    </div>
                    <div>
                        <label for="add_medicine_quantity">Quantity:</label>
                        <input type="number" step="0.1" id="add_medicine_quantity" name="quantity" required>
                    </div>
                    <div>
                        <label for="add_medicine_unit">Unit:</label>
                        <input type="text" id="add_medicine_unit" name="unit" placeholder="e.g., ml, tablets" required>
                    </div>
                    <div>
                        <label for="add_medicine_expiryDate">Expiry Date:</label>
                        <input type="date" id="add_medicine_expiryDate" name="expiryDate" required>
                    </div>
                    <div>
                        <label for="add_medicine_cost">Total Cost:</label>
                        <input type="number" step="0.01" id="add_medicine_cost" name="cost" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Entry</button>
                        <button type="button" onclick="closeAddModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="editModalTitle">Edit Entry</h2>
                <button class="close" onclick="closeEditModal()">&times;</button>
            </div>
            <div class="modal-body">
                <!-- Feed Edit Form -->
                <form id="editFeedForm" action="/update-feed" method="post" class="data-form">
                    <input type="hidden" id="edit_feed_id" name="id">
                    <div>
                        <label for="edit_feed_purchaseDate">Purchase Date:</label>
                        <input type="date" id="edit_feed_purchaseDate" name="purchaseDate" required>
                    </div>
                    <div>
                        <label for="edit_feed_feedType">Feed Type:</label>
                        <input type="text" id="edit_feed_feedType" name="feedType" required>
                    </div>
                    <div>
                        <label for="edit_feed_quantityKg">Quantity (kg):</label>
                        <input type="number" step="0.1" id="edit_feed_quantityKg" name="quantityKg" required>
                    </div>
                    <div>
                        <label for="edit_feed_cost">Total Cost:</label>
                        <input type="number" step="0.01" id="edit_feed_cost" name="cost" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Changes</button>
                        <button type="button" onclick="closeEditModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>

                <!-- Supplies Edit Form -->
                <form id="editSuppliesForm" action="/update-supply" method="post" class="data-form" style="display:none;">
                    <input type="hidden" id="edit_supply_id" name="id">
                    <div>
                        <label for="edit_supply_purchaseDate">Purchase Date:</label>
                        <input type="date" id="edit_supply_purchaseDate" name="purchaseDate" required>
                    </div>
                    <div>
                        <label for="edit_supply_itemName">Item Name:</label>
                        <input type="text" id="edit_supply_itemName" name="itemName" required>
                    </div>
                    <div>
                        <label for="edit_supply_quantity">Quantity:</label>
                        <input type="number" step="0.1" id="edit_supply_quantity" name="quantity" required>
                    </div>
                    <div>
                        <label for="edit_supply_unit">Unit:</label>
                        <input type="text" id="edit_supply_unit" name="unit" required>
                    </div>
                    <div>
                        <label for="edit_supply_cost">Total Cost:</label>
                        <input type="number" step="0.01" id="edit_supply_cost" name="cost" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Changes</button>
                        <button type="button" onclick="closeEditModal()" class="btn-secondary">Cancel</button>
                    </div>
                </form>

                <!-- Medicine Edit Form -->
                <form id="editMedicineForm" action="/update-medicine" method="post" class="data-form" style="display:none;">
                    <input type="hidden" id="edit_medicine_id" name="id">
                    <div>
                        <label for="edit_medicine_purchaseDate">Purchase Date:</label>
                        <input type="date" id="edit_medicine_purchaseDate" name="purchaseDate" required>
                    </div>
                    <div>
                        <label for="edit_medicine_medicineName">Medicine Name:</label>
                        <input type="text" id="edit_medicine_medicineName" name="medicineName" required>
                    </div>
                    <div>
                        <label for="edit_medicine_quantity">Quantity:</label>
                        <input type="number" step="0.1" id="edit_medicine_quantity" name="quantity" required>
                    </div>
                    <div>
                        <label for="edit_medicine_unit">Unit:</label>
                        <input type="text" id="edit_medicine_unit" name="unit" required>
                    </div>
                    <div>
                        <label for="edit_medicine_expiryDate">Expiry Date:</label>
                        <input type="date" id="edit_medicine_expiryDate" name="expiryDate" required>
                    </div>
                    <div>
                        <label for="edit_medicine_cost">Total Cost:</label>
                        <input type="number" step="0.01" id="edit_medicine_cost" name="cost" required>
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

        let currentTab = 'feed';

        // Tab Switching
        function switchTab(tab) {
            currentTab = tab;
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));

            event.target.classList.add('active');
            document.getElementById(tab + '-tab').classList.add('active');
        }

        // Add Modal Functions
        function openAddModal(type) {
            const titles = {
                feed: 'Add Feed Entry',
                supplies: 'Add Supply Entry',
                medicine: 'Add Medicine Entry'
            };

            document.getElementById('addModalTitle').textContent = titles[type];

            // Hide all forms
            document.getElementById('addFeedForm').style.display = 'none';
            document.getElementById('addSuppliesForm').style.display = 'none';
            document.getElementById('addMedicineForm').style.display = 'none';

            // Show selected form
            document.getElementById('add' + type.charAt(0).toUpperCase() + type.slice(1) + 'Form').style.display = 'block';

            document.getElementById('addModal').classList.add('active');
        }

        function closeAddModal() {
            document.getElementById('addModal').classList.remove('active');
            document.querySelectorAll('#addModal form').forEach(form => form.reset());
        }

        // Edit Modal Functions
        function openEditModal(type, id, purchaseDate, name, quantity, cost, unit, expiryDate) {
            const titles = {
                feed: 'Edit Feed Entry',
                supplies: 'Edit Supply Entry',
                medicine: 'Edit Medicine Entry'
            };

            document.getElementById('editModalTitle').textContent = titles[type];

            // Hide all forms
            document.getElementById('editFeedForm').style.display = 'none';
            document.getElementById('editSuppliesForm').style.display = 'none';
            document.getElementById('editMedicineForm').style.display = 'none';

            // Show and populate selected form
            if (type === 'feed') {
                document.getElementById('editFeedForm').style.display = 'block';
                document.getElementById('edit_feed_id').value = id;
                document.getElementById('edit_feed_purchaseDate').value = purchaseDate;
                document.getElementById('edit_feed_feedType').value = name;
                document.getElementById('edit_feed_quantityKg').value = quantity;
                document.getElementById('edit_feed_cost').value = cost;
            } else if (type === 'supplies') {
                document.getElementById('editSuppliesForm').style.display = 'block';
                document.getElementById('edit_supply_id').value = id;
                document.getElementById('edit_supply_purchaseDate').value = purchaseDate;
                document.getElementById('edit_supply_itemName').value = name;
                document.getElementById('edit_supply_quantity').value = quantity;
                document.getElementById('edit_supply_unit').value = unit;
                document.getElementById('edit_supply_cost').value = cost;
            } else if (type === 'medicine') {
                document.getElementById('editMedicineForm').style.display = 'block';
                document.getElementById('edit_medicine_id').value = id;
                document.getElementById('edit_medicine_purchaseDate').value = purchaseDate;
                document.getElementById('edit_medicine_medicineName').value = name;
                document.getElementById('edit_medicine_quantity').value = quantity;
                document.getElementById('edit_medicine_unit').value = unit;
                document.getElementById('edit_medicine_expiryDate').value = expiryDate;
                document.getElementById('edit_medicine_cost').value = cost;
            }

            document.getElementById('editModal').classList.add('active');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('active');
        }

        // Delete Function
        function deleteEntry(type, id) {
            const messages = {
                feed: 'Delete this feed entry?',
                supply: 'Delete this supply entry?',
                medicine: 'Delete this medicine entry?'
            };

            if (confirm(messages[type])) {
                window.location.href = '/delete-' + type + '/' + id;
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
    </script>
</body>
</html>