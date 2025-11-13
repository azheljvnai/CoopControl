<!DOCTYPE html>
<html>
<head>
    <title>Add Sale</title>
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
        <h2>Add Sale</h2>
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
                <a href="/financials" class="btn-secondary">Cancel</a>
            </div>
        </form>
    </main>
    <footer>
        &copy; 2025 Coop
    </footer>
</body>
</html>