package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.service.IFinanceService;
import com.grp10.CourseProject.service.IFlockService;
import com.grp10.CourseProject.service.IInventoryService;
import com.grp10.CourseProject.service.IMedicineService;
import com.grp10.CourseProject.service.ISupplyService;
import com.grp10.CourseProject.service.IEggProductionService;
import com.grp10.CourseProject.service.IHealthRecordService;
import com.grp10.CourseProject.service.IMortalityService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @Autowired
    private IFlockService flockService;

    @Autowired
    private IInventoryService inventoryService; // For Feed

    @Autowired
    private IFinanceService financeService;

    @Autowired
    private ISupplyService supplyService;

    @Autowired
    private IMedicineService medicineService;

    @Autowired
    private IEggProductionService eggProductionService;

    @Autowired
    private IHealthRecordService healthRecordService;

    @Autowired
    private IMortalityService mortalityService;

    @GetMapping("/")
    public String showDashboard(Model model) {
        // Flock Data
        model.addAttribute("totalFlocks", flockService.getTotalFlockCount());
        model.addAttribute("totalBirds", flockService.getTotalBirdCount());

        // Financial Data
        model.addAttribute("totalRevenue", financeService.getTotalRevenue());
        model.addAttribute("totalExpenses", financeService.getTotalExpenses());
        model.addAttribute("netProfit", financeService.getNetProfit());

        // Inventory Data
        model.addAttribute("totalFeedStock", inventoryService.getTotalFeedStockKg());
        model.addAttribute("totalSupplies", supplyService.getTotalItems());
        model.addAttribute("totalMedicine", medicineService.getTotalItems());

        // New Features Data
        model.addAttribute("totalEggs", eggProductionService.getTotalEggs() != null ? eggProductionService.getTotalEggs() : 0);
        model.addAttribute("totalHealthRecords", healthRecordService.getTotalHealthRecords());
        model.addAttribute("totalMortality", mortalityService.getTotalMortality() != null ? mortalityService.getTotalMortality() : 0);

        return "index"; // Renders index.ftlh
    }
}