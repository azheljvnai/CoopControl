package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.Expense;
import com.grp10.CourseProject.service.IFinanceService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/financials/expenses")
public class ExpenseRestController {

    @Autowired
    private IFinanceService financeService;

    @GetMapping
    public ResponseEntity<List<Expense>> getAllExpenses(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) Long flockId) {
        List<Expense> expenses = financeService.getAllExpenses();
        
        // Filter by category
        if (category != null && !category.isEmpty()) {
            expenses = expenses.stream()
                    .filter(e -> e.getCategory() != null && e.getCategory().equalsIgnoreCase(category))
                    .collect(Collectors.toList());
        }
        
        // Filter by date range
        if (startDate != null || endDate != null) {
            if (startDate != null && endDate != null) {
                expenses = expenses.stream()
                        .filter(e -> e.getExpenseDate() != null && 
                                !e.getExpenseDate().isBefore(startDate) && 
                                !e.getExpenseDate().isAfter(endDate))
                        .collect(Collectors.toList());
            } else if (startDate != null) {
                expenses = expenses.stream()
                        .filter(e -> e.getExpenseDate() != null && !e.getExpenseDate().isBefore(startDate))
                        .collect(Collectors.toList());
            } else if (endDate != null) {
                expenses = expenses.stream()
                        .filter(e -> e.getExpenseDate() != null && !e.getExpenseDate().isAfter(endDate))
                        .collect(Collectors.toList());
            }
        }
        
        // Filter by flock ID
        if (flockId != null) {
            expenses = expenses.stream()
                    .filter(e -> e.getFlock() != null && e.getFlock().getId().equals(flockId))
                    .collect(Collectors.toList());
        }
        
        return ResponseEntity.ok(expenses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Expense> getExpense(@PathVariable Long id) {
        Expense expense = financeService.findExpenseById(id);
        if (expense == null) {
            throw new ResourceNotFoundException("Expense", "id", id);
        }
        return ResponseEntity.ok(expense);
    }

    @PostMapping
    public ResponseEntity<Expense> createExpense(@Valid @RequestBody Expense expense) {
        Expense created = financeService.addExpense(expense);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Expense> updateExpense(@PathVariable Long id, @Valid @RequestBody Expense expense) {
        Expense existing = financeService.findExpenseById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Expense", "id", id);
        }
        expense.setId(id);
        Expense updated = financeService.saveExpense(expense);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExpense(@PathVariable Long id) {
        Expense existing = financeService.findExpenseById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Expense", "id", id);
        }
        financeService.deleteExpenseById(id);
        return ResponseEntity.noContent().build();
    }
}

