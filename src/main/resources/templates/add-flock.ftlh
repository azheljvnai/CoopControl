<!DOCTYPE html>
<html>
<head>
    <title>Add New Flock</title>
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
        <h2>Add New Flock</h2>

        <form action="/add-flock" method="post" class="data-form">
            <div>
                <label for="name">Flock Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div>
                <label for="breed">Breed:</label>
                <input type="text" id="breed" name="breed" required>
            </div>
            <div>
                <label for="acquisitionDate">Acquisition Date:</label>
                <input type="date" id="acquisitionDate" name="acquisitionDate" required>
            </div>
            <div>
                <label for="initialCount">Initial Count:</label>
                <input type="number" id="initialCount" name="initialCount" required>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn">Save Flock</button>
                <a href="/flocks" class="btn-secondary">Cancel</a>
            </div>
        </form>
    </main>
    <footer>
        &copy; 2025 Coop
    </footer>
</body>
</html>