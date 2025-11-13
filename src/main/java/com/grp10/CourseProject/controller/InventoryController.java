package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.model.FeedEntry;
import com.grp10.CourseProject.model.Medicine;
import com.grp10.CourseProject.model.Supply;
import com.grp10.CourseProject.service.IInventoryService;
import com.grp10.CourseProject.service.IMedicineService;
import com.grp10.CourseProject.service.ISupplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class InventoryController {

    @Autowired
    private IInventoryService inventoryService; // For Feed

    // --- INJECT NEW SERVICES ---
    @Autowired
    private ISupplyService supplyService;

    @Autowired
    private IMedicineService medicineService;

    // --- UPDATED Main /inventory mapping ---
    @GetMapping("/inventory")
    public String viewInventory(Model model) {
        // Feed
        model.addAttribute("feedEntries", inventoryService.getAllFeedEntries());
        model.addAttribute("totalFeedStock", inventoryService.getTotalFeedStockKg());

        // Supply (as requested)
        model.addAttribute("supplyEntries", supplyService.getAll());
        model.addAttribute("totalSupplies", supplyService.getTotalItems());

        // Medicine (as requested)
        model.addAttribute("medicineEntries", medicineService.getAll());
        model.addAttribute("totalMedicine", medicineService.getTotalItems());

        return "inventory";
    }

    // ===========================================
    // Feed Entry Endpoints (Existing)
    // ===========================================

    @GetMapping("/add-feed")
    public String showAddFeedForm(Model model) {
        model.addAttribute("feedEntry", new FeedEntry());
        return "add-feed";
    }

    @PostMapping("/add-feed")
    public String addFeed(@ModelAttribute FeedEntry feedEntry) {
        inventoryService.addFeedEntry(feedEntry);
        return "redirect:/inventory";
    }

    @GetMapping("/edit-feed/{id}")
    public String showEditFeedForm(@PathVariable Long id, Model model) {
        FeedEntry feedEntry = inventoryService.findFeedEntryById(id);
        if (feedEntry != null) {
            model.addAttribute("feedEntry", feedEntry);
            return "edit-feed";
        }
        return "redirect:/inventory";
    }

    @PostMapping("/update-feed")
    public String updateFeed(@ModelAttribute FeedEntry feedEntry) {
        inventoryService.saveFeedEntry(feedEntry);
        return "redirect:/inventory";
    }

    @GetMapping("/delete-feed/{id}")
    public String deleteFeed(@PathVariable Long id) {
        inventoryService.deleteFeedEntryById(id);
        return "redirect:/inventory";
    }

    // ===========================================
    // Supply Endpoints (New, as requested)
    // ===========================================

    @GetMapping("/add-supply")
    public String showAddSupplyForm(Model model) {
        model.addAttribute("supply", new Supply());
        return "add-supply"; // New template
    }

    @PostMapping("/add-supply")
    public String addSupply(@ModelAttribute Supply supply) {
        supplyService.addSupply(supply);
        return "redirect:/inventory";
    }

    @GetMapping("/edit-supply/{id}")
    public String showEditSupplyForm(@PathVariable Long id, Model model) {
        Supply supply = supplyService.findById(id);
        if (supply != null) {
            model.addAttribute("supply", supply);
            return "edit-supply"; // New template
        }
        return "redirect:/inventory";
    }

    @PostMapping("/update-supply")
    public String updateSupply(@ModelAttribute Supply supply) {
        supplyService.saveSupply(supply);
        return "redirect:/inventory";
    }

    @GetMapping("/delete-supply/{id}")
    public String deleteSupply(@PathVariable Long id) {
        supplyService.deleteById(id);
        return "redirect:/inventory";
    }

    // ===========================================
    // Medicine Endpoints (New, as requested)
    // ===========================================

    @GetMapping("/add-medicine")
    public String showAddMedicineForm(Model model) {
        model.addAttribute("medicine", new Medicine());
        return "add-medicine"; // New template
    }

    @PostMapping("/add-medicine")
    public String addMedicine(@ModelAttribute Medicine medicine) {
        medicineService.addMedicine(medicine);
        return "redirect:/inventory";
    }

    @GetMapping("/edit-medicine/{id}")
    public String showEditMedicineForm(@PathVariable Long id, Model model) {
        Medicine medicine = medicineService.findById(id);
        if (medicine != null) {
            model.addAttribute("medicine", medicine);
            return "edit-medicine"; // New template
        }
        return "redirect:/inventory";
    }

    @PostMapping("/update-medicine")
    public String updateMedicine(@ModelAttribute Medicine medicine) {
        medicineService.saveMedicine(medicine);
        return "redirect:/inventory";
    }

    @GetMapping("/delete-medicine/{id}")
    public String deleteMedicine(@PathVariable Long id) {
        medicineService.deleteById(id);
        return "redirect:/inventory";
    }
}