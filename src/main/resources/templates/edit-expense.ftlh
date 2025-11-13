<!DOCTYPE html>
<html>
<head>
    <title>Edit Expense</title>
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
        <h2>Edit Expense</h2>

        <form action="/update-expense" method="post" class="data-form">
            <input type="hidden" name="id" value="${expense.id}">

            <div>
                <label for="expenseDate">Expense Date:</label>
                <input type="date" id="expenseDate" name="expenseDate"
                       value="${(expense.expenseDate??)?then(expense.expenseDate, "")}" required>
            </div>
            <div>
                <label for="category">Category:</label>
                <input type="text" id="category" name="category"
                       value="${(expense.category)!}" placeholder="e.g., Feed, Medication" required>
            </div>
            <div>
                <label for="description">Description:</label>
                <input type="text" id="description" name="description"
                       value="${(expense.description)!}">
            </div>
            <div>
                <label for="amount">Amount:</label>
                <input type="number" step="0.01" id="amount" name="amount"
                       value="${(expense.amount)!0}" required>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn">Save Changes</button>
                <a href="/financials" class="btn-secondary">Cancel</a>
            </div>
        </form>
    </main>
    <footer>
        &copy; 2025 Coop
    </footer>
</body>
</html>