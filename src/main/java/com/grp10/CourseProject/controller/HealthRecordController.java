package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.model.HealthRecord;
import com.grp10.CourseProject.service.IHealthRecordService;
import com.grp10.CourseProject.service.IFlockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class HealthRecordController {

    @Autowired
    private IHealthRecordService healthRecordService;

    @Autowired
    private IFlockService flockService;

    @GetMapping("/health-records")
    public String viewHealthRecords(Model model) {
        model.addAttribute("healthRecords", healthRecordService.getAll());
        model.addAttribute("flocks", flockService.getAllFlocks());
        return "health-records";
    }

    @PostMapping("/add-health-record")
    public String addHealthRecord(@ModelAttribute HealthRecord healthRecord) {
        // Load the Flock object from the ID
        if (healthRecord.getFlock() != null && healthRecord.getFlock().getId() != null) {
            com.grp10.CourseProject.model.Flock flock = flockService.findFlockById(healthRecord.getFlock().getId());
            healthRecord.setFlock(flock);
        }
        healthRecordService.addHealthRecord(healthRecord);
        return "redirect:/health-records?action=created&status=success";
    }

    @PostMapping("/update-health-record")
    public String updateHealthRecord(@ModelAttribute HealthRecord healthRecord) {
        // Load the Flock object from the ID
        if (healthRecord.getFlock() != null && healthRecord.getFlock().getId() != null) {
            com.grp10.CourseProject.model.Flock flock = flockService.findFlockById(healthRecord.getFlock().getId());
            healthRecord.setFlock(flock);
        }
        healthRecordService.saveHealthRecord(healthRecord);
        return "redirect:/health-records?action=updated&status=success";
    }

    @GetMapping("/delete-health-record/{id}")
    public String deleteHealthRecord(@PathVariable Long id) {
        healthRecordService.deleteById(id);
        return "redirect:/health-records?action=deleted&status=success";
    }
}

