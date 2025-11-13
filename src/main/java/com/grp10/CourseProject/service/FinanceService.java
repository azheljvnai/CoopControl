package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Expense;
import com.grp10.CourseProject.model.Sale;
import com.grp10.CourseProject.repository.ExpenseRepository;
import com.grp10.CourseProject.repository.SaleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class FinanceService implements IFinanceService {

    @Autowired
    private SaleRepository saleRepository;
    @Autowired
    private ExpenseRepository expenseRepository;

    // =================================================================
    // Sales Methods (CRUD)
    // =================================================================

    @Override
    public List<Sale> getAllSales() {
        return (List<Sale>) saleRepository.findAll();
    }

    @Override
    public Sale findSaleById(Long id) {
        return saleRepository.findById(id).orElse(null);
    }

    @Override
    public Sale addSale(Sale sale) {
        // Null-safe checks for CREATING a new sale
        if (sale.getQuantity() == null || sale.getQuantity() < 0) {
            sale.setQuantity(0);
        }
        if (sale.getTotalAmount() == null) {
            sale.setTotalAmount(BigDecimal.ZERO);
        }
        return saleRepository.save(sale);
    }

    @Override
    public Sale saveSale(Sale sale) {
        // Null-safe checks for UPDATING an existing sale
        if (sale.getQuantity() == null || sale.getQuantity() < 0) {
            sale.setQuantity(0);
        }
        if (sale.getTotalAmount() == null) {
            sale.setTotalAmount(BigDecimal.ZERO);
        }
        return saleRepository.save(sale);
    }

    @Override
    public void deleteSaleById(Long id) {
        saleRepository.deleteById(id);
    }

    // =================================================================
    // Expense Methods (CRUD)
    // =================================================================

    @Override
    public List<Expense> getAllExpenses() {
        return (List<Expense>) expenseRepository.findAll();
    }

    @Override
    public Expense findExpenseById(Long id) {
        return expenseRepository.findById(id).orElse(null);
    }

    @Override
    public Expense addExpense(Expense expense) {
        // Null-safe check for CREATING a new expense
        if (expense.getAmount() == null) {
            expense.setAmount(BigDecimal.ZERO);
        }
        return expenseRepository.save(expense);
    }

    @Override
    public Expense saveExpense(Expense expense) {
        // Null-safe check for UPDATING an existing expense
        if (expense.getAmount() == null) {
            expense.setAmount(BigDecimal.ZERO);
        }
        return expenseRepository.save(expense);
    }

    @Override
    public void deleteExpenseById(Long id) {
        expenseRepository.deleteById(id);
    }

    // =================================================================
    // Business Logic & Reporting Methods
    // =================================================================

    @Override
    public BigDecimal getTotalRevenue() {
        // Null-safe aggregation
        return getAllSales().stream()
                .map(sale -> (sale.getTotalAmount() != null ? sale.getTotalAmount() : BigDecimal.ZERO))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public BigDecimal getTotalExpenses() {
        // Null-safe aggregation
        return getAllExpenses().stream()
                .map(expense -> (expense.getAmount() != null ? expense.getAmount() : BigDecimal.ZERO))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public BigDecimal getNetProfit() {
        return getTotalRevenue().subtract(getTotalExpenses());
    }

    @Override
    public Map<String, BigDecimal> getExpenseSummaryByCategory() {
        // Null-safe grouping and aggregation for the report
        return getAllExpenses().stream()
                .collect(Collectors.groupingBy(
                        // Group by category, but use "Uncategorized" if category is null
                        expense -> (expense.getCategory() != null && !expense.getCategory().isBlank()
                                ? expense.getCategory()
                                : "Uncategorized"),
                        Collectors.mapping(
                                // Map to the amount, but use 0 if amount is null
                                expense -> (expense.getAmount() != null ? expense.getAmount() : BigDecimal.ZERO),
                                // Sum all amounts in the group
                                Collectors.reducing(BigDecimal.ZERO, BigDecimal::add)
                        )
                ));
    }
}