package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.service.IFinanceService;
import com.grp10.CourseProject.service.IFlockService;
import com.grp10.CourseProject.service.IInventoryService;
import com.grp10.CourseProject.service.IMedicineService;
import com.grp10.CourseProject.service.ISupplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/reports")
public class ReportRestController {

    @Autowired
    private IFinanceService financeService;

    @Autowired
    private IFlockService flockService;

    @Autowired
    private IInventoryService inventoryService;

    @Autowired
    private ISupplyService supplyService;

    @Autowired
    private IMedicineService medicineService;

    @GetMapping("/financials/summary")
    public ResponseEntity<Map<String, Object>> getFinancialSummary() {
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalRevenue", financeService.getTotalRevenue());
        summary.put("totalExpenses", financeService.getTotalExpenses());
        summary.put("netProfit", financeService.getNetProfit());
        return ResponseEntity.ok(summary);
    }

    @GetMapping("/financials/expenses/by-category")
    public ResponseEntity<Map<String, BigDecimal>> getExpenseSummaryByCategory() {
        Map<String, BigDecimal> expenseSummary = financeService.getExpenseSummaryByCategory();
        return ResponseEntity.ok(expenseSummary);
    }

    @GetMapping("/flocks/summary")
    public ResponseEntity<Map<String, Object>> getFlockSummary() {
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalFlocks", flockService.getTotalFlockCount());
        summary.put("totalBirds", flockService.getTotalBirdCount());
        return ResponseEntity.ok(summary);
    }

    @GetMapping("/inventory/summary")
    public ResponseEntity<Map<String, Object>> getInventorySummary() {
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalFeedStock", inventoryService.getTotalFeedStockKg());
        summary.put("totalSupplies", supplyService.getTotalItems());
        summary.put("totalMedicine", medicineService.getTotalItems());
        return ResponseEntity.ok(summary);
    }

    @GetMapping("/dashboard")
    public ResponseEntity<Map<String, Object>> getDashboardData() {
        Map<String, Object> dashboard = new HashMap<>();
        
        // Flock Data
        Map<String, Object> flocks = new HashMap<>();
        flocks.put("totalFlocks", flockService.getTotalFlockCount());
        flocks.put("totalBirds", flockService.getTotalBirdCount());
        dashboard.put("flocks", flocks);

        // Financial Data
        Map<String, Object> financials = new HashMap<>();
        financials.put("totalRevenue", financeService.getTotalRevenue());
        financials.put("totalExpenses", financeService.getTotalExpenses());
        financials.put("netProfit", financeService.getNetProfit());
        dashboard.put("financials", financials);

        // Inventory Data
        Map<String, Object> inventory = new HashMap<>();
        inventory.put("totalFeedStock", inventoryService.getTotalFeedStockKg());
        inventory.put("totalSupplies", supplyService.getTotalItems());
        inventory.put("totalMedicine", medicineService.getTotalItems());
        dashboard.put("inventory", inventory);

        return ResponseEntity.ok(dashboard);
    }
}

