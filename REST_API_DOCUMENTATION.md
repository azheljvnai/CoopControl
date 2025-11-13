# REST API Documentation - Chicken Coop Management System

This document describes all the RESTful Web Service APIs available in the application.

## Base URL
All API endpoints are prefixed with `/api`

---

## Flock Management API

**Base Path:** `/api/flocks`

### Get All Flocks
- **Method:** `GET`
- **Endpoint:** `/api/flocks`
- **Response:** `200 OK` - List of all flocks

### Get Flock by ID
- **Method:** `GET`
- **Endpoint:** `/api/flocks/{id}`
- **Response:** `200 OK` - Flock object
- **Response:** `404 Not Found` - Flock not found

### Create Flock
- **Method:** `POST`
- **Endpoint:** `/api/flocks`
- **Body:** JSON Flock object
- **Response:** `201 Created` - Created flock object

### Update Flock
- **Method:** `PUT`
- **Endpoint:** `/api/flocks/{id}`
- **Body:** JSON Flock object
- **Response:** `200 OK` - Updated flock object
- **Response:** `404 Not Found` - Flock not found

### Delete Flock
- **Method:** `DELETE`
- **Endpoint:** `/api/flocks/{id}`
- **Response:** `204 No Content` - Successfully deleted
- **Response:** `404 Not Found` - Flock not found

### Get Total Flock Count (Stats)
- **Method:** `GET`
- **Endpoint:** `/api/flocks/stats/count`
- **Response:** `200 OK` - Total number of flocks

### Get Total Bird Count (Stats)
- **Method:** `GET`
- **Endpoint:** `/api/flocks/stats/birds`
- **Response:** `200 OK` - Total number of birds

---

## Feed Inventory API

**Base Path:** `/api/inventory/feed`

### Get All Feed Entries
- **Method:** `GET`
- **Endpoint:** `/api/inventory/feed`
- **Response:** `200 OK` - List of all feed entries

### Get Feed Entry by ID
- **Method:** `GET`
- **Endpoint:** `/api/inventory/feed/{id}`
- **Response:** `200 OK` - Feed entry object
- **Response:** `404 Not Found` - Feed entry not found

### Create Feed Entry
- **Method:** `POST`
- **Endpoint:** `/api/inventory/feed`
- **Body:** JSON FeedEntry object
- **Response:** `201 Created` - Created feed entry object

### Update Feed Entry
- **Method:** `PUT`
- **Endpoint:** `/api/inventory/feed/{id}`
- **Body:** JSON FeedEntry object
- **Response:** `200 OK` - Updated feed entry object
- **Response:** `404 Not Found` - Feed entry not found

### Delete Feed Entry
- **Method:** `DELETE`
- **Endpoint:** `/api/inventory/feed/{id}`
- **Response:** `204 No Content` - Successfully deleted
- **Response:** `404 Not Found` - Feed entry not found

### Get Total Feed Stock (Stats)
- **Method:** `GET`
- **Endpoint:** `/api/inventory/feed/stats/total`
- **Response:** `200 OK` - Total feed stock in kg

---

## Medicine Inventory API

**Base Path:** `/api/inventory/medicine`

### Get All Medicines
- **Method:** `GET`
- **Endpoint:** `/api/inventory/medicine`
- **Response:** `200 OK` - List of all medicines

### Get Medicine by ID
- **Method:** `GET`
- **Endpoint:** `/api/inventory/medicine/{id}`
- **Response:** `200 OK` - Medicine object
- **Response:** `404 Not Found` - Medicine not found

### Create Medicine
- **Method:** `POST`
- **Endpoint:** `/api/inventory/medicine`
- **Body:** JSON Medicine object
- **Response:** `201 Created` - Created medicine object

### Update Medicine
- **Method:** `PUT`
- **Endpoint:** `/api/inventory/medicine/{id}`
- **Body:** JSON Medicine object
- **Response:** `200 OK` - Updated medicine object
- **Response:** `404 Not Found` - Medicine not found

