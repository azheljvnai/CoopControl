<!DOCTYPE html>
<html>
<head>
    <title>Edit Flock</title>
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
        <h2>Edit Flock: ${(flock.name)!"-"}</h2>

        <form action="/update-flock" method="post" class="data-form">
            <input type="hidden" name="id" value="${flock.id}">

            <div>
                <label for="name">Flock Name:</label>
                <input type="text" id="name" name="name" value="${(flock.name)!}" required>
            </div>
            <div>
                <label for="breed">Breed:</label>
                <input type="text" id="breed" name="breed" value="${(flock.breed)!}" required>
            </div>
            <div>
                <label for="acquisitionDate">Acquisition Date:</label>
                <input type="date" id="acquisitionDate" name="acquisitionDate"
                       value="${(flock.acquisitionDate??)?then(flock.acquisitionDate, "")}" required>
            </div>
            <div>
                <label for="initialCount">Initial Count:</label>
                <input type="number" id="initialCount" name="initialCount" value="${(flock.initialCount)!0}" required>
            </div>
            <div>
                <label for="currentCount">Current Count:</label>
                <input type="number" id="currentCount" name="currentCount" value="${(flock.currentCount)!0}" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn">Save Changes</button>
                <a href="/flocks" class="btn-secondary">Cancel</a>
            </div>
        </form>
    </main>
    <footer>
        &copy; 2025 Coop
    </footer>
</body>
</html>