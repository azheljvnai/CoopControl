package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.service.IFinanceService;
import com.grp10.CourseProject.service.IFlockService;
import com.grp10.CourseProject.service.IEggProductionService;
import com.grp10.CourseProject.service.IHealthRecordService;
import com.grp10.CourseProject.service.IMortalityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Map;

@Controller
public class ReportController {

    @Autowired
    private IFinanceService financeService;

    @Autowired
    private IFlockService flockService;

    @Autowired
    private IEggProductionService eggProductionService;

    @Autowired
    private IHealthRecordService healthRecordService;

    @Autowired
    private IMortalityService mortalityService;

    @GetMapping("/reports")
    public String showReportMenu(Model model) {
        // Financial Data - Summary
        Map<String, BigDecimal> expenseSummary = financeService.getExpenseSummaryByCategory();
        BigDecimal totalExpenses = financeService.getTotalExpenses();
        model.addAttribute("expenseSummary", expenseSummary);
        model.addAttribute("totalExpenses", totalExpenses);
        model.addAttribute("totalRevenue", financeService.getTotalRevenue());
        model.addAttribute("netProfit", financeService.getNetProfit());

        // Financial Data - Lists
        model.addAttribute("sales", financeService.getAllSales());
        model.addAttribute("expenses", financeService.getAllExpenses());

        // Flock Data
        model.addAttribute("flocks", flockService.getAllFlocks());
        model.addAttribute("totalFlocks", flockService.getTotalFlockCount());
        model.addAttribute("totalBirds", flockService.getTotalBirdCount());

        // New Features Data - Lists
        model.addAttribute("eggProductions", eggProductionService.getAll());
        model.addAttribute("healthRecords", healthRecordService.getAll());
        model.addAttribute("mortalities", mortalityService.getAll());

        // New Features Data - Summary
        model.addAttribute("totalEggs", eggProductionService.getTotalEggs() != null ? eggProductionService.getTotalEggs() : 0);
        model.addAttribute("totalHealthRecords", healthRecordService.getTotalHealthRecords());
        model.addAttribute("totalMortality", mortalityService.getTotalMortality() != null ? mortalityService.getTotalMortality() : 0);

        // We will pass this to calculate percentages
        model.addAttribute("RoundingMode", RoundingMode.class);

        return "reports"; // This loads "reports.ftlh"
    }
}