### Delete Medicine
- **Method:** `DELETE`
- **Endpoint:** `/api/inventory/medicine/{id}`
- **Response:** `204 No Content` - Successfully deleted
- **Response:** `404 Not Found` - Medicine not found

### Get Total Medicine Count (Stats)
- **Method:** `GET`
- **Endpoint:** `/api/inventory/medicine/stats/total`
- **Response:** `200 OK` - Total medicine items

---

## Supply Inventory API

**Base Path:** `/api/inventory/supplies`

### Get All Supplies
- **Method:** `GET`
- **Endpoint:** `/api/inventory/supplies`
- **Response:** `200 OK` - List of all supplies

### Get Supply by ID
- **Method:** `GET`
- **Endpoint:** `/api/inventory/supplies/{id}`
- **Response:** `200 OK` - Supply object
- **Response:** `404 Not Found` - Supply not found

### Create Supply
- **Method:** `POST`
- **Endpoint:** `/api/inventory/supplies`
- **Body:** JSON Supply object
- **Response:** `201 Created` - Created supply object

### Update Supply
- **Method:** `PUT`
- **Endpoint:** `/api/inventory/supplies/{id}`
- **Body:** JSON Supply object
- **Response:** `200 OK` - Updated supply object
- **Response:** `404 Not Found` - Supply not found

### Delete Supply
- **Method:** `DELETE`
- **Endpoint:** `/api/inventory/supplies/{id}`
- **Response:** `204 No Content` - Successfully deleted
- **Response:** `404 Not Found` - Supply not found

### Get Total Supply Count (Stats)
- **Method:** `GET`
- **Endpoint:** `/api/inventory/supplies/stats/total`
- **Response:** `200 OK` - Total supply items

---

## Sales Financial API

**Base Path:** `/api/financials/sales`

### Get All Sales
- **Method:** `GET`
- **Endpoint:** `/api/financials/sales`
- **Response:** `200 OK` - List of all sales

### Get Sale by ID
- **Method:** `GET`
- **Endpoint:** `/api/financials/sales/{id}`
- **Response:** `200 OK` - Sale object
- **Response:** `404 Not Found` - Sale not found

### Create Sale
- **Method:** `POST`
- **Endpoint:** `/api/financials/sales`
- **Body:** JSON Sale object
- **Response:** `201 Created` - Created sale object

### Update Sale
- **Method:** `PUT`
- **Endpoint:** `/api/financials/sales/{id}`
- **Body:** JSON Sale object
- **Response:** `200 OK` - Updated sale object
- **Response:** `404 Not Found` - Sale not found

### Delete Sale
- **Method:** `DELETE`
- **Endpoint:** `/api/financials/sales/{id}`
- **Response:** `204 No Content` - Successfully deleted
- **Response:** `404 Not Found` - Sale not found

---

## Expenses Financial API

**Base Path:** `/api/financials/expenses`

### Get All Expenses
- **Method:** `GET`
- **Endpoint:** `/api/financials/expenses`
- **Response:** `200 OK` - List of all expenses

### Get Expense by ID
- **Method:** `GET`
- **Endpoint:** `/api/financials/expenses/{id}`
- **Response:** `200 OK` - Expense object
- **Response:** `404 Not Found` - Expense not found

### Create Expense
- **Method:** `POST`
- **Endpoint:** `/api/financials/expenses`
- **Body:** JSON Expense object
- **Response:** `201 Created` - Created expense object

### Update Expense
- **Method:** `PUT`
- **Endpoint:** `/api/financials/expenses/{id}`
- **Body:** JSON Expense object
- **Response:** `200 OK` - Updated expense object
- **Response:** `404 Not Found` - Expense not found

### Delete Expense
- **Method:** `DELETE`
- **Endpoint:** `/api/financials/expenses/{id}`
- **Response:** `204 No Content` - Successfully deleted
- **Response:** `404 Not Found` - Expense not found

