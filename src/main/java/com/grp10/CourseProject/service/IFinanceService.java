package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Expense;
import com.grp10.CourseProject.model.Sale;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface IFinanceService {
    // Sales
    List<Sale> getAllSales();
    Sale addSale(Sale sale);
    BigDecimal getTotalRevenue();
    Sale findSaleById(Long id);
    Sale saveSale(Sale sale);
    void deleteSaleById(Long id);

    // Expenses
    List<Expense> getAllExpenses();
    Expense addExpense(Expense expense);
    BigDecimal getTotalExpenses();
    Expense findExpenseById(Long id);
    Expense saveExpense(Expense expense);
    void deleteExpenseById(Long id);

    // Profit & Reports
    BigDecimal getNetProfit();
    Map<String, BigDecimal> getExpenseSummaryByCategory();
}