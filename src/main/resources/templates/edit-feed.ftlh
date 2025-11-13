<!DOCTYPE html>
<html>
<head>
    <title>Edit Feed Entry</title>
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
        <h2>Edit Feed Entry</h2>

        <form action="/update-feed" method="post" class="data-form">
            <input type="hidden" name="id" value="${feedEntry.id}">

            <div>
                <label for="purchaseDate">Purchase Date:</label>
                <input type="date" id="purchaseDate" name="purchaseDate"
                       value="${(feedEntry.purchaseDate??)?then(feedEntry.purchaseDate, "")}" required>
            </div>
            <div>
                <label for="feedType">Feed Type:</label>
                <input type="text" id="feedType" name="feedType"
                       value="${(feedEntry.feedType)!}" placeholder="e.g., Starter, Grower" required>
            </div>
            <div>
                <label for="quantityKg">Quantity (kg):</label>
                <input type="number" step="0.1" id="quantityKg" name="quantityKg"
                       value="${(feedEntry.quantityKg)!0}" required>
            </div>
            <div>
                <label for="cost">Total Cost:</label>
                <input type="number" step="0.01" id="cost" name="cost"
                       value="${(feedEntry.cost)!0}" required>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn">Save Changes</button>
                <a href="/inventory" class="btn-secondary">Cancel</a>
            </div>
        </form>
    </main>
    <footer>
        &copy; 2025 Coop
    </footer>
</body>
</html>