---

## Reports API

**Base Path:** `/api/reports`

### Get Financial Summary
- **Method:** `GET`
- **Endpoint:** `/api/reports/financials/summary`
- **Response:** `200 OK` - JSON object containing:
  - `totalRevenue`: BigDecimal
  - `totalExpenses`: BigDecimal
  - `netProfit`: BigDecimal

### Get Expense Summary by Category
- **Method:** `GET`
- **Endpoint:** `/api/reports/financials/expenses/by-category`
- **Response:** `200 OK` - Map of category to total expense amount

### Get Flock Summary
- **Method:** `GET`
- **Endpoint:** `/api/reports/flocks/summary`
- **Response:** `200 OK` - JSON object containing:
  - `totalFlocks`: Long
  - `totalBirds`: Integer

### Get Inventory Summary
- **Method:** `GET`
- **Endpoint:** `/api/reports/inventory/summary`
- **Response:** `200 OK` - JSON object containing:
  - `totalFeedStock`: Double
  - `totalSupplies`: Double
  - `totalMedicine`: Double

### Get Dashboard Data
- **Method:** `GET`
- **Endpoint:** `/api/reports/dashboard`
- **Response:** `200 OK` - Complete dashboard data including:
  - `flocks`: Object with totalFlocks and totalBirds
  - `financials`: Object with totalRevenue, totalExpenses, netProfit
  - `inventory`: Object with totalFeedStock, totalSupplies, totalMedicine

---

## Example JSON Request Bodies

### Flock
```json
{
  "name": "Chicken Flock A",
  "breed": "Rhode Island Red",
  "acquisitionDate": "2024-01-15",
  "initialCount": 100,
  "currentCount": 95
}
```

### FeedEntry
```json
{
  "feedType": "Layer Feed",
  "quantityKg": 50.5,
  "cost": 1250.00,
  "purchaseDate": "2024-02-01"
}
```

### Medicine
```json
{
  "medicineName": "Antibiotic",
  "quantity": 10.0,
  "unit": "bottles",
  "cost": 500.00,
  "purchaseDate": "2024-01-20",
  "expiryDate": "2025-01-20"
}
```

### Supply
```json
{
  "itemName": "Feed Bags",
  "quantity": 20.0,
  "unit": "bags",
  "cost": 800.00,
  "purchaseDate": "2024-02-01"
}
```

### Sale
```json
{
  "item": "Eggs",
  "quantity": 500,
  "totalAmount": 2500.00,
  "saleDate": "2024-02-15"
}
```

### Expense
```json
{
  "category": "Feed",
  "description": "Monthly feed purchase",
  "amount": 1500.00,
  "expenseDate": "2024-02-01"
}
```

---

## Testing the APIs

### Using cURL Examples

**Get all flocks:**
```bash
curl http://localhost:18080/api/flocks
```

**Create a new flock:**
```bash
curl -X POST http://localhost:18080/api/flocks \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Flock",
    "breed": "Leghorn",
    "acquisitionDate": "2024-01-01",
    "initialCount": 50,
    "currentCount": 50
  }'
```

**Update a flock:**
```bash
curl -X PUT http://localhost:18080/api/flocks/1 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Updated Flock",
    "breed": "Leghorn",
    "acquisitionDate": "2024-01-01",
    "initialCount": 50,
    "currentCount": 48
  }'
```

**Delete a flock:**
```bash
curl -X DELETE http://localhost:18080/api/flocks/1
```

---

## Notes

- All dates should be in ISO format: `YYYY-MM-DD`
- All monetary values are BigDecimal (JSON numbers)
- All responses return JSON unless otherwise specified
- HTTP status codes follow RESTful conventions:
  - `200 OK` - Successful GET/PUT
  - `201 Created` - Successful POST
  - `204 No Content` - Successful DELETE
  - `404 Not Found` - Resource not found
- The application runs on port `18080` by default (configured in `application.properties`)

