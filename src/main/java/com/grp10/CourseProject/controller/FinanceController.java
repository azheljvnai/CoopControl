package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.model.Expense;
import com.grp10.CourseProject.model.Sale;
import com.grp10.CourseProject.service.IFinanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class FinanceController {

    @Autowired
    private IFinanceService financeService;

    @GetMapping("/financials")
    public String viewFinancials(Model model) {
        model.addAttribute("sales", financeService.getAllSales());
        model.addAttribute("expenses", financeService.getAllExpenses());
        model.addAttribute("totalRevenue", financeService.getTotalRevenue());
        model.addAttribute("totalExpenses", financeService.getTotalExpenses());
        model.addAttribute("netProfit", financeService.getNetProfit());
        return "financials";
    }

    // --- Expenses (CREATE) ---
    @GetMapping("/add-expense")
    public String showAddExpenseForm(Model model) {
        model.addAttribute("expense", new Expense());
        return "add-expense";
    }

    @PostMapping("/add-expense")
    public String addExpense(@ModelAttribute Expense expense) {
        financeService.addExpense(expense);
        return "redirect:/financials";
    }

    // --- Expenses (UPDATE) ---
    @GetMapping("/edit-expense/{id}")
    public String showEditExpenseForm(@PathVariable Long id, Model model) {
        Expense expense = financeService.findExpenseById(id);
        if (expense != null) {
            model.addAttribute("expense", expense);
            return "edit-expense";
        }
        return "redirect:/financials";
    }

    @PostMapping("/update-expense")
    public String updateExpense(@ModelAttribute Expense expense) {
        financeService.saveExpense(expense);
        return "redirect:/financials";
    }

    // --- Expenses (DELETE) ---
    @GetMapping("/delete-expense/{id}")
    public String deleteExpense(@PathVariable Long id) {
        financeService.deleteExpenseById(id);
        return "redirect:/financials";
    }

    // --- Sales (CREATE) ---
    @GetMapping("/add-sale")
    public String showAddSaleForm(Model model) {
        model.addAttribute("sale", new Sale());
        return "add-sale";
    }

    @PostMapping("/add-sale")
    public String addSale(@ModelAttribute Sale sale) {
        financeService.addSale(sale);
        return "redirect:/financials";
    }

    // --- Sales (UPDATE) ---
    @GetMapping("/edit-sale/{id}")
    public String showEditSaleForm(@PathVariable Long id, Model model) {
        Sale sale = financeService.findSaleById(id);
        if (sale != null) {
            model.addAttribute("sale", sale);
            return "edit-sale";
        }
        return "redirect:/financials";
    }

    @PostMapping("/update-sale")
    public String updateSale(@ModelAttribute Sale sale) {
        financeService.saveSale(sale);
        return "redirect:/financials";
    }

    // --- Sales (DELETE) ---
    @GetMapping("/delete-sale/{id}")
    public String deleteSale(@PathVariable Long id) {
        financeService.deleteSaleById(id);
        return "redirect:/financials";
    }
}