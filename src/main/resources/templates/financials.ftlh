<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financials | Chicken Coop Management System</title>
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
                        <a href="/inventory">Inventory</a>
                        <a href="/financials" class="active">Financials</a>
                    </div>
                </div>
                
                <a href="/reports">Reports</a>
            </nav>
        </div>
    </header>
    <main>
        <div class="page-header">
            <h2>Financials</h2>
        </div>

        <div class="page-header">
            <h3>Sales / Revenue</h3>
            <button class="add-btn" onclick="openAddSaleModal(); return false;">
                <i class="fas fa-plus"></i> Add Sale
            </button>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Item Sold</th>
                    <th>Quantity</th>
                    <th>Total Amount</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <#list sales as sale>
                    <tr>
                        <td>${(sale.saleDate)!}</td>
                        <td>${(sale.item)!"-"}</td>
                        <td>${(sale.quantity)!0}</td>
                        <td>₱${(sale.totalAmount)!0?string("0.00")}</td>
                        <td class="actions">
                            <button class="icon-btn edit"
                                    onclick="openEditSaleModal('${sale.id}', '${(sale.saleDate)!}', '${(sale.item)!}', ${(sale.quantity)!0}, ${(sale.totalAmount)!0})"
                                    title="Edit">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="icon-btn delete"
                                    onclick="deleteSale('${sale.id}')"
                                    title="Delete">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                <#else>
                    <tr>
                        <td colspan="5">No sales recorded.</td>
                    </tr>
                </#list>
            </tbody>
        </table>

        <div class="page-header" style="margin-top: 3rem;">
            <h3>Expenses / Costs</h3>
            <button class="add-btn" onclick="openAddExpenseModal(); return false;">
                <i class="fas fa-plus"></i> Add Expense
            </button>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Category</th>
                    <th>Description</th>
                    <th>Amount</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <#list expenses as expense>
                    <tr>
                        <td>${(expense.expenseDate)!}</td>
                        <td>${(expense.category)!"-"}</td>
                        <td>${(expense.description)!}</td>
                        <td>₱${(expense.amount)!0?string("0.00")}</td>
                        <td class="actions">
                            <button class="icon-btn edit"
                                    onclick="openEditExpenseModal('${expense.id}', '${(expense.expenseDate)!}', '${(expense.category)!}', '${(expense.description)!}', ${(expense.amount)!0})"
                                    title="Edit">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="icon-btn delete"
                                    onclick="deleteExpense('${expense.id}')"
                                    title="Delete">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                <#else>
                    <tr>
                        <td colspan="5">No expenses recorded.</td>
                    </tr>
                </#list>
            </tbody>
        </table>
    </main>

    <!-- Add Sale Modal -->
    <div id="addSaleModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add Sale</h2>
                <button class="close" onclick="closeAddSaleModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/add-sale" method="post" class="data-form">
                    <div>
                        <label for="saleDate">Sale Date:</label>
                        <input type="date" id="saleDate" name="saleDate" required>
                    </div>
                    <div>
                        <label for="item">Item Sold:</label>
                        <input type="text" id="item" name="item" placeholder="e.g., Live Birds, Eggs" required>
                    </div>
                    <div>
                        <label for="quantity">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" required>
                    </div>
                    <div>
                        <label for="totalAmount">Total Amount:</label>
                        <input type="number" step="0.01" id="totalAmount" name="totalAmount" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Sale</button>
                        <button type="button" class="btn-secondary" onclick="closeAddSaleModal()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Sale Modal -->
    <div id="editSaleModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Sale</h2>
                <button class="close" onclick="closeEditSaleModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/update-sale" method="post" class="data-form">
                    <input type="hidden" id="editSaleId" name="id">
                    <div>
                        <label for="editSaleDate">Sale Date:</label>
                        <input type="date" id="editSaleDate" name="saleDate" required>
                    </div>
                    <div>
                        <label for="editItem">Item Sold:</label>
                        <input type="text" id="editItem" name="item" placeholder="e.g., Live Birds, Eggs" required>
                    </div>
                    <div>
                        <label for="editQuantity">Quantity:</label>
                        <input type="number" id="editQuantity" name="quantity" required>
                    </div>
                    <div>
                        <label for="editTotalAmount">Total Amount:</label>
                        <input type="number" step="0.01" id="editTotalAmount" name="totalAmount" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Changes</button>
                        <button type="button" class="btn-secondary" onclick="closeEditSaleModal()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Expense Modal -->
    <div id="addExpenseModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add Expense</h2>
                <button class="close" onclick="closeAddExpenseModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/add-expense" method="post" class="data-form">
                    <div>
                        <label for="expenseDate">Expense Date:</label>
                        <input type="date" id="expenseDate" name="expenseDate" required>
                    </div>
                    <div>
                        <label for="category">Category:</label>
                        <input type="text" id="category" name="category" placeholder="e.g., Feed, Medication, Labor" required>
                    </div>
                    <div>
                        <label for="description">Description:</label>
                        <input type="text" id="description" name="description">
                    </div>
                    <div>
                        <label for="amount">Amount:</label>
                        <input type="number" step="0.01" id="amount" name="amount" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Expense</button>
                        <button type="button" class="btn-secondary" onclick="closeAddExpenseModal()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Expense Modal -->
    <div id="editExpenseModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Expense</h2>
                <button class="close" onclick="closeEditExpenseModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form action="/update-expense" method="post" class="data-form">
                    <input type="hidden" id="editExpenseId" name="id">
                    <div>
                        <label for="editExpenseDate">Expense Date:</label>
                        <input type="date" id="editExpenseDate" name="expenseDate" required>
                    </div>
                    <div>
                        <label for="editCategory">Category:</label>
                        <input type="text" id="editCategory" name="category" placeholder="e.g., Feed, Medication" required>
                    </div>
                    <div>
                        <label for="editDescription">Description:</label>
                        <input type="text" id="editDescription" name="description">
                    </div>
                    <div>
                        <label for="editAmount">Amount:</label>
                        <input type="number" step="0.01" id="editAmount" name="amount" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Changes</button>
                        <button type="button" class="btn-secondary" onclick="closeEditExpenseModal()">Cancel</button>
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

        // Sale Modal Functions
        function openAddSaleModal() {
            document.getElementById('addSaleModal').classList.add('active');
        }

        function closeAddSaleModal() {
            document.getElementById('addSaleModal').classList.remove('active');
        }

        function openEditSaleModal(id, date, item, quantity, amount) {
            document.getElementById('editSaleId').value = id;
            document.getElementById('editSaleDate').value = date;
            document.getElementById('editItem').value = item;
            document.getElementById('editQuantity').value = quantity;
            document.getElementById('editTotalAmount').value = amount;
            document.getElementById('editSaleModal').classList.add('active');
        }

        function closeEditSaleModal() {
            document.getElementById('editSaleModal').classList.remove('active');
        }

        function deleteSale(id) {
            if (confirm('Delete this sale?')) {
                window.location.href = '/delete-sale/' + id;
            }
        }

        // Expense Modal Functions
        function openAddExpenseModal() {
            document.getElementById('addExpenseModal').classList.add('active');
        }

        function closeAddExpenseModal() {
            document.getElementById('addExpenseModal').classList.remove('active');
        }

        function openEditExpenseModal(id, date, category, description, amount) {
            document.getElementById('editExpenseId').value = id;
            document.getElementById('editExpenseDate').value = date;
            document.getElementById('editCategory').value = category;
            document.getElementById('editDescription').value = description;
            document.getElementById('editAmount').value = amount;
            document.getElementById('editExpenseModal').classList.add('active');
        }

        function closeEditExpenseModal() {
            document.getElementById('editExpenseModal').classList.remove('active');
        }

        function deleteExpense(id) {
            if (confirm('Delete this expense?')) {
                window.location.href = '/delete-expense/' + id;
            }
        }

        // Close modal when clicking outside of it
        window.onclick = function(event) {
            const modals = ['addSaleModal', 'editSaleModal', 'addExpenseModal', 'editExpenseModal'];
            modals.forEach(modalId => {
                const modal = document.getElementById(modalId);
                if (event.target == modal) {
                    modal.classList.remove('active');
                }
            });
        }

        // Close modals with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                const modals = ['addSaleModal', 'editSaleModal', 'addExpenseModal', 'editExpenseModal'];
                modals.forEach(modalId => {
                    document.getElementById(modalId).classList.remove('active');
                });
            }
        });
    </script>
</body>
</html>