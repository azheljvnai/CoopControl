<!DOCTYPE html>
<html>
<head>
    <title>Add Expense</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <header>
        <h1><a href="/">Flock Management System</a></h1>
    </header>
    <nav>
        <a href="/">Dashboard</a>
        <a href="/flocks">Flock Management</a>
        <a href="/inventory">Inventory</a>
        <a href="/financials">Financials</a>
        <a href="/reports">Reports</a>
    </nav>
    <main>
        <h2>Add Expense</h2>
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
                <a href="/financials" class="btn-secondary">Cancel</a>
            </div>
        </form>
    </main>
    <footer>
        &copy; 2025 Coop
    </footer>
</body>
</html>