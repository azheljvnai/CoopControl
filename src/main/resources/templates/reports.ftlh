<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports | Chicken Coop Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/js/toast.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        .chart-container {
            position: relative;
            height: 280px;
            margin: 1rem 0;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        .report-section {
            margin-bottom: 2rem;
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--hover-highlight);
        }
        .report-header h3 {
            margin: 0;
            color: var(--text-primary);
            font-size: 1.25rem;
        }
        .export-btn {
            background: var(--primary-red);
            color: var(--white);
            border: none;
            padding: 0.625rem 1.25rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 0.9375rem;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .export-btn:hover {
            background: var(--primary-red-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(178, 58, 72, 0.3);
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
                
                <div class="nav-dropdown">
                    <a href="/inventory">Operations</a>
                    <div class="dropdown-menu">
                        <a href="/inventory">Inventory</a>
                        <a href="/financials">Financials</a>
                    </div>
                </div>
                
                <a href="/reports" class="active">Reports</a>
            </nav>
        </div>
    </header>
    <main>
        <div class="page-header">
            <h2>Reports & Analytics</h2>
        </div>

        <div class="reports-container">
            <!-- Financial Reports -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Financial Summary</h3>
                    <button class="export-btn" onclick="exportFinancialSummaryToCSV()">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
                <table id="financialSummaryTable">
                    <thead>
                        <tr>
                            <th>Metric</th>
                            <th>Amount (₱)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Total Revenue</strong></td>
                            <td>₱${(totalRevenue)!0?string("0.00")}</td>
                        </tr>
                        <tr>
                            <td><strong>Total Expenses</strong></td>
                            <td>₱${(totalExpenses)!0?string("0.00")}</td>
                        </tr>
                        <tr>
                            <td><strong>Net Profit</strong></td>
                            <td>₱${(netProfit)!0?string("0.00")}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Expense by Category Report -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Expense by Category</h3>
                    <button class="export-btn" onclick="exportTableToCSV('expenseTable', 'expense-category-report.csv')">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>

                <#if expenseSummary?size gt 0>
                    <div class="chart-container">
                        <canvas id="expenseChart"></canvas>
                    </div>

                    <table id="expenseTable">
                        <thead>
                            <tr>
                                <th>Category</th>
                                <th>Total Amount</th>
                                <th>% of Total</th>
                                <th>Visualization</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#list expenseSummary?keys as category>
                                <#assign amount = expenseSummary[category]>
                                <#if totalExpenses gt 0>
                                    <#assign percentage = (amount / totalExpenses) * 100>
                                <#else>
                                    <#assign percentage = 0>
                                </#if>
                                <tr>
                                    <td><strong>${category}</strong></td>
                                    <td>₱${amount?string("0.00")}</td>
                                    <td>${percentage?string("0.0")}%</td>
                                    <td>
                                        <div style="background: #e0e0e0; border-radius: 4px; overflow: hidden; height: 20px;">
                                            <div style="background: linear-gradient(90deg, #B23A48, #9A2F3C); width: ${percentage?string("0.0")}%; height: 100%;"></div>
                                        </div>
                                    </td>
                                </tr>
                            </#list>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td><strong>Total All Expenses</strong></td>
                                <td><strong>₱${(totalExpenses)!0?string("0.00")}</strong></td>
                                <td><strong>100.0%</strong></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                <#else>
                    <div class="no-data">
                        <p style="font-size: 1.1rem; color: #333;">No expense data available yet.</p>
                        <p>Start by adding expenses in the <a href="/financials">Financials section</a>.</p>
                    </div>
                </#if>
            </div>

            <!-- Sales Report -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Sales Report</h3>
                    <button class="export-btn" onclick="exportTableToCSV('salesTable', 'sales-report.csv')">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
                <#if sales?? && sales?size gt 0>
                    <table id="salesTable">
                        <thead>
                            <tr>
                                <th>Flock</th>
                                <th>Item</th>
                                <th>Quantity</th>
                                <th>Sale Date</th>
                                <th>Total Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#list sales as sale>
                                <tr>
                                    <td>${(sale.flock.name)!"-"}</td>
                                    <td>${(sale.item)!}</td>
                                    <td>${(sale.quantity)!0}</td>
                                    <td>${(sale.saleDate)!}</td>
                                    <td>₱${(sale.totalAmount)!0?string("0.00")}</td>
                                </tr>
                            </#list>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4"><strong>Total Revenue</strong></td>
                                <td><strong>₱${(totalRevenue)!0?string("0.00")}</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                <#else>
                    <div class="no-data">
                        <p>No sales data available yet.</p>
                    </div>
                </#if>
            </div>

            <!-- Expenses Report -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Expenses Report</h3>
                    <button class="export-btn" onclick="exportTableToCSV('expensesTable', 'expenses-report.csv')">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
                <#if expenses?? && expenses?size gt 0>
                    <table id="expensesTable">
                        <thead>
                            <tr>
                                <th>Flock</th>
                                <th>Category</th>
                                <th>Description</th>
                                <th>Expense Date</th>
                                <th>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#list expenses as expense>
                                <tr>
                                    <td>${(expense.flock.name)!"-"}</td>
                                    <td>${(expense.category)!}</td>
                                    <td>${(expense.description)!}</td>
                                    <td>${(expense.expenseDate)!}</td>
                                    <td>₱${(expense.amount)!0?string("0.00")}</td>
                                </tr>
                            </#list>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4"><strong>Total Expenses</strong></td>
                                <td><strong>₱${(totalExpenses)!0?string("0.00")}</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                <#else>
                    <div class="no-data">
                        <p>No expenses data available yet.</p>
                    </div>
                </#if>
            </div>

            <!-- Flock Report -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Flock Report</h3>
                    <button class="export-btn" onclick="exportTableToCSV('flocksTable', 'flocks-report.csv')">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
                <#if flocks?? && flocks?size gt 0>
                    <table id="flocksTable">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Breed</th>
                                <th>Acquisition Date</th>
                                <th>Initial Count</th>
                                <th>Current Count</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#list flocks as flock>
                                <tr>
                                    <td>${(flock.name)!}</td>
                                    <td>${(flock.breed)!}</td>
                                    <td>${(flock.acquisitionDate)!}</td>
                                    <td>${(flock.initialCount)!0}</td>
                                    <td>${(flock.currentCount)!0}</td>
                                </tr>
                            </#list>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3"><strong>Total Flocks</strong></td>
                                <td><strong>${(totalFlocks)!0}</strong></td>
                                <td><strong>${(totalBirds)!0}</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                <#else>
                    <div class="no-data">
                        <p>No flock data available yet.</p>
                    </div>
                </#if>
            </div>

            <!-- Egg Production Report -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Egg Production Report</h3>
                    <button class="export-btn" onclick="exportTableToCSV('eggProductionTable', 'egg-production-report.csv')">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
                <#if eggProductions?? && eggProductions?size gt 0>
                    <table id="eggProductionTable">
                        <thead>
                            <tr>
                                <th>Flock</th>
                                <th>Collection Date</th>
                                <th>Quantity</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#list eggProductions as eggProduction>
                                <tr>
                                    <td>${(eggProduction.flock.name)!"-"}</td>
                                    <td>${(eggProduction.collectionDate)!}</td>
                                    <td>${(eggProduction.quantity)!0}</td>
                                    <td>${(eggProduction.notes)!"-"}</td>
                                </tr>
                            </#list>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2"><strong>Total Eggs</strong></td>
                                <td><strong>${(totalEggs)!0}</strong></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                <#else>
                    <div class="no-data">
                        <p>No egg production data available yet.</p>
                    </div>
                </#if>
            </div>

            <!-- Health Records Report -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Health Records Report</h3>
                    <button class="export-btn" onclick="exportTableToCSV('healthRecordsTable', 'health-records-report.csv')">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
                <#if healthRecords?? && healthRecords?size gt 0>
                    <table id="healthRecordsTable">
                        <thead>
                            <tr>
                                <th>Flock</th>
                                <th>Record Date</th>
                                <th>Record Type</th>
                                <th>Description</th>
                                <th>Veterinarian</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#list healthRecords as healthRecord>
                                <tr>
                                    <td>${(healthRecord.flock.name)!"-"}</td>
                                    <td>${(healthRecord.recordDate)!}</td>
                                    <td>${(healthRecord.recordType)!}</td>
                                    <td>${(healthRecord.description)!}</td>
                                    <td>${(healthRecord.veterinarian)!"-"}</td>
                                </tr>
                            </#list>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4"><strong>Total Health Records</strong></td>
                                <td><strong>${(totalHealthRecords)!0}</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                <#else>
                    <div class="no-data">
                        <p>No health records data available yet.</p>
                    </div>
                </#if>
            </div>

            <!-- Mortality Report -->
            <div class="report-section">
                <div class="report-header">
                    <h3>Mortality Report</h3>
                    <button class="export-btn" onclick="exportTableToCSV('mortalityTable', 'mortality-report.csv')">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
                <#if mortalities?? && mortalities?size gt 0>
                    <table id="mortalityTable">
                        <thead>
                            <tr>
                                <th>Flock</th>
                                <th>Death Date</th>
                                <th>Quantity</th>
                                <th>Cause</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#list mortalities as mortality>
                                <tr>
                                    <td>${(mortality.flock.name)!"-"}</td>
                                    <td>${(mortality.deathDate)!}</td>
                                    <td>${(mortality.quantity)!0}</td>
                                    <td>${(mortality.cause)!"-"}</td>
                                    <td>${(mortality.notes)!"-"}</td>
                                </tr>
                            </#list>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2"><strong>Total Mortality</strong></td>
                                <td><strong>${(totalMortality)!0}</strong></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                <#else>
                    <div class="no-data">
                        <p>No mortality data available yet.</p>
                    </div>
                </#if>
            </div>
        </div>
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
                
                document.addEventListener('keydown', function(event) {
                    if (event.key === 'Escape' && nav.classList.contains('active')) {
                        closeMenu();
                    }
                });
            }
        });

        // Initialize Chart only if data exists
        <#if expenseSummary?size gt 0>
        const totalExpenses = parseFloat('${(totalExpenses)!0}') || 0;
        const ctx = document.getElementById('expenseChart').getContext('2d');
        const categories = [<#list expenseSummary?keys as category>'${category?js_string}'<#sep>, </#list>];
        const amounts = [<#list expenseSummary?keys as category>${expenseSummary[category]}<#sep>, </#list>];
        const colors = [
            'rgba(178, 58, 72, 0.8)', 'rgba(154, 47, 60, 0.8)', 'rgba(115, 43, 43, 0.8)',
            'rgba(244, 199, 199, 0.8)', 'rgba(255, 245, 228, 0.8)', 'rgba(239, 217, 193, 0.8)'
        ];
        const chart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: categories,
                datasets: [{
                    label: 'Expenses',
                    data: amounts,
                    backgroundColor: colors,
                    borderColor: 'white',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: { padding: 20, font: { size: 14 } }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed || 0;
                                const total = totalExpenses;
                                if (total === 0) {
                                    return label + ': ₱' + value.toFixed(2) + ' (0%)';
                                }
                                const percentage = ((value / total) * 100).toFixed(1);
                                return label + ': ₱' + value.toFixed(2) + ' (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
        </#if>

        // Generic CSV Export Function
        function exportTableToCSV(tableId, filename) {
            const table = document.getElementById(tableId);
            if (!table) {
                alert('Table not found!');
                return;
            }

            let csv = [];
            const rows = table.querySelectorAll('tr');

            for (let row of rows) {
                const cols = row.querySelectorAll('td, th');
                let csvRow = [];
                for (let col of cols) {
                    let cellText = col.textContent.trim();
                    // Remove any commas and escape quotes
                    cellText = cellText.replace(/"/g, '""');
                    csvRow.push('"' + cellText + '"');
                }
                csv.push(csvRow.join(','));
            }

            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.setAttribute('hidden', '');
            a.setAttribute('href', url);
            a.setAttribute('download', filename);
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }

        // Export Financial Summary
        function exportFinancialSummaryToCSV() {
            const data = [
                ['Metric', 'Amount (₱)'],
                ['Total Revenue', '₱${(totalRevenue)!0?string("0.00")}'],
                ['Total Expenses', '₱${(totalExpenses)!0?string("0.00")}'],
                ['Net Profit', '₱${(netProfit)!0?string("0.00")}']
            ];

            let csv = data.map(row => row.map(cell => '"' + cell.replace(/"/g, '""') + '"').join(',')).join('\n');
            const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.setAttribute('hidden', '');
            a.setAttribute('href', url);
            a.setAttribute('download', 'financial-summary-report.csv');
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }
    </script>
</body>
</html